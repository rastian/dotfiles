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
  "Kill ARG lines backwards."
  (interactive "p")
  (kill-line (- 1 args)))
(global-set-key (kbd "C-c k") 'kill-line-backwards)

(defun fix-indent ()
  "Fixes indents of whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))


(provide 'functions)

;;; functions.el ends here


