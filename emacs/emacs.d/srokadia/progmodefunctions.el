(defun c-set-style-stroustrup ()
  (c-set-style "java"))

(defun comment-fill-mode-hook ()
    (auto-fill-mode 1)
    (setq fill-column 90
          comment-auto-fill-only-comments t)

    (set (make-local-variable 'fill-nobreak-predicate)
         (lambda ()
           (not (eq (get-text-property (point) 'face)
                    'font-lock-comment-face)))))

(defun find-project-file (regexp &optional filter)
  (when buffer-file-name
    (let (current-dir-contents
          parent-dir
          (current-dir (file-name-directory (buffer-file-name))))
      (while (and current-dir
                  (not (= 1 (length (setq current-dir-contents
                                          (directory-files-match current-dir regexp filter))))))
        (setq current-dir (directory-parent current-dir)))
      (car current-dir-contents))))

;; Use lexical-binding because it's awesome and will help
;; with closures to keep values when defined.
(set (make-local-variable 'lexical-binding) t)
(defun directory-files-match (current-dir regexp &optional filter)
  (let ((filter-on (if filter
                       (lambda (file) (string-match-p filter file))
                       (lambda (file) nil)))
        (current-dir-contents (directory-files current-dir t regexp t)))
    (cl-remove-if filter-on current-dir-contents)))
