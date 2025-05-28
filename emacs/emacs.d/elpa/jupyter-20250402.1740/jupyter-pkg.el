;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "jupyter" "20250402.1740"
  "Jupyter."
  '((emacs        "27")
    (cl-lib       "0.5")
    (org          "9.1.6")
    (zmq          "0.10.10")
    (simple-httpd "1.5.0")
    (websocket    "1.9"))
  :url "https://github.com/emacs-jupyter/jupyter"
  :commit "3615c2de16988c4dd9d1978bfa10ee3092e85b33"
  :revdesc "3615c2de1698"
  :authors '(("Nathaniel Nicandro" . "nathanielnicandro@gmail.com"))
  :maintainers '(("Nathaniel Nicandro" . "nathanielnicandro@gmail.com")))
