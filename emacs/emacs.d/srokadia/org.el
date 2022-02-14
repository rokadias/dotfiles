(setq org-startup-indented 1)
(setq org-log-done t)

(defun formatted-copy ()
  "Export region to HTML, and copy it to the clipboard."
  (interactive)
  (save-window-excursion
    (shell-command-on-region
     (point-min)
     (point-max)
     "pandoc -s -o ~/Downloads/temp.docx")))

(global-set-key (kbd "H-w") 'formatted-copy)
(setq auto-mode-alist (append '(("todoist.org$" . todoist-mode)) auto-mode-alist))
