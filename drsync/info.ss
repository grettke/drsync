#|
Copyright (c) 2008 Grant Rettke (grettke@acm.org)

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
#lang setup/infotab

(define name "DrSync")

(define version "1.0.2")

(define release-notes '((p "Updated for 4.x.")))

(define blurb
  '("DrSync is a tool that saves your files on frame deactivation "
    "and reverts them on frame activation. This tool is of particular "
    "interest to folks who run external programs like version control or "
    "build related tools on files which they are editing inside of DrScheme."))

(define categories '(devtools))

(define can-be-loaded-with 'none)

(define homepage "http://www.wisdomandwonder.com/")

(define primary-file "drsync.ss")

(define required-core-version "4.0")

(define repositories '("4.x"))

(define scribblings '(("drsync.scrbl" ())))

(define tools (list "drsync.ss"))
(define tool-names (list "DrSync"))
(define tool-icons (list "drsync-icon.png"))
(define tool-urls  (list "http://www.wisdomandwonder.com/software/"))
