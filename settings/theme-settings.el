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
  (progn (disable-theme 'deep-blue) (setq frame-background-mode 'dark)))

;; set the minibuffer color
(set-face-foreground 'minibuffer-prompt "cyan")

;; shortcuts and C+Mouse to adjust the font size
;; this is from http://zhuoqiang.me/torture-emacs.html
(global-set-key (kbd "<C-=>") 'text-scale-increase)
(global-set-key (kbd "<C-->") 'text-scale-decrease)
(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease)

(provide 'theme-settings)
