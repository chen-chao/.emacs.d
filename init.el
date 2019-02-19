;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.


;; proxy
;; (setq url-gateway-method 'socks)
;; (setq socks-server '("Default server" "127.0.0.1" 1080 5) ) ;;for socks5

;; package repository
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://elpa.emacs-china.org/melpa/") t)

;; (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;; 			 ("melpa" . "http://elpa.emacs-china.org/melpa/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile (require 'use-package))


(defun load-current-file ()
  (interactive)
  (load-file (buffer-file-name))
  )

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

(require 'init-eaf)

(require 'init-dict)

;; (require 'init-evil)

;; (require 'init-browser)

;; (require 'init-flycheck)

;; (require 'init-ispell)

;; (require 'matlab-settings)

;; (require 'markdown-settings)

(setq custom-file "~/.emacs.d/settings/custom.el")

(when (file-exists-p custom-file)
  (load custom-file))
