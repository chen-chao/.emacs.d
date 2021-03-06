(use-package go-mode
  :after init-lsp
  :mode (("\\.go\\'" . go-mode))
  :bind (:map go-mode-map
	      ([remap xref-find-definitions] . godef-jump)
	      ("C-c g r" . go-remove-unused-imports)
	      ("<f1>" . godoc-at-point))
  :config
  ;; require $GOPATH

  (add-hook 'before-save-hook 'gofmt-before-save)
  (setq gofmt-command "goimports")

  (use-package go-dlv)
  (use-package go-guru)
  (use-package go-fill-struct)
  (use-package go-impl)
  (use-package go-rename)
  (use-package golint)
  (use-package govet)

    ;; Pre-install: golangci-lint
  (use-package flycheck-golangci-lint
    :if (executable-find "golangci-lint")
    :config
    (setq flycheck-golangci-lint-enable-all t)
    (add-hook 'lsp-after-open-hook
	      (lambda () (when (derived-mode-p 'go-mode)
			   (flycheck-golangci-lint-setup))))
    )

  ;; Pre-install:
  ;; go get -u github.com/lukehoban/go-outline
  ;; CAVEAT: lsp-mode also set up `imenu-create-index-function'
  (use-package go-imenu
    :config
    (add-hook 'lsp-after-open-hook (lambda () (when (derived-mode-p 'go-mode) (go-imenu-setup)))))

  ;; Pre-install:
  ;; go get -u github.com/fatih/gomodifytags
  (use-package go-tag
    :bind (:map go-mode-map
		("C-c g t" . go-tag-add)
		("C-c g T" . go-tag-remove))
    :config
    (setq go-tag-args (list "-transform" "snakecase"))
    )

  (use-package gotest
    :bind (:map go-mode-map
		("C-c g a" . go-test-current-project)
		("C-c g m" . go-test-current-file)
		("C-c g ." . go-test-current-test)
		("C-c g x" . go-run))
    :config
    (setq go-test-verbose t)
    )

  (use-package go-gen-test
    :bind (:map go-mode-map
		("C-c C-t" . go-gen-test-dwim)))

  (use-package go-playground))

(provide 'init-golang)
