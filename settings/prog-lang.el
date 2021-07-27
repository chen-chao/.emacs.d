;;; prog-lang.el --- major modes for programming languages

;; Pre-install: pip install virtualenvwrapper
(use-package virtualenvwrapper
  :defer t
  :config
  (venv-initialize-interactive-shells)
  (venv-initialize-eshell)
  (setq venv-location (getenv "WORKON_HOME")))

(use-package csharp-mode
  :mode (("\\.csproj\\'" . nxml-mode))
  :hook (csharp-mode . (lambda () (setq indent-tabs-mode nil))))

(use-package lsp-java
  :hook (java-mode . #'lsp))

(use-package powershell
  :if (eq system-type 'windows-nt))

(use-package protobuf-mode
  :mode (("\\.proto\\'" . protobuf-mode)))

(use-package octave
  :mode (("\\.m$" . octave-mode))
  :config
  (setq octave-comment-start "%"))

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :config
  ;; Pre-install: markdown
  (setq markdown-command "markdown")
  ;; set faces
  ;; (zh-align-set-faces '(markdown-table-face))
  )

(use-package yaml-mode
  :mode (("\\.yaml\\'" . yaml-mode)
	 ("\\.yml\\'" . yaml-mode)))

(use-package asy-mode
  :load-path "site-lisp/asy"
  :commands (asy-mode lasy-mode asy-insinuate-latex)
  :mode (("\\.asy\\'" . asy-mode)))

;; @see https://github.com/jwiegley/use-package/issues/379#issuecomment-258217014
;; (use-package tex
;;   :ensure auctex
;;   :config
;;   (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex --synctex=1%(mode)%' %t" TeX-run-TeX nil t))
;;   (setq TeX-command-default "XeLaTeX")
;;   (setq TeX-auto-save t)
;;   (setq TeX-parse-self t)
;;   ;; (setq TeX-save-query nil)
;;   ;; (setq TeX-show-compilation t)
;;   (use-package company-auctex :config (company-auctex-init))
;;   )

(use-package json-mode :defer t)

(use-package cmake-mode :defer t)

(use-package typescript-mode :defer t)

(use-package racket-mode :defer t)

(use-package sml-mode :defer t)

(use-package docker :defer t)

(use-package dockerfile-mode
  :mode ("Dockerfile\\'" . dockerfile-mode))

(use-package crontab-mode :if (eq system-type 'windows-nt) :defer t)

(use-package kotlin-mode :defer t)

(use-package lua-mode :defer t)

(use-package go-mode
  :mode (("\\.go\\'" . go-mode))
  :bind (:map go-mode-map
	      ([remap xref-find-definitions] . godef-jump)
	      ("C-c g r" . go-remove-unused-imports)
	      ("<f1>" . godoc-at-point))
  :config

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
    (add-hook 'lsp-after-open-hook
	      (lambda () (when (derived-mode-p 'go-mode) (go-imenu-setup)))))

  ;; Pre-install:
  ;; go get -u github.com/fatih/gomodifytags
  (use-package go-tag
    :bind (:map go-mode-map
		("C-c g t" . go-tag-add)
		("C-c g T" . go-tag-remove))
    :config
    (setq go-tag-args (list "-transform" "snakecase")))

  (use-package gotest
    :bind (:map go-mode-map
		("C-c g a" . go-test-current-project)
		("C-c g m" . go-test-current-file)
		("C-c g ." . go-test-current-test)
		("C-c g x" . go-run))
    :config
    (setq go-test-verbose t))

  (use-package go-gen-test
    :bind (:map go-mode-map
		("C-c C-t" . go-gen-test-dwim)))

  (use-package go-playground))

(provide 'prog-lang)
