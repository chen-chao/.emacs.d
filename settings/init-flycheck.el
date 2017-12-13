(use-package flycheck
  :ensure t
  :commands global-flycheck-mode
  :init (global-flycheck-mode)
  :config
  ;; reference: https://github.com/flycheck/flycheck/issues/1002
  (setq flycheck-emacs-lisp-load-path 'inherit)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq flycheck-standard-error-navigation nil)
  (if (file-exists-p "~/.pylint.d/pylintrc")
      (setq flycheck-pylintrc "~/.pylint.d/pylintrc"))
  )

(provide 'init-flycheck)
