(setq jsx-indent-level 2)

(define-hostmode poly-tsx-hostmode
  :mode 'typescript-mode)

(define-innermode poly-tsx-html-innermode
  :mode 'html-mode
  :head-matcher (cons "\\(.*(.*\n\\)[ \t]*<[[:alpha:]]*.*>.*\n" 1)
  :tail-matcher "^[ \t]*);?.*\n"
  :head-mode 'host
  :tail-mode 'host)

(define-polymode poly-tsx-mode
  :hostmode 'poly-tsx-hostmode
  :innermodes '(poly-tsx-html-innermode))



(define-innermode poly-jsx-html-innermode
  :mode 'html-mode
  :head-matcher (cons "\\(.*(.*\n\\)[ \t]*<[[:alpha:]]*.*>.*\n" 1)
  :tail-matcher "^[ \t]*);?.*\n"
  :head-mode 'host
  :tail-mode 'host)

(define-hostmode poly-jsx-hostmode
  :mode 'js2-mode)

(define-polymode poly-jsx-mode
  :hostmode 'poly-jsx-hostmode
  :innermodes '(poly-tsx-html-innermode))

(setq auto-mode-alist (append '(("\\.tsx$" . poly-tsx-mode)) auto-mode-alist))
(add-hook 'poly-tsx-mode-hook #'setup-tide-mode)

(setq auto-mode-alist (append '(("\\.jsx?$" . poly-jsx-mode)) auto-mode-alist))
