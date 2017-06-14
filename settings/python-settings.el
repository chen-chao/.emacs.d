;; auto pair
(electric-pair-mode 1)
(setq electric-pair-pairs '((?\" . ?\")
                            (?\{ . ?\}) ))

(setq python-indent-offset 4)
;; python auto completion
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; python syntax check
(add-hook 'python-mode-hook 'flycheck-mode)

;; auto pep8 format
;; need `pip install autopep8`
(require 'py-autopep8)
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
(setq py-autopep8-options '("--max-line-length=100"))

;; python interpreter
(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"
        python-shell-interpreter-args "--simple-prompt -i"))

;; markdown-mode
;; from https://github.com/purcell/emacs.d/blob/master/lisp/init-markdown.el
;(when (maybe-require-package 'markdown-mode)
;  (after-load 'whitespace-cleanup-mode
;              (push 'markdown-mode whitespace-cleanup-mode-ignore-modes)))

(provide 'python-settings)
