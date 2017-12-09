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
             '("melpa" . "http://melpa.org/packages/") t)

;; (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ;; ("melpa" . "http://melpa.org/packages/")))

(package-initialize)

;; when package-archive-contents does not exist, refresh package
;; (when (not package-archive-contents) (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile (require 'use-package))


;; mode settings
(add-to-list 'load-path "~/.emacs.d/settings")

(require 'ido)
(ido-mode t)

(require 'general-settings)

(require 'theme-settings)

(require 'avy-settings)

(require 'python-settings)

(require 'init-flycheck)

(require 'org-settings)

(require 'matlab-settings)

(require 'markdown-settings)

(setq custom-file "~/.emacs.d/settings/custom.el")
(load custom-file 'noerror)
