;;; org-pivotal-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "org-pivotal" "org-pivotal.el" (0 0 0 0))
;;; Generated autoloads from org-pivotal.el

(autoload 'org-pivotal-install-project-metadata "org-pivotal" "\
Install selected project's metadata to buffer.

\(fn)" t nil)

(autoload 'org-pivotal-pull-stories "org-pivotal" "\
Pull stories to org buffer.

\(fn)" t nil)

(autoload 'org-pivotal-push-story "org-pivotal" "\
Push current story to Pivotal.

\(fn)" t nil)

(autoload 'org-pivotal-mode "org-pivotal" "\
Define minor mode for org-pivotal.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-pivotal" '("org-pivotal--")))

;;;***

;;;### (autoloads nil "org-pivotal-api" "org-pivotal-api.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from org-pivotal-api.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-pivotal-api" '("org-pivotal-api-")))

;;;***

;;;### (autoloads nil nil ("org-pivotal-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; org-pivotal-autoloads.el ends here
