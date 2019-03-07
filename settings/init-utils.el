;; Emacs frontend for weather web service wttr.in

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-wttrin/")
(require 'wttrin)
(setq wttrin-default-cities '("Wuxi" "Sihong"))
(setq wttrin-default-accept-language '("Accept-Language" . "en-US"))
(defun my-wttrin-show-current-city ()
  (interactive)
  (delete-other-windows)
  (wttrin-query "")
  )
(wttrin-display-weather-in-mode-line)

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
