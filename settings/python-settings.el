(setq python-indent-offset 4)
;; python auto completion
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; python syntax check
(add-hook 'python-mode-hook 'flycheck-mode)

;; using anaconda mode
;; (add-hook 'python-mode-hook 'anaconda-mode)
;; (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
;; (add-hook 'python-mode-hook 'ac-anaconda-setup)

;; auto indent yanked/pasted text
(dolist (command '(yank yank-pop))
   (eval `(defadvice ,command (after indent-region activate)
            (and (not current-prefix-arg)
                 (member major-mode '(emacs-lisp-mode lisp-mode
                                                      clojure-mode    scheme-mode
                                                      haskell-mode    ruby-mode
                                                      rspec-mode      python-mode
                                                      c-mode          c++-mode
                                                      objc-mode       latex-mode
                                                      plain-tex-mode))
                 (let ((mark-even-if-inactive transient-mark-mode))
                   (indent-region (region-beginning) (region-end) nil))))))

;; auto pair
(electric-pair-mode 1)
(setq electric-pair-pairs '((?\" . ?\")
                            (?\{ . ?\}) ))

;; python interpreter
(when (executable-find "ipython")
   (setq python-shell-interpreter "ipython"))

;; markdown-mode
;; from https://github.com/purcell/emacs.d/blob/master/lisp/init-markdown.el
;(when (maybe-require-package 'markdown-mode)
;  (after-load 'whitespace-cleanup-mode
;              (push 'markdown-mode whitespace-cleanup-mode-ignore-modes)))

(provide 'python-settings)
