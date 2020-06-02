;; -*- lexical-binding: t; -*-

;; weather web service wttr.in
(use-package xterm-color)

(use-package wttrin
  :load-path "site-lisp/emacs-wttrin/"
  :demand t
  :config
  (setq wttrin-default-cities '("Shanghai" "Sihong"))
  (setq wttrin-default-accept-language '("Accept-Language" . "en-US"))
  ;; (setq wttrin-mode-line-city "Shanghai")
  ;; (when (>= emacs-major-version 26)
  ;;   (wttrin-display-weather-in-mode-line)
  ;;   )
  )

;; reading epub
(use-package nov
  :mode (("\\.epub\\'" . nov-mode))
  :config
  (setq nov-text-width 80)
  (add-hook 'nov-mode-hook 'visual-line-mode)
  )

;; po files
(use-package po-mode
  :load-path "site-lisp/po-mode"
  :mode (("\\.po\\'" . po-mode))
  )

;; Pre-install: mpv
;; play music or audio
(use-package mpv
  :requires ffap
  :commands mpv-play-at-point
  :defer t
  :config
  ;; prevent mpv from showing art cover
  (add-to-list 'mpv-default-options "--no-audio-display")

  (defun mpv-guess-url-at-point ()
    (let (guess)
      (when (derived-mode-p 'dired-mode)
	(setq guess (dired-get-filename)))
      ;; TODO: org mode links
      (or guess (ffap-guess-file-name-at-point)))
    )

  (defun mpv-play-at-point ()
    (interactive)
    (let ((guess (mpv-guess-url-at-point)))
      (if (stringp guess)
	  (mpv-start guess)
	(message "invalid url")))
    )
  )

;; dict
(use-package youdao-dictionary
  :bind
  (("C-c y s" . youdao-dictionary-search-at-point-tooltip)
   ("C-c y i" . youdao-dictionary-search-from-input))
  :config
  (setq url-automatic-caching t)	;enable cache
  (setq youdao-dictionary-search-history-file "~/.emacs.d/.youdao_hist")
  )

(use-package leetcode
  :commands leetcode
  :defer t
  :config
  (let* ((secret (auth-source-user-and-password "leetcode.com"))
	 (username (car secret))
	 (password (cadr secret)))
    (setq leetcode-account username)
    (setq leetcode-password password))
  (setq leetcode-prefer-language "python3")
  )

;; open in other window/frame
(use-package other-frame-window
  :diminish
  :init (other-frame-window-mode)
  )

;; Diminished minor modes without modeline display
(use-package diminish
  :config
  ;; diminish built-in modes
  (diminish 'eldoc-mode)
  (diminish 'auto-revert-mode)
  )

;; same as diminish, but also works for major modes
(use-package delight)

(use-package time
  :config
  (setq display-time-default-load-average nil)
  )

;; transmission
(use-package transmission
  :defer t
  :if (executable-find "transmission-daemon"))

;; holidays and chinese holidays
(use-package cal-china-x
  :config
  (setq western-general-holidays
	'((holiday-fixed 2 14 "Valentine's Day")
	  (holiday-fixed 4 1 "April Fools' Day")
	  (holiday-float 5 0 2 "Mother's Day")
	  (holiday-float 6 0 3 "Father's Day")
	  (holiday-fixed 10 31 "Halloween")
	  (holiday-fixed 12 25 "Christmas")))

  (setq cal-china-x-general-holidays
	'((holiday-lunar 1 15 "元宵节" 0)
	  (holiday-fixed 3 8 "妇女节")
	  (holiday-fixed 5 4 "青年节")
	  (holiday-fixed 6 1 "儿童节")
	  (holiday-fixed 9 10 "教师节")
	  (holiday-lunar 7 7 "七夕" 0)
	  (holiday-lunar 9 9 "重阳节" 0)))

  (setq calendar-holidays (append cal-china-x-chinese-holidays
				  cal-china-x-general-holidays
				  western-general-holidays)))

(use-package hledger-mode
  :if (executable-find "hledger")
  :mode ("\\.journal\\'" . (lambda () (hledger-mode) (company-mode)))
  :bind (:map hledger-mode-map
	      ("C-c h" . hledger-run-command))
  :config
  (add-to-list 'company-backends #'hledger-company)
  (setq hledger-jfile (getenv "LEDGER_FILE"))
  (setq hledger-currency-string "¥"))


(use-package calibredb
  :quelpa
  (calibredb :repo "chenyanming/calibredb.el" :fetcher github)
  :config
  (setq sql-sqlite-program (executable-find "sqlite3"))
  (setq calibredb-root-dir (expand-file-name "~/Documents/calibre"))
  (setq calibredb-db-dir (concat calibredb-root-dir "/metadata.db"))
  (setq calibredb-program (executable-find "calibredb"))
  (setq calibredb-library-alist '(("~/Documents/calibre/")))
)

(provide 'init-utils)
