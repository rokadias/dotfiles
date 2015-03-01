;; all things javascript

(autoload 'js3-mode "js3-mode" "JavaScript editing mode" t)
(setq auto-mode-alist (append '(("\\.js$" . js3-mode)) auto-mode-alist))

(setq js3-basic-offset 4
      js3-bounce-indent-flag t
      js3-cleanup-whitespace nil
      js3-enter-indents-newline nil
      js3-highlight-level 3
      js3-mirror-mode nil
      js3-rebind-eol-bol-keys nil
      js3-use-font-lock-faces t)

(custom-set-variables
 '(js3-lazy-commas t)
 '(js3-lazy-operators t)
 '(js3-expr-indent-offset 2)
 '(js3-paren-indent-offset 2)
 '(js3-square-indent-offset 2)
 '(js3-curly-indent-offset 2))

(defun on-javascript-loaded ()
  (when (package-installed-p 'js-comint)
    (require 'js-comint)
    (local-set-key "\C-x\C-e" 'js-send-last-sexp)
    (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
    (local-set-key "\C-cb" 'js-send-buffer)
    (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
    (local-set-key "\C-c\C-r" 'js-send-region)
    (local-set-key "\C-cl" 'js-load-file-and-go))
  (setq show-trailing-whitespace t)
  (let ((project-file (find-project-file "\.proj$")))
    (when project-file
      (progn (message "Found project file at %s" project-file)
             (when is-cygwin
               (setq project-file (concat "$(cygpath -aw " project-file ")")))
             (set (make-local-variable 'compile-command)
                  (concat "C:/Windows/Microsoft.NET/Framework/v4.0.30319/MSBuild.exe /p:GenerateFullPaths=true \"" project-file "\"")))))

(eval-after-load "js3-mode"
  '(let ((closure-snippets "~/dev/closure-snippets/emacs"))
     (when (file-exists-p closure-snippets)
       (add-to-list 'load-path closure-snippets)
       (require 'closure-snippets-support)
       (yas/load-directory closure-snippets))))

(eval-after-load "compile"
  '(setq compilation-error-regexp-alist
         (append '(("at\\s-*\\([^[:space:]]+\\)\\s-*line\\s-*\\([0-9]+\\)\\s-*:\\s-*\\([0-9]*\\)" 1 2 3))
                 compilation-error-regexp-alist))))

(add-hook 'js3-mode-hook 'on-javascript-loaded)
(add-hook 'js3-mode-hook 'comment-fill-mode-hook)
(add-hook 'js3-mode-hook 'node-resolver-start)
