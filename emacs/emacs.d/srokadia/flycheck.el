(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
     '(javascript-jshint)))

(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
     '(json-jsonlist)))

(flycheck-add-mode 'javascript-eslint 'web-mode)

(flycheck-define-checker omnisharp
  "Flycheck checker for omnisharp"
  :command ("curl" 
	    "--silent" "-H"
	    "Content-type: application/json"
	    "--data-binary" 
	    (eval (concat "@" (omnisharp--write-json-params-to-tmp-file
			       omnisharp--windows-curl-tmp-file-path
			       (json-encode (omnisharp--get-common-params))))) ;; do the work here, and get the path
	    "http://localhost:2000/syntaxerrors")
  :error-parser omnisharp--flycheck-error-parser-raw-json
  :modes csharp-mode)

(defun omnisharp--write-json-params-to-tmp-file
  (target-path stuff-to-write-to-file)
  "Deletes the file when done."
  (with-temp-file target-path
    (insert stuff-to-write-to-file)
    target-path)) ;; return the target path

(setq flycheck-check-syntax-automatically '(save new-line mode-enabled))
