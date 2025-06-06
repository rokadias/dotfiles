;;; pabbrev.el --- Predictive abbreviation expansion -*- lexical-binding: t; -*-

;; Copyright (C) 2003-2024 Free Software Foundation, Inc.

;; Author: Phillip Lord <phillip.lord@newcastle.ac.uk>
;; Maintainer: Arthur Miller <arthur.miller@live.com>
;; URL: https://github.com/phillord/pabbrev
;; Package-Version: 20240617.1622
;; Package-Revision: d5f120c523dd
;; Package-requires: ((emacs "25.1"))

;; The contents of this file are subject to the GPL License, Version 3.0.
;;
;; COPYRIGHT NOTICE
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:
;;
;; The code provides a abbreviation expansion for Emacs.  Its fairly
;; similar to "dabbrev" expansion, which works based on the contents
;; of the current buffer (or other buffers).
;;
;; Predictive abbreviation expansion works based on the previously
;; written text.  Unlike dynamic abbreviation, the text is analysed
;; during idle time, while Emacs is doing nothing else.  `pabbrev-mode'
;; tells you when this is happening.  If this irritates you unset
;; `pabbrev-idle-timer-verbose'.  The advantage of this is that its
;; very quick to look up potential abbreviations, which means that they
;; can be constantly displayed, without interfering with the user as
;; they type.  Certainly it works for me, on an old laptop, typing as
;; fast as I can (which is fast, since I learnt to type with four
;; fingers).
;;
;; pabbrev's main entry point is through the minor mode
;; `pabbrev-mode'.  There is also a global minor mode, called
;; `global-pabbrev-mode', which does the same in all appropriate
;; buffers.
;;
;; The current user interface looks like so...
;;
;; p[oint]
;; pr[ogn]
;; pre[-command-hook]
;; pred[ictive]
;;
;; As the user types the system narrows down the possibilities.  The
;; narrowing is based on how many times the words have been used
;; previously.  By hitting [tab] at any point the user can complete the
;; word.  The [tab] key is normally bound to `indent-line'.
;; `pabbrev-mode' preserves access to this command (or whatever else
;; [tab] was bound to), if there is no current expansion.
;;
;; Sometimes you do not want to select the most commonly occurring
;; word, but a less frequently occurring word.  You can access this
;; functionality by hitting [tab] for a second time.  This takes you
;; into a special suggestions buffer, from where you can select
;; secondary selections.  See `pabbrev-select-mode' for more
;; details.  There is also an option `pabbrev-minimal-expansion-p'
;; which results in the shortest substring option being offered as the
;; first replacement.
;;
;; But is this actually of any use? Well having use the system for a
;; while now, I can say that it is sometimes.  I originally thought
;; that it would be good for text, but in general its not so
;; useful.  By the time you have realised that you have an expansion
;; that you can use, hit tab, and checked that its done the right
;; thing, you could have just typed the word directly in.  It's much
;; nicer in code containing buffers, where there tend to be lots of
;; long words, which is obviously where an abbreviation expansion
;; mechanism is most useful.
;;
;; Currently pabbrev builds up a dictionary on a per major-mode basis.
;; While pabbrev builds up this dictionary automatically, you can also
;; explicitly add a buffer, or a region to the dictionary with
;; `pabbrev-scavenge-buffer', or `pabbrev-scavenge-region'.  There is
;; also a command `pabbrev-scavenge-some' which adds some words from
;; around point.  pabbrev remembers the word that it has seen already,
;; so run these commands as many times as you wish.
;;
;; Although the main data structures are efficient during typing, the
;; pay off cost is that they can take a reasonable amount of time, and
;; processor power to gather up the words from the buffer.  There are
;; two main settings of interest to reduce this, which are
;; `pabbrev-scavenge-some-chunk-size' and
;; `pabbrev-scavenge-on-large-move'.  `pabbrev-mode' gathers text from
;; around point when point has moved a long way.  This means symbols
;; within the current context should be in the dictionary, but it can
;; make Emacs choppy, in handling.  Either reduce
;; `pabbrev-scavenge-some-chunk-size' to a smaller value, or
;; `pabbrev-scavenge-on-large-move' to nil to reduce the effects of
;; this.
;;
;; NOTE: There are a set of standard conventions for Emacs minor
;; modes, particularly with respect to standard key bindings, which
;; pabbrev somewhat abuses.  The justification for this is that the
;; whole point of pabbrev mode is to speed up typing.  Access to its
;; main function has to be on a very easy to use keybinding.  The tab
;; seems to be a good choice for this.  By preserving access to the
;; original tab binding when there is no expansion, pabbrev mostly
;; "does what I mean", at least in my hands.

;;; Installation:
;;
;; To install this file place in your `load-path', and add
;;
;; (require 'pabbrev)
;;
;; to your .emacs

;;; Package Support:
;;
;; Some packages need extra support for pabbrev to work with. There are two
;; plists properties which package developers can use.
;;
;; (put 'command-name 'pabbrev-expand-after-command t)
;;
;; means that the following the named command (in this case command-name),
;; expansion will be offered. `self-insert-command' and a few others is
;; normally fine, but not always.
;;
;; (put mode-name 'pabbrev-global-mode-excluded-modes t)
;;
;; will mean that any buffer with this major mode will not have
;; global-pabbrev-mode activated.
;;

;;; Bugs;
;;
;; This package had an occasional bug which has historically been hard
;; to track down and reproduce.  Basically I end up with a load of
;; offering expansions in the buffer. It looks something like this....
;; pabbrev[-mode][v][ev][rev][brev][bbrev][abbrev] which is amusing
;; the first time, but more or less totally useless.
;;
;; Thanks to the efforts of Martin Kuehl, I think we have tracked the
;; cause of the problem now (the old version depended on
;; pre-command-hook and post-command-hook being called
;; consecutively. But sometimes they get called twice). Please let us
;; know if you see this problem.

;;; Bug Reporting
;;
;; Bug reports are more than welcome. However one particular problem
;; with this mode is that it makes heavy use of
;; `post-command-hook'. This is a very useful hook, but makes the
;; package difficult to debug. If you want to send in a bug report it
;; will help a lot if you can get a repeatable set of keypresses, that
;; always causes the problem.

;;; Implementation notes:
;;
;; The core data structures are two hashes. The first of which looks
;; like this...
;; "the" -> ("the" . 5)
;; "there" -> ("there" . 3)
;;
;; I call this the usage hash, as it stores the total number of times
;; each word has been seen.
;;
;; The second hash which is called the prefix hash. It stores
;; prefixes, and usages...
;;
;; "t"->
;; (("the" . 64)
;;  ("to" . 28)
;;  ("t" . 22)
;;  ("this" . 17))
;;
;; "th"->
;; (("the" . 64)
;;  ("this" . 17)
;;  ("that" . 7))
;;
;; "the"->
;; (("the" . 64)
;;  ("there" . 6)
;;  ("then" . 3)
;;  ("these" . 1))
;;
;; The alist cons cells in the first hash are conserved in the second,
;; but the alists are not. The alist in the second hash is always
;; sorted, on the basis of word usage.
;;
;; The point with this data structure is that I can find word usage
;; in constant time, from the first hash, and completions for a given
;; prefix, also in constant time. As access to completions happens as
;; the user types speed is more important here, than during
;; update, which is why the prefix hash maintains sorted alists. This
;; is probably at the cost of slower updating of words.

;;; Acknowledgements;
;;
;; Many thanks to Martin Kuehl for tracking down the last bug which
;; stood between this being an "official" full release.
;;
;; Once again I need to thank Stefan Monnier, for his comments on my
;; code base. Once day I will write a minor mode which Stefan Monnier
;; does not offer me advice on, but it would appear that this day has not
;; yet arrived!
;;
;; I should also thank Kim F. Storm (and in turn Stephen Eglen), as
;; the user interface for this mode has been heavily influenced by
;; ido.el, a wonderful package which I use every day.
;;
;; Carsten Dominik suggested I add the package suppport rather than the
;; existing defcustom which was not as good I think.
;;
;; Scott Vokes added a nice patch, adding the single/multiple expansion, the
;; universal argument support and some bug fixes.

;;; News:

;; Since 4.2.2:
;; - Cosmestic changes (enable lexical-binding, silence compiler warnings, ...)

;;; Code:
(require 'cl-lib)
(require 'thingatpt)

;;; User customization
(defgroup pabbrev nil
  "Predicative abbreviation expansion."
  :tag "Predictive Abbreviations."
  :group 'abbrev
  :group 'convenience)

(defcustom pabbrev-global-mode-not-buffer-names '("*Messages*")
  "*Will not activate function `global-pabbrev-mode' if buffers have this name."
  :type '(repeat (string :tag "Buffer name")))

(defcustom pabbrev-global-mode-buffer-size-limit nil
  "Max size of buffers for `global-pabbrev-mode'.
If a buffer is over this size (in chars), `pabbrev-mode' will not activate.
Nil means there is no limit."
   :type 'integer)

(defcustom pabbrev-marker-distance-before-scavenge 2000
  "Minimal distance moved before we wish to scavenge."
  :type 'integer)

;;(setq pabbrev-scavenge-on-large-move nil)
(defcustom pabbrev-scavenge-on-large-move t
  "*If non NIL, scavenge when a large buffer move has occured.
This can make Emacs' handling a little bumpy.  See also
`pabbrev-scavenge-some-chunk-size', as reducing this, or increasing
`pabbrev-marker-distance-before-scavenge'  is an alternative
to setting this to nil"
  :type 'boolean)

(defcustom pabbrev-thing-at-point-constituent 'symbol
  "Symbol defining THING which function `pabbrev-mode' works on.
This symbol should be understandable by
`bounds-of-thing-at-point'.  This symbol defines what function `pabbrev-mode'
considers to be the basic unit of expansion.  If if it set to `symbol',
for example, \"pabbrev-mode\" would be offered as an expansion, while
if it is set to `word' \"pabbrev\" and \"mode\" would be offered.
You could also set it to `whitespace' which would be really daft,
or `page' which would be silly in a different way."
  :type 'symbol
  :options '(symbol word))

(defcustom pabbrev-scavenge-some-chunk-size 40
  "Number of words that `pabbrev-scavenge-words' gathers.
This also affects the speed with which pabbrev will scan through
the buffer during idle, so decrease this if too much processor
is being used, increase it if you want more.  It's set quite
conservatively.  If you get choppy performance when moving
around the buffer you should also consider
`pabbrev-scavenge-on-large-move' to nil."
  :type 'integer)

(defcustom pabbrev-idle-timer-verbose t
  "If non NIL, print messages while scavenging on idle timer.

At the moment this is set to t by default.  The idle timer function,
`pabbrev-idle-timer-function' uses quite a bit of processor power, and
I want the users to known what is eating their CPU.  I may change
this at a later date."
  :type 'boolean)

(defcustom pabbrev-read-only-error t
  "If non NIL, signal an error when in a read only buffer.

The function `pabbrev-mode' works by altering the local buffer,
so it's pointless within a read only buffer.  So, normally, it
prints a message when an attempt is made to use it in this way.
But this is a pain if you toggle buffers read only a lot.  Set
this to NIL, and function `pabbrev-mode' will disable it's functionality in
read only buffers silently."
  :type 'boolean)

;; variable in progress
(defcustom pabbrev-minimal-expansion-p nil
  "If t offer minimal expansion.

pabbrev can select the optimal expansion in two different ways.  The
normal way is to offer the expansion which occurs most frequently in
the words which pabbrev has scavenged (in any buffer in the same
mode).  The other method is to take the minimal occuring substring
present in any potential expansion; this is a lot more like standard
completion seen on a command line.

I'm not telling you which version, I prefer."
  :type 'boolean)

;;(setq pabbrev-minimal-expansion-p t)

;; stolen from font-lock!
(defface pabbrev-suggestions-face
  '((((type tty) (class color)) (:foreground "green"))
    (((class grayscale) (background light)) (:foreground "Gray90" :bold t))
    (((class grayscale) (background dark)) (:foreground "DimGray" :bold t))
    (((class color) (background light)) (:foreground "ForestGreen"))
    (((class color) (background dark)) (:foreground "Red"))
    (t (:bold t :underline t)))
  "Face for displaying suggestions.")
(defface pabbrev-single-suggestion-face
  '((((type tty) (class color)) (:foreground "green"))
    (((class grayscale) (background light)) (:foreground "Gray70" :bold t))
    (((class grayscale) (background dark)) (:foreground "DarkSlateGray" :bold t))
    (((class color) (background light)) (:foreground "OliveDrab"))
    (((class color) (background dark)) (:foreground "PaleGreen"))
    (t (:bold t :underline t)))
  "Face for displaying one suggestion.")
(defface pabbrev-suggestions-label-face
  '((t
     :inverse-video t))
  "Font Lock mode face used to highlight suggestions")


;;;; End user Customizable variables.



;;;; Begin Package Support.

;; mark commands after which expansion should be offered
(mapc
 (lambda(x)
   (put x 'pabbrev-expand-after-command t))
 '(self-insert-command mouse-set-point delete-char
                       backward-delete-char-untabify pabbrev-expand-maybe
                       pabbrev-expand-maybe-minimal pabbrev-expand-maybe-full
                       universal-argument universal-argument-other-key))

;; mark modes in which to not activate pabbrev with global mode.
(mapc
 (lambda(x)
   (put x 'pabbrev-global-mode-excluded-modes t))
 `(
   ;; I put this in at one point -- probably not needed now, but I have no
   ;; where to test it.
   telnet-mode
   term-mode
   ;; eshell uses it's own tab binding, so abbrevs get offered but not expanded
   eshell-mode
   ;; gnus article mode is read-only so should be missed anyway,
   ;; but it does something wierd so that it's not
   gnus-article-mode))

;;;; End Package Support

;;; Start data structures
(defvar pabbrev-usage-hash-modes nil
  "List of modes with associated usage dictionaries.")

(defvar pabbrev-prefix-hash-modes nil
  "List of modes with associated prefix dictionaries.")

(defvar pabbrev-long-idle-timer nil
  "Timer which adds whole buffer.
There are two idle timers which run for function `pabbrev-mode'.  This
one doesn't start for a while, but once it has will work its way
through the whole buffer.  In prints out a message to say what its
doing, and stops on user input.  The variable
`pabbrev-short-idle-timer' is the other.
The idea here is that the short timer will pick up most of the recent
changes, and will not bother the user.  The long timer will slowly
gather up the whole buffer, telling the user what it is doing, in case
it takes up too much processor.  If this happened after a second it
would be irritating in the extreme.")

(defvar pabbrev-short-idle-timer nil
  "Timer which adds a few words.
See `pabbrev-long-idle-timer'.")

(defun pabbrev-get-usage-hash()
  "Return the usage hash for this buffer."
  (let((hash (get major-mode 'pabbrev-usage-hash)))
    (unless hash
      (put major-mode 'pabbrev-usage-hash
           (setq hash (make-hash-table :test 'equal)))
      (push major-mode pabbrev-usage-hash-modes))
    hash))

(defsubst pabbrev-get-usage-dictionary-size()
  "Return the size of the usage hash."
  (hash-table-count (pabbrev-get-usage-hash)))

(defun pabbrev-get-total-usages-dictionary()
  "Return the total number of usages from the usage hash."
  (interactive)
  (let ((size 0))
    (maphash
     (lambda(_key value)
       (setq size (+ size (cdr value))))
     (pabbrev-get-usage-hash))
    size))

(defun pabbrev-get-prefix-hash()
  "Return the prefix hash for the current buffer."
  (let((hash (get major-mode 'pabbrev-prefix-hash)))
    (unless hash
      (put major-mode 'pabbrev-prefix-hash
           (setq hash (make-hash-table :test 'equal)))
      (push major-mode pabbrev-prefix-hash-modes))
    hash))

(defun pabbrev-add-word-usage (word)
  "Add a WORD to the usage hash.
This is a function internal to the data structures.  The
`pabbrev-add-word' is the main entry point to this functionality."
  (let ((value
         (gethash
          ;; look for word usage cons we need a cons, but the last
          ;; value is irrelevant.
          word (pabbrev-get-usage-hash))))
    ;; so now we have cons, or nil
    (if value
        ;; increment occurences
        (setcdr value (+ 1 (cdr value)))
      ;; we have no so make is
      (setq value (cons word 1)))
    ;; so now we the cons cell for sure
    ;; possible we should do this above, as I think it only needs
    ;; doing for a new cons.
    (puthash word value (pabbrev-get-usage-hash)) value))

(defsubst pabbrev-comparitor-function(a b)
  (> (cdr a) (cdr b)))

(defsubst pabbrev-sort-alist(alist)
  ;; this sort is bit poor. It should be possible to do this in less
  ;; than linear time, rather than n(log-n) as now. I think most of
  ;; the time is spent entering the lambda function. The irony is that
  ;; the sort is more or less sorted from the start, so a bubble sort
  ;; would work in linear time. I've tried replacing with a linear
  ;; sort, that is just placing the cons in the correct place, but in
  ;; my hands, it's three or four times slower, on this buffer which
  ;; has a lot of common prefixes, and so should take a while,
  ;; probably because too much has to be done in lisp rather than with
  ;; builtin's.
  ;;
  ;; Possibly the sort could be done on removing the value from the
  ;; hash, which would reduce the amount of sorting that needs to be
  ;; done. But it would then be in the command cycle rather than the
  ;; idle loop, which seems like a really bad idea to me.
  ;;
  ;; When I wrote the data structures this was a bit of a worry as
  ;; emacs spent most of its time in this loop, but now I've bolted
  ;; on a user interface, its not so much of a problem, as plenty of
  ;; time is spent in placing on the "been here" overlays....
  (sort alist #'pabbrev-comparitor-function)) ; inlined, is speed ok?
        ;;(lambda(a b) (> (cdr a) (cdr b)))))

(defun pabbrev-add-word-cons-with-prefix (prefix conscell)
  "Add a word usage, and a PREFIX.
This function is internal to the data structures, and should normally
only be called, by `pabbrev-add-word'.  CONSCELL should be cons
returned from `pabbrev-add-word-usage', while PREFIX should be a
prefix of the from the cons cell."
  (let
      ;; this should be an alist or nil
      ((value (gethash prefix (pabbrev-get-prefix-hash))))
    (if value
        ;; so we have an alist. Has our word been added to this alist
        ;; before? If not, do so. If it has been added, then it will
        ;; have been updated with the addition of the word
        (unless (member conscell value)
          (setq value (cons conscell value)))
      ;; nothing in there, so create an alist with
      ;; a single element
      (setq value (list conscell)))
    ;; so we now have the value alist...sort it and store it back in
    ;; the hash
    (puthash prefix (pabbrev-sort-alist value) (pabbrev-get-prefix-hash))))

(defun pabbrev-add-word (word)
  "Add the usage of a WORD to the current dictionary."
  (let ((conscell (pabbrev-add-word-usage word)))
    (dotimes (i (- (length word) 1))
      (pabbrev-add-word-cons-with-prefix
       (substring word 0 (1+ i)) conscell))))

(defsubst pabbrev-fetch-all-suggestions-for-prefix(prefix)
  "Return the suggestions for a given PREFIX.
Results are an alist, with cons with car of the word, and cdr of the
number of usages seen so far. This alist should NOT be altered, its
it's ordering is part of the core data structures"
  (gethash prefix (pabbrev-get-prefix-hash)))
;; Which completes the core data structures.

;; This code provides the minor mode which displays, and accepts
;; abbreviations.
(defvar pabbrev-mode-map
  (let ((map (make-sparse-keymap)))

    ;; It should be possible to reconfigure this now, although there is special
    ;; handling in `pabbrev-get-previous-binding' for tab and return and this
    ;; might be needed for other bindings also.

    ;; \t works in tty but gets overridden by the [tab] binding elsewhere.
    (define-key map "\t" #'pabbrev-expand-maybe)
    ;; This is not needed since function-key-map remaps a `tab' into a \t.
    ;;(define-key map [tab] #'pabbrev-expand-maybe)
    map)
  "Keymap for pabbrev-minor-mode.")

(defsubst pabbrev-bounds-of-thing-at-point()
  "Get the bounds of the thing at point"
  (bounds-of-thing-at-point pabbrev-thing-at-point-constituent))

(defsubst pabbrev-thing-at-point()
  "Get thing at point."
  (when-let ((bounds (pabbrev-bounds-of-thing-at-point)))
    (buffer-substring-no-properties (car bounds) (cdr bounds))))

(defun pabbrev-start-idle-timer ()
  (setq pabbrev-long-idle-timer
        (run-with-idle-timer 5 t #'pabbrev-idle-timer-function))
  (setq pabbrev-short-idle-timer
        (run-with-idle-timer 1 t #'pabbrev-short-idle-timer)))

(defun pabbrev-ensure-idle-timer ()
  (unless nil
    (if (not (and pabbrev-short-idle-timer
                  pabbrev-long-idle-timer))
        (pabbrev-start-idle-timer))))

;;;###autoload
(define-minor-mode pabbrev-mode
  "Toggle pabbrev mode.
With arg, turn on Predicative Abbreviation mode if and only if arg is
positive.

This mode is another abbreviation expansion mode somewhat like
`dabbrev-expand', in that it looks through the current buffer for
symbols that can complete the current symbol. Unlike `dabbrev-expand',
it does this by discovering the words during the Emacs idle time, and
places the results into data structures which enable very rapid
extraction of expansions. The upshot of this is that it can offer
suggestions as you type, without causing an unacceptable slow down.

There is an associated `global-pabbrev-mode' which turns on the mode
on in all buffers.
"
  :global nil
  :lighter " Pabbrev"
  :keymap pabbrev-mode-map
  (when (and pabbrev-mode buffer-read-only pabbrev-read-only-error)
    ;; FIXME: Signaling an error makes no sense.  Just make it a `message'
    ;; and get rid of pabbrev-read-only-error.  After all, the user can
    ;; enable/disable read-only-mode after pabbrev-mode.
    (message "Can not use pabbrev-mode in read only buffer"))
  (cond
   (pabbrev-mode
    (add-hook 'pre-command-hook #'pabbrev-pre-command-hook nil t)
    (add-hook 'post-command-hook #'pabbrev-post-command-hook nil t)
    ;; Switch on the idle timer if required when the mode is switched on.
    (pabbrev-ensure-idle-timer)
    ;; Also run the idle timer function, to put some works in the
    ;; dictionary.
    (pabbrev-scavenge-some))
   (t
    (remove-hook 'pre-command-hook #'pabbrev-pre-command-hook t)
    (remove-hook 'post-command-hook #'pabbrev-post-command-hook t))))

;;   (easy-mmode-define-minor-mode pabbrev-mode
;;                              "Toggle pabbrev mode.
;; This mode is an abbreviation expansion mode. It looks through the
;; current buffer, and offers expansions based on the words already
;; there.

;;;###autoload
(define-global-minor-mode global-pabbrev-mode
  pabbrev-mode pabbrev-global-mode)

(defun pabbrev-global-mode()
  "Switch on `pabbrev-mode' in current buffer if appropriate.
Currently appropriate means, if the buffer is not read only, and is
not a minibuffer."
  (unless (or buffer-read-only
              pabbrev-mode
              (get major-mode 'pabbrev-global-mode-excluded-modes)
              ;; don't turn on in non listable buffers
              (equal (substring (buffer-name) 0 1) " ")
              (when pabbrev-global-mode-buffer-size-limit
                (> (buffer-size) pabbrev-global-mode-buffer-size-limit))
              (member (buffer-name) pabbrev-global-mode-not-buffer-names)
              (window-minibuffer-p (selected-window)))
    (let
        ;; set the chunk size low, or the global mode takes for ever
        ;; to switch on
        ((pabbrev-scavenge-some-chunk-size 0))
      (pabbrev-mode))))

(defvar-local pabbrev-marker nil
  "Location of current insertion, or nil.
This variable is not actually a marker, but a cons of
start and end positions")

(defvar-local pabbrev-expansion nil
  "Currently displayed expansion, or nil.")

(defvar-local pabbrev-expansion-suggestions nil
  "Current expansion suggestions, or nil.")

(defvar-local pabbrev-marker-last-expansion nil
  "Marks where the last possible expansion was.")

(defvar-local pabbrev-overlay nil
  "Overlay for offered completion.")

(defsubst pabbrev-delete-overlay()
  "Make overlay invisible."
  (when pabbrev-overlay
    (delete-overlay pabbrev-overlay)))

(defsubst pabbrev-delete-last-suggestion()
  "Remove previously inserted suggestions."
  ;; I don't think we need to check for buffer-read-only
  ;; here, because pabbrev-marker will always be nil in a
  ;; read only buffer. I could be wrong about this of
  ;; course.
  (pabbrev-delete-overlay)
  (setq pabbrev-marker nil))

;;(defun test()(interactive)(let ((last-command 'self-insert-command))(pabbrev-post-command-hook)))

;;(defun test()
;;   (interactive)
;;   (pabbrev-insert-suggestion
;;    (pabbrev-thing-at-point)
;;    (cdr (pabbrev-bounds-of-thing-at-point))
;;    (pabbrev-fetch-all-suggestions-for-prefix
;;     (pabbrev-thing-at-point))))

(defun pabbrev-post-command-hook()
  "Offer expansion if appropriate.
This function is normally run off the `post-command-hook'."
  (condition-case err
      ;; pabbrev will not switch on in a read only buffer. But the
      ;; buffer may have become read only between the time that it was
      ;; switched on, and now. So we need to check this anyway.
      (unless (or buffer-read-only (window-minibuffer-p (selected-window)))
        (save-excursion
          ;; ensure that any suggestion is deleted.
          (when pabbrev-marker
            (pabbrev-delete-last-suggestion))
          (let ((word (pabbrev-thing-at-point))
                (bounds (pabbrev-bounds-of-thing-at-point))
                (suggestions))
            (when (and
                   ;; last command was a symbol
                   ;; PWL last-command to this-command
                   (symbolp this-command)
                   ;; we have just had an appropriate command
                   ;; PWL commented out and testing change suggestd by Ye Wenbin
                   ;;(get last-command 'pabbrev-expand-after-command)
                   (get this-command 'pabbrev-expand-after-command)
                   ;; is word at point
                   word
                   ;; we are at the end of it.
                   (= (point) (cdr bounds))
                   ;; and we have some suggestions.
                   (setq suggestions (pabbrev-fetch-all-suggestions-for-prefix word)))
              (pabbrev-insert-suggestion word suggestions)
              (pabbrev-post-command-check-movement)))))
    (error
     (pabbrev-command-hook-fail err "post"))))

(defvar pabbrev-expand-commands
  '(pabbrev-expand-maybe pabbrev-expand
    pabbrev-expand-maybe-minimal pabbrev-expand-maybe-full)
  "List of commands which will be used expand.
We need to know this, or the possible expansions are deleted
before the command gets run.")

(defun pabbrev-pre-command-hook()
  "Remove offering expansion from the buffer, if present.
This function is normally run off the `pre-command-hook'"
  (condition-case err
      (progn
        (unless (memq this-command pabbrev-expand-commands)
          (setq pabbrev-expansion nil
                pabbrev-expansion-suggestions nil))
        (when pabbrev-marker
          (pabbrev-delete-last-suggestion)))
    ;;catch the error
    (error
     (pabbrev-command-hook-fail err "pre"))))

(defun pabbrev-command-hook-fail(err hook)
  "Advise user of a failure command-hooks.
This function should only run as the result of a bug.
A message is sent, as we can do little else safely,
on the `post-command-hook', or `pre-command-hook'."
  (message "pabbrev mode has failed on %s hook: %s "
           hook (error-message-string err))
  (remove-hook 'pre-command-hook #'pabbrev-pre-command-hook t)
  (remove-hook 'post-command-hook #'pabbrev-post-command-hook t)
  (with-output-to-temp-buffer "*pabbrev-fail*"
    (princ "There has been an error in pabbrev-mode. This mode normally
makes use of \"post-command-hook\", which runs after every command. If this
error continued Emacs could be made unusable, so pabbrev-mode has attempted
to disable itself. So although it will appear to still be on, it won't do
anything. Toggling it off, and then on again will usually restore functionality.\n")
    (princ "The following is debugging information\n\n")
    (princ (error-message-string err))
    (princ "\n\nBacktrace is: \n" )
    (let ((standard-output (get-buffer "*pabbrev-fail*" )))
      (backtrace)))
  (select-window (get-buffer-window "*pabbrev-fail*"))
  (error "Error in pabbrev-mode"))

(defsubst pabbrev-debug-get-buffer()
  (get-buffer-create "*pabbrev-debug"))

(defsubst pabbrev-marker-last-expansion()
  "Fetch marker for last offered expansion."
  (or pabbrev-marker-last-expansion
      (setq pabbrev-marker-last-expansion
            (set-marker (make-marker) (point) (current-buffer)))))

(defsubst pabbrev-update-marker()
  (set-marker (pabbrev-marker-last-expansion) (point) (current-buffer)))

(defvar pabbrev-debug-enabled nil)
(defmacro pabbrev-debug-message(&rest body)
  `(when pabbrev-debug-enabled
     (let ((insert (concat (format ,@body) "\n")))
       (with-current-buffer (pabbrev-debug-get-buffer)
         (goto-char (point-max))
         (insert insert)
         (pabbrev-debug-frame-scroll)))))

(defun pabbrev-post-command-check-movement()
  (let ((distance
         (abs (- (point) (marker-position
                          (pabbrev-marker-last-expansion))))))
    (when (> distance pabbrev-marker-distance-before-scavenge)
      ;; we have moved a lot in the buffer
      (pabbrev-debug-message "Scavenge due to buffer marker")
      (pabbrev-scavenge-some)
      (pabbrev-update-marker))))

(defun pabbrev-set-overlay(start end count)
  "Move overlay to START END location."
  (unless pabbrev-overlay
    (setq pabbrev-overlay
          ;; set an overlay at 1 1. Originally this used to be a 0 0 but
          ;; it crashes XEmacs...well I never....
          (make-overlay 1 1)))
  (overlay-put pabbrev-overlay 'face
               (if (> count 1)
                   'pabbrev-suggestions-face
                 'pabbrev-single-suggestion-face))
  (move-overlay pabbrev-overlay start end (current-buffer)))

(defun pabbrev-insert-suggestion(prefix suggestions)
  "Insert a suggestion into the buffer.
The suggestion should start with PREFIX, and be entered at point."
  (interactive)
  (let* ((suggestion
          (if (not pabbrev-minimal-expansion-p)
              (car (car suggestions))
            (try-completion "" suggestions)))
         (expansion
           (if suggestion
               (substring suggestion (length prefix))
             "")))
    (when (< 0 (length expansion))
      ;; Add the abbreviation to the buffer.
      (setq pabbrev-expansion expansion
            pabbrev-expansion-suggestions suggestions)
      (pabbrev-set-overlay (point) (point) (length suggestions))
      (setq pabbrev-marker (cons (point) (point)))
      (overlay-put pabbrev-overlay
                   'after-string
                   (concat
                    (propertize "[" 'cursor 1)
                    (propertize expansion
                                'face (overlay-get pabbrev-overlay 'face))
                    "]")))))

(defvar pabbrev-last-expansion-suggestions nil
  "Cached alternative suggestions from the last expansion.")

;; patch from Trey Jackson to fix problem with python (which uses tab to cycle
;; through indentation levels
(defun pabbrev-call-previous-tab-binding ()
  "Call the function normally associated with [tab]."
  (let ((prev-binding (pabbrev-get-previous-binding)))
    (when (and (fboundp prev-binding)
               (not (eq prev-binding 'pabbrev-expand-maybe)))
      (let ((last-command (if (eq last-command this-command)
                              prev-binding
                            last-command))
            (this-command prev-binding))
        (if (eq 'self-insert-command prev-binding)
            (self-insert-command 1)
          (funcall prev-binding))))))

;; (defun pabbrev-call-previous-tab-binding ()
;;   "Call the function normally associated with [tab]."
;;   (let ((prev-binding (pabbrev-get-previous-binding)))
;;     (if (and (fboundp prev-binding)
;;              (not (eq prev-binding 'pabbrev-expand-maybe)))
;;         (funcall prev-binding))))

(defun pabbrev-expand-maybe(uarg)
  "Call appropriate expansion command based on whether minimal or
full expansion is desired. If there is no expansion the command
returned by `pabbrev-get-previous-binding' will be run instead.
A prefix argument means offer a menu of expansions.
UARG is the prefix argument."
  (interactive "p")
  (if pabbrev-minimal-expansion-p
      (pabbrev-expand-maybe-minimal uarg)
    (pabbrev-expand-maybe-full uarg)))

(defun pabbrev-expand-maybe-minimal (uarg)
  "Expand the minimal common prefix at point.
With prefix argument, bring up the menu of all full expansions.
UARG is the prefix argument."
  (cond
   ((and (= uarg 4) (> (length pabbrev-expansion-suggestions) 1))
    (pabbrev-suggestions-goto-buffer pabbrev-expansion-suggestions))
   (pabbrev-expansion
    (pabbrev-expand))
   (t (pabbrev-call-previous-tab-binding))))

(defun pabbrev-expand-maybe-full (uarg)
  "Expand fully to the most common abbreviation at point.
With prefix argument, bring up a menu of all full expansions.
UARG is the prefix argument."
  (cond
   ((and (= uarg 4) (> (length pabbrev-expansion-suggestions) 1))
    (pabbrev-suggestions-goto-buffer pabbrev-expansion-suggestions))
   ((and (eq last-command 'pabbrev-expand-maybe)
         (> (length pabbrev-expansion-suggestions) 1)
         (> (length pabbrev-last-expansion-suggestions) 1))
    (pabbrev-suggestions-goto-buffer pabbrev-last-expansion-suggestions))
   (pabbrev-expansion
    (setq pabbrev-last-expansion-suggestions pabbrev-expansion-suggestions)
    (pabbrev-expand))
   (t (pabbrev-call-previous-tab-binding))))

;; (setq pabbrev-minimal-expansion-p nil)

(defun pabbrev-show-previous-binding ()
  "Print the previous binding.
Debugging function."
  (interactive)
  (message "Previous binding is: %s" (pabbrev-get-previous-binding)))

(defun pabbrev-get-previous-binding ()
  "Show the binding of tab if pabbrev were not active.
The command `pabbrev-show-previous-binding' prints this out."
  (let ((pabbrev-mode nil))
    ;; tab is special, because we can bind both [tab]
    ;; and \t. Normally, pabbrev binds to [tab] but for example
    ;; so this-command-keys-vector returns [tab]. But, emacs-lisp-mode for
    ;; instance, binds to \t. Now this has been overridden by the pabbrev
    ;; binding for [tab]. But if we check for previous binding for [tab] it
    ;; will be nil, because emacs-lisp-mode binds \t and not [tab]. So,
    ;; we check for tab and return either the binding for tab or the binding
    ;; for \t which should work regardless of what the mode binds.
    ;; Likewise return it seems!
    (let ((tckv (this-command-keys-vector)))
      (cond
       ((or (equal tckv [tab]) (equal tckv [9]))
        (or (key-binding [tab]) (key-binding "\t")))
       ((or (equal tckv [return]) (equal tckv [32]))
        (or (key-binding [return]) (key-binding "\n")))
       (t (key-binding tckv))))))

    ;; ;; This is the original and satisfying solution
    ;; (key-binding (this-command-keys))))
    ;; This is the new and unsatisfying one. The
    ;; keybindings are hard coded here, because I defined
    ;; [tab] and \t earlier. Both are tab, but the former
    ;; gets used in preference to the later.
;;    (or (key-binding [tab])
;;        (key-binding "\t"))))

;;           ;; I think that I have this worked out now.
;;           (if (eq prev-binding 'pabbrev-expand-maybe)
;;               (message "pabbrev known bug! Avoiding recursive tab")
;;             (funcall prev-binding))))))

;;     (define-key pabbrev-mode-map "\t" nil)
;;     (let ((tunneled-keybinding (key-binding "\t")))
;;       (if (and (fboundp tunneled-keybinding)
;;                (not (eq tunneled-keybinding 'pabbrev-expand-maybe)))
;;           (funcall tunneled-keybinding)))
;;     (define-key pabbrev-mode-map "\t" 'pabbrev-expand-maybe)))

(defvar pabbrev-expand-previous-word nil)
(defun pabbrev-expand()
  "Expand abbreviation"
  (setq pabbrev-expand-previous-word (pabbrev-thing-at-point))
  (if pabbrev-expansion
      (insert pabbrev-expansion)
    (message "No expansion"))
  (setq pabbrev-expansion nil))

(defvar pabbrev-window-configuration nil
  "Stores the window configuration before presence of a window buffer.")

;; suggestions buffer
;; (defvar pabbrev-suggestions-buffer-enable nil)
;; (defun pabbrev-suggestions-toggle()
;;   "NOT FULLY FUNCTIONAL. Enable interactive suggestions window.
;; This is just a test function at the moment. The idea is that you will
;; be able to see alternate suggestions as you type. This will be most
;; useful in a programming buffer. At the moment there is no way of
;; actually selecting these abbreviations. But it appears that the core
;; data structures are quick enough to work."
;;   (interactive)
;;   (if pabbrev-suggestions-buffer-enable
;;       (progn
;;         (setq pabbrev-suggestions-buffer-enable nil)
;;         (remove-hook 'post-command-hook
;;                      'pabbrev-suggestions-delete-window)
;;         (delete-window (get-buffer-window " *pabbrev suggestions*"))
;;         (message "pabbrev suggestions off"))
;;     (setq pabbrev-suggestions-buffer-enable t)
;;     (add-hook 'post-command-hook
;;               'pabbrev-suggestions-delete-window)
;;     (message "pabbrev suggestions on")))

(defun pabbrev-suggestions-delete-window()
  "Delete the suggestions window."
  (interactive)
  (when (or pabbrev-mode (equal (buffer-name) " *pabbrev suggestions*"))
    (delete-window (get-buffer-window " *pabbrev suggestions*"))
    (set-window-configuration pabbrev-window-configuration)))

;; (defun pabbrev-post-command-delete-suggestions()
;;   (interactive)
;;   (if pabbrev-suggestions-buffer-enable
;;       (progn
;;      ;; this isn't perfect. The window pops up in a fairly random place.
;;         (with-output-to-temp-buffer " *pabbrev suggestions*")
;;        (shrink-window-if-larger-than-buffer (get-buffer-window " *pabbrev suggestions*")))))

;; (defun pabbrev-post-command-show-suggestions(suggestions prefix)
;;   (if pabbrev-suggestions-buffer-enable
;;       (pabbrev-suggestions-buffer suggestions prefix)))


(defun pabbrev-suggestions-goto-buffer(suggestion-list)
  "Jump into the suggestions buffer."
  ;;  (if pabbrev-suggestions-buffer-enable
  ;;    (pabbrev-suggestions-delete-window))
  (setq pabbrev-window-configuration (current-window-configuration))
  (pabbrev-suggestions-buffer suggestion-list "")
  (shrink-window-if-larger-than-buffer
   (select-window (get-buffer-window " *pabbrev suggestions*"))))

(defvar pabbrev-suggestions-from-buffer nil)
(defvar pabbrev-suggestions-done-suggestions nil)
(defvar pabbrev-suggestions-best-suggestion nil)

(defsubst pabbrev-suggestions-limit-alpha-sort (suggestions)
  "Limit suggestions and sort."
  (delq nil
        (sort (seq-take suggestions 10)
              (lambda(a b)
                (string< (car a) (car b))))))

(defsubst pabbrev-suggestions-setup()
  "Set up suggestions major mode."
  (pabbrev-select-mode))

(defun pabbrev-suggestions-buffer(suggestions _prefix)
  "Form the suggestions buffer."
  (with-output-to-temp-buffer " *pabbrev suggestions*"
    (setq pabbrev-suggestions-from-buffer (current-buffer)
          pabbrev-suggestions-best-suggestion (car suggestions)
          pabbrev-suggestions-done-suggestions
          (pabbrev-suggestions-limit-alpha-sort suggestions)
          suggestions pabbrev-suggestions-done-suggestions)
    (let ((window-width (- (window-width) 1)))
      (with-current-buffer (get-buffer " *pabbrev suggestions*")
        (pabbrev-suggestions-setup)`
        (princ
         (concat ;;"Current Word: " prefix " "
          "Max Substring: " (try-completion "" suggestions)
          "\n"))
        (princ
         (concat
          "Best Match: " (car pabbrev-suggestions-best-suggestion)
          "\n"))
        (when suggestions
          (dotimes (i 10)
            ;; are we less than the suggestions
            (when (< i (length suggestions))
              (goto-char (point-max))
              ;; insert all the suggestions
              (let ((next-suggestion
                     (concat (number-to-string i) ") "
                             (car (nth i suggestions)) " " ))
                    (line-length
                     (- (line-end-position) (line-beginning-position))))
                ;; if well. are not on the first suggestion,
                (when (and (> i 0)
                           ;; and the line will be too long
                           (< window-width
                              (+ line-length (length next-suggestion))))
                  ;; add a new line.
                  (princ "\n"))
                (princ next-suggestion)
                (let ((start (- (point) (length next-suggestion))))
                  (overlay-put
                   (make-overlay start (+ 2 start))
                   'face 'pabbrev-suggestions-label-face)))))))))
  (shrink-window-if-larger-than-buffer (get-buffer-window " *pabbrev suggestions*")))

(defvar pabbrev-select-mode-map
  (let ((map (make-sparse-keymap)))
    (cl-loop for i from ?! to ?~ do
             (define-key map (char-to-string i) #'ignore))
    (define-key map "\t"     #'pabbrev-suggestions-select-default)
    (define-key map [delete] #'pabbrev-suggestions-delete)
    (define-key map "\C-?"   #'pabbrev-suggestions-delete)
    (define-key map "\C-m"   #'pabbrev-suggestions-minimum)
    (define-key map " "      #'pabbrev-suggestions-delete-window)
    (define-key map "q"      #'pabbrev-suggestions-delete-window)
    ;; Define all the standard insert commands.
    (dotimes (i 10)
      (define-key map (number-to-string i) #'pabbrev-suggestions-select))
    map))

(define-derived-mode pabbrev-select-mode fundamental-mode ;Use special-mode?
  "Pabbrev Select"
  "Major mode for selecting `pabbrev-mode' expansions.
The number keys selects the various possible expansions. \\[pabbrev-suggestions-delete]
removes the previously added expansion, \\[pabbrev-suggestions-minimum] selects the minimum
matching substring, while \\[pabbrev-suggestions-delete-window] just deletes the window
\\{pabbrev-select-mode-map}")

(defun pabbrev-suggestions-select-default()
  "Select the most commonly occuring string."
  (interactive)
  (when pabbrev-suggestions-best-suggestion
    (pabbrev-suggestions-insert (car pabbrev-suggestions-best-suggestion))))

(defun pabbrev-suggestions-delete()
  "Delete the last suggestion."
  (interactive)
  (pabbrev-suggestions-insert pabbrev-expand-previous-word))

(defun pabbrev-suggestions-minimum()
  "Select the maximally occuring substring."
  (interactive)
  (pabbrev-suggestions-insert
   ;;(try-completion "" pabbrev-suggestions-done-suggestions)))
   (try-completion "" (seq-take pabbrev-suggestions-done-suggestions 10))))

(defun pabbrev-suggestions-insert(insertion)
  "Actually insert the suggestion."
  (let ((point))
    (with-current-buffer
        pabbrev-suggestions-from-buffer
      (let ((bounds (pabbrev-bounds-of-thing-at-point)))
        (delete-region (car bounds) (cdr bounds))
        (insert insertion)
        (setq point (point))))
    (pabbrev-suggestions-delete-window)
    (when point (goto-char point))))

(defun pabbrev-suggestions-select(&optional index)
  "Select one of the numbered suggestions."
  (interactive)
  (let ((insert-index
         (or index (string-to-number (char-to-string last-command-event)))))
    (when (< insert-index (length pabbrev-suggestions-done-suggestions))
      (pabbrev-suggestions-insert
       (car (nth insert-index pabbrev-suggestions-done-suggestions))))))

;; These functions define movement around the buffer, which
;; determines what pabbrev considers to be a "word"
(defun pabbrev-forward-thing(&optional number)
  "Move forward a pabbrev word. Or backwards if number -1"
  (interactive)
  (forward-thing pabbrev-thing-at-point-constituent number))

;; These functions deal with scavenging word usage from the buffer,
;; which are then added to the dictionary.
(defun pabbrev-bounds-marked-p (start end)
  "Return t if anywhere between START and END is marked."
  (save-excursion
    (let ((retn))
      (cl-do ((i start (1+ i)))
          ((> i end))
        (when (setq retn (get-text-property i 'pabbrev-added))
          (setq i end)))
      retn)))

;;(setq pabbrev-debug-display t)
(defvar pabbrev-debug-display nil
  "If t visible mark the progress of function `pabbrev-mode' through the buffer.
This looks very ugly.  Note that this only shows newly added words.  Use
`pabbrev-debug-remove-properties' to clear this invisible markers.  Use
`pabbrev-debug-show-all-properties' to show existing markers.")

(defsubst pabbrev-debug-display (start end)
  (when pabbrev-debug-display
    (overlay-put
     (make-overlay start end)
     'face 'pabbrev-debug-display-label-face)))

(defun pabbrev-mark-add-word (bounds)
  "Add word in BOUNDS as abbreviation, and mark the buffer."
  (when bounds
    (let ((start (car bounds))
          (end (cdr bounds)))
      (unless
          ;; is this word or part of it already added?
          (pabbrev-bounds-marked-p start end)
        ;; mark the word visibly as well.
        (pabbrev-debug-display start end)
        ;; set a property so that we know what we have done.
        (with-silent-modifications
          (add-text-properties start end '(pabbrev-added t)))
        ;; and add the word to the system.
        (pabbrev-add-word
         (buffer-substring-no-properties start end))))))

(defun pabbrev-scavenge-some()
  "Gather some words up from around point"
  (interactive)
  (save-excursion
    ;; move somewhat away from point, as this is likely to not contain
    ;; complete words.
    (pabbrev-forward-thing -2)
    (pabbrev-scavenge-words -1 (* 2 pabbrev-scavenge-some-chunk-size))
    (save-excursion
      (pabbrev-forward-thing 2)
      (pabbrev-scavenge-words 1 pabbrev-scavenge-some-chunk-size))))

(defun pabbrev-scavenge-region()
  (interactive)
  (narrow-to-region (region-beginning) (region-end))
  (pabbrev-scavenge-buffer))

(defun pabbrev-scavenge-buffer-fast()
  (interactive)
  (message "pabbrev fast scavenging buffer...")
  (save-excursion
    (goto-char (point-min))
    (while (pabbrev-forward-thing)
      (let* ((bounds (pabbrev-bounds-of-thing-at-point))
             (start (car bounds))
             (stop (cdr bounds)))
        (unless (pabbrev-bounds-marked-p start stop)
          (pabbrev-add-word
           (buffer-substring-no-properties start stop)))))

    (pabbrev-debug-message "Dictionary size %s total usage %s"
                           (pabbrev-get-usage-dictionary-size)
                           (pabbrev-get-total-usages-dictionary))
    (with-silent-modifications
     (add-text-properties (point-min) (point-max) '(pabbrev-added t)))
    (message "pabbrev fast scavenging buffer...done.")))

(defun pabbrev-scavenge-buffer()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((pr (make-progress-reporter "pabbrev scavenging buffer"
                                      (point) (point-max))))
      (while (pabbrev-forward-thing)
        (progress-reporter-update pr (point))
        (pabbrev-mark-add-word
         (pabbrev-bounds-of-thing-at-point)))
      (progress-reporter-done pr))
    (pabbrev-debug-message "Dictionary size %s total usage %s"
                           (pabbrev-get-usage-dictionary-size)
                           (pabbrev-get-total-usages-dictionary))
    (message "pabbrev scavenging buffer...done.")))

(defun pabbrev-scavenge-words(&optional direction number)
  "Scavenge words from current buffer, starting from point.
DIRECTION is in which direction we should work,
NUMBER is how many words we should try to scavenge"
  (unless direction (setq direction 1))
  (unless number (setq number 20))
  (save-excursion
    (dotimes (_ number)
      (pabbrev-forward-thing direction)
      (pabbrev-mark-add-word
       (pabbrev-bounds-of-thing-at-point)))
    (point)))

;;(setq  pabbrev-disable-timers t)
(defvar pabbrev-disable-timers nil)
;; I don't understand why this is necessary but it seems to help the
;; slow idle timer work in the correct buffer. I suspect someother
;; timer is screwing up with the current buffer...
(defvar pabbrev-timer-buffer nil)

(defun pabbrev-short-idle-timer(&optional buffer)
  "Add a few words to the dictionary."
  (with-current-buffer
      (or buffer (current-buffer))
    ;; remember which buffer we have just looked at.
    (setq pabbrev-timer-buffer (current-buffer))
    (when (and pabbrev-mode (not pabbrev-disable-timers))
      (pabbrev-debug-message "running short idle timer")
      ;;(message "Running short timer in %s" (current-buffer))

      (pabbrev-scavenge-some)
      (pabbrev-debug-message "Dictionary size %s total usage %s"
                             (pabbrev-get-usage-dictionary-size)
                             (pabbrev-get-total-usages-dictionary)))))

(defun pabbrev-idle-timer-function(&optional buffer)
  ;; so this only works on the current buffer. Might want to scavenge
  ;; over other buffers
  (when-let ((first-live-b
              (seq-find
               #'buffer-live-p
               (list buffer pabbrev-timer-buffer (current-buffer)))))
    (with-current-buffer first-live-b
      (if (and pabbrev-mode (not pabbrev-disable-timers))
          (pabbrev-idle-timer-function-0)
        (pabbrev-debug-message "idle running in non pabbrev-mode")))))

;; for some reason that I do not understand yet, this sometimes
;; appears to work in the wrong buffer. I really have not got any idea
;; why this is the case.
(defun pabbrev-idle-timer-function-0()
  "Add all words to the buffer.

`pabbrev-scavenge-buffer' does this more efficiently interactively.
If it up too much processor power, see `pabbrev-scavenge-some-chunk-size'."
  (let ((forward-marker (point))
        (backward-marker (point))
        (forward-complete nil)
        (backward-complete nil)
        (repeat t))
    (when pabbrev-idle-timer-verbose
      (message "pabbrev scavenging..."))
    (pabbrev-debug-message "running idle timer at %s" (point))
    (while (and repeat
                (not (and forward-complete backward-complete)))
      (save-excursion
        (unless backward-complete
          (goto-char backward-marker)
          (setq backward-marker
                (pabbrev-scavenge-words -1
                                        (* 2 pabbrev-scavenge-some-chunk-size)))
          (setq backward-complete
                (eq (point-min) backward-marker))
          (pabbrev-debug-message "searching backward to %s complete %s"
                                 backward-marker backward-complete))
        (unless forward-complete
          (goto-char forward-marker)
          (setq forward-marker
                (pabbrev-scavenge-words 1 pabbrev-scavenge-some-chunk-size))
          (setq forward-complete
                (eq (point-max) forward-marker))
          (pabbrev-debug-message "searching forward to %s complete %s"
                                 forward-marker forward-complete)))
      (pabbrev-debug-message "Dictionary size %s total usage %s"
                             (pabbrev-get-usage-dictionary-size)
                             (pabbrev-get-total-usages-dictionary))

      (when pabbrev-idle-timer-verbose
        (message "pabbrev scavenging (%s words %s buffer)..."
                 (pabbrev-get-usage-dictionary-size)
                 (buffer-name (current-buffer))))
      (setq repeat (sit-for 0.1)))
    (when pabbrev-idle-timer-verbose
      (message "pabbrev scavenging...done")
      (sit-for 2)
      (message nil))))

(defun pabbrev-shut-up()
  "Switch off verbose messages..."
  (interactive)
  (message "Swiching off pabbrev messages" )
  (setq pabbrev-idle-timer-verbose nil))

;;; The following are debug functions.
(defvar pabbrev-debug-buffer nil)

;;(setq pabbrev-debug-enabled t)
(defvar pabbrev-debug-enabled nil)

(defun pabbrev-debug()
  (interactive)
  (pabbrev-debug-frame)
  (setq pabbrev-debug-enabled t))

(defvar pabbrev-debug-frame nil)
(defun pabbrev-debug-frame ()
  (interactive)
  (when (not pabbrev-debug-frame)
      (setq pabbrev-debug-frame
            (make-frame '((width . 30)
                          (height . 30))))
      (select-frame pabbrev-debug-frame)
      (switch-to-buffer (pabbrev-debug-get-buffer))))

(defun pabbrev-debug-frame-scroll ()
  (save-excursion
    (when pabbrev-debug-frame
        (select-frame pabbrev-debug-frame)
        (switch-to-buffer (pabbrev-debug-get-buffer))
        (goto-char (point-max)))))

(defface pabbrev-debug-display-label-face
  '((t
     (:underline "navy")))
  "Font Lock mode face used to highlight suggestions")

(defun pabbrev-debug-erase-all-overlays()
  "Kill all visible overlays from the current buffer. "
  (interactive)
  (pabbrev-debug-remove-properties)
  (mapcar
   (lambda(overlay)
     (when (eq 'pabbrev-debug-display-label-face
               (overlay-get overlay 'face))
       (delete-overlay overlay)))
   (overlays-in (point-min) (point-max))))

(defun pabbrev-debug-show-all-properties()
  "Show all existing markers.
This can be rather slow."
  (interactive)
  (goto-char (point-min))
  (let ((on-mark-state nil)
        (on-mark))
    (while t
      (setq on-mark (get-text-property (point) 'pabbrev-added))
      (message "On line %s" (count-lines (point-min) (point)))
      (cond
       ;; just moved onto marked area
       ((and on-mark (not on-mark-state))
        (setq on-mark-state (point)))
       ;; just moved off a marked area
       ((and on-mark-state (not on-mark))
        (overlay-put (make-overlay on-mark-state (point)) 'face 'underline)
        (setq on-mark-state nil)))
      (forward-char))))

(defun pabbrev-debug-restart-idle-timer()
  "Kill and restart the idle timers."
  (interactive)
  (pabbrev-debug-kill-idle-timer)
  (pabbrev-ensure-idle-timer))

(defun pabbrev-debug-kill-idle-timer()
  "Kill the idle timers.
Toggling `pabbrev-mode' will tend to turn them on again, as
will `pabbrev-debug-restart-idle-timer'."
  (interactive)
  (when pabbrev-short-idle-timer
      (cancel-timer pabbrev-short-idle-timer)
      (setq pabbrev-short-idle-timer nil))
  (when pabbrev-long-idle-timer
      (cancel-timer pabbrev-long-idle-timer)
      (setq pabbrev-long-idle-timer nil)))

(defsubst pabbrev-debug-clear()
  (pabbrev-debug-clear-all-hashes)
  (pabbrev-debug-remove-properties))

(defun pabbrev-debug-remove-properties()
  "Remove all the `pabbrev-added' properties from the buffer.
This means all the words in the buffer will be open for addition
to the dictionary."
  (interactive)
  (remove-text-properties (point-min) (point-max) '(pabbrev-added)))

(defun pabbrev-debug-clear-hashes(&optional mode)
  "Clear the dictionary for major mode MODE, or the current mode."
  (interactive)
  (unless mode (setq mode major-mode))
  (setq pabbrev-prefix-hash-modes (delq mode pabbrev-prefix-hash-modes)
        pabbrev-usage-hash-modes  (delq mode pabbrev-usage-hash-modes))
  ;; help the GC a bit..
  (when (pabbrev-get-usage-hash)
      (clrhash (pabbrev-get-usage-hash))
      (put mode 'pabbrev-usage-hash nil))
  (when (pabbrev-get-prefix-hash)
      (clrhash (pabbrev-get-prefix-hash))
      (put mode 'pabbrev-get-prefix-hash nil)))

(defun pabbrev-debug-clear-all-hashes()
  "Clear all hashes for all modes."
  (interactive)
  (mapcar #'pabbrev-debug-clear-hashes pabbrev-prefix-hash-modes))

(defun pabbrev-debug-print-hashes()
  "Print the hashes for the current mode."
  (interactive)
  (let ((usage (pabbrev-get-usage-hash))
        (prefix (pabbrev-get-prefix-hash)))
    (switch-to-buffer (get-buffer-create "*pabbrev hash*"))
    (erase-buffer)
    (unless usage
      (insert "Usage hash nil"))
    (insert "Usage hash size "
            (number-to-string
             (hash-table-count usage)) "\n")
    (if (not prefix)
        (insert "Prefix hash nil")
      (insert "Prefix hash size "
              (number-to-string
               (hash-table-count prefix)) "\n"))
    (insert "Usage hash:\n")
    (pabbrev-debug-print-hash usage)
    (insert "Prefix hash:\n")
    (pabbrev-debug-print-hash prefix)))

(defun pabbrev-debug-print-hash(hash)
  "Pretty print a hash."
  (when hash
    (pp hash (current-buffer))
    (insert "\n")
    (insert (hash-table-count hash))
    (insert "\n")
    (maphash
     (lambda(key value)
       (insert (concat "KEY: " key "\n"))
       (pp value (current-buffer)))
     hash)))

;; nobble pabbrev -- useful for profiling.
;;
;; nobble core data structures...
;;(defun pabbrev-add-word(word))
;;
;; nobble text properties...
;; (defun pabbrev-mark-add-word (bounds))

(provide 'pabbrev)
;;; pabbrev.el ends here
