(setq custom-safe-themes t)

(use-package color-theme-modern
             :ensure t
             :config
             (load-theme 'deep-blue t t)             
             )

;; enable/disable theme for window-system/terminal
(defun switch-color-theme (frame)
  (select-frame frame)
  (if (window-system frame)
      (enable-theme 'deep-blue)
    (disable-theme 'deep-blue)))

(add-hook 'after-make-frame-functions 'switch-color-theme)

(if window-system (enable-theme 'deep-blue)
  (disable-theme 'deep-blue))

;; set the minibuffer color
(set-face-foreground 'minibuffer-prompt "cyan")

(provide 'theme-settings)
