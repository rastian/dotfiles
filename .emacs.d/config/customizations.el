;; Customizations

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

(set-frame-font "Monaco 11" nil t)

(when window-system
  (setq frame-title-format "%b (%f)"))

(when window-system
  (fringe-mode '(8 . 0)))

(set-cursor-color "white")
(blink-cursor-mode 0)

(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)

(tooltip-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(when window-system
   (scroll-bar-mode -1))

(line-number-mode 1)
(column-number-mode 1)

(setq default-directory "~/")

(global-hl-line-mode 1)

(pending-delete-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

(show-paren-mode 1)
(setq show-paren-delay 0)

(setq echo-keystrokes 0.1)

(add-hook 'prog-mode-hook
	  (lambda ()
	    (push '(">=" . 8805) prettify-symbols-alist)
	    (push '("<=" . 8804) prettify-symbols-alist)
	    (push '("lambda" . 955) prettify-symbols-alist)
	    (push '("!=" . 8800) prettify-symbols-alist)))
(global-prettify-symbols-mode t)

;; Key Bindings
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

