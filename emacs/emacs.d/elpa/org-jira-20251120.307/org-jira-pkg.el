;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "org-jira" "20251120.307"
  "Syncing between Jira and Org-mode."
  '((emacs   "24.5")
    (cl-lib  "0.5")
    (request "0.2.0")
    (dash    "2.14.1"))
  :url "https://github.com/ahungry/org-jira"
  :commit "f5ccb0719478a6f7dd2c045b1b191420d04242d7"
  :revdesc "f5ccb0719478"
  :keywords '("ahungry" "jira" "org" "bug" "tracker")
  :maintainers '(("Matthew Carter" . "m@ahungry.com")))
