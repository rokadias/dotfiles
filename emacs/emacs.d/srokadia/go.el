;;; go --- Saqib's go configuration.
;;; Commentary:
;;; Sets general things that I like.
;;; Code:
(require 'go-mode)

(defun on-go-load ()
  (lsp)
  (set-bazel-compile-command)
  (add-hook ’before-save-hook ’gofmt-before-save)
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
    (set (make-local-variable 'compile-command) (concat "docker exec -w /electron electron-build bazel build //" (substring relative-build-dir 0 -1)))))

(defun bazel-compile-run-test ()
  (interactive)
  (let* ((project-build-file (find-project-file "BUILD.*"))
         (project-build-dir (directory-parent project-build-file))
         (project-workspace-file (find-project-file "WORKSPACE"))
         (project-parent-dir (directory-parent project-workspace-file))
         (relative-build-dir (string-replace project-parent-dir "" project-build-dir)))
    (message "Found build file at %s and workspace at %s" project-build-file project-workspace-file)
    (compile (concat "docker exec -w /electron electron-build bazel --output_base output test $(bazel query 'tests(//" (substring relative-build-dir 0 -1) ")')"))
    (set-bazel-compile-command)
    )
  )
(define-key go-mode-map (kbd "M-M") 'bazel-compile-run-test)

(add-hook 'go-mode-hook #'on-go-load)
