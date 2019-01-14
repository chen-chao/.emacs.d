;; initialize emacs application framework, eaf mode

(use-package eaf
  :load-path "site-lisp/emacs-application-framework/"
  :defer t
  :bind
  (("C-c e" . eaf-open))
  )

(provide 'init-eaf)
