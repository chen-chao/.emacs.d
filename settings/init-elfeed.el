(use-package elfeed
  :commands (elfeed elfeed-update)
  :bind (:map elfeed-search-mode-map
	      ("g" . elfeed-update)
	      )
  :config
  ;; set face attribute
  (push 'elfeed-search-title-face zh-align-faces)
  (push 'elfeed-search-feed-face zh-align-faces)

  (use-package elfeed-org
    :config
    (setq rmh-elfeed-org-files (list "~/.emacs.d/settings/elfeed.org"))
    (elfeed-org))
  )
(provide 'init-elfeed)
