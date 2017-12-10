(use-package flycheck
  :ensure t
  :commands global-flycheck-mode
  :init (global-flycheck-mode)
  :config
  (setq flycheck-emacs-lisp-load-path "inherit")
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq flycheck-standard-error-navigation nil)
  (if (file-exists-p "~/.pylint.d/pylintrc")
      (setq flycheck-pylintrc "~/.pylint.d/pylintrc"))
  )

(provide 'init-flycheck)
