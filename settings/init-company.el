;; completion
(use-package company
  :diminish company-mode
  :init (global-company-mode)
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
    :init (setq company-lsp-cache-candidates 'auto)
    :config
    (add-to-list 'company-backends #'company-lsp)
    )

  ;; tabnine backend
  (use-package company-tabnine
    :config
    (add-to-list 'company-backends #'company-tabnine))

  ;; disable tabnine prompt to pay
  ;; @see https://emacs-china.org/t/tabnine/9988/51
  (defadvice company-echo-show (around disable-tabnine-upgrade-message activate)
  (let ((company-message-func (ad-get-arg 0)))
    (when (and company-message-func
               (stringp (funcall company-message-func)))
      (unless (string-match "The free version of TabNine only indexes up to" (funcall company-message-func))
        ad-do-it))))

  ;; @see https://emacs-china.org/t/tabnine/9988/40
  (defun company//sort-by-tabnine (candidates)
    (if (or (functionp company-backend)
	    (not (and (listp company-backend) (memq 'company-tabnine company-backend))))
	candidates
      (let ((candidates-table (make-hash-table :test #'equal))
	    candidates-1
	    candidates-2)
	(dolist (candidate candidates)
	  (if (eq (get-text-property 0 'company-backend candidate)
		  'company-tabnine)
	      (unless (gethash candidate candidates-table)
		(push candidate candidates-2))
	    (push candidate candidates-1)
	    (puthash candidate t candidates-table)))
	(setq candidates-1 (nreverse candidates-1))
	(setq candidates-2 (nreverse candidates-2))
	(nconc (seq-take candidates-1 2)
	       (seq-take candidates-2 2)
	       (seq-drop candidates-1 2)
	       (seq-drop candidates-2 2)))))

  (add-to-list 'company-transformers 'company//sort-by-tabnine t)
  ;; `:separate`  使得不同 backend 分开排序
  (add-to-list 'company-backends '(company-lsp :with company-tabnine :separate))
  )


(provide 'init-company)
