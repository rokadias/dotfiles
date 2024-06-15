(defun on-clang-load ()
  (set-bazel-compile-command)
  (clang-format-save-hook-for-this-buffer)
  )
(defun clang-format-save-hook-for-this-buffer ()
  "Create a buffer local save hook."
  (add-hook 'before-save-hook
            (lambda ()
              (when (locate-dominating-file "." ".clang-format")
                (clang-format-buffer))
              ;; Continue to save.
              nil)
            nil
            ;; Buffer local hook.
            t))

(define-key c++-mode-map (kbd "M-M") 'bazel-compile-run-test)

(add-hook 'c-mode-hook (lambda () (on-clang-load)))
(add-hook 'c++-mode-hook (lambda () (on-clang-load)))
(add-hook 'glsl-mode-hook (lambda () (on-clang-load)))

(define-key c++-mode-map (kbd "M-M") 'bazel-compile-run-test)
