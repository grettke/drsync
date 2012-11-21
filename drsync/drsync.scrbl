#lang scribble/doc

@(require scribble/manual)

@title{DrSync: A file synchronization tool}

@section[#:tag "What"]{What}

DrSync does two things:

@(itemize    
  (item "Synchronizes files on frame activation.")
  (item "Saves files on frame deactivation."))

@section[#:tag "Why"]{Why}

@(itemize    
  (item "Switching between DrScheme and your version control client, it is
	easier knowing that your file is saved, and ready for a commit. After
	going through this process only fifty or sixty times, you will begin 
	to appreciate any way to make it easier.")
  (item "If you use version control keyword expansion, you need to revert your
	file each time you return to DrScheme.")
  (item "If you use an external compilation process, sometimes you forget to
	save your changes, resulting in your quizzical stares and hair pulling."))

@section[#:tag "How"]{How}

DrSync follows the KIS principle: Keep It Simple.

@(itemize    
  (item "Synchronization occurs only on frame activation and deactivation and
	at no other time. Opening file menus, switching between tabs, or moving
	between the editor and the REPL will not trigger synchronization.")
  (item "Every type of file will be synchronized. Whether you edit SS, SCM, or
	TXT files in the editor makes no difference. If there is a file open in
	a tab, it will be synchronized.")
  (item "Synchronization always occurs, it is not configurable. If you use this 
	tool, you most probably have a good reason to do so, and in the long 
	run you will be better off always knowing that your files are in sync
	at all times."))