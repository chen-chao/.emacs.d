(use-package go-mode
  :ensure t
  :mode (("\\.go\\'" . go-mode))
  :bind (:map go-mode-map
	      ([remap xref-find-definitions] . godef-jump)
	      ("C-c g r" . go-remove-unused-imports)
	      ("<f1>" . godoc-at-point))
  :config
  (when (setq gopath (or (getenv "GOPATH")
			 (if (file-directory-p "~/go") "~/go"
			   nil)))
    (add-to-list 'exec-path (concat (file-name-as-directory gopath) "bin"))
    )
    
  (add-hook 'before-save-hook 'gofmt-before-save)
  (setq gofmt-command "goimports")

  (use-package go-dlv :ensure t)
  (use-package go-guru :ensure t)
  (use-package go-fill-struct :ensure t)
  (use-package go-impl :ensure t)
  (use-package go-rename :ensure t)
  (use-package golint :ensure t)
  (use-package govet :ensure t)

  (use-package go-tag
    :ensure t
    :bind (:map go-mode-map
		("C-c g t" . go-tag-add)
		("C-c g T" . go-tag-remove))
    :config
    (setq go-tag-args (list "-transform" "camelcase")))

  (use-package gotest
    :ensure t
    :bind (:map go-mode-map
		("C-c g a" . go-test-current-project)
		("C-c g m" . go-test-current-file)
		("C-c g ." . go-test-current-test)
		("C-c g x" . go-run)))

  (use-package go-gen-test
    :ensure t
    :bind (:map go-mode-map
		("C-c C-t" . go-gen-test-dwim)))

  )

  
;; Local Golang playground for short snippes
(use-package go-playground
  :ensure t
  :diminish go-playground-mode
  :commands go-playground-mode)


(provide 'init-golang)

