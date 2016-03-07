;; all things javascript
;; Use lexical-binding because it's awesome and will help
;; with closures to keep values when defined.
(set (make-local-variable 'lexical-binding) t)

(autoload 'js2-mode "js2-mode" "JavaScript editing mode" t)
(setq auto-mode-alist (append '(("\\.js$" . js2-mode)) auto-mode-alist))
(setq ac-js2-evaluate-calls t)

(setq js-indent-level 2
      js2-basic-offset 2
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
  (setq show-trailing-whitespace t)
  (let ((project-file (find-project-file "\.proj$")))
    (when project-file
      (progn (message "Found project file at %s" project-file)
             (when is-cygwin
               (setq project-file (concat "$(cygpath -aw " project-file ")")))
             (set (make-local-variable 'compile-command)
                  (concat "C:/Windows/Microsoft.NET/Framework/v4.0.30319/MSBuild.exe /p:GenerateFullPaths=true \"" project-file "\"")))))
  (let* ((project-file (find-project-file "gulpfile\.js"))
         (project-file-directory (expand-file-name ".." project-file)))
        (when project-file
          (progn (message "Found project file at %s" project-file)
                 (set (make-local-variable 'compile-command) "gulp build")
                 (setq compile-fun (lambda () (compile-pkg project-file-directory))))))

(eval-after-load "js2-mode"
  '(let ((js2-snippets (concat yasnippets-root "js2-mode")))
     (when (file-exists-p js2-snippets)
       (add-to-list 'load-path js2-snippets)
       (yas/load-directory js2-snippets)
       (add-to-list 'ac-sources 'ac-source-yasnippet))))

(eval-after-load "compile"
  '(setq compilation-error-regexp-alist
         (append '(("at\\s-*\\([^[:space:]]+\\)\\s-*line\\s-*\\([0-9]+\\)\\s-*:\\s-*\\([0-9]*\\)" 1 2 3))
                 compilation-error-regexp-alist))))

(add-hook 'js2-mode-hook 'on-javascript-loaded)
(add-hook 'js2-mode-hook 'comment-fill-mode-hook)
(add-hook 'js2-mode-hook 'ac-js2-mode)
