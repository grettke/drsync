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
          
          (define/override (on-activate active?)
            (super on-activate active?)
            (if active? (handle-activation) (handle-deactivation))) 
          
          (define each-tab
            (λ (predicate? action)
              (for-each
               (λ (tab)
                 (let ([editor (send tab get-defs)])
                   (if (predicate? editor) (action editor))))
               (send this get-tabs))))
          
          (define file-loaded?
            (λ (editor)
              (send editor get-filename)))
          
          (define file-modified?
            (λ (editor)
              (send editor is-modified?)))
          
          (define handle-activation
            (λ ()
              (each-tab
               (λ (editor) (file-loaded? editor))
               (λ (editor) 
                 (send editor begin-edit-sequence)
                 (letrec ([pos (send editor get-start-position)]
                          [loaded (send editor load-file 
                                        #f 
                                        (send editor get-file-format) 
                                        #t)])
                   (if loaded (send editor set-position pos pos)))
                 (send editor end-edit-sequence)))))          
          
          (define handle-deactivation
            (λ ()
              (each-tab
               (λ (editor) (and (file-loaded? editor) (file-modified? editor)))
               (λ (editor)
                 (send editor save-file 
                       #f 
                       (send editor get-file-format) 
                       #t)))))
          
          (super-new)))
      
      (drscheme:get/extend:extend-unit-frame drsync-frame-mixin))))
