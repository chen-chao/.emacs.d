(use-package elfeed
  :config

  ;; set face attribute
  (push 'elfeed-search-title-face zh-align-faces)
  (push 'elfeed-search-feed-face zh-align-faces)

  (use-package elfeed-org
    :config
    (setq rmh-elfeed-org-files (list "~/.emacs.d/settings/elfeed.org"))
    (elfeed-org))

  ;; automatically update feeds
  (when (>= emacs-major-version 26)

    (defvar elfeed-update-timer nil)

    (defun elfeed-cancel-timer ()
      (interactive)
      (and elfeed-update-timer (cancel-timer elfeed-update-timer))
      (setq elfeed-update-timer nil))

    (with-eval-after-load 'elfeed
      ;; (message "load elfeed")
      (elfeed-cancel-timer)
      (setq elfeed-update-timer
	    (run-with-timer 0 3600 (lambda () (make-thread 'elfeed-update))))
      )
  )
)
(provide 'init-elfeed)
