(use-package flycheck
  :ensure t
  :commands global-flycheck-mode
  :init (global-flycheck-mode)
  :config
  (setq flycheck-emacs-lisp-load-path "inherit")
  (progn
    (setq flycheck-check-syntax-automatically '(save mode-enabled))
    (setq flycheck-standard-error-navigation nil)
    ;; flycheck errors on a tooltip (doesn't work on console)
    ;; (when (display-graphic-p (selected-frame))
    ;; (eval-after-load 'flycheck '(custom-set-variables
    ;; '(flycheck-display-errors-function
    ;; #'flycheck-pos-tip-error-messages))))
    ;; (add-hook 'python-mode-hook 'flycheck-mode)
    )
  )

(provide 'init-flycheck)
