;; lsp mode

(use-package company
  :ensure t
  :demand t
  :diminish company-mode
  :bind
  (:map company-active-map
	(("C-n" . company-select-next)
	 ("C-p" . company-select-previous)
	 ("C-d" . company-show-doc-buffer)
	 ))
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay 0.1)
  )

(use-package lsp-mode
  :ensure t
  :commands lsp
  :init (setq lsp-auto-guess-root nil)
  :hook ((python-mode c++-mode go-mode) . (lambda () (lsp)))
  :config
  (require 'lsp-clients)
  (setq lsp-clients-python-library-directories '("/usr/local/" "/usr/"))

  ;; (add-hook 'python-mode-hook #'lsp)
  ;; (add-hook 'c++-mode-hook #'lsp)

  ;; Pre-install:
  ;; go get -u golang.org/x/tools/cmd/gopls
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection "gopls")
		    :major-modes '(go-mode)
		    :priority 0
		    :initialization-options 'lsp-clients-go--make-init-options
		    :server-id 'gopls
		    :library-folders-fn (lambda (_workspace)
					  lsp-clients-go-library-directories)))
  )

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :bind
  (:map lsp-ui-mode-map
	([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
	([remap xref-find-references] . lsp-ui-peek-find-references)
	("C-c u" . lsp-ui-imenu))
  :init
  (setq lsp-ui-doc-enable t
	lsp-ui-doc-header t
	lsp-ui-doc-include-signature t
	lsp-ui-doc-position 'top
	lsp-ui-doc-use-webkit t
	lsp-ui-doc-border (face-foreground 'default)

	lsp-ui-sideline-enable nil
	lsp-ui-sideline-ignore-duplicate t)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (setq lsp-ui-doc-use-childframe t)
  (set-face-foreground 'lsp-ui-sideline-code-action "purple")
  )

(use-package company-lsp
  :ensure t
  :init (setq company-lsp-cache-candidates 'auto)
  :config
  (push 'company-lsp company-backends)
  )

;; C/C++/Objective-C support
(use-package ccls
  :ensure t
  :defines projectile-project-root-files-top-down-recurring
  :hook ((c-mode c++-mode objc-mode cuda-mode) . (lambda ()
						   (require 'ccls)
						   (lsp)))
  :config
  (with-eval-after-load 'projectile
    (setq projectile-project-root-files-top-down-recurring
	  (append '("compile_commands.json"
		    ".ccls")
		  projectile-project-root-files-top-down-recurring))))

(use-package lsp-java
  :ensure t
  :hook (java-mode . (lambda () (require 'lsp-java) (lsp))))

(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :init (yas-global-mode 1)
  :config
  ;; (yas-reload-all)
  ;; (add-hook 'prog-mode-hook #'yas-minor-mode)
  ;; (add-hook 'latex-mode-hook #'yas-minor-mode)
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  )

(use-package ivy-yasnippet
  :ensure t
  :after yasnippet
  )


(provide 'completion-settings)
