;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.

;; paths
(add-to-list 'load-path "~/.emacs.d/settings")
(when (file-exists-p
       (setq custom-file
	     (expand-file-name
	      (concat (system-name) ".el") "~/Sync/emacs/custom/")))
  (load-file custom-file))

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
(when (eq system-type 'windows-nt)
  (set-fontset-font t 'han (font-spec :family "NSimSun")))

;; mac specific settings
(when (eq system-type 'darwin)
  (setq-default mac-option-modifier 'alt)
  (setq-default mac-command-modifier 'meta)
  ;; sets fn-delete to be right-delete
  (global-set-key [kp-delete] 'delete-char))

(require 'init-ivy)

;; edit
(defalias 'yes-or-no-p 'y-or-n-p)

(electric-pair-mode 1)
(show-paren-mode 1)

(setq require-final-newline 1)
(add-hook 'before-save-hook #'delete-trailing-whitespace)

(defun copy-current-line (arg)
  (interactive "p")
  (let* ((beg (line-beginning-position))
	 (end (line-end-position arg))
	 (lines (count-lines beg end)))
    (kill-ring-save beg end)
    (message "%d line%s copied" lines (if (= 1 lines) "" "s"))))

(global-set-key (kbd "M-+") 'text-scale-increase)
(global-set-key (kbd "M--") 'text-scale-decrease)
(global-set-key (kbd "M-k") 'copy-current-line)
(global-set-key (kbd "M-j") 'join-line)
(global-set-key (kbd "M-;") 'comment-line)
(global-set-key (kbd "C->") 'forward-list)
(global-set-key (kbd "C-<") 'backward-list)

(use-package edit-indirect)


;; template
(use-package yasnippet
  :ensure t
  :init (yas-global-mode 1)
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets")))


;; external command management
(use-package whicher
  :commands whicher
  :load-path "site-lisp/whicher/")

(use-package magit
  :ensure t
  :bind (("C-c v" . magit-status)
	 ("C-c m" . magit-dispatch))
  :config
  (when (eq system-type 'windows-nt)
    (setenv "GIT_ASKPASS" "git-gui--askpass")
    (setenv "SSH_ASKPASS" "git-gui--askpass")))


;; (use-package zh-align
;;   :load-path "site-lisp/zh-align.el/")

;; project
(use-package company
  :ensure t
  :hook ((prog-mode hledger-mode) . company-mode)
  :bind (:map company-active-map
	      (("C-n" . company-select-next)
	       ("C-p" . company-select-previous)))
  :config
  (setq company-idle-delay 0))

(use-package lsp-mode
  :ensure t
  :hook ((go-mode python-mode c-mode c++-mode csharp-mode) . lsp-deferred)
  :config
  (use-package lsp-ui
    :config (setq lsp-ui-sideline-enable nil)))

(use-package projectile
  :ensure t
  :bind-keymap ("C-c p" . projectile-command-map)
  :config
  (setq projectile-completion-system 'ivy)
  (setq projectile-mode-line-prefix "Proj"))

;; syntax checking
(use-package flycheck
  :hook (prog-mode . global-flycheck-mode)
  :bind-keymap
  ("C-c C-f" . flycheck-command-map)
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

;; major modes
(require 'prog-lang)

(require 'init-org)

(require 'init-utils)

(require 'init-dired)
