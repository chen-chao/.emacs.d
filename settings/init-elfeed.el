(use-package elfeed
  :ensure t
  :config
  (use-package elfeed-org :ensure t)
  (setq rmh-elfeed-org-files (list "~/.emacs.d/settings/elfeed.org"))
  (elfeed-org)
  )

(provide 'init-elfeed)
