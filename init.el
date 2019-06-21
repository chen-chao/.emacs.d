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

(setq use-package-verbose t)

(use-package auth-source
  :init
  (setenv "GPG_AGENT_INFO" nil)
  (setq epa-pinentry-mode 'loopback)
  (setq auth-sources '("~/.emacs.d/.authinfo.gpg")))


(setq inhibit-startup-screen 1)
(menu-bar-mode 0)
(tool-bar-mode 0)

;; maximize window at startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(use-package eclipse-theme
  :ensure t
  :init
  (setq custom-safe-themes t)
  (load-theme 'eclipse)
  )

(use-package zh-align
  :load-path "site-lisp/emacs-zh-align/"
  :demand t
  :init
  (add-hook 'after-make-frame-functions #'zh-align-set-frame-faces)
  (add-hook 'window-setup-hook #'zh-align-set-frame-faces)
  )

(use-package edit-indirect)

;; mode settings
(add-to-list 'load-path "~/.emacs.d/settings")

(require 'edit-settings)

(require 'org-settings)

(require 'completion-settings)

(require 'init-ivy)

(require 'init-magit)

(require 'init-projectile)

(require 'init-shell)

;; (require 'init-gnus)

(require 'init-protobuf)

(require 'init-eaf)

(require 'init-dict)

(require 'init-elfeed)

(require 'init-utils)

;; (require 'init-browser)

;; (require 'init-ispell)

(require 'init-golang)

(require 'init-matlab)

(require 'init-markdown)

(setq custom-file "~/.emacs.d/settings/custom.el")

(when (file-exists-p custom-file)
  (load custom-file))
