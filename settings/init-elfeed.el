(use-package elfeed
  :commands (elfeed elfeed-update)
  :bind (:map elfeed-search-mode-map
	      ("g" . elfeed-update))
  :config
  ;; set face attribute
  (zh-align-set-faces '(elfeed-search-title-face
			      elfeed-search-feed-face))
  (use-package elfeed-org
    :config
    (setq rmh-elfeed-org-files (list "~/.emacs.d/settings/elfeed.org"))
    (elfeed-org))
  )
(provide 'init-elfeed)
