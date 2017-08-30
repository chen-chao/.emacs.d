;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
;; when package-archive-contents does not exist, refresh package
(when (not package-archive-contents) (package-refresh-contents))

;; package repository
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")))


;; mode settings
(add-to-list 'load-path "~/.emacs.d/settings")

(require 'ido)
(ido-mode t)

(require 'general-settings)

(require 'org-settings)

(require 'auto-complete-settings)

(require 'python-settings)


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
    (org-link-minor-mode python-info color-theme-sanityinc-solarized pydoc pydoc-info flycheck jedi org))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
