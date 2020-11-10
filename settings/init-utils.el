;; reading epub
(use-package nov
  :hook (nov-mode . visual-line-mode)
  :mode (("\\.epub\\'" . nov-mode)))

;; po files
(use-package po-mode :mode (("\\.po\\'" . po-mode)))

(use-package pdf-tools
  :if (not (eq system-type 'windows-nt))
  :commands (pdf-tools-enable-minor-modes)
  :mode (("\\.pdf\\'" . pdf-view-mode))
  :hook (pdf-view-mode . pdf-tools-enable-minor-modes)
  :bind (:map pdf-view-mode-map
	      ("C-s" . isearch-forward)))

;; dict
(use-package youdao-dictionary
  :bind (("C-c y s" . youdao-dictionary-search-at-point-posframe)
	 ("C-c y i" . youdao-dictionary-search-from-input))
  :config
  (setq url-automatic-caching t))

;; transmission
(use-package transmission
  :defer t
  :if (executable-find "transmission-daemon"))

;; holidays and chinese holidays
(use-package cal-china-x
  :config
  (let ((western-general-holidays
	 '((holiday-fixed 2 14 "Valentine's Day")
	  (holiday-fixed 4 1 "April Fools' Day")
	  (holiday-float 5 0 2 "Mother's Day")
	  (holiday-float 6 0 3 "Father's Day")
	  (holiday-fixed 10 31 "Halloween")
	  (holiday-fixed 12 25 "Christmas")))
	(cal-china-x-general-holidays
	 '((holiday-lunar 1 15 "元宵节" 0)
	   (holiday-fixed 3 8 "妇女节")
	   (holiday-fixed 5 4 "青年节")
	   (holiday-fixed 6 1 "儿童节")
	   (holiday-fixed 9 10 "教师节")
	   (holiday-lunar 7 7 "七夕" 0)
	   (holiday-lunar 9 9 "重阳节" 0))))
    (setq calendar-holidays (append cal-china-x-chinese-holidays
				    cal-china-x-general-holidays
				    western-general-holidays))))

(use-package hledger-mode
  :mode (("\\.journal\\'" . hledger-mode))
  :bind (:map hledger-mode-map
	      ("C-c h" . hledger-run-command))
  :config
  (add-to-list 'company-backends #'hledger-company)
  (setq hledger-jfile "~/org/finance/2020.journal")
  (setq hledger-currency-string "¥")
  (setq hledger-reporting-day 10)
  (setq hledger-year-of-birth 1991))

(use-package pdf-tools
  :commands (pdf-tools-enable-minor-modes)
  :mode (("\\.pdf\\'" . pdf-view-mode))
  :hook (pdf-view-mode . pdf-tools-enable-minor-modes)
  :bind (:map pdf-view-mode-map
	      ("C-s" . isearch-forward)))

(use-package elfeed
  :commands (elfeed elfeed-update)
  :bind (:map elfeed-search-mode-map
	      ("g" . elfeed-update)
	      :map elfeed-show-mode-map
	      ("h" . elfeed-show-render-html))

  :config
  ;; set face attribute
  ;; (zh-align-set-faces '(elfeed-search-title-face
  ;; 			elfeed-search-feed-face))

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

(use-package keyfreq
  :init (progn (keyfreq-mode 1) (keyfreq-autosave-mode)))

(provide 'init-utils)
