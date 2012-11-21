#lang scribble/doc

@(require scribble/manual)

@title{DrSync: A file synchronization tool}

This is DrSync, written by Grant Rettke (grettke@elem["@"]acm.org).

@section[#:tag "What"]{What it does}

@(itemize    
  (item "DrSync reverts your files when DrRacket's frame activates and saves them
        when it deactivates. "))

@section[#:tag "Why"]{Why you might want to use it}

@(itemize    
  (item "When switching between DrRacket and your favorite version control client, it is
	easier knowing that your file is saved, and ready for a commit.")
  (item "If you use version control keyword expansion, after a commit you need to revert your
	file upon returning to DrRacket.")
  (item "If you use an external compilation process, sometimes you forget to
	save your changes, resulting in phenomena ranging from head scratching to hair pulling.")
  (item "After manually addressing any of these scenarios three or four hundred times, you will start 
        looking for any way to make it easier. DrSync is one such way."))

@section[#:tag "How"]{How it works}

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