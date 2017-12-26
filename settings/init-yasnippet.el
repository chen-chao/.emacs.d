;;; init yasnippet

(require 'yasnippet)

(yas-reload-all)

(add-hook 'prog-mode-hook #'yas-minor-mode)
(add-hook 'latex-mode-hook #'yas-minor-mode)

;; (define-key yas-minor-mode-map (kbd "<tab>") nil)
;; (define-key yas-minor-mode-map (kbd "TAB") nil)
;; (define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand)

(defun my-yas-reload-all ()
  "Compile and reload yasnippets.  Run the command after adding new snippets."
  (interactive)
  (yas-compile-directory (file-truename "~/.emacs.d/snippets"))
  (yas-reload-all)
  (yas-minor-mode 1))

(provide 'init-yasnippet)
;;; init-yasnippet.el ends here
