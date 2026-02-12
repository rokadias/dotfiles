;;; go --- Saqib's go configuration.
;;; Commentary:
;;; Sets general things that I like.
;;; Code:
(require 'go-mode)

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/go/bin"))

(defun on-go-load ()
  (eglot-ensure)
  (set-bazel-compile-command)
  (add-hook 'before-save-hook 'gofmt-before-save)
  )

(defun set-bazel-compile-command ()
  "Set the python compile command which is just check mypy."
  (let* ((project-build-file (find-project-file "BUILD.*"))
         (project-build-dir (directory-parent project-build-file))
         (project-workspace-file (find-project-file "WORKSPACE"))
         (project-parent-dir (directory-parent project-workspace-file))
         (relative-build-dir (string-replace project-parent-dir "" project-build-dir)))
    (message "Found build file at %s and workspace at %s" project-build-file project-workspace-file)
    (set (make-local-variable 'project-directory) project-parent-dir)
    (set (make-local-variable 'compile-command) (concat "bazel --output_base output-test build  -c dbg --strip=never //" relative-build-dir "..." ))))

(defun bazel-compile-run-test ()
  (interactive)
  (let* ((project-build-file (find-project-file "BUILD.*"))
         (project-build-dir (directory-parent project-build-file))
         (project-workspace-file (find-project-file "WORKSPACE"))
         (project-parent-dir (directory-parent project-workspace-file))
         (relative-build-dir (string-replace project-parent-dir "" project-build-dir)))
    (message "Found build file at %s and workspace at %s" project-build-file project-workspace-file)
    (set (make-local-variable 'project-directory) project-parent-dir)
    (set (make-local-variable 'compile-command) (concat "bazel --output_base output-test test --test_output=streamed $(bazel query 'tests(//" relative-build-dir "...)')"))
    (compile-override)
    (set-bazel-compile-command)
    )
  )
(define-key go-mode-map (kbd "M-M") 'bazel-compile-run-test)

(setq lsp-log-io nil
      lsp-file-watch-threshold 4000
      lsp-headerline-breadcrumb-enable t
      lsp-headerline-breadcrumb-icons-enable nil
      lsp-headerline-breadcrumb-segments '(file symbols)
      lsp-imenu-index-symbol-kinds '(File Module Namespace Package Class Method Enum Interface
                                          Function Variable Constant Struct Event Operator TypeParameter)
      )
(dolist (dir '("[/\\\\]\\.ccls-cache\\'"
               "[/\\\\]\\.mypy_cache\\'"
               "[/\\\\]\\.pytest_cache\\'"
               "[/\\\\]\\.cache\\'"
               "[/\\\\]\\.clwb\\'"
               "[/\\\\]__pycache__\\'"
               "[/\\\\]bazel-bin\\'"
               "[/\\\\]bazel-code\\'"
               "[/\\\\]bazel-genfiles\\'"
               "[/\\\\]bazel-out\\'"
               "[/\\\\]bazel-testlogs\\'"
               "[/\\\\]third_party\\'"
               "[/\\\\]third-party\\'"
               "[/\\\\]buildtools\\'"
               "[/\\\\]output\\'"
               "[/\\\\]build\\'"
               ))
  (push dir lsp-file-watch-ignored-directories))


(add-hook 'go-mode-hook #'on-go-load)
