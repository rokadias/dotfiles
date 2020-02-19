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
      (message "Found project file at &s" project-file)
      (set (make-local-variable 'project-directory) (file-name-directory project-file))
      (set (make-local-variable 'compile-command) "cargo make check")
      )
    )
  )

(defun rust-compile-run-test ()
  (interactive)
  (let* ((project-file (find-project-file "Makefile\\.toml"))
        (default-directory (file-name-directory project-file)))
    (when project-file
      (compile "cargo make test")
      (set-rust-compile-command)
      )
    )
  )
(define-key rust-mode-map (kbd "M-M") 'rust-compile-run-test)
