(setq racer-cmd "/usr/bin/racer")
(setq racer-rust-src-path "~/OpenSource/rust/rust/src")


;; (setq lsp-rust-server 'rust-analyzer)
(require 'lsp)
(require 'lsp-rust)
;; (load-uid-library '("ra-emacs-lsp"))

(add-hook 'rust-mode-hook #'lsp)
(add-hook 'rust-mode-hook #'company-mode)
(add-hook 'rust-mode-hook #'cargo-minor-mode)
(add-hook 'rust-mode-hook 'set-rust-compile-command)

(defun set-rust-compile-command ()
  (let ((project-file (find-project-file "Makefile\\.toml")))
    (when project-file
      (message "Found project file at %s" project-file)
      (set (make-local-variable 'project-directory) (file-name-directory project-file))
      (set (make-local-variable 'compile-command) "cargo make check")
      )
    )
  )

(defun rust-ignore-test-directory ()
  (interactive)
  )

(defun rust-compile-run-test ()
  (interactive)
  (let* ((project-file (find-project-file "Makefile\\.toml"))
         (default-directory (file-name-directory project-file))
         (current-directory (file-name-directory (buffer-file-name)))
         (current-directory-name (file-name-nondirectory (directory-file-name current-directory)))
         (test-directory (if (string= (concat default-directory "src/") current-directory) "" (concat " " current-directory-name))))
    (when project-file
      (compile (concat "cargo make test" test-directory))
      (set-rust-compile-command)
      )
    )
  )
(define-key rust-mode-map (kbd "M-M") 'rust-compile-run-test)

;; (lsp-register-client
;;  (make-lsp-client :new-connection (lsp-stdio-connection (lambda () lsp-rust-rls-server-command))
;;                   :major-modes '(rust-mode rustic-mode)
;;                   :priority (if (eq lsp-rust-server 'rls) 1 -1)
;;                   :initialization-options '((omitInitBuild . t)
;;                                             (cmdRun . t))
;;                   :notification-handlers (ht ("window/progress" 'lsp-clients--rust-window-progress))
;;                   :action-handlers (ht ("rls.run" 'lsp-rust--rls-run))
;;                   :library-folders-fn (lambda (_workspace) lsp-rust-library-directories)
;;                   :initialized-fn (lambda (workspace)
;;                                     (with-lsp-workspace workspace
;;                                       (lsp--set-configuration
;;                                        (lsp-configuration-section "rust"))))
;;                   :remote? t
;;                   :server-id 'rls))
