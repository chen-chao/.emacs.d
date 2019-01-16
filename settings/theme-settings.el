;; general settings
(setq inhibit-startup-screen 1)
(menu-bar-mode 0)
(tool-bar-mode 0)

;; maximize window at startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; auto completion of pairs and quotations
(electric-pair-mode 1)
(show-paren-mode 1)

(setq require-final-newline 1)

;; show line numbers in the left margin
(setq global-display-line-numbers t)

;; theme settings
(setq custom-safe-themes t)

(require 'eclipse-theme)
(load-theme 'eclipse)

;; enable/disable theme for window-system/terminal
(defun switch-color-theme (frame)
  (select-frame frame)
  (if (window-system frame)
      (progn
	(enable-theme 'eclipse)
	(set-face-foreground 'minibuffer-prompt "medium blue")
	)
    (progn
      (disable-theme 'eclipse)
      ;; set the minibuffer color
      (set-face-foreground 'minibuffer-prompt "cyan")
      )
    ))

;; (add-hook 'after-make-frame-functions 'switch-color-theme)

;; (if window-system (enable-theme 'eclipse)
;;   (progn (disable-theme 'eclipse) (setq frame-background-mode 'dark)))

(provide 'theme-settings)
