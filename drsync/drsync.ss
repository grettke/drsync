#|
Copyright (c) 2007 Grant Rettke

All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
3. The name of the author may not be used to endorse or promote products
   derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
|#
#|
$LastChangedDate$
$LastChangedRevision$
$HeadURL$
|#
(module drsync mzscheme
  (require (lib "tool.ss" "drscheme")
           (lib "mred.ss" "mred")
           (lib "unit.ss")
           (lib "class.ss"))
  
  (provide tool@)
  
  (define tool@
    (unit
      (import drscheme:tool^)
      (export drscheme:tool-exports^)
      (define phase1 void)
      (define phase2 void) 
      
      (define drsync-frame-mixin
        (mixin (drscheme:unit:frame<%>) () 
          
          (define file/timestamps (make-hash-table 'equal))
          
          ; (path -> number|bool)
          (define mem-timestamp
            (λ (path)
              (hash-table-get 
               file/timestamps 
               (path->string path)
               #f)))
          
          ; (path number -> void)
          (define set-mem-timestamp
            (λ (path stamp)
              (hash-table-put! 
               file/timestamps 
               (path->string path)
               stamp)))
          
          ; (text% -> bool)
          (define file-loaded?
            (λ (editor)
              (send editor get-filename)))
          
          ; (text% -> bool)
          (define file-modified?
            (λ (editor)
              (send editor is-modified?)))
          
          ; (path -> number|bool)
          (define fs-timestamp
            (λ (path)
              (with-handlers
                  ((exn:fail:filesystem? (λ (exc) #f)))
                (file-or-directory-modify-seconds path))))
          
          ; (text% -> bool)
          (define load-file
            (λ (editor)
              (send editor load-file 
                    #f 
                    (send editor get-file-format) 
                    #t)))
          
          ; (text% -> bool)
          (define save-file
            (λ (editor)
              (send editor save-file 
                    #f 
                    (send editor get-file-format) 
                    #t)))
          
          ; (text% -> number)
          (define start-position
            (λ (editor)
              (send editor get-start-position)))
          
          (define/override (on-activate active?)
            (super on-activate active?)
            (if active? (handle-activation) (handle-deactivation))) 
          
          (define handle-activation
            (λ ()
              (each-tab
               (λ (editor) (file-loaded? editor))
               (λ (editor) 
                 (send editor begin-edit-sequence)
                 (letrec ([pos (start-position editor)]
                          [loaded (load-file editor)])
                   (if loaded (send editor set-position pos pos)))
                 (send editor end-edit-sequence)))))          
          
          (define handle-deactivation
            (λ ()
              (each-tab
               (λ (editor) (and (file-loaded? editor) (file-modified? editor)))
               (λ (editor) (save-file editor)))))
          
          (define each-tab
            (λ (predicate? action)
              (for-each
               (λ (tab)
                 (let ([editor (send tab get-defs)])
                   (if (predicate? editor) (action editor))))
               (send this get-tabs))))
          
          (super-new)))
      
      (drscheme:get/extend:extend-unit-frame drsync-frame-mixin))))