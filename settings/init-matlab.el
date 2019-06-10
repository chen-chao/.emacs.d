;;; MATLAB and octave .m file settings

(use-package octave
  ;; :init (add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))
  :mode (("\\.m$" . octave-mode))
  :config
  (defun fix-octave-comments ()
    (make-local-variable 'comment-start)
    (setq comment-start "%")
    (setq comment-column 0))

  (add-hook 'octave-mode-hook 'fix-octave-comments)
  )

(provide 'init-matlab)

