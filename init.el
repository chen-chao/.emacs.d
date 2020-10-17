;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; paths
(add-to-list 'load-path "~/.emacs.d/settings")
(setq custom-file "~/.emacs.d/settings/custom.el")

;; package repository
(require 'package)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

;; gc threshold, 10 Mb
(setq gc-cons-threshold (* 10 1000 1000))

;; display
(setq inhibit-startup-screen 1)
(menu-bar-mode 0)
(tool-bar-mode 0)
(if (display-graphic-p) (scroll-bar-mode 0))

(setq window-combination-resize t)
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(set-face-attribute 'default nil :family "Cascadia Code" :height 140)

(use-package doom-themes
  :init
  (setq custom-safe-themes t)
  (load-theme 'doom-one))

;; mac specific settings
(when (eq system-type 'darwin)
  (setq-default mac-option-modifier 'alt)
  (setq-default mac-command-modifier 'meta)
  ;; sets fn-delete to be right-delete
  (global-set-key [kp-delete] 'delete-char))

(require 'init-ivy)

;; template
(use-package yasnippet
  :init (yas-global-mode 1)
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets")))


;; external command management
(use-package whicher
  :load-path "site-lisp/whicher/")

(use-package magit
  :bind (("C-c v" . magit-status))
  :config
  (use-package forge))

(use-package zh-align
  :load-path "site-lisp/zh-align.el/")

;; edit
(require 'edit-settings)
(use-package edit-indirect)

;; programming
(use-package company
  :hook ((prog-mode hledger-mode) . company-mode)
  :bind (:map company-active-map
	      (("C-n" . company-select-next)
	       ("C-p" . company-select-previous)))
  :config
  (setq company-idle-delay 0))

(use-package lsp-mode
  :hook ((go-mode python-mode c-mode c++-mode) . lsp-deferred)
  :config
  (use-package lsp-ui
    :config (setq lsp-ui-sideline-enable nil)))

;; syntax checking
;; Pre-install: pip install pylint
(use-package flycheck
  :hook (prog-mode . global-flycheck-mode)
  :bind-keymap
  ("C-c f" . flycheck-command-map)
  :config
  (setq flycheck-emacs-lisp-load-path 'inherit)
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

  ;; only check at saving or opening
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq flycheck-indication-mode 'right-fringe)
  ;; Set fringe style
  (setq flycheck-indication-mode 'right-fringe)
  (when (fboundp 'define-fringe-bitmap)
    (define-fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
      [16 48 112 240 112 48 16] nil nil 'center))

  (if (display-graphic-p)
      (use-package flycheck-posframe
	:hook (flycheck-mode . flycheck-posframe-mode)
	:config
	(add-to-list 'flycheck-posframe-inhibit-functions
		     #'(lambda () (bound-and-true-p company-backend)))
	))

  )

;; spell checking
;; @see https://github.com/seagle0128/.emacs.d/lisp/init-edit.el
(use-package flyspell
  :ensure nil
  :if (executable-find "aspell")
  :hook ((flyspell-mode . (lambda ()
			    (dolist (key '("C-;" "C-," "C-."))
			      (unbind-key key flyspell-mode-map)))))
  :config
  (setq flyspell-issue-message-flag nil)
  (setq ispell-program-name "aspell")
  (setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US" "--run-together")))

;; major modes
(use-package lsp-java
  :hook (java-mode . #'lsp))

(use-package elispfl
  :load-path "site-lisp/elispfl/"
  :hook (emacs-lisp-mode . elispfl-mode))

(use-package protobuf-mode
  :mode (("\\.proto\\'" . protobuf-mode)))

(use-package octave
  :mode (("\\.m$" . octave-mode))
  :config
  (setq octave-comment-start "%"))

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :config
  ;; Pre-install: markdown
  (setq markdown-command (whicher "markdown"))
  ;; set faces
  (zh-align-set-faces '(markdown-table-face)))

(use-package yaml-mode
  :mode (("\\.yaml\\'" . yaml-mode)
	 ("\\.yml\\'" . yaml-mode)))

(use-package asy-mode
  :load-path "site-lisp/asy"
  :commands (asy-mode lasy-mode asy-insinuate-latex)
  :mode (("\\.asy\\'" . asy-mode)))

;; @see https://github.com/jwiegley/use-package/issues/379#issuecomment-258217014
(use-package tex
  :ensure auctex
  :config
  (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex --synctex=1%(mode)%' %t" TeX-run-TeX nil t))
  (setq TeX-command-default "XeLaTeX")
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  ;; (setq TeX-save-query nil)
  ;; (setq TeX-show-compilation t)
  (use-package company-auctex :config (company-auctex-init))
  )

(use-package json-mode)

(use-package cmake-mode)

(use-package typescript-mode)

(use-package racket-mode)

(use-package sml-mode)

;; docker
(use-package docker :defer t)

(use-package dockerfile-mode
  :mode ("Dockerfile\\'" . dockerfile-mode))

;; crontab
(use-package crontab-mode)

(require 'init-python)

(require 'init-org)

(require 'init-shell)

(require 'init-eaf)

(require 'init-elfeed)

(require 'init-utils)

(require 'init-golang)

(require 'init-dired)

(require 'server)
(or (server-running-p) (server-start))
