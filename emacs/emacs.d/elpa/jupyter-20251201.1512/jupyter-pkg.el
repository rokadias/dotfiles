;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "jupyter" "20251201.1512"
  "Jupyter."
  '((emacs        "27")
    (cl-lib       "0.5")
    (org          "9.1.6")
    (zmq          "0.10.10")
    (simple-httpd "1.5.0")
    (websocket    "1.9"))
  :url "https://github.com/emacs-jupyter/jupyter"
  :commit "de89cbeca890db51ba84aee956658f89aaa0b642"
  :revdesc "de89cbeca890"
  :authors '(("Nathaniel Nicandro" . "nathanielnicandro@gmail.com"))
  :maintainers '(("Nathaniel Nicandro" . "nathanielnicandro@gmail.com")))
