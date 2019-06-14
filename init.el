;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.


;; package repository
(require 'package)

;; Emacs China ELPA
;; (add-to-list 'package-archives
;;              '("melpa" . "http://elpa.emacs-china.org/melpa/") t)

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

;; mode settings
(add-to-list 'load-path "~/.emacs.d/settings")

(require 'theme-settings)

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
