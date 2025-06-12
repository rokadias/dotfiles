(use-package aider
  :config
  ;; For latest claude sonnet model
  (setq aider-args '("--model" "haiku" "--no-auto-accept-architect"))
  ;; (setenv "ANTHROPIC_API_KEY" <your-anthropic-api-key>)
  ;; Or gemini model
  ;; (setq aider-args '("--model" "gemini"))
  ;; (setenv "GEMINI_API_KEY" <your-gemini-api-key>)
  ;; Or chatgpt model
  ;; (setq aider-args '("--model" "o3"))
  ;; (setenv "OPENAI_API_KEY" "<your-open-ai-api-key>")
  ;; Or use your personal config file
  ;; (setq aider-args `("--config" ,(expand-file-name "~/.aider.conf.yml")))
  ;; ;;
  ;; Optional: Set a key binding for the transient menu
  (global-set-key (kbd "C-c a") 'aider-transient-menu) ;; for wider screen
  ;; or use aider-transient-menu-2cols / aider-transient-menu-1col, for narrow screen
  ;;(aider-magit-setup-transients)) ;; add aider magit function to magit menu
  (require 'aider-helm))

(defun company-backend-with-yas (backends)
  (if (and (listp backends) (memq 'company-yasnippet backends))
      backends
    (append (if (consp backends)
                backends
              (list backends))
            '(:with company-yasnippet))))

(require 'company)
(setq company-backends (mapcar #'company-backend-with-yas company-backends))
(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0)
