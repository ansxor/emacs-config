(defconst answer-config/config-location
  (expand-file-name (concat user-emacs-directory "config.org"))
  "The location on the filesystem where the configuration is saved.")

(defconst answer-config/secret-config-location
  (expand-file-name (concat user-emacs-directory "secret.org"))
  "The location on the filesystem where the secret configuraiton is saved.")

(defun answer-config/load-config (filename)
  "Load the org file from FILENAME using babel."
  (let ((file-name-handler-alist nil))
    (when (file-readable-p filename)
      (org-babel-load-file filename))))

(answer-config/load-config answer-config/secret-config-location)
(answer-config/load-config answer-config/config-location)
