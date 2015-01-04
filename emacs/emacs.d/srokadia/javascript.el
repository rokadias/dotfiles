;; all things javascript

(autoload 'js2-mode "js2-mode" "JavaScript editing mode" t)
(setq auto-mode-alist (append '(("\\.js$" . js2-mode)) auto-mode-alist))

(setq js2-basic-offset 4
      js2-bounce-indent-flag t
      js2-cleanup-whitespace nil
      js2-enter-indents-newline nil
      js2-highlight-level 3
      js2-mirror-mode nil
      js2-rebind-eol-bol-keys nil
      js2-use-font-lock-faces t)

(defun on-javascript-loaded ()
  (when (package-installed-p 'js-comint)
    (require 'js-comint)
    (local-set-key "\C-x\C-e" 'js-send-last-sexp)
    (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
    (local-set-key "\C-cb" 'js-send-buffer)
    (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
    (local-set-key "\C-c\C-r" 'js-send-region)
    (local-set-key "\C-cl" 'js-load-file-and-go))
  (let ((project-file (find-project-file "\.proj$")))
    (when project-file
      (progn (message "Found project file at %s" project-file)
             (set (make-local-variable 'compile-command)
                  (concat "C:/Windows/Microsoft.NET/Framework/v4.0.30319/MSBuild.exe /p:GenerateFullPaths=true \"" project-file "\"")))))

(eval-after-load "js2-mode"
  '(let ((closure-snippets "~/dev/closure-snippets/emacs"))
     (when (file-exists-p closure-snippets)
       (add-to-list 'load-path closure-snippets)
       (require 'closure-snippets-support)
       (yas/load-directory closure-snippets))))

(eval-after-load "compile"
  '(setq compilation-error-regexp-alist
         (append '(("at\\s-*\\([^[:space:]]+\\)\\s-*line\\s-*\\([0-9]+\\)\\s-*:\\s-*\\([0-9]*\\)" 1 2 3))
                 compilation-error-regexp-alist)))

(add-hook 'js2-mode-hook 'on-javascript-loaded)
(add-hook 'js2-mode-hook 'comment-fill-mode-hook)
