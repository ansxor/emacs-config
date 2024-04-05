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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
	'("12953be69a341359b933c552cc2c0127410c755349096018868d5c109283bfd8" default))
 '(package-vc-selected-packages
	'((copilot :url "https://github.com/copilot-emacs/copilot.el")
	  (asdf :url "https://github.com/tabfugnic/asdf.el"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
