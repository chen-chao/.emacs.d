;; Emacs frontend for weather web service wttr.in

;; for wttrin

(use-package wttrin
  :load-path "site-lisp/emacs-wttrin/"
  :demand t
  :config
  (setq wttrin-default-cities '("Shanghai" "Sihong"))
  (setq wttrin-default-accept-language '("Accept-Language" . "en-US"))
  (setq wttrin-mode-line-city "Shanghai")
  (when (>= emacs-major-version 26)
    (wttrin-display-weather-in-mode-line)
    )
  )

;; reading epub
(use-package nov
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

(use-package leetcode
  :commands leetcode
  :defer t
  :config
  (let* ((secret (auth-source-user-and-password "leetcode.com"))
	 (username (car secret))
	 (password (cadr secret)))
    (setq leetcode-account username)
    (setq leetcode-password password))
  (setq leetcode-prefer-language "python3")
  )

;; open in other window/frame
(use-package other-frame-window
  :diminish
  :init (other-frame-window-mode)
  )

;; Diminished minor modes without modeline display
(use-package diminish
  :config
  ;; diminish built-in modes
  (diminish 'eldoc-mode)
  (diminish 'auto-revert-mode)
  )

;; same as diminish, but also works for major modes 
(use-package delight)

(use-package time
  :config
  (setq display-time-default-load-average nil)
  )

(provide 'init-utils)
