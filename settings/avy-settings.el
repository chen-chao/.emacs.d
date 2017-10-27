;;; Settings for avy

(use-package avy
  :ensure t
  ;; :bind (("C-:" . avy-goto-char)
  ;;        ("C-'" . avy-goto-char-2)
  ;;        ("M-g g" . avy-goto-line)
  ;;        ("M-g w" . avy-goto-word-1)
  ;;        ("M-g e" . avy-goto-word-0)
  ;;        )
  :config (avy-setup-default)
  )

(use-package ace-window
  :ensure t
  :bind (("M-p" . ace-window))
  :config
  (setq aw-dispatch-always t)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (defvar aw-dispatch-alist
  '((?x aw-delete-window " Ace - Delete Window")
    (?m aw-swap-window " Ace - Swap Window")
    (?n aw-flip-window)
    (?c aw-split-window-fair " Ace - Split Fair Window")
    (?v aw-split-window-vert " Ace - Split Vert Window")
    (?b aw-split-window-horz " Ace - Split Horz Window")
    (?i delete-other-windows " Ace - Maximize Window")
    (?o delete-other-windows))
  "List of actions for `aw-dispatch-default'."))


(provide 'avy-settings)
;;; avy-settings ends here


