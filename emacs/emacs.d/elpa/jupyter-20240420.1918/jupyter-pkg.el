(define-package "jupyter" "20240420.1918" "Jupyter"
  '((emacs "26")
    (cl-lib "0.5")
    (org "9.1.6")
    (zmq "0.10.10")
    (simple-httpd "1.5.0")
    (websocket "1.9"))
  :commit "aec436af541549ccd02e23c066a6c497d1365f6b" :authors
  '(("Nathaniel Nicandro" . "nathanielnicandro@gmail.com"))
  :maintainers
  '(("Nathaniel Nicandro" . "nathanielnicandro@gmail.com"))
  :maintainer
  '("Nathaniel Nicandro" . "nathanielnicandro@gmail.com")
  :url "https://github.com/emacs-jupyter/jupyter")
;; Local Variables:
;; no-byte-compile: t
;; End:
