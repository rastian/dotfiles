;;; package-setup -- Summary

;;; Commentary:

;;; Code:

(package-initialize)
(require 'package)

;;; Package sources
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t)

(when (not package-archive-contents)
  (package-refresh-contents))

;;; Package Configurations
;; (require 'use-package)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(setq use-package-verbose t)

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)


(use-package org
  ;; For keeping notes, maintaining TODO lists, planning projects, and
  ;; authoring documents with a fast and effective plain-text system.
  :ensure t
  :config
  (setq org-hide-emphasis-markers t)
  ;; Regex to replace bullets with unicode characters
  (font-lock-add-keywords 'org-mode
			  '(("^ +\\([*]\\) "
			     (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  (font-lock-add-keywords 'org-mode
			  '(("^ +\\([-]\\) "
			     (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "►"))))))
  (font-lock-add-keywords 'org-mode
			  '(("^ +\\([+]\\) "
			     (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "○"))))))
  
  (setq org-log-done t)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (java . t)))
  (org-toggle-pretty-entities)
  ;; testing. changing header size and font based on level
  (let* ((variable-tuple (cond ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
			       ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
			       ((x-list-fonts "Verdana")         '(:font "Verdana"))
			       ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
			       (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
	 (base-font-color     (face-foreground 'default nil 'default))
	 (headline           '(:inherit default :weight bold :foreground ,base-font-color)))

    (custom-theme-set-faces 'user
			    '(org-level-8 ((t (,@headline ,@variable-tuple))))
			    '(org-level-7 ((t (,@headline ,@variable-tuple))))
			    '(org-level-6 ((t (,@headline ,@variable-tuple))))
			    '(org-level-5 ((t (,@headline ,@variable-tuple))))
			    '(org-level-4 ((t (,@headline ,@variable-tuple :height 1))))
			    '(org-level-3 ((t (,@headline ,@variable-tuple :height 1.1))))
			    '(org-level-2 ((t (,@headline ,@variable-tuple :height 1.25))))
			    '(org-level-1 ((t (,@headline ,@variable-tuple :height 1.5))))
			    '(org-document-title ((t (,@headline ,@variable-tuple :height 1.5 :underline nil)))))))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package helm
  ;; An incremental completion and selection narrowing framework for Emacs.
  :ensure t
  :diminish helm-mode
  :init
  (require 'helm-config)
  (setq helm-candidate-number-limit 100)
  (setq  helm-idle-delay 0.0)
  (setq helm-input-idle-delay 0.01)
  (setq helm-quick-update t)
  (setq helm-M-x-requires-pattern nil)
  (setq helm-ff-skip-boring-files t)
  (helm-mode)
  :bind (("C-c h" . helm-mini)
	 ("C-h a" . helm-apropos)
	 ("C-x b" . helm-buffers-list)
	 ("M-y" . helm-show-kill-ring)
	 ("M-x" . helm-M-x)
	 ("C-x c o" . helm-occur)
	 ("C-x c s" . helm-swoop)
	 ("C-x c SPC" . helm-all-mark-rings)
	 ("C-x C-f" . helm-find-files)))

(use-package helm-descbinds
  :ensure t
  :defer t
  :bind (("C-h b" . helm-descbinds)
	 ("C-h w" . helm-descbinds)))

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

(use-package undo-tree
  :ensure t
  :defer t
  :config
  (global-undo-tree-mode)
  (setq undo-tree-visualizer-timestamps t)
  (setq undo-tree-visualizer-diff t))

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

(use-package tramp
  :ensure t
  :config
  (setq tramp-default-method "ssh"))

(use-package comment-dwim-2
  :ensure t
  :bind (("M-;" . comment-dwim-2))
  :config
  (setq comment-dwim-2--inline-comment-behavior 'reindent-comment))


(use-package company
  ;; Modular in-buffer completion framework for Emacs
  :ensure t
  :diminish company-mode
  :config
  (global-company-mode 1))

(use-package auto-complete
  :ensure t)

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
  (add-to-list 'auto-mode-alist '("\\.php?\\'" . web-mode))
  (defun my-web-mode-hook ()
    (setq web-mode-enable-auto-closing t)
    (setq web-mode-enable-auto-pairing t)
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-css-indent-offset 2)
    (setq web-mode-code-indent-offset 2)
    (setq web-mode-attr-indent-offset 2)
    (setq web-mode-enable-current-element-highlight t))
  (add-hook 'web-mode-hook 'my-web-mode-hook))
;; (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;; (setq web-mode-enable-auto-closing t)
;; (setq tab-width 2)
;; (setq web-mode-enable-auto-pairing t))

(use-package js2-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.js?\\'" . js2-mode)))


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
  :disabled t
  :ensure t
  :config
  (powerline-default-theme)
  (setq powerline-default-separator 'wave))

(use-package spaceline-config
  ;; :disabled t
  :load-path "elisp/spaceline/"
  :config
  (defvar spaceline-workspace-numbers-unicode)
  (defvar spaceline-window-numbers-unicode)
  (spaceline-emacs-theme)
  (setq spaceline-workspace-numbers-unicode t)
  (setq spaceline-window-numbers-unicode t)
  (setq spaceline--segment-line ))

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
  :config
  (setq multiple-cursors-mode nil)
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

(use-package clojure-mode
  :ensure t
  :config
  (add-hook 'clojure-mode-hook 'subword-mode))

(use-package clojure-mode-extra-font-locking
  :ensure t
  :config
  (require 'clojure-mode-extra-font-locking))

(use-package cider
  :ensure t
  :config
  (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
  (setq cider-repl-pop-to-buffer-on-connect)
  (setq cider-show-error-buffer)
  (setq cider-auto-select-error-buffer)
  (setq cider-repl-history-file "~/.emacs.d/cider-history")
  (setq cider-repl-wrap-history)
  (add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
  (add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
  (add-to-list 'auto-mode-alist '("\\.cljs.*$" . clojure-mode))
  (add-to-list 'auto-mode-alist '("lein-env" . enh-ruby-mode))

  (setq cider-repl-display-help-banner nil)

  (defun cider-start-http-server ()
    (interactive)
    (cider-load-current-buffer)
    (let ((ns (cider-current-ns)))
      (cider-repl-set-ns ns)
      (cider-interactive-eval (format "(println '(def server (%s/start))) (println 'server)" ns))
      (cider-interactive-eval (format "(def server (%s/start)) (println server)" ns))))

  (defun cider-refresh ()
    (interactive)
    (cider-interactive-eval (format "(user/reset)")))

  (defun cider-user-ns ()
    (interactive)
    (cider-repl-set-ns "user"))

  (add-hook 'cider-mode-hook 'ac-flyspell-workaround)
  (add-hook 'cider-mode-hook 'ac-cider-setup)
  (add-hook 'cider-repl-mode-hook 'ac-cider-setup))

(use-package ac-cider
  :ensure t
  :config
  (eval-after-load "auto-complete"
    '(progn
       (add-to-list 'ac-modes 'cider-mode)
       (add-to-list 'ac-modes 'cider-repl-mode))))


(use-package cc-mode
  :config
  (setq tab-width 4)
  (setq c-basic-offset 4)
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
  (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
  (add-hook 'clojure-mode-hook 'enable-paredit-mode)
  (add-hook 'cider-repl-mode-hook 'paredit-mode)

  (add-to-list 'exec-path "~/.lein/bin"))

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

(use-package rainbow-delimiters
  :ensure t
  :config
  (rainbow-delimiters-mode t))

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

;;; fixme-mode
;; highlights keywords like TODO, FIX, FIXME, and BUG
(use-package fixme-mode
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'fixme-mode))

(provide 'package-setup)

;;; package-setup.el ends here

