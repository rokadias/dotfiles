;;; go-playground-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "go-playground" "go-playground.el" (0 0 0 0))
;;; Generated autoloads from go-playground.el

(autoload 'go-playground-mode "go-playground" "\
A place for playing with golang code and export it in short snippets.

This is a minor mode.  If called interactively, toggle the
`Go-Playground mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `go-playground-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(autoload 'go-playground "go-playground" "\
Run playground for Go language in a new buffer." t nil)

(autoload 'go-playground-remove-current-snippet "go-playground" "\
Obsoleted by `go-playground-rm'." t nil)

(autoload 'go-playground-download "go-playground" "\
Download a paste from the play.golang.org and insert it in a new local playground buffer.
Tries to look for a URL at point.

\(fn URL)" t nil)

(register-definition-prefixes "go-playground" '("go-playground-"))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; go-playground-autoloads.el ends here
