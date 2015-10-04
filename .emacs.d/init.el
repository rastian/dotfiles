;;; package --- init.el
;;; Code:

(package-initialize)
(require 'package)

;; Package Sources
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t)

;; Package List
(defvar package-list '(
											 org
											 helm
											 helm-projectile
											 god-mode
											 yasnippet
											 company
											 flycheck
											 ace-jump-mode
											 web-mode
											 impatient-mode
											 autopair
											 pyvenv
											 elpy
											 winner
											 nlinum
											 expand-region
											 guide-key
											 powerline
											 smart-mode-line
											 multiple-cursors
											 speed-type
											 slime
											 paredit
											 eldoc
											 ace-window
											 anzu
											 window-numbering
											 eyebrowse
											 org-present
           ))

;;; Packages
;; use-package
(require 'use-package)

;;; org
;; For keeping notes, maintaining TODO lists, planning projects, and
;; authoring documents with a fast and effective plain-text system.
(use-package org
  :ensure t
  :config
  (setq org-log-done t)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (java . t))))

;;; helm
;; An incremental completion and selection narrowing framework for Emacs. 
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
  :bind
  (("C-c h" . helm-mini)
   ("C-h a" . helm-apropos)
   ("C-x b" . helm-buffers-list)
   ("M-y" . helm-show-kill-ring)
   ("M-x" . helm-M-x)
   ("C-x c o" . helm-occur)
   ("C-x c s" . helm-swoop)
   ("C-x c SPC" . helm-all-mark-rings)))

;;; projectile
;; A project interaction library for Emacs
(use-package projectile
  :ensure t
  :diminish projectile-mode
  :init
  (setq projectile-keymap-prefix (kbd "C-c p"))
  (setq projectile-completion-system 'helm)
  (setq projectile-enable-caching t)
  (projectile-global-mode))

;;; helm-projectile
;; helm and projectile integration

(use-package helm-projectile
  :ensure t
  :defer t
  :ensure helm-projectile)

;;; god-mode
;; Global minor mode for entering Emacs commands without modifier keys
(use-package god-mode
  :ensure t
  :init
  (global-set-key (kbd "<escape>") 'god-mode-all)
	(setq god-exempt-major-modes nil)
	(setq god-exempt-predicates)
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

;;; yasnippet
;;  A template system for Emacs
(use-package yasnippet
  :ensure t
	:diminish yas-minor-mode
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
          "purple" "white"))))

  (add-hook 'post-command-hook 'yasnippet-can-fire-p)

  (yas-global-mode 1))

;;; magit
;; Magit is an interface to the version control system Git,
;; implemented as an Emacs package.
(use-package magit
	:ensure t
	:init
	(global-set-key (kbd "C-x g") 'magit-status))


;;; company
;; Modular in-buffer completion framework for Emacs
(use-package company
	:ensure t
	:diminish company-mode
	:config
	(global-company-mode 1))

;;; flycheck
;; Modern on the fly syntax checking for GNU Emacs
(use-package flycheck
	:ensure t
	:diminish flycheck-mode
	:config
	(global-flycheck-mode 1))

;;; ace-jump
;; A quick cursor jump mode for emacs
(use-package ace-jump-mode
  :ensure t
  :init
  (bind-key "C-c SPC" 'ace-jump-mode))

;;; web-mode
;; web template editing mode for emacs
(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (setq web-mode-enable-auto-closing t)
  (setq-default tab-width 2)
  (setq web-mode-enable-auto-pairing t))

;;; impatient-mode
;; See the effect of your HTML as you type it.
(use-package impatient-mode
  :ensure t)

;;; autopair
;; Automagically pair braces and quotes in emacs like TextMate 
(use-package autopair
  :ensure t
  :diminish autopair-mode
  :config
  (autopair-global-mode t))

;;; pyvenv
;; Python virtual environment interface for Emacs 
(use-package pyvenv
	:ensure t
	:config
	(provide 'pyvenv))

;;; elpy
;; Emacs Python Development Environment 
(use-package elpy
  :ensure t
  :config
  (setq python-indent-guess-indent-offset nil))

;;; winner
;; Winner mode is a global minor mode that records the changes in
;; the window configuration (i.e. how the frames are partitioned into
;; windows) so that the changes can be "undone" using the command
;; 'winner-undo'.
(use-package winner
  :ensure t
  :init
  (winner-mode))

;;; nlinum
;; Lighter replacement for linum
(use-package nlinum
  :ensure t)

;;; expand-region
;; Emacs extension to increase selected region by semantic units
(use-package expand-region
  :ensure t
  :init
  (global-set-key (kbd "C-=") 'er/expand-region))

;;; guide-key
;; Guide following keys to an input key sequence automatically and
;; dynamically in Emacs.
(use-package guide-key
  :ensure t
  :diminish guide-key-mode
  :init
  (progn
    (setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-c" "C-x" "C-x v" "C-x 8"))
    (guide-key-mode 1)
    (setq guide-key/recursive-key-sequence-flag t)
    (setq guide-key/popup-window-position 'bottom)))

;;; powerline
;; Powerline in Emacs
(use-package powerline
	:ensure t)

;; spaceline
(use-package spaceline-config
	:load-path "elisp/spaceline/"
	:config
	(defvar spaceline-workspace-numbers-unicode)
	(defvar spaceline-window-numbers-unicode)
	(spaceline-spacemacs-theme)
	(setq spaceline-workspace-numbers-unicode t)
	(setq spaceline-window-numbers-unicode t))

;;; smart-mode-line
;; A powerful and beautiful mode-line for Emacs. 
(use-package smart-mode-line
  :ensure t
  :init
  (setq sml/no-confirm-load-theme t)
  (setq sml/theme 'respectful)
  (sml/setup))

;;; multiple-cursors
;; Multiple cursors for emacs. 
(use-package multiple-cursors
  :ensure t
  :init
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))

;;; speed-type
;; Tests WPM
(use-package speed-type
  :ensure t)

;;; slime
;; The Superior Lisp Interaction Mode for Emacs
(use-package slime
  :ensure t
  :config
  (setq inferior-lisp-program "sbcl")
  (setq slime-auto-start 'ask)
  (slime-setup)
  (add-to-list 'slime-contribs 'slime-repl))

;;; paredit
;; A minor mode for performing structured editing of S-expression data.
(use-package paredit
  :ensure t
  :config
  (autoload 'enable-paredit-mode "paredit"
    "Turn on pseudo-structural editing of Lisp code"
    t)
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode))

;; eldoc
;; A very simple but effective thing, eldoc-mode is a MinorMode which
;; shows you, in the echo area, the argument list of the function call
;; you are currently writing.
(use-package eldoc
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode))

;;; ace-window
;;  Quickly switch windows in Emacs 
(use-package ace-window
  :ensure t
  :init
  (global-set-key (kbd "M-p") 'ace-window)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (defvar aw-dispatch-alist
    '((?x aw-delete-window " Ace - Delete Window")
      (?m aw-swap-window " Ace - Swap Window")
      (?n aw-flip-window)
      (?v aw-split-window-vert " Ace - Split Vert Window")
      (?b aw-split-window-horz " Ace - Split Horz Window")
      (?i delete-other-windows " Ace - Maximize Window")
      (?o delete-other-windows))
    "List of actions for `aw-dispatch-default'."))

;;; anzu
;; Displays current match and total matches information in the
;; mode-line in various search modes.
(use-package anzu
	:ensure t
	:diminish anzu-mode
	:config
	(global-anzu-mode 1)
	:init
	(global-set-key (kbd "M-%") 'anzu-query-replace)
	(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp))

;;; window-numbering
;; Numbers windows and allows switching using M-{window-num}
(use-package window-numbering
	:ensure t
	:config
	(window-numbering-mode 1))

;;; eyebrowse
;; A global minor mode for Emacs that allows you to manage your window
;; configurations in a simple manner, just like tiling window managers
;; like i3wm with their workspaces do
(use-package eyebrowse
	:ensure t
	:diminish eyebrowse-mode
	:config
	(eyebrowse-mode t))

;;; org-present
;; Ultra-minimalist presentation minor-mode for Emacs org-mode
(use-package org-present
	:ensure t
	:config
	(add-hook 'org-present-mode-hook
						(lambda ()
							(org-present-big)
							(org-display-inline-images)
							(org-present-hide-cursor)
							(org-present-read-only)
							(nlinum-mode 0)
							(linum-mode 0)
							(global-hl-line-mode 0)))
	(add-hook 'org-present-mode-quit-hook
						(lambda ()
							(org-present-small)
							(org-remove-inline-images)
							(org-present-show-cursor)
							(org-present-read-write)
							(global-hl-line-mode 1))))

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

;; Spacemacs
(use-package spacemacs-theme
	:ensure t
	:init
	(load-theme 'spacemacs-dark t)
	;; (load-theme 'spacemacs-light t)
	)

;; Solarized
;; (use-package solarized-theme
;;  :ensure t
;;  :init
;;  (load-theme 'solarized-dark t))

;; Zenburn
;; (use-package zenburn-theme
;;   :ensure t
;;   :init
;;   (load-theme 'zenburn t))

;; Darktooth
;; (use-package darktooth-theme
;;   :ensure t
;;   :init
;;   (load-theme 'darktooth t))

;; Seti
;; (use-package seti-theme
;;  :ensure t
;;  :init
;;  (load-theme 'seti t))

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
;; (add-to-list 'default-frame-alist '(font . "Inconsolata-14"))

(fringe-mode '(8 . 0))

(set-cursor-color "white")
(blink-cursor-mode 0)

(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)
(setq initial-major-mode 'org-mode)

(tooltip-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(line-number-mode 1)
(column-number-mode)

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


(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b"))))

(setq echo-keystrokes 0.1)

(setq c-default-style "bsd")
(setq c-basic-offset 4)

;;; init.el ends here
