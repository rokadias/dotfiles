;;; auto-virtualenvwrapper-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "auto-virtualenvwrapper" "auto-virtualenvwrapper.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from auto-virtualenvwrapper.el

(autoload 'auto-virtualenvwrapper-activate "auto-virtualenvwrapper" "\
Activate virtualenv for buffer-filename.
If invoked with prefix command argument, cached information is ignored.
Set `auto-virtualenvwrapper-auto-deactivate' to t, if you want deactivate
automatically at visiting the buffer not related to any virtualenv.

\(fn &optional IGNORE-CACHE)" t nil)

(register-definition-prefixes "auto-virtualenvwrapper" '("auto-virtualenvwrapper-"))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; auto-virtualenvwrapper-autoloads.el ends here
