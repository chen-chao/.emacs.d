(use-package magit
  :ensure t
  :bind
  (("C-c g" . magit-status)
   ("C-c m" . magit-dispatch-popup)
   )
  )

(provide 'init-magit)
