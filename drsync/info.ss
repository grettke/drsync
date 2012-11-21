; $LastChangedDate$
; $LastChangedRevision$
; $HeadURL$
(module info (lib "infotab.ss" "setup")
  
  (define name "DrSync")
  
  (define version "1.0alpha")
  
  (define release-notes (list "It works on my machine!"))
  
  (define blurb
    (list
     "DrSync is a tool that saves your files on frame deactivation "
     "and reverts them on frame activation. This tool is of particular "
     "interest to folks who run external programs like version control or "
     "compiler tools on files which they are editing inside of DrScheme."))
  
  (define categories '(devtools))
  
  (define can-be-loaded-with 'none)
  
  (define doc.txt "doc.txt")
  
  (define tools (list (list "tool.ss"))))