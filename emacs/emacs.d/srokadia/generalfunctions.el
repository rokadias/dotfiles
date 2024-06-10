(defun directory-parent (directory)
  (let ((parent (file-name-directory (directory-file-name directory))))
    (if (not (equal directory parent))
        parent)))

;; define function to shutdown emacs server instance
(defun server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs)
  )

(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive) ; Use (interactive "^") in Emacs 23 to make shift-select work
  (let ((oldpos (point)))
    (beginning-of-line)
    (and (= oldpos (point))
         (back-to-indentation))))

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

(defun reverse-other-window ()
  (interactive)
  (other-window -1))

(setq frames-hash (make-hash-table :test 'equal))
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

(defun switch-to-window-buffer (buffer &optional _arg)
  (interactive
   (list 
    (ido-completing-read "Buffer:" (delq
                                    nil
                                    (mapcar (lambda (buf)
                                              (when (get-buffer-window buf "visible")
                                                (buffer-name buf)))
                                            (buffer-list))))))
  (let ((window (get-buffer-window buffer "visible")))
    (select-frame-set-input-focus (window-frame window))
    (select-window window)))

(defun list-keys (plist)
  (let ((iterator plist)
        (keys))
    (while iterator
      (setq keys (cons (car iterator) keys))
      (setq iterator (cdr (cdr iterator))))
    keys))

(defun back-zap-to-char (char)
  (interactive (list (read-char "Zap to char: " t)))
  (zap-to-char -1 char)
  )

(defun trim-string (string)
  "Remove white spaces in beginning and ending of STRING.
White space here is any of: space, tab, emacs newline (line feed, ASCII 10)."
  (replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" string))
  )

(defun downcase-first-char (&optional string)
  "Downcase the first character of the input STRING."
  (when (and string (> (length string) 0))
    (let ((first-char (substring string 0 1))
          (rest-str   (substring string 1)))
      (concat (downcase first-char) rest-str))))

(defun upcase-first-char (&optional string)
  "Capitalize the first character of the input STRING."
  (when (and string (> (length string) 0))
    (let ((first-char (substring string 0 1))
          (rest-str   (substring string 1)))
      (concat (upcase first-char) rest-str))))

(defun get-current-line-number ()
  (save-restriction)
  (widen)
  (save-excursion
    (beginning-of-line)
    (1+ (count-lines 1 (point)))))

(defun mark-current-sexp ()
  (interactive)
  (backward-sexp)
  (set-mark-command nil)
  (forward-sexp)
)

(defun kill-ring-save-sexp ()
  (interactive)
  (save-excursion
    (mark-current-sexp)
    (kill-ring-save nil nil t)
    )
  )

(defun yank-pop-sexp ()
  (interactive)
  (save-excursion
    (mark-current-sexp)
    (delete-region (region-beginning) (region-end))
    (yank)
    )
)

(defun get-file-name (&optional BUFFER)
  (if (equal major-mode 'dired-mode)
      default-directory
    (buffer-file-name BUFFER)))

(defun er-copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename ))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))
