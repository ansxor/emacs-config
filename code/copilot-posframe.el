;;;; -*- lexical-binding: t -*-

(require 'posframe)
(require 'copilot)

(defvar copilot-posframe-point nil
  "The point in the buffer where the user was at when the posframe was created")

(defconst copilot-posframe-buffer
  "*copilot-message-buffer*"
  "The Posframe buffer which contains the message for completions")

(defun copilot-complete-custom-fail (success-function fail-function)
  "Complete at the current point."
  (interactive)
  (setq copilot--last-doc-version copilot--doc-version)

  (setq copilot--completion-cache nil)
  (setq copilot--completion-idx 0)

  (copilot--get-completion
   (jsonrpc-lambda (&key completions &allow-other-keys)
     (let ((completion (if (seq-empty-p completions) nil (seq-elt completions 0))))
       (if completion
			  (progn
				 (copilot--show-completion completion)
				 (funcall success-function))
			(funcall fail-function))))))

(defun copilot-posframe-hide ()
  "Hide the Posframe that displays in the Copilot flow."
  (when (and copilot-posframe-point
				 (/= (point) copilot-posframe-point))
	 (posframe-delete copilot-posframe-buffer)
	 (setq copilot-posframe-point nil)))

(defun copilot-posframe-show-message (msg)
  "Show `msg' at the point."
  (posframe-show copilot-posframe-buffer
					  :string msg
					  :position (point)
					  :timeout 3
					  :internal-border-color "#ffffff") )

(defun copilot-posframe-flow ()
  "Depending on whether the Copilot overlay is visible, either request for a
completion, or accept the completion available."
  (interactive)
  (when copilot-posframe-point
	 (posframe-delete copilot-posframe-buffer))
  (if (copilot--overlay-visible)
		(copilot-accept-completion)
	 (progn
		(copilot-posframe-show-message "Querying Copilot...")
		(copilot-complete-custom-fail
		 '(lambda () (posframe-delete copilot-posframe-buffer))
		 '(lambda ()
			 (setq copilot-posframe-point (point))
			 (copilot-posframe-show-message "No completion available"))))))

(defvar copilot-posframe-mode-map (make-sparse-keymap)
  "Keymap used by `copilot-posframe-mode'.")

(define-minor-mode copilot-posframe-mode
  "Minor mode for Copilot posframes"
  :init-value nil
  :lighter " Copilot-Posframe"
  (add-hook 'post-command-hook 'copilot-posframe-hide nil 'local-only))

(provide 'copilot-posframe)
