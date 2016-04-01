(package-initialize)
(require 'package)

;;; Package sources
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(
		      use-package
		      org
		      helm
		      projectile
		      helm-projectile
		      god-mode
		      ))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;;; Package Configurations
;; (require 'use-package)
(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)


(use-package org
  ;; For keeping notes, maintaining TODO lists, planning projects, and
  ;; authoring documents with a fast and effective plain-text system.
  :ensure t
  :config
  (setq org-log-done t)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (java . t)))
  (setq org-ellipsis "◦◦◦"))


(use-package helm
  ;; An incremental completion and selection narrowing framework for Emacs.
  :ensure t
  :diminish helm-mode
  :init
  (progn
    (require 'helm-config)
    (setq helm-candidate-number-limit 100)
    (setq helm-idle-delay 0.0
	  helm-input-idle-delay 0.01
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
	 ("C-x c SPC" . helm-all-mark-rings)
	 ("C-x C-f" . helm-find-files)))


(use-package projectile
  ;; A project interaction library for Emacs
  :ensure t
  :diminish projectile-mode
  :config
  (setq projectile-keymap-prefix (kbd "C-c p"))
  (setq projectile-completion-system 'helm)
  (setq projectile-enable-caching t)
  (projectile-global-mode))


(use-package helm-projectile
  ;; helm and projectile integration
  :ensure t
  :defer t
  )

(use-package god-mode
  ;; Global minor mode for entering Emacs commands without modifier keys
  :ensure t
  :config
  ;; (setq god-exempt-major-modes nil)
  ;; (setq god-exempt-predicates)
  ;; Changes cursor depending on whether or not god-mode is activated
  (defun my-update-cursor ()
    (setq cursor-type (if (or god-local-mode buffer-read-only) 'hollow 'box)))
  (add-hook 'god-mode-enabled-hook 'my-update-cursor)
  (add-hook 'god-mode-disabled-hook 'my-update-cursor)
  (require 'god-mode-isearch)
  (define-key isearch-mode-map (kbd "<escape>") 'god-mode-isearch-activate)
  (define-key god-mode-isearch-map (kbd "<escape>") 'god-mode-isearch-disable)
  :bind (("<escape>" . god-mode-all)
	 ("C-x C-1" . delete-other-windows)
  	 ("C-x C-2" . split-window-below)
	 ("C-x C-3" . split-window-right)
	 ("C-x C-0" . delete-window)
	 ("C-x C-o" . other-window)
	 ("C-x C-k" . kill-buffer)
	 ("C-x C-d" . dired)
	 ("C-x SPC" . set-mark-command)
	 ("C-c C-<left>" . winner-undo)
	 ("C-c C-<right>" . winner-redo)))


(use-package yasnippet
  ;; A template system for Emacs
  :ensure t
  :diminish yas-minor-mode
  :config
  (defun yasnippet-can-fire-p (&optional field)
    "Changes the color of the cursor when yasnippet is able to fire"
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


(use-package abbrev
  ;; Defined abbreviations get autoexpanded
  :init
  (setq-default abbrev-mode t))

(use-package magit
  ;; Magit is an interface to the version control system Git,
  ;; implemented as an Emacs package.
  :ensure t
  :bind (("C-x g" . magit-status)))


(use-package company
  ;; Modular in-buffer completion framework for Emacs
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


(use-package ace-jump-mode
  ;; A quick cursor jump mode for emacs
  :ensure t
  :bind (("C-c SPC" . ace-jump-mode)))


(use-package web-mode
  ;; web template editing mode for emacs
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (setq web-mode-enable-auto-closing t)
  (setq tab-width 2)
  (setq web-mode-enable-auto-pairing t))


(use-package impatient-mode
  ;; See the effect of your HTML as you type it.
  :ensure t)

(use-package autopair
  ;; Automagically pair braces and quotes in emacs like TextMate 
  :ensure t
  :diminish autopair-mode
  :config
  (autopair-global-mode t))

(use-package pyvenv
  ;; Python virtual environment interface for Emacs 
  :ensure t
  :config
  (provide 'pyvenv))


(use-package elpy
  ;; Emacs Python Development Environment 
  :ensure t
  :config
  (setq python-indent-guess-indent-offset nil))


(use-package winner
  ;; A global minor mode that records the changes in the window
  ;; configuration so that the changes can be "undone" using the
  ;; command 'winner-undo'.
  :ensure t
  :config
  (winner-mode))

(use-package nlinum
  ;; Lighter replacement for linum
  :ensure t
  :config
  (global-nlinum-mode))

(use-package expand-region
  ;; Emacs extension to increase selected region by semantic units
  :ensure t
  :bind (("C-=" . er/expand-region)))

(use-package guide-key
  ;; Guide following keys to an input key sequence automatically and
  ;; dynamically in Emacs.
  :ensure t
  :diminish guide-key-mode
  :init
  (setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-c" "C-x" "C-x v" "C-x 8"))
  (guide-key-mode 1)
  (setq guide-key/recursive-key-sequence-flag t)
  (setq guide-key/popup-window-position 'bottom))

(use-package powerline
  ;; Powerline in Emacs
  :ensure t)

(use-package spaceline-config
  :disabled t
  :load-path "elisp/spaceline/"
  :config
  (defvar spaceline-workspace-numbers-unicode)
  (defvar spaceline-window-numbers-unicode)
  (spaceline-emacs-theme)
  (setq spaceline-workspace-numbers-unicode t)
  (setq spaceline-window-numbers-unicode t))


(use-package smart-mode-line
  ;; A powerful and beautiful mode-line for Emacs.
  :disabled t
  :ensure t
  :config
  (setq sml/no-confirm-load-theme t)
  (setq sml/theme 'respectful)
  (sml/setup))

;;; multiple-cursors
;; Multiple cursors for emacs. 
(use-package multiple-cursors
  :ensure t
  :bind (("C->" . mc/mark-next-like-this)
	 ("C-<" . mc/mark-previous-like-this)
	 ("C-c C-<" . mc/mark-all-like-this)))

(use-package slime
  ;; The Superior Lisp Interaction Mode for Emacs
  :ensure t
  :config
  (setq inferior-lisp-program "sbcl")
  (setq slime-auto-start 'ask)
  (slime-setup)
  (add-to-list 'slime-contribs 'slime-repl))

(use-package c-mode
  :config
  (setq-default c-basic-offset 4)
  (setq-default c-default-style "linux"))

(use-package tex-site
  :ensure auctex)

(use-package cdlatex
  :ensure t)

(use-package paredit
  ;; A minor mode for performing structured editing of S-expression data.
  :ensure t
  :config
  (autoload 'enable-paredit-mode "paredit"
    "Turn on pseudo-structural editing of Lisp code"
    t)
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode))

(use-package eldoc
  ;; A very simple but effective thing, eldoc-mode is a MinorMode which
  ;; shows you, in the echo area, the argument list of the function call
  ;; you are currently writing.
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode))

(use-package ace-window
  ;;  Quickly switch windows in Emacs 
  :ensure t
  :config

  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (defvar aw-dispatch-alist
    '((?x aw-delete-window " Ace - Delete Window")
      (?m aw-swap-window " Ace - Swap Window")
      (?n aw-flip-window)
      (?v aw-split-window-vert " Ace - Split Vert Window")
      (?b aw-split-window-horz " Ace - Split Horz Window")
      (?i delete-other-windows " Ace - Maximize Window")
      (?o delete-other-windows))
    "List of actions for `aw-dispatch-default'.")
  :bind   (("M-p" . ace-window)))


(use-package anzu
  ;; Displays current match and total matches information in the
  ;; mode-line in various search modes.
  :ensure t
  :diminish anzu-mode
  :config
  (global-anzu-mode 1)
  :bind (("M-%" . anzu-query-replace)
	 ("C-M-%" . anzu-query-replae-regexp)))

(use-package window-numbering
  ;; Numbers windows and allows switching using M-{window-num}
  :ensure t
  :config
  (window-numbering-mode 1))


(use-package eyebrowse
  ;; A global minor mode for Emacs that allows you to manage your window
  ;; configurations in a simple manner, just like tiling window managers
  ;; like i3wm with their workspaces do
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
