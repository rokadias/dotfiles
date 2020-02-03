;;; fsharp-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "eglot-fsharp" "eglot-fsharp.el" (0 0 0 0))
;;; Generated autoloads from eglot-fsharp.el

(autoload 'eglot-fsharp "eglot-fsharp" "\
Return `eglot' contact when FsAutoComplete is installed.
Ensure FsAutoComplete is installed (when called INTERACTIVE).

\(fn INTERACTIVE)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "eglot-fsharp" '("eglot-fs")))

;;;***

;;;### (autoloads nil "fsharp-mode" "fsharp-mode.el" (0 0 0 0))
;;; Generated autoloads from fsharp-mode.el

(add-to-list 'auto-mode-alist '("\\.fs[iylx]?\\'" . fsharp-mode))

(autoload 'fsharp-mode "fsharp-mode" "\


\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "fsharp-mode" '("fsharp-" "running-xemacs")))

;;;***

;;;### (autoloads nil "fsharp-mode-font" "fsharp-mode-font.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from fsharp-mode-font.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "fsharp-mode-font" '("fsharp-" "def-fsharp-compiled-var")))

;;;***

;;;### (autoloads nil "fsharp-mode-structure" "fsharp-mode-structure.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from fsharp-mode-structure.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "fsharp-mode-structure" '("fsharp-" "beginning-of-fsharp-def-or-class")))

;;;***

;;;### (autoloads nil "fsharp-mode-util" "fsharp-mode-util.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from fsharp-mode-util.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "fsharp-mode-util" '("fsharp-")))

;;;***

;;;### (autoloads nil "inf-fsharp-mode" "inf-fsharp-mode.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from inf-fsharp-mode.el

(autoload 'run-fsharp "inf-fsharp-mode" "\
Run an inferior fsharp process.
Input and output via buffer `*inferior-fsharp*'.

\(fn &optional CMD)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "inf-fsharp-mode" '("fsharp-" "inferior-fsharp-")))

;;;***

;;;### (autoloads nil nil ("fsharp-mode-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; fsharp-mode-autoloads.el ends here
