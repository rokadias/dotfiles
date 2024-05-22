(setq jsx-indent-level 2)

(define-innermode poly-jsx-html-innermode
  :mode 'js-mode
  :head-matcher (cons "\\(.*(.*\n\\)[ \t]*<[[:alpha:]]*.*>.*\n" 1)
  :tail-matcher "^[ \t]*);?.*\n[:space:]*}"
  :head-mode 'host
  :tail-mode 'host)

(define-hostmode poly-jsx-hostmode
  :mode 'js2-mode)

(define-polymode poly-jsx-mode
  :hostmode 'poly-jsx-hostmode
  :innermodes '(poly-tsx-html-innermode))

(setq auto-mode-alist (append '(("\\.jsx?$" . js-mode)) auto-mode-alist))

(with-eval-after-load "polymode"
  (add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode)))
