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
      
      (define activate-frame-mixin%
        (mixin (top-level-window<%>) () 
          (define not-showed-on #t)
          (define not-showed-off #t)
          (define/override (on-activate active?)
            (super on-activate active?)
            (cond [(and active? not-showed-on) 
                   (message-box "" "Activated") (set! not-showed-on #f)]
                  [(and (not active?) not-showed-off)
                   (message-box "" "Deactivated") (set! not-showed-off #f)]
                  [else void]))
          (super-new)))
      
      (drscheme:get/extend:extend-unit-frame activate-frame-mixin%))))
