(use-package magit
  :bind (("C-c v" . magit-status)
	 ("C-c m" . magit-dispatch))
  :config
  (unbind-key "M-1" magit-mode-map)
  (unbind-key "M-2" magit-mode-map)
  (unbind-key "M-3" magit-mode-map)
  (unbind-key "M-4" magit-mode-map)
  (unbind-key "M-1" diff-mode-map)
  (unbind-key "M-2" diff-mode-map)
  (unbind-key "M-3" diff-mode-map)
  (unbind-key "M-4" diff-mode-map)
  ;; (setq magit-diff-refine-hunk t)

  ;; @see https://emacs-china.org/t/magit-log/10432
  (defun my-magit-log-line ()
    (interactive)
    (let* ((file (buffer-file-name (current-buffer)))
	   (trace (magit-read-string "Trace" (concat (number-to-string (line-number-at-pos)) ",")))
	   (optstr (concat "-L " trace ":" file)))
      (message optstr)
      (magit-log-current nil `(,optstr))))
    )

(use-package git-timemachine)

(use-package forge
  :after magit)

(provide 'init-magit)
