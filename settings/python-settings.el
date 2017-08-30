(setq python-indent-offset 4)
;; python auto completion
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; python syntax check
(require 'flycheck)
(add-hook 'python-mode-hook 'flycheck-mode)

;; python doc
(require 'pydoc)
(require 'pydoc-info)

;; python interpreter
(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"
        python-shell-interpreter-args "--simple-prompt -i"))

(provide 'python-settings)
