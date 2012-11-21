; $LastChangedDate$
; $LastChangedRevision$
; $HeadURL$
(module tool mzscheme
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
            (λ (predicate action)
              (for-each
               (λ (tab)
                 (let ([editor (send tab get-defs)])
                   (if (predicate editor) (action editor))))
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
                 (send editor load-file 
                       #f 
                       (send editor get-file-format) 
                       #t)))))
          
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

