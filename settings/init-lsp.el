;; lsp mode

(use-package lsp-mode
  :diminish lsp-mode
  :hook (prog-mode . lsp-deferred)
  :bind (:map lsp-mode-map
	      ("C-c C-d" . lsp-describe-thing-at-point))
  :config
  (setq lsp-auto-guess-root t)
  (setq lsp-prefer-flymake nil)

  (use-package lsp-clients
    :ensure nil
    :init (setq lsp-clients-python-library-directories '("/usr/local/" "/usr/")))

  (defun lsp-select-root()
    (interactive)
    (setq-local lsp-auto-guess-root nil)
    (lsp))
  )

(use-package lsp-ui
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

(use-package lsp-java
  :hook (java-mode . (lambda () (require 'lsp-java) (lsp))))

;; Debug
;; @see https://github.com/seagle0128/.emacs.d/blob/3245953ac5d3e69cdb8a8c2fbfb861e7addb48b6/lisp/init-lsp.el#L99
(use-package dap-mode
  :diminish
  :functions dap-hydra/nil
  :bind (:map lsp-mode-map
	      ("C-c d" . dap-debug)
	      ("C-c h" . dap-hydra))
  :hook ((after-init . dap-mode)
	 (dap-mode . dap-ui-mode)
	 (dap-session-created . (lambda (&_rest) (dap-hydra)))
	 (dap-terminated . (lambda (&_rest) (dap-hydra/nil)))

	 ;; Pre-install:
	 ;; pip install "ptvsd>=4.2"
	 (python-mode . (lambda () (require 'dap-python)))

	 (ruby-mode . (lambda () (require 'dap-ruby)))

	 ;; Pre-install:
	 ;; go get -u github.com/go-delve/delve/cmd/dlv
	 (go-mode . (lambda () (require 'dap-go)))

	 (java-mode . (lambda () (require 'dap-java)))
	 ((c-mode c++-mode objc-mode swift) . (lambda () (require 'dap-lldb)))
	 (php-mode . (lambda () (require 'dap-php)))
	 (elixir-mode . (lambda () (require 'dap-elixir)))
	 ((js-mode js2-mode) . (lambda () (require 'dap-chrome)))))

(provide 'init-lsp)
