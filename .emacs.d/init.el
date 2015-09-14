(package-initialize)
(require 'package)
;; Package Sources
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t)
;; Package List
(defvar package-list '(
           use-package
           org
           helm
           projectile
           god-mode
           ace-jump-mode
           auto-complete
           web-mode
           impatient-mode
           autopair
           neotree
           elpy
           winner-mode
           nlinum
           expand-region
           guide-key
           iy-go-to-char
           key-chord
           smart-mode-line
           writegood-mode
           yasnippet
           speed-type
           auctex
           multiple-cursors
           slime
           paredit
           ))
;;; Packages
;; Use-Package
(require 'use-package)
;; Org
(use-package org
  :ensure t
  :init
  (setq org-log-done t)                 ; Logs TODO -> DONE
  ;; Activates Org Babel execution
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (java . t))))
;; Helm
(use-package helm
  :ensure t
  :diminish helm-mode
  :init
  (progn
    (require 'helm-config)
    (setq helm-candidate-number-limit 100)
    ;; From https://gist.github.com/antifuchs/9238468
    (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
    helm-input-idle-delay 0.01  ; this actually updates things
          ; reeeelatively quickly.
    helm-quick-update t
    helm-M-x-requires-pattern nil
    helm-ff-skip-boring-files t)
    (helm-mode))
  :bind (("C-c h" . helm-mini)
   ("C-h a" . helm-apropos)
   ("C-x b" . helm-buffers-list)
   ("M-y" . helm-show-kill-ring)
   ("M-x" . helm-M-x)
   ("C-x c o" . helm-occur)
   ("C-x c s" . helm-swoop)
   ("C-x c SPC" . helm-all-mark-rings)))
(ido-mode -1)
;; Projectile
(use-package projectile
  :ensure t
  :defer t
  :diminish projectile-mode
  :init
  (setq projectile-keymap-prefix (kbd "C-c p"))
  (setq projectile-completion-system 'helm)
  (setq projectile-enable-cachingt )
  (projectile-global-mode))

(use-package helm-projectile
  :ensure t
  :defer t
  :ensure helm-projectile)
;; God-mode
(use-package god-mode
  :ensure t
  :init
  (global-set-key (kbd "<escape>") 'god-mode-all)
  ;; Changes cursor depending on whether or not god-mode is activated
  (defun my-update-cursor ()
    (setq cursor-type (if (or god-local-mode buffer-read-only)
        'box
      'bar)))
  (add-hook 'god-mode-enabled-hook 'my-update-cursor)
  (add-hook 'god-mode-disabled-hook 'my-update-cursor)
  ;; Integrates I-search
  (require 'god-mode-isearch)
  (define-key isearch-mode-map (kbd "<escape>") 'god-mode-isearch-activate)
  (define-key god-mode-isearch-map (kbd "<escape>") 'god-mode-isearch-disable)
  ;; Makes window switching easier.
  (global-set-key (kbd "C-x C-1") 'delete-other-windows)
  (global-set-key (kbd "C-x C-2") 'split-window-below)
  (global-set-key (kbd "C-x C-3") 'split-window-right)
  (global-set-key (kbd "C-x C-0") 'delete-window)
  (global-set-key (kbd "C-x C-o") 'other-window)
  (global-set-key (kbd "C-x C-k") 'kill-buffer)
  (global-set-key (kbd "C-x C-d") 'dired)
  (global-set-key (kbd "C-x SPC") 'set-mark-command)
  ;; Winner-mode bindings
  (global-set-key (kbd "C-c C-<left>") 'winner-undo)
  (global-set-key (kbd "C-c C-<right>") 'winner-redo))
;; Ace-Jump
(use-package ace-jump-mode
  :ensure t
  :init
  (bind-key "C-c SPC" 'ace-jump-mode))
;; Auto-Complete
(use-package auto-complete
  :ensure t
  :diminish auto-complete-mode
  :init
  (progn
    (global-auto-complete-mode t)))
;; Web-Mode
(use-package web-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (setq web-mode-enable-auto-closing t)
  (setq-default tab-width 2)
  (setq web-mode-enable-auto-pairing t))
;; Impatient-Mode
(use-package impatient-mode
  :ensure t)
;; Autopair
(use-package autopair
  :ensure t
  :diminish autopair-mode
  :init
  (autopair-global-mode t))
;; Neotree
(use-package neotree
  :ensure t)
(use-package pyvenv
	:ensure t
	:init
	(provide 'pyvenv))
;; Elpy
(use-package elpy
  :ensure t
  :init
  (setq python-indent-guess-indent-offset nil))
;; Winner-Mode
(use-package winner
  :ensure t
  :init
  (winner-mode))
;; Nlinum-Mode
(use-package nlinum
  :ensure t
  :init
  (global-nlinum-mode))
;; Expand-Region
(use-package expand-region
  :ensure t
  :init
  (global-set-key (kbd "C-=") 'er/expand-region))
;; Guide-Key
(use-package guide-key
  :ensure t
  :diminish guide-key-mode
  :init
  (progn
    (setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-c" "C-x" "C-x v" "C-x 8"))
    (guide-key-mode 1)
    (setq guide-key/recursive-key-sequence-flag t)
    (setq guide-key/popup-window-position 'bottom)))
;; Smart-Mode-Line
(use-package smart-mode-line
  :ensure t
  :init
  (setq sml/no-confirm-load-theme t)
  (setq sml/theme 'respectful)
  (sml/setup))
;; Multiple-Cursors
(use-package multiple-cursors
  :ensure t
  :init
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))
;; Yasnippet
(use-package yasnippet
  :ensure t
  :init
  (defun yasnippet-can-fire-p (&optional field)
    (interactive)
    (setq yas--condition-cache-timestamp (current-time))
    (let (templates-and-pos)
      (unless (and yas-expand-only-for-last-commands
       (not (member last-command yas-expand-only-for-last-commands)))
  (setq templates-and-pos (if field
            (save-restriction
              (narrow-to-region (yas--field-start field)
              (yas--field-end field))
              (yas--templates-for-key-at-point))
          (yas--templates-for-key-at-point))))

      (set-cursor-color (if (and templates-and-pos (first templates-and-pos))
          "purple" "deep pink"))))

  (add-hook 'post-command-hook 'yasnippet-can-fire-p)

  (yas-global-mode 1))
;; Speed-Type
(use-package speed-type
  :ensure t)
;; SLIME
(use-package slime
  :ensure t
  :init
  (setq inferior-lisp-program "sbcl")
  (setq slime-auto-connect 'ask)
  (slime-setup)
  (add-to-list 'slime-contribs 'slime-repl))
;; Paredit
(use-package paredit
  :ensure t
  :init
  (autoload 'enable-paredit-mode "paredit"
    "Turn on pseudo-structural editing of Lisp code"
    t)
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode))
;; ElDoc
(use-package eldoc
  :ensure t
  :init
  (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode))
;; Prettify-Symbols
;; Uses UTF-16
(add-hook 'prog-mode-hook
    (lambda ()
      (push '(">=" . 8805) prettify-symbols-alist)
      (push '("<=" . 8804) prettify-symbols-alist)
      (push '("lambda" . 955) prettify-symbols-alist)
      (push '("!=" . 8800) prettify-symbols-alist)))
(global-prettify-symbols-mode t)
;;; Themes
;; Solarized
;; (use-package solarized-theme
;;  :ensure t
;;  :init
;;  (load-theme 'solarized-dark t))
;; Zenburn
;; (use-package zenburn-theme
;;  :ensure t
;;  :init
;;  (load-theme 'zenburn t))
;; Darktooth
;; (use-package darktooth-theme
;;   :ensure t
;;   :init
;;   (load-theme 'darktooth t))
;; Seti
(use-package seti-theme
 :ensure t
 :init
 (load-theme 'seti t))
;; Material
;; (use-package material-theme
;;  :ensure t
;;  :init
;;  (load-theme 'material t))
;; Monokai
;; (use-package monokai-theme
;;   :ensure t
;;   :init
;;   (load-theme 'monokai t))

;;; Options
(add-to-list 'default-frame-alist '(font . "Inconsolata-12"))

(fringe-mode '(8 . 0))

(set-cursor-color "deep pink")
(blink-cursor-mode 0)

(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)
(setq initial-major-mode 'org-mode)

(tooltip-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(line-number-mode 1)
(column-number-mode )
(global-linum-mode)

(setq default-directory "~/" )

(global-hl-line-mode 1)

(pending-delete-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

(show-paren-mode 1)
(setq show-paren-delay 0)

(setq make-backup-files nil)

(setq echo-keystrokes 0.1)

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(setq-default indent-tabs-mode nil)

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b"))))

(setq echo-keystrokes 0.1)

(setq c-default-style "bsd")
