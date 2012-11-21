; $LastChangedDate$
; $LastChangedRevision$
; $HeadURL$
(module tool mzscheme
  (require (lib "tool.ss" "drscheme")
           (lib "mred.ss" "mred")
           (lib "unit.ss"))
  
  (provide tool@)
  
  (define tool@
    (unit
      (import drscheme:tool^)
      (export drscheme:tool-exports^)
      (define (phase1)
        (message-box "tool example" "phase1"))
      (define (phase2)
        (message-box "tool example" "phase2")) 
	 (message-box "tool example" "first"))))
