;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "org-jira" "20250424.41"
  "Syncing between Jira and Org-mode."
  '((emacs   "24.5")
    (cl-lib  "0.5")
    (request "0.2.0")
    (dash    "2.14.1"))
  :url "https://github.com/ahungry/org-jira"
  :commit "dfdc26ab8bfb54f4419d3eb52a17be5361d74b87"
  :revdesc "dfdc26ab8bfb"
  :keywords '("ahungry" "jira" "org" "bug" "tracker")
  :maintainers '(("Matthew Carter" . "m@ahungry.com")))
