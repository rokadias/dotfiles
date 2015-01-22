(require 'request)

(defcustom reviewboard-url ""
  "User customizable URL to ReviewBoard server."
  :group 'reviewboard
  :type 'string
  :initialize 'custom-initialize-set)

(defcustom reviewboard-username nil
  "User customizable username for ReviewBoard server."
  :group 'reviewboard
  :type 'string
  :initialize 'custom-initialize-set)

(defun reviewboard-from-user (&optional username)
  (interactive)
  (let ((username (or username (read-string "User: " reviewboard-username))))
    (setq params '((status . "all")))
    (setq params (acons 'from-user username params))
    (reviewboard-request
     "review-requests/"
     :params params
     :success (function*
               (lambda (&key data &allow-other-keys)
                 (reviewboard-review-request-handle data 'reviewboard-review-request-short-insert))))))

(defun reviewboard-my-incoming ()
  (interactive)
  (setq params '((ship-it . "0")
                 (status . "pending")))
  (setq params (acons 'to-users-directly reviewboard-username params))
  (reviewboard-request
   "review-requests/"
   :params params
   :success (function*
             (lambda (&key data &allow-other-keys)
               (reviewboard-review-request-handle data 'reviewboard-review-request-short-insert)))))

(defun reviewboard-review-request-handle (data insert-func)
  (let ((review-requests (assoc-default 'review_requests data)))
    (with-current-buffer (get-buffer-create "*review-requests*")
      (org-mode)
      (erase-buffer)
      (mapc insert-func review-requests)
      (goto-char (point-min))
      (pop-to-buffer (current-buffer)))))

(defun reviewboard-review-request-short-insert (review-request)
  (insert (reviewboard-review-request-short review-request)))

(defun reviewboard-review-request-short (review-request)
  (let ((summary (assoc-default 'summary review-request))
        (links (assoc-default 'links review-request))
        (target-people (assoc-default 'target_people review-request))
        (url (assoc-default 'url review-request)))
    (concat "* Summary: " summary "\n"
            "** Submitter: " (assoc-default 'title (assoc-default 'submitter links)) "\n"
            "** Target People: "
            (mapconcat (lambda (person) (assoc-default 'title person)) target-people ", ") "\n"
            "** Url: " (concat reviewboard-url url) "\n"
            "\n")))

(defun* reviewboard-request (api-request
                            &key
                            (params nil)
                            (success nil))
  (request
   (concat reviewboard-url "/api/" api-request)
   :params params
   :parser 'json-read
   :error (function* (lambda (error-thrown &allow-other-keys&rest _)
                       (message "Got error: %S" error-thrown)))
   :success success))
