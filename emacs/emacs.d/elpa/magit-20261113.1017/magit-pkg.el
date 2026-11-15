;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "magit" "20261113.1017"
  "A Git porcelain inside Emacs."
  '((emacs         "28.1")
    (compat        "31.1")
    (cond-let      "1.1")
    (llama         "1.0")
    (magit-section "4.7")
    (seq           "2.24")
    (transient     "0.13")
    (with-editor   "3.6"))
  :url "https://github.com/magit/magit"
  :commit "4402e972bb2b6df2dad25118d8a638fa5a9b3e5b"
  :revdesc "4402e972bb2b"
  :keywords '("git" "tools" "vc")
  :authors '(("Marius Vollmer" . "marius.vollmer@gmail.com")
             ("Jonas Bernoulli" . "emacs.magit@jonas.bernoulli.dev"))
  :maintainers '(("Jonas Bernoulli" . "emacs.magit@jonas.bernoulli.dev")
                 ("Kyle Meyer" . "kyle@kyleam.com")))
