(use-package projectile
  ;; :demand t
  :delight '(:eval (concat " Proj[" (projectile-project-name) "]"))
  ;; :init
  ;; (projectile-mode 1)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  )

(provide 'init-projectile)
