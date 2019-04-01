;; Emacs frontend for weather web service wttr.in

;; for wttrin
(use-package xterm-color
  :ensure t
  )

(use-package wttrin
  :load-path "site-lisp/emacs-wttrin/"
  :requires xterm-color
  :config
  (setq wttrin-default-cities '("Wuxi" "Sihong"))
  (setq wttrin-default-accept-language '("Accept-Language" . "en-US"))
  
  (when (>= emacs-major-version 26)
    (wttrin-display-weather-in-mode-line)
    )
  
  (defun my-wttrin-show-current-city ()
    (interactive)
    (delete-other-windows)
    (wttrin-query "")
    )
  )

;; reading epub
(use-package nov
  :ensure t
  ;; :init (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  :mode (("\\.epub\\'" . nov-mode))
  :config
  (setq nov-text-width 80)
  (add-hook 'nov-mode-hook 'visual-line-mode)
  )

;; Diminished modes are minor modes with no modeline display
(use-package diminish
  :ensure t
  :config
  ;; diminish built-in modes
  (diminish 'eldoc-mode)
  (diminish 'auto-revert-mode)
  )

;; same as diminish, but also works for major modes 
(use-package delight
  :ensure t
  )

(use-package time
  :config
  (setq display-time-default-load-average nil)
  )

(provide 'init-utils)
