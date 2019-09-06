;; Pre-install: pip install virtualenvwrapper
(use-package virtualenvwrapper
  :config
  (venv-initialize-interactive-shells)
  (venv-initialize-eshell)
  (setq venv-location (getenv "WORKON_HOME")))

;; Pre-install: ipython>=5.0, jupyter>=1.0, jupyter_console, jupyter_client
;; ipython support for org babel
(use-package ob-ipython)

;; jupyter notebook
(use-package ein)

(provide 'init-python)
