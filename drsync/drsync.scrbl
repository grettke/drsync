#lang scribble/doc

@(require scribble/manual)

@title{DrSync: A file synchronization tool}

This is DrSync, written by Grant Rettke (grettke@elem["@"]acm.org).

@section[#:tag "What"]{What}

DrSync does two things:

@(itemize    
  (item "Synchronizes files on DrScheme frame activation.")
  (item "Saves files on DrScheme frame deactivation."))

@section[#:tag "Why"]{Why}

@(itemize    
  (item "When switching between DrScheme and your favorite version control client, it is
	easier knowing that your file is saved, and ready for a commit.")
  (item "If you use version control keyword expansion, you need to revert your
	file upon returning to DrScheme.")
  (item "If you use an external compilation process, sometimes you forget to
	save your changes, resulting in phenomena ranging from head scratching to hair pulling.")
  (item "After manually addressing any of these scenarios three or four hundred times, you will begin 
	to appreciate any way to make it easier. DrSync is one such way."))

@section[#:tag "How"]{How}

DrSync follows the KIS principle: Keep It Simple.

@(itemize    
  (item "Synchronization occurs only on frame activation and deactivation. 
        For example, opening file menus, switching between tabs, or moving
	between the editor and the REPL will not trigger synchronization.
        Opening any dialog, however, will trigger synchronization.")
  (item "Every editor is synchronized. If there is a file open in
	a tab, it will be synchronized.")
  (item "This tool may not be disabled. If you use this 
	tool, you most probably have a good reason to do so, and in the long 
	run you will be better off knowing that your files are always in sync."))
