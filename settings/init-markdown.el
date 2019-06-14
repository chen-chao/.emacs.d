(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
	 )
  :hook ((markdown-mode . flyspell-mode)
	 (markdown-mode . auto-fill-mode))
  :config
  ;; Pre-install: markdown
  (when (executable-find "markdown")
    (setq markdown-command "markdown"))
  )

(provide 'init-markdown)
