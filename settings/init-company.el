;; completion
(use-package company
  :diminish company-mode
  ;; :init (global-company-mode)
  :hook (prog-mode . company-mode)
  :bind (:map company-active-map
	      (("C-n" . company-select-next)
	       ("C-p" . company-select-previous)
	       ("C-d" . company-show-doc-buffer)
	       ))
  :config
  (setq company-idle-delay 0)
  (setq company-show-numbers t)

  ;; Allows TAB to select and complete at the same time.
  ;; (company-tng-configure-default)

  ;; lsp backend
  (use-package company-lsp
    :config
    (setq company-lsp-cache-candidates 'auto)
    (add-to-list 'company-backends #'company-lsp))
  )


(provide 'init-company)
