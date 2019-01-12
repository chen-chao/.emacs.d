;; lsp mode

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  )

(use-package lsp-mode
  :ensure t
  :defer t
  :commands lsp
  :config
  (require 'lsp-clients)
  :init
  (add-hook 'python-mode-hook #'lsp)
  (add-hook 'c++-mode-hook #'lsp)
  )

(use-package lsp-ui
  :ensure t
  :defer t
  :commands lsp-ui-mode
  :bind
  (:map lsp-ui-mode-map
	([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
	([remap xref-find-references] . lsp-ui-peek-find-references)
	)
  :init
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  )

(use-package company-lsp
  :ensure t
  :defer t
  :requires company
  :commands company-lsp
  :init
  (push 'company-lsp company-backends)
  )

(provide 'init-lsp)
