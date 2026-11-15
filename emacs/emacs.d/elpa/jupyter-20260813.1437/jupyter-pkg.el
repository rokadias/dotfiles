;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "jupyter" "20260813.1437"
  "Jupyter."
  '((emacs        "27")
    (cl-lib       "0.5")
    (org          "9.1.6")
    (zmq          "0.10.10")
    (simple-httpd "1.5.0")
    (websocket    "1.9"))
  :url "https://github.com/emacs-jupyter/jupyter"
  :commit "05ea84067f784fb7cd1f829d7a0fadcad20466aa"
  :revdesc "05ea84067f78"
  :authors '(("Nathaniel Nicandro" . "nathanielnicandro@gmail.com"))
  :maintainers '(("Nathaniel Nicandro" . "nathanielnicandro@gmail.com")))
