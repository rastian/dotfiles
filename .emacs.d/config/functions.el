(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))


(global-set-key (kbd "C-;") 'toggle-comment-on-line)

(defun display-startup-echo-area-message ()
  "Displays message after Emacs has finished loading"
  (interactive)
  (message "Let the hacking begin!"))

(defun unix-file ()
  "Change the current buffer to Latin 1 with Unix line-ends."
  (interactive)
  (set-buffer-file-coding-system 'iso-latin-1-unix t))

(defun make (args)
  "Runs the make command and then "
  (interactive "smake: ")
  (compile (concat "make " args)))




