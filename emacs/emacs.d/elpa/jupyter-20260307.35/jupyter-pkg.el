;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "jupyter" "20260307.35"
  "Jupyter."
  '((emacs        "27")
    (cl-lib       "0.5")
    (org          "9.1.6")
    (zmq          "0.10.10")
    (simple-httpd "1.5.0")
    (websocket    "1.9"))
  :url "https://github.com/emacs-jupyter/jupyter"
  :commit "3b9caed3e4cc5f4bc0348eb65d17098de76904e4"
  :revdesc "3b9caed3e4cc"
  :authors '(("Nathaniel Nicandro" . "nathanielnicandro@gmail.com"))
  :maintainers '(("Nathaniel Nicandro" . "nathanielnicandro@gmail.com")))
