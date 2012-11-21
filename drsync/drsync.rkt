#|
Copyright (c) 2010 Grant Rettke (grettke@acm.org)

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
See the definition of revert in /collects/framework/private/frame.ss on line 1147 for inspiration of the revert functionality in this mixin.

Thanks to everyone's help in the PLT community; writing this tool was relatively "a breeze".
|#
#lang racket/base
(require drracket/tool
         racket/gui/base
         racket/unit
         racket/class)

(provide tool@)

(define tool@
  (unit
    (import drracket:tool^)
    (export drracket:tool-exports^)
    (define phase1 void)
    (define phase2 void) 
    
    (define drsync-frame-mixin
      (mixin (drracket:unit:frame<%>) () 
        
        (define file/timestamps (make-hash))
        
        ; (path-string?) -> (or/c exact-integer? false/c)
        (define (mem-timestamp path)
          (hash-ref file/timestamps (path->string path) #f))
        
        ; (path-string?) -> (or/c exact-integer? false/c) -> (void)
        (define (set!-mem-timestamp path stamp)
          (hash-set! file/timestamps (path->string path) stamp))
        
        ; (text% : class?) -> (or/c path-string? false/c)
        (define (file-path editor)
          (send editor get-filename))
        
        ; (text% : class?) -> (boolean?)
        (define (file-modified? editor)
          (send editor is-modified?))
        
        ; (path-string?) -> (exact-integer?)
        (define (fs-timestamp path)
          (with-handlers
              ((exn:fail:filesystem? (lambda (exc) -1)))
            (file-or-directory-modify-seconds path)))
        
        ; (text% : class?) -> (boolean?)
        (define (load-file editor)
          (with-handlers
              ((exn:fail? (lambda (exc) #f)))
            (send editor load-file #f (send editor get-file-format) #t)))
        
        ; (text% : class?) -> (boolean?)
        (define (save-file editor)
          (with-handlers
              ((exn:fail? (lambda (exc) #f)))
            (send editor save-file #f (send editor get-file-format) #t)))
        
        ; (text% : class?) -> (nonnegative-exact-integer?)
        (define (file-start-position editor)
          (send editor get-start-position))
        
        (define/override (on-activate active?)
          (super on-activate active?)
          (if active? (handle-activation) (handle-deactivation))) 
        
        (define (handle-activation)
          (each-tab
           (lambda (editor) (file-path editor))
           (lambda (editor) 
             (let* ((path (file-path editor))
                    (mem/timestamp (mem-timestamp path))
                    (fs/timestamp (fs-timestamp path)))
               (when (and mem/timestamp (> fs/timestamp mem/timestamp))
                 (begin 
                   (send editor begin-edit-sequence)
                   (let ((pos (file-start-position editor)))
                     (when (load-file editor) (send editor set-position pos pos)))
                   (send editor end-edit-sequence)))))))
        
        (define (handle-deactivation)
          (each-tab
           (lambda (editor) (file-path editor))
           (lambda (editor) 
             (when (file-modified? editor) (save-file editor))
             (let* ((path (file-path editor))
                    (mem/timestamp (mem-timestamp path))
                    (fs/timestamp (fs-timestamp path)))
               (when (or (not mem/timestamp) (> fs/timestamp mem/timestamp))
                 (set!-mem-timestamp path fs/timestamp))))))
        
        (define (each-tab predicate? action)
          (for-each
           (lambda (tab)
             (let ((editor (send tab get-defs)))
               (when (predicate? editor) (action editor))))
           (send this get-tabs)))
        
        (super-new)))
    
    (drracket:get/extend:extend-unit-frame drsync-frame-mixin)))