;; Emacs frontend for weather web service wttr.in

;; for wttrin

(use-package wttrin
  :load-path "site-lisp/emacs-wttrin/"
  :demand t
  :config
  (setq wttrin-default-cities '("Wuxi" "Sihong"))
  (setq wttrin-default-accept-language '("Accept-Language" . "en-US"))
  (setq wttrin-mode-line-city "Shanghai")
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
  :mode (("\\.epub\\'" . nov-mode))
  :config
  (setq nov-text-width 80)
  (add-hook 'nov-mode-hook 'visual-line-mode)
  )

;; po files
(use-package po-mode
  :load-path "site-lisp/po-mode"
  :mode (("\\.po\\'" . po-mode))
  )

(use-package furl
  :ensure t)

(use-package graphql-mode
  :ensure t)

(use-package leetcode
  :load-path "site-lisp/leetcode.el"
  )

;; open in other window/frame
(use-package other-frame-window
  :ensure t
  :diminish
  :init (other-frame-window-mode)
  )

;; Diminished minor modes without modeline display
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
