;;; js2-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "../../../dotfiles/emacs/emacs.d/elpa/js2-mode-20210712.202/js2-imenu-extras"
;;;;;;  "js2-imenu-extras.el" "cb16db9294721b465b42f430dbb082ea")
;;; Generated autoloads from js2-imenu-extras.el

(autoload 'js2-imenu-extras-setup "../../../dotfiles/emacs/emacs.d/elpa/js2-mode-20210712.202/js2-imenu-extras" nil nil nil)

(autoload 'js2-imenu-extras-mode "../../../dotfiles/emacs/emacs.d/elpa/js2-mode-20210712.202/js2-imenu-extras" "\
Toggle Imenu support for frameworks and structural patterns.

If called interactively, enable Js2-Imenu-Extras mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

;;;### (autoloads "actual autoloads are elsewhere" "../../../dotfiles/emacs/emacs.d/elpa/js2-mode-20210712.202/js2-imenu-extras"
;;;;;;  "js2-imenu-extras.el" (0 0 0 0))
;;; Generated autoloads from js2-imenu-extras.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "../../../dotfiles/emacs/emacs.d/elpa/js2-mode-20210712.202/js2-imenu-extras" '("js2-imenu-")))

;;;***

;;;***

;;;### (autoloads nil "../../../dotfiles/emacs/emacs.d/elpa/js2-mode-20210712.202/js2-mode"
;;;;;;  "js2-mode.el" "a208057180bf99d43809f2b1d412dad2")
;;; Generated autoloads from js2-mode.el

(autoload 'js2-highlight-unused-variables-mode "../../../dotfiles/emacs/emacs.d/elpa/js2-mode-20210712.202/js2-mode" "\
Toggle highlight of unused variables.

If called interactively, enable Js2-Highlight-Unused-Variables
mode if ARG is positive, and disable it if ARG is zero or
negative.  If called from Lisp, also enable the mode if ARG is
omitted or nil, and toggle it if ARG is `toggle'; disable the
mode otherwise.

\(fn &optional ARG)" t nil)

(autoload 'js2-minor-mode "../../../dotfiles/emacs/emacs.d/elpa/js2-mode-20210712.202/js2-mode" "\
Minor mode for running js2 as a background linter.
This allows you to use a different major mode for JavaScript editing,
such as `js-mode', while retaining the asynchronous error/warning
highlighting features of `js2-mode'.

If called interactively, enable Js2 minor mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(autoload 'js2-mode "../../../dotfiles/emacs/emacs.d/elpa/js2-mode-20210712.202/js2-mode" "\
Major mode for editing JavaScript code.

\(fn)" t nil)

(autoload 'js2-jsx-mode "../../../dotfiles/emacs/emacs.d/elpa/js2-mode-20210712.202/js2-mode" "\
Major mode for editing JSX code in Emacs 26 and earlier.

To edit JSX code in Emacs 27, use `js-mode' as your major mode
with `js2-minor-mode' enabled.

To customize the indentation for this mode, set the SGML offset
variables (`sgml-basic-offset' et al) locally, like so:

  (defun set-jsx-indentation ()
    (setq-local sgml-basic-offset js2-basic-offset))
  (add-hook \\='js2-jsx-mode-hook #\\='set-jsx-indentation)

\(fn)" t nil)

;;;### (autoloads "actual autoloads are elsewhere" "../../../dotfiles/emacs/emacs.d/elpa/js2-mode-20210712.202/js2-mode"
;;;;;;  "js2-mode.el" (0 0 0 0))
;;; Generated autoloads from js2-mode.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "../../../dotfiles/emacs/emacs.d/elpa/js2-mode-20210712.202/js2-mode" '("js2-")))

;;;***

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "../../../dotfiles/emacs/emacs.d/elpa/js2-mode-20210712.202/js2-old-indent"
;;;;;;  "js2-old-indent.el" (0 0 0 0))
;;; Generated autoloads from js2-old-indent.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "../../../dotfiles/emacs/emacs.d/elpa/js2-mode-20210712.202/js2-old-indent" '("js2-")))

;;;***

;;;### (autoloads nil "js2-imenu-extras" "../../../../../.emacs.d/elpa/js2-mode-20210712.202/js2-imenu-extras.el"
;;;;;;  "cb16db9294721b465b42f430dbb082ea")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/js2-mode-20210712.202/js2-imenu-extras.el

(autoload 'js2-imenu-extras-setup "js2-imenu-extras" nil nil nil)

(autoload 'js2-imenu-extras-mode "js2-imenu-extras" "\
Toggle Imenu support for frameworks and structural patterns.

If called interactively, enable Js2-Imenu-Extras mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

;;;### (autoloads "actual autoloads are elsewhere" "js2-imenu-extras"
;;;;;;  "../../../../../.emacs.d/elpa/js2-mode-20210712.202/js2-imenu-extras.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/js2-mode-20210712.202/js2-imenu-extras.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "js2-imenu-extras" '("js2-imenu-")))

;;;***

;;;***

;;;### (autoloads nil "js2-mode" "../../../../../.emacs.d/elpa/js2-mode-20210712.202/js2-mode.el"
;;;;;;  "a208057180bf99d43809f2b1d412dad2")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/js2-mode-20210712.202/js2-mode.el

(autoload 'js2-highlight-unused-variables-mode "js2-mode" "\
Toggle highlight of unused variables.

If called interactively, enable Js2-Highlight-Unused-Variables
mode if ARG is positive, and disable it if ARG is zero or
negative.  If called from Lisp, also enable the mode if ARG is
omitted or nil, and toggle it if ARG is `toggle'; disable the
mode otherwise.

\(fn &optional ARG)" t nil)

(autoload 'js2-minor-mode "js2-mode" "\
Minor mode for running js2 as a background linter.
This allows you to use a different major mode for JavaScript editing,
such as `js-mode', while retaining the asynchronous error/warning
highlighting features of `js2-mode'.

If called interactively, enable Js2 minor mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(autoload 'js2-mode "js2-mode" "\
Major mode for editing JavaScript code.

\(fn)" t nil)

(autoload 'js2-jsx-mode "js2-mode" "\
Major mode for editing JSX code in Emacs 26 and earlier.

To edit JSX code in Emacs 27, use `js-mode' as your major mode
with `js2-minor-mode' enabled.

To customize the indentation for this mode, set the SGML offset
variables (`sgml-basic-offset' et al) locally, like so:

  (defun set-jsx-indentation ()
    (setq-local sgml-basic-offset js2-basic-offset))
  (add-hook \\='js2-jsx-mode-hook #\\='set-jsx-indentation)

\(fn)" t nil)

;;;### (autoloads "actual autoloads are elsewhere" "js2-mode" "../../../../../.emacs.d/elpa/js2-mode-20210712.202/js2-mode.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/js2-mode-20210712.202/js2-mode.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "js2-mode" '("js2-")))

;;;***

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "js2-old-indent"
;;;;;;  "../../../../../.emacs.d/elpa/js2-mode-20210712.202/js2-old-indent.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/js2-mode-20210712.202/js2-old-indent.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "js2-old-indent" '("js2-")))

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/js2-mode-20210712.202/js2-imenu-extras.el"
;;;;;;  "../../../../../.emacs.d/elpa/js2-mode-20210712.202/js2-mode-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/js2-mode-20210712.202/js2-mode-pkg.el"
;;;;;;  "../../../../../.emacs.d/elpa/js2-mode-20210712.202/js2-mode.el"
;;;;;;  "../../../../../.emacs.d/elpa/js2-mode-20210712.202/js2-old-indent.el"
;;;;;;  "js2-imenu-extras.el" "js2-mode.el" "js2-old-indent.el")
;;;;;;  (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; js2-mode-autoloads.el ends here
