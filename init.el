;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.


;; package repository
(require 'package)

;; TNUA ELPA
(setq package-archives
      '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
	("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile (require 'use-package))

;; (setq use-package-verbose t)
(setq use-package-always-ensure t)

(setq inhibit-startup-screen 1)
(menu-bar-mode 0)
(tool-bar-mode 0)

;; maximize window at startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(add-to-list 'load-path "~/.emacs.d/settings")

;; mac specific settings
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  ;; sets fn-delete to be right-delete
  (global-set-key [kp-delete] 'delete-char)
  (set-face-attribute 'default nil :height 200)
  ;; (add-to-list 'default-frame-alist '(font . "Menlo-20"))
  )

(use-package exec-path-from-shell
  :if (memq window-system '(ns mac x))
  :config
  (add-to-list 'exec-path-from-shell-variables "GOPATH")
  (add-to-list 'exec-path-from-shell-variables "WORKON_HOME")
  (exec-path-from-shell-initialize)
  )

;; auth by gpg
(use-package auth-source
  :ensure nil
  :init
  (setenv "GPG_AGENT_INFO" nil)
  (setq epa-pinentry-mode 'loopback)
  (setq auth-sources '("~/.emacs.d/data/.authinfo.gpg"))
  (setq auth-source-cache-expiry 86400) ;; All Day
  (setq auth-source-gpg-encrypt-to "wenbushi@gmail.com")
  )

;; theme
(use-package eclipse-theme
  :ensure nil
  :init
  (setq custom-safe-themes t)
  (load-theme 'eclipse)
  )

(use-package zh-align
  :load-path "site-lisp/emacs-zh-align/"
  :demand t
  :init
  (setq zh-align-charsets '(han kana cjk-misc))
  )

;; edit
(require 'edit-settings)
(use-package edit-indirect)

;; window numbering
(use-package winum
  :init (winum-mode)
  :bind (("M-0" . winum-select-window-0-or-10)
	 ("M-1" . winum-select-window-1)
	 ("M-2" . winum-select-window-2)
	 ("M-3" . winum-select-window-3)
	 ("M-4" . winum-select-window-4)
	 ("M-5" . winum-select-window-5)
	 ("M-6" . winum-select-window-6)
	 ("M-7" . winum-select-window-7))
  )

;; completion
(require 'init-company)

;; template
(use-package yasnippet
  :diminish yas-minor-mode
  :init (yas-global-mode 1)
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  )

;; git
(use-package magit
  :bind (("C-c v" . magit-status)
	 ("C-c m" . magit-dispatch-popup))
  :config
  (unbind-key "M-1" magit-mode-map)
  (unbind-key "M-2" magit-mode-map)
  (unbind-key "M-3" magit-mode-map)
  (unbind-key "M-4" magit-mode-map)
  (unbind-key "M-1" diff-mode-map)
  (unbind-key "M-2" diff-mode-map)
  (unbind-key "M-3" diff-mode-map)
  (unbind-key "M-4" diff-mode-map)
  ;; (setq magit-diff-refine-hunk t)
  )

(use-package git-timemachine)

(use-package forge
  :after magit)

;; dict
(use-package youdao-dictionary
  :bind
  (("C-c y s" . youdao-dictionary-search-at-point-tooltip)
   ("C-c y i" . youdao-dictionary-search-from-input))
  :config
  (setq url-automatic-caching t)	;enable cache
  (setq youdao-dictionary-search-history-file "~/.emacs.d/.youdao_hist")
  )

;; @see https://github.com/seagle0128/.emacs.d/lisp/init-edit.el
(use-package flyspell
  :ensure nil
  :diminish
  :if (executable-find "aspell")
  :hook (((text-mode outline-mode) . flyspell-mode)
	 (flyspell-mode . (lambda ()
			    (dolist (key '("C-;" "C-," "C-."))
			      (unbind-key key flyspell-mode-map)))))
  :init
  (setq flyspell-issue-message-flag nil)
  (setq ispell-program-name "aspell")
  (setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US" "--run-together")))


;; major modes
(use-package protobuf-mode
  :mode (("\\.proto\\'" . protobuf-mode)))

(use-package octave
  :mode (("\\.m$" . octave-mode))
  :config
  (setq octave-comment-start "%")
  )

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :hook ((markdown-mode . flyspell-mode))
  :config
  ;; Pre-install: markdown
  (when (executable-find "markdown")
    (setq markdown-command "markdown"))
  ;; set faces
  (zh-align-set-faces '(markdown-table-face))
  )

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

(use-package js
  :ensure nil
  :hook (js-mode . lsp)
  )

(use-package web-mode
  :mode (("\\.phtml\\'" . web-mode)
	 ("\\.tpl\\.php\\'" . web-mode)
	 ("\\.[agj]sp\\'" . web-mode)
	 ("\\.as[cp]x\\'" . web-mode)
	 ("\\.erb\\'" . web-mode)
	 ("\\.mustache\\'" . web-mode)
	 ("\\.djhtml\\'" . web-mode)
	 ("\\.html?\\'" . web-mode)
	 ("\\.api\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-style-padding 1)
  (setq web-mode-script-padding 1)
  (setq web-mode-block-padding 0)
  )

;; built-in package
(use-package sql
  :ensure nil
  :defer t
  ;; truncate long lines
  :hook ((sql-interactive-mode . (lambda () (toggle-truncate-lines t))))
  :config
  (defun database-info (dbtype loginname database)
    (let* ((secret (auth-source-user-and-password loginname))
	   (username (car secret))
	   (password (cadr secret))
	   (datainfo (auth-source-user-and-password database))
	   (name (car datainfo))
	   (db (cadr datainfo))
	   (port 3306))
      `(,(make-symbol loginname)
	(sql-product (quote ,dbtype))
	(sql-user ,username)
	(sql-password ,password)
	(sql-port ,port)
	(sql-server ,name)
	(sql-database ,db))))

  (setq sql-connection-alist `(,(database-info 'mysql "localtest" "localdb")
			       ,(database-info 'mysql "splayer" "splayerdb")
			       ,(database-info 'mysql "splayerprod" "splayerproddb")
			       ))
  )

(require 'init-python)

(require 'org-settings)

(require 'init-lsp)

(require 'init-ivy)

(require 'init-projectile)

(require 'init-shell)

;; (require 'init-gnus)

(require 'init-eaf)

(require 'init-elfeed)

(require 'init-utils)

(require 'init-mail)

;; (require 'init-browser)

(require 'init-golang)

(require 'init-dired)

(setq custom-file "~/.emacs.d/settings/custom.el")

(when (file-exists-p custom-file)
  (load custom-file))

(require 'server)
(or (server-running-p) (server-start))
