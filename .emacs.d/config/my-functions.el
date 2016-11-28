;;; my-functions -- Summary

;;; Commentary:

;;; Code:

(defun toggle-comment-on-line ()
  "Comment or uncomment current line."
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))


(global-set-key (kbd "C-;") 'toggle-comment-on-line)

(defun display-startup-echo-area-message ()
  "Displays message after Emacs has finished loading."
  (interactive)
  (message "Let the hacking begin! :^)"))

(defun unix-file ()
  "Change the current buffer to Latin 1 with Unix line-ends."
  (interactive)
  (set-buffer-file-coding-system 'iso-latin-1-unix t))

(defun make (args)
  "Run the make command with ARGS."
  (interactive "smake: ")
  (compile (concat "make " args)))

(defun kill-line-backwards (args)
  "Kill ARGS lines backwards."
  (interactive "p")
  (kill-line (- 1 args)))
(global-set-key (kbd "C-c k") 'kill-line-backwards)

(defun eshell/clear ()
  "Clear the eshell buffer."
  (let ((inhibit-read-only t))
    (erase-buffer)
        (eshell-send-input)))


(provide 'my-functions)
;;; my-functions.el ends here


