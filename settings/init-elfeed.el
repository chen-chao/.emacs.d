(use-package elfeed
  :commands (elfeed elfeed-update)
  :bind (:map elfeed-search-mode-map
	      ("g" . elfeed-update)
	      :map elfeed-show-mode-map
	      ("h" . elfeed-show-render-html))

  :config
  ;; set face attribute
  (zh-align-set-faces '(elfeed-search-title-face
			elfeed-search-feed-face))
  (use-package elfeed-org
    :config
    (setq rmh-elfeed-org-files (list "~/.emacs.d/settings/elfeed.org"))
    (elfeed-org))

  (defun elfeed-show-render-html ()
    (interactive)
    (read-only-mode -1)
    (save-excursion
      (goto-char (point-min))
      (re-search-forward "Link:.*\n\n")
      (shr-render-region (point) (point-max))
      )
    (read-only-mode 1))

  (defun elfeed-enable-socks-proxy (&optional host)
    (interactive)
    (let ((host (or host "127.0.0.1:1080")))
      (setf elfeed-curl-extra-arguments `("--socks5-hostname" ,host))))
  )

(provide 'init-elfeed)
