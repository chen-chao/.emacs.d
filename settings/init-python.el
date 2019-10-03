;; Pre-install: pip install virtualenvwrapper
(use-package virtualenvwrapper
  :config
  (venv-initialize-interactive-shells)
  (venv-initialize-eshell)
  (setq venv-location (getenv "WORKON_HOME")))

;; Pre-install: ipython>=5.0, jupyter>=1.0, jupyter_console, jupyter_client
;; ipython support for org babel
(use-package ob-ipython)

(use-package lispy
  ;; :hook ((elisp-mode python-mode closure-mode scheme-mode julia-mode) . lispy-mode)
  :config
  (defun conditionally-enable-lispy ()
    (when (eq this-command 'eval-expression)
      (lispy-mode 1)))
  ;; (add-hook 'minibuffer-setup-hook 'conditionally-enable-lispy)
  )

(use-package lpy
  :load-path "site-lisp/lpy/"
  :requires lispy
  )

;; jupyter notebook
(use-package ein
  :defer t)

(provide 'init-python)
