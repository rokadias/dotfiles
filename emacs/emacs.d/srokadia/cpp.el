(defun on-clang-load ()
  (set-bazel-compile-command)
  (clang-format-save-hook-for-this-buffer)
  (eglot-ensure)
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

(setq path-to-ctags "/usr/bin/ctags")

(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "%s -f TAGS -e -R %s" path-to-ctags (directory-file-name dir-name)))
)


(define-key c++-mode-map (kbd "M-M") 'bazel-compile-run-test)
