;;; tide-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "../../../dotfiles/emacs/emacs.d/elpa/tide-20210517.507/tide"
;;;;;;  "tide.el" "493ed2c7a8f00af1002690f837efadc0")
;;; Generated autoloads from tide.el

(autoload 'company-tide "../../../dotfiles/emacs/emacs.d/elpa/tide-20210517.507/tide" "\


\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

(autoload 'tide-format-before-save "../../../dotfiles/emacs/emacs.d/elpa/tide-20210517.507/tide" "\
Before save hook to format the buffer before each save." t nil)

(autoload 'tide-format "../../../dotfiles/emacs/emacs.d/elpa/tide-20210517.507/tide" "\
Format the current region or buffer." t nil)

(autoload 'tide-setup "../../../dotfiles/emacs/emacs.d/elpa/tide-20210517.507/tide" "\
Setup `tide-mode' in current buffer." t nil)

(autoload 'tide-mode "../../../dotfiles/emacs/emacs.d/elpa/tide-20210517.507/tide" "\
Minor mode for Typescript Interactive Development Environment.

If called interactively, enable Tide mode if ARG is positive, and
disable it if ARG is zero or negative.  If called from Lisp, also
enable the mode if ARG is omitted or nil, and toggle it if ARG is
`toggle'; disable the mode otherwise.

\\{tide-mode-map}

\(fn &optional ARG)" t nil)

(autoload 'tide-project-errors "../../../dotfiles/emacs/emacs.d/elpa/tide-20210517.507/tide" nil t nil)

(autoload 'tide-unhighlight-identifiers "../../../dotfiles/emacs/emacs.d/elpa/tide-20210517.507/tide" "\
Remove highlights from previously highlighted identifier." nil nil)

(autoload 'tide-hl-identifier "../../../dotfiles/emacs/emacs.d/elpa/tide-20210517.507/tide" "\
Highlight all instances of the identifier under point. Removes
highlights from previously highlighted identifier." t nil)

(autoload 'tide-hl-identifier-mode "../../../dotfiles/emacs/emacs.d/elpa/tide-20210517.507/tide" "\
Highlight instances of the identifier at point after a short
timeout.

If called interactively, enable Tide-Hl-Identifier mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

;;;### (autoloads "actual autoloads are elsewhere" "../../../dotfiles/emacs/emacs.d/elpa/tide-20210517.507/tide"
;;;;;;  "tide.el" (0 0 0 0))
;;; Generated autoloads from tide.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "../../../dotfiles/emacs/emacs.d/elpa/tide-20210517.507/tide" '("tide-" "xref-tide-xref-backend")))

;;;***

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "../../../dotfiles/emacs/emacs.d/elpa/tide-20210517.507/tide-lv"
;;;;;;  "tide-lv.el" (0 0 0 0))
;;; Generated autoloads from tide-lv.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "../../../dotfiles/emacs/emacs.d/elpa/tide-20210517.507/tide-lv" '("tide-lv-")))

;;;***

;;;### (autoloads nil "tide" "../../../../../.emacs.d/elpa/tide-20210517.507/tide.el"
;;;;;;  "493ed2c7a8f00af1002690f837efadc0")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/tide-20210517.507/tide.el

(autoload 'company-tide "tide" "\


\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

(autoload 'tide-format-before-save "tide" "\
Before save hook to format the buffer before each save." t nil)

(autoload 'tide-format "tide" "\
Format the current region or buffer." t nil)

(autoload 'tide-setup "tide" "\
Setup `tide-mode' in current buffer." t nil)

(autoload 'tide-mode "tide" "\
Minor mode for Typescript Interactive Development Environment.

If called interactively, enable Tide mode if ARG is positive, and
disable it if ARG is zero or negative.  If called from Lisp, also
enable the mode if ARG is omitted or nil, and toggle it if ARG is
`toggle'; disable the mode otherwise.

\\{tide-mode-map}

\(fn &optional ARG)" t nil)

(autoload 'tide-project-errors "tide" nil t nil)

(autoload 'tide-unhighlight-identifiers "tide" "\
Remove highlights from previously highlighted identifier." nil nil)

(autoload 'tide-hl-identifier "tide" "\
Highlight all instances of the identifier under point. Removes
highlights from previously highlighted identifier." t nil)

(autoload 'tide-hl-identifier-mode "tide" "\
Highlight instances of the identifier at point after a short
timeout.

If called interactively, enable Tide-Hl-Identifier mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

;;;### (autoloads "actual autoloads are elsewhere" "tide" "../../../../../.emacs.d/elpa/tide-20210517.507/tide.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/tide-20210517.507/tide.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "tide" '("tide-" "xref-tide-xref-backend")))

;;;***

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "tide-lv" "../../../../../.emacs.d/elpa/tide-20210517.507/tide-lv.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/tide-20210517.507/tide-lv.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "tide-lv" '("tide-lv-")))

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/tide-20210517.507/tide-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/tide-20210517.507/tide-lv.el"
;;;;;;  "../../../../../.emacs.d/elpa/tide-20210517.507/tide-pkg.el"
;;;;;;  "../../../../../.emacs.d/elpa/tide-20210517.507/tide.el"
;;;;;;  "tide-lv.el" "tide.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; tide-autoloads.el ends here
