;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

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

(require 'python-settings)

(require 'org-settings)

(require 'matlab-settings)

 ;; Added by installed packages
 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   (quote
    ("~/org/gtd.org" "~/archlinux.log/python.org" "~/work.org")))
 '(package-selected-packages
   (quote
    (neotree projectile org-link-minor-mode python-info color-theme-sanityinc-solarized pydoc pydoc-info flycheck jedi org))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
