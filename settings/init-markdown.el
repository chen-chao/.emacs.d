(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
	 )
  :config
  (when (executable-find "markdown")
    (setq markdown-command "markdown")
    )
  )

(provide 'markdown-settings)
