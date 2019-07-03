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

;; completion
(use-package company
  :diminish company-mode
  :init (global-company-mode)
  :bind (:map company-active-map
	      (("C-n" . company-select-next)
	       ("C-p" . company-select-previous)
	       ("C-d" . company-show-doc-buffer)
	       ))
  :config
  (setq company-idle-delay 0.1)
  )

;; template

(use-package yasnippet
  :diminish yas-minor-mode
  :init (yas-global-mode 1)
  :config
  ;; (yas-reload-all)
  ;; (add-hook 'prog-mode-hook #'yas-minor-mode)
  ;; (add-hook 'latex-mode-hook #'yas-minor-mode)
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  )

;; git
(use-package magit
  :bind (("C-c v" . magit-status)
	 ("C-c m" . magit-dispatch-popup))
  )

;; dict
(use-package youdao-dictionary
  :bind
  (("C-c y s" . youdao-dictionary-search-at-point-tooltip)
   ("C-c y i" . youdao-dictionary-search-from-input)
   ("C-c y v" . youdao-dictionary-play-voice-at-point))
  :config
  (setq url-automatic-caching t)	;enable cache
  (setq youdao-dictionary-search-history-file "~/.emacs.d/.youdao_hist")
  )

;; from https://github.com/seagle0128/.emacs.d/lisp/init-edit.el
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
  :hook ((markdown-mode . flyspell-mode)
	 (markdown-mode . auto-fill-mode))
  :config
  ;; Pre-install: markdown
  (when (executable-find "markdown")
    (setq markdown-command "markdown"))
  )

(use-package yaml-mode
  :mode (("\\.yaml\\'" . yaml-mode)
	 ("\\.yml\\'" . yaml-mode)))

(use-package asy-mode
  :load-path "site-lisp/asy"
  :commands (asy-mode lasy-mode asy-insinuate-latex)
  :mode (("\\.asy\\'" . asy-mode)))

(require 'org-settings)

(require 'init-lsp)

(require 'init-ivy)

(require 'init-projectile)

(require 'init-shell)

;; (require 'init-gnus)

(require 'init-eaf)

(require 'init-elfeed)

(require 'init-utils)

;; (require 'init-browser)

(require 'init-golang)

(require 'init-dired)

(setq custom-file "~/.emacs.d/settings/custom.el")

(when (file-exists-p custom-file)
  (load custom-file))

(server-start)
