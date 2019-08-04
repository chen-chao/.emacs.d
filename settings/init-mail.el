(use-package wl
  :ensure wanderlust
  :config
  ;; simplify mail headers
  (setq wl-message-ignored-field-list
	'(".")
	wl-message-visible-field-list
	'("^\\(To\\|Cc\\):"
	  "^Subject:"
	  "^\\(From\\|Reply-To\\):"
	  "^\\(Posted\\|Date\\):"
	  "^Organization:"
	  "^X-\\(Face\\(-[0-9]+\\)?\\|Weather\\|Fortune\\|Now-Playing\\):")
	wl-message-sort-field-list
	(append wl-message-sort-field-list
		'("^Reply-To" "^Posted" "^Date" "^Organization")))
  ;; show mailboxes while reading
  (setq wl-stay-folder-window t)
  ;; show images using shr
  (setq mime-shr-blocked-images nil)
  ;; (setq elmo-passwd-storage-type 'auth-source)
  (setq mime-header-accept-quoted-encoded-words t)
  (zh-align-set-faces '(wl-highlight-summary-displaying-face
			wl-highlight-summary-new-face
			wl-highlight-summary-thread-top-face))
  )

(provide 'init-mail)
