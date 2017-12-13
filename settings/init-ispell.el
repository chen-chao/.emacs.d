;; This is from https://joelkuiper.eu/spellcheck_emacs

(dolist (hook '(text-mode-hook)) (add-hook hook (lambda (): (flyspell-mode t))))

(dolist (mode '(emacs-lisp-mode-hook
                inferior-lisp-mode-hook
                python-mode-hook
                c-mode-hook
                c++-mode-hook))
  (add-hook mode '(lambda() (flyspell-prog-mode))))

(global-set-key (kbd "C-c i") 'ispell-word)
(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word))
(global-set-key (kbd "C-c f") 'flyspell-check-next-highlighted-word)

(when (executable-find "hunspell")
  (setq-default ispell-program-name "hunspell")
  (setq ispell-really-hunspell t))

(provide 'init-ispell)
