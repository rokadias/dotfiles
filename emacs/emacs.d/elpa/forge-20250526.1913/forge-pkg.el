;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "forge" "20250526.1913"
  "Access Git forges from Magit."
  '((emacs         "29.1")
    (compat        "30.0.2.0")
    (closql        "2.2.1")
    (emacsql       "4.3.0")
    (ghub          "4.3.0")
    (let-alist     "1.0.6")
    (llama         "0.6.2")
    (magit         "4.3.2")
    (markdown-mode "2.7")
    (seq           "2.24")
    (transient     "0.8.7")
    (yaml          "1.2.0"))
  :url "https://github.com/magit/forge"
  :commit "7454f160f388f5e7f8b0081b03814b50e1c8d07b"
  :revdesc "7454f160f388"
  :keywords '("git" "tools" "vc")
  :authors '(("Jonas Bernoulli" . "emacs.forge@jonas.bernoulli.dev"))
  :maintainers '(("Jonas Bernoulli" . "emacs.forge@jonas.bernoulli.dev")))
