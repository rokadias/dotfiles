;;; session-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (session-initialize session-jump-to-last-change)
;;;;;;  "session" "../../../../../.emacs.d/elpa/session-20120510.1700/session.el"
;;;;;;  "50aa634ad19b1c61eef773100609f2e2")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/session-20120510.1700/session.el

(autoload 'session-jump-to-last-change "session" "\
Jump to the position of the last change.
Without prefix arg, jump successively to previous change positions which
differ by at least `session-jump-undo-threshold' characters by repeated
invocation of this command.  With prefix argument 0, jump to end of last
change.  With numeric prefix argument, jump to start of first change in
the ARG's undo block in the `buffer-undo-list'.

With non-numeric prefix argument (\\[universal-argument] only), set
point as oldest change position.  It might change slightly if you jump
to it due to intermediate insert/delete elements in the
`buffer-undo-list'.

\(fn &optional ARG)" t nil)

(autoload 'session-initialize "session" "\
Initialize package session and read previous session file.
Setup hooks and load `session-save-file', see variable `session-initialize'.  At
best, this function is called at the end of the Emacs startup, i.e., add
this function to `after-init-hook'.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/session-20120510.1700/session-pkg.el"
;;;;;;  "../../../../../.emacs.d/elpa/session-20120510.1700/session.el")
;;;;;;  (21677 48492 171000 0))

;;;***

(provide 'session-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; session-autoloads.el ends here
