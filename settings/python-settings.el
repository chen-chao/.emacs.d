(setq python-indent-offset 4)

(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"
        python-shell-interpreter-args "--simple-prompt -i"))

(use-package jedi
  :ensure t
  :config
  (add-hook 'python-mode-hook 'jedi:setup)
  (setq jedi:complete-on-dot t)
  )

(use-package flycheck
  :ensure t
  :commands global-flycheck-mode
  :init (global-flycheck-mode)
  :config
  (progn
    (setq flycheck-check-syntax-automatically '(save mode-enabled))
    (setq flycheck-standard-error-navigation nil)
    ;; flycheck errors on a tooltip (doesn't work on console)
    ;; (when (display-graphic-p (selected-frame))
      ;; (eval-after-load 'flycheck '(custom-set-variables
                                   ;; '(flycheck-display-errors-function
                                     ;; #'flycheck-pos-tip-error-messages))))
    ;; (add-hook 'python-mode-hook 'flycheck-mode)
    )
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
