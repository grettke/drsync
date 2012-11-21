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
      
      (define drsync-frame-mixin%
        (mixin (drscheme:unit:frame<%>) () 
          
          (define/override (on-activate active?)
            (super on-activate active?)
            (if active? (on-activation)
                (on-deactivation)))
          
          (define on-activation
            (λ ()
              void))
          
          (define on-deactivation
            (λ ()
              (for-each
               (λ (tab)
                 (let ([editor (send tab get-defs)])
                   (if (and (send editor get-filename) (send editor is-modified?))
                       (send editor save-file 
                             #f 
                             (send editor get-file-format) 
                             #t)
                       void)))               
               (send this get-tabs))))
          
            (super-new)))
        
        (drscheme:get/extend:extend-unit-frame drsync-frame-mixin%))))
  