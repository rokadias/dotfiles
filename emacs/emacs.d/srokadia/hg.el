;; mercurial

(defun hg-pull (&optional arg)
  (interactive "P")
  (shell-command
   (concat "hg pull" (if arg "" " -u") "&")))

(global-set-key [(control x) ?v ?w] '(lambda () (interactive) (shell-command "hg view&")))
(global-set-key [(control x) ?v ?>] '(lambda () (interactive) (shell-command "hg push&")))
(global-set-key [(control x) ?v ?.] '(lambda () (interactive) (shell-command "hg out&")))
(global-set-key [(control x) ?v ?<] 'hg-pull)
(global-set-key [(control x) ?v ?\,] '(lambda () (interactive) (shell-command "hg in&")))

(defun vc-hg-annotate-command (file buffer &optional revision)
  "Execute \"hg annotate\" on FILE, inserting the contents in BUFFER. Optional arg REVISION is a revision to annotate from."
  (vc-hg-command buffer 0 file "blame"
                 (when revision (concat "-r" revision))))
