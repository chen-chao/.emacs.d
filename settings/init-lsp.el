;; lsp mode

(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  )

(use-package lsp-mode
  :ensure t
  :commands lsp
  :config
  (require 'lsp-clients)
  (add-hook 'python-mode-hook #'lsp)
  (add-hook 'c++-mode-hook #'lsp)
  )

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :bind
  (:map lsp-ui-mode-map
	([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
	([remap xref-find-references] . lsp-ui-peek-find-references)
	)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (setq lsp-ui-doc-use-childframe t)
  (set-face-foreground 'lsp-ui-sideline-code-action "purple")
  )

(use-package company-lsp
  :ensure t
  :requires company
  :commands company-lsp
  :config
  (push 'company-lsp company-backends)
  )

(use-package lsp-java
  :ensure t
  :after lsp
  :config
  (add-hook 'java-mode-hook #'lsp)
  ;; (setq lsp-java-server-install-dir "~/.emacs.d/site-lisp/eclipse.jdt.ls/server/")
  )

(provide 'init-lsp)