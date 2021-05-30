;;; github-notifier-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "github-notifier" "github-notifier.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from github-notifier.el

(defalias 'github-notifier 'github-notifier-mode)

(defvar github-notifier-mode nil "\
Non-nil if Github-Notifier mode is enabled.
See the `github-notifier-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `github-notifier-mode'.")

(custom-autoload 'github-notifier-mode "github-notifier" nil)

(autoload 'github-notifier-mode "github-notifier" "\
Toggle github notifications count display in mode line (Github Notifier mode).
With a prefix argument ARG, enable Github Notifier mode if ARG is
positive, and disable it otherwise.  If called from Lisp, enable
the mode if ARG is omitted or nil.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "github-notifier" '("github-notifier-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; github-notifier-autoloads.el ends here
