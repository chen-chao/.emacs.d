;; lsp mode

(use-package lsp-mode
  :commands lsp
  :config
  (require 'lsp-clients)
  (setq lsp-auto-guess-root t)
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

;; C/C++/Objective-C support
;; Pre-install: ccls in path
(use-package ccls
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
  :hook (java-mode . (lambda () (require 'lsp-java) (lsp))))


(provide 'init-lsp)
