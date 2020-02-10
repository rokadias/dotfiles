;;; kubernetes-tramp-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "kubernetes-tramp" "kubernetes-tramp.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from kubernetes-tramp.el

(defvar kubernetes-tramp-kubectl-options nil "\
List of kubectl options.")

(custom-autoload 'kubernetes-tramp-kubectl-options "kubernetes-tramp" t)

(defconst kubernetes-tramp-completion-function-alist '((kubernetes-tramp--parse-running-containers "")) "\
Default list of (FUNCTION FILE) pairs to be examined for kubectl method.")

(defconst kubernetes-tramp-method "kubectl" "\
Method to connect docker containers.")

(autoload 'kubernetes-tramp-cleanup "kubernetes-tramp" "\
Cleanup TRAMP cache for kubernetes method.

\(fn)" t nil)

(autoload 'kubernetes-tramp-add-method "kubernetes-tramp" "\
Add kubectl tramp method.

\(fn)" nil nil)

(eval-after-load 'tramp '(progn (kubernetes-tramp-add-method) (tramp-set-completion-function kubernetes-tramp-method kubernetes-tramp-completion-function-alist)))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "kubernetes-tramp" '("kubernetes-tramp-" "tramp-remote-shell-executable")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; kubernetes-tramp-autoloads.el ends here
