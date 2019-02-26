;; Emacs frontend for weather web service wttr.in
(use-package wttrin
  :ensure t
  :commands (wttrin)
  :config
  (setq wttrin-default-cities '("Wuxi" "Sihong"))
  (setq wttrin-default-accept-language '("Accept-Language" . "en-US"))

  (defun my-wttrin-show-current-city ()
    (interactive)
    (delete-other-windows)
    (wttrin-query "")
    )
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

(use-package display-time
  :config
  (setq display-time-default-load-average nil)
  )

(provide 'utils)
