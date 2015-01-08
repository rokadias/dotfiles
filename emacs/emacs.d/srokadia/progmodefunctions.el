(defun c-set-style-stroustrup ()
  (c-set-style "java"))

(defun comment-fill-mode-hook ()
    (auto-fill-mode 1)
    (setq fill-column 100
          comment-auto-fill-only-comments t)

    (set (make-local-variable 'fill-nobreak-predicate)
         (lambda ()
           (not (eq (get-text-property (point) 'face)
                    'font-lock-comment-face)))))

(defun find-project-file (regexp)
  (when buffer-file-name
    (let (current-dir-contents
          parent-dir
          (current-dir (file-name-directory (buffer-file-name))))
      (while (and current-dir
                  (not (= 1 (length (setq current-dir-contents
                                          (directory-files
                                           current-dir
                                           t regexp t))))))
        (setq current-dir (directory-parent current-dir)))
      (car current-dir-contents))))
