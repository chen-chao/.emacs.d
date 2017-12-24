(setq python-indent-offset 4)

(defun ipython ()
  (interactive)
  (when (executable-find "ipython")
    (term "ipython")))

(use-package jedi
  :ensure t
  :config
  (add-hook 'python-mode-hook 'jedi:setup)
  (setq jedi:complete-on-dot t)
  )

(use-package pydoc)

(use-package pydoc-info)

(use-package auto-complete
  :ensure jedi

  :config
  (require 'auto-complete-config) 
  (ac-config-default)
  (global-auto-complete-mode 1)
  (ac-set-trigger-key "TAB")
  (ac-set-trigger-key "<tab>")
  ;; Start auto-completion after 2 characters of a word
  (setq ac-auto-start 2)
  ;; case sensitivity is important when finding matches
  (setq ac-ignore-case nil)
  )

(use-package neotree
  :bind (([f8] . neotree-toggle))

  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))             
  )

(provide 'python-settings)
