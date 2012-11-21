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
#lang setup/infotab

(define name "DrSync")

(define version "1.0.3")

(define release-notes '((p "Updated for 5.x.")))

(define blurb
  '("DrSync reverts your files when DrRacket's frame activates and saves them
    when it deactivates. Something like this would be of particular interest
    to folks who run external programs like version control or build
    related tools on files which they are editing inside of DrRacket."))

(define categories '(devtools))

(define can-be-loaded-with 'none)

(define homepage "http://www.wisdomandwonder.com/")

(define primary-file "drsync.rkt")

(define required-core-version "5.0")

(define repositories '("4.x"))

(define scribblings '(("drsync.scrbl" ())))

(define drracket-tools (list "drsync.rkt"))
(define drracket-tool-names (list "DrSync"))
(define drracket-tool-icons (list "drsync-icon.png"))
(define drracket-tool-urls  (list "http://www.wisdomandwonder.com/software/"))
