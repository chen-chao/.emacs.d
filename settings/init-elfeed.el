(use-package elfeed
  :ensure t
  :config
  (use-package elfeed-org :ensure t)
  (setq rmh-elfeed-org-files (list "~/.emacs.d/settings/elfeed.org"))
  (elfeed-org)

  (let ((fset (cc/fontset-han-twice-width)))
    (set-face-attribute 'elfeed-search-title-face nil :fontset fset)
    (set-face-attribute 'elfeed-search-feed-face nil :fontset fset))

  ;; automatically update feeds
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

(provide 'init-elfeed)
