(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive) ; Use (interactive "^") in Emacs 23 to make shift-select work
  (let ((oldpos (point)))
    (beginning-of-line)
    (and (= oldpos (point))
         (back-to-indentation))))

(defun reverse-other-window ()
  (interactive)
  (other-window -1))

;; Encapsulates window-configuration-to-register while setting the current
;; window register variable for the window being registered.
(defun switch-to-window-configuration-to-register (current-selected-frame &optional _arg)
  (interactive (list (selected-frame)))
  (let ((register (read-char "Window configuration to register: ")))
    (when (and (<= ?a register)
               (>= ?z register))
      (point-to-register (upcase register) t)
      (puthash (upcase register) current-selected-frame frames-hash))
    (window-configuration-to-register register)
    (setq current-window-register register)))

;; Switches to a different window configuration while saving the existing
;; window state which makes it seem like switching between different
;; desktops.
(setq current-window-register ?a)
(defun switch-to-window-configuration (current-selected-frame &optional _arg)
  (interactive (list (selected-frame)))
  (let ((register (read-char "Window configuration to switch to: ")))
    (when (and (<= ?a current-window-register)
               (>= ?z current-window-register))
      (point-to-register (upcase current-window-register) t)
      (puthash (upcase current-window-register) current-selected-frame frames-hash))
    (window-configuration-to-register current-window-register)
    (when (and (<= ?a register)
               (>= ?z register))
      (jump-to-register (upcase register))
      (select-frame-set-input-focus (gethash (upcase register) frames-hash)))
    (jump-to-register register)
    (setq current-window-register register)))

;; helper function for platform variance
(defun find-in-exec-path (exact-name)
  (catch 'found
    (dolist (dir exec-path)
      (let ((file (concat (file-name-as-directory dir) exact-name)))
        (when (file-exists-p file)
          (throw 'found file)))
      nil)))

(defun exists-in-exec-path (exact-name)
  (not (null (find-in-exec-path exact-name))))

(when (and (package-installed-p 'find-file-in-repository) is-w32)
  (defun ffir-shell-command (command file-separator working-dir)
  "Executes 'command' and returns the list of printed files in
   the form '((short/file/name . full/path/to/file) ...). The
   'file-separator' character is used to split the file names
   printed by the shell command and is usually set to \\n or \\0"
  (let ((command-output (shell-command-to-string
                         (format "cd %s && %s"
                                 (shell-quote-argument working-dir) command))))
    (let ((files (delete "" (split-string command-output file-separator))))
      (mapcar (lambda (file)
                (cons file (expand-file-name file working-dir)))
              files)))))

(defun list-keys (plist)
  (let ((iterator plist)
        (keys))
    (while iterator
      (setq keys (cons (car iterator) keys))
      (setq iterator (cdr (cdr iterator))))
    keys))
