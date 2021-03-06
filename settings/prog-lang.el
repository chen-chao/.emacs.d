;;; prog-lang.el --- major modes for programming languages

(require 'init-golang)

(use-package lpy)

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
  (setq markdown-command (whicher "markdown"))
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
(use-package tex
  :ensure auctex
  :config
  (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex --synctex=1%(mode)%' %t" TeX-run-TeX nil t))
  (setq TeX-command-default "XeLaTeX")
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  ;; (setq TeX-save-query nil)
  ;; (setq TeX-show-compilation t)
  (use-package company-auctex :config (company-auctex-init))
  )

(use-package json-mode)

(use-package cmake-mode)

(use-package typescript-mode)

(use-package racket-mode)

(use-package sml-mode)

(use-package docker :defer t)

(use-package dockerfile-mode
  :mode ("Dockerfile\\'" . dockerfile-mode))

(use-package crontab-mode :if (eq system-type 'windows-nt))

(use-package kotlin-mode)

(use-package lua-mode)

(provide 'prog-lang)
