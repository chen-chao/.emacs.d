;; init ivy mode

(use-package which-key
  :diminish which-key-mode
  :init
  (which-key-mode)
  :config
  (setq which-key-idle-delay 0.5)
  )

(use-package ivy
  :diminish ivy-mode        ; not display ivy in the modeline
  :init (ivy-mode 1)        ; enable ivy globally at startup
  :bind
  (:map ivy-mode-map			; bind in the ivy buffer
	("C-c C-r" . ivy-resume)	; recalls completion session
	)
  :config
  (setq ivy-use-virtual-buffers t)   ; extend searching to bookmarks and …
  (setq ivy-height 20)               ; set height of the ivy window
  (setq ivy-count-format "(%d/%d) ") ; count format, from the ivy help page
  (setq ivy-wrap t)		     ; enable "C-n" "C-p" to cycle past the first and last candidates
  )

(use-package ivy-yasnippet
  :after yasnippet
  :bind ("C-c C-y" . ivy-yasnippet))

;; Correcting words with flyspell via Ivy
(use-package flyspell-correct-ivy
  :after flyspell
  :init (setq flyspell-correct-interface #'flyspell-correct-ivy)
  :bind (:map flyspell-mode-map
	      ([remap flyspell-correct-word-before-point] . flyspell-correct-previous-word-generic)
	      ("C-M-i" . flyspell-correct-wrapper)
	      ))

(use-package counsel
  :bind
  (("M-x"     . counsel-M-x)
   ("M-y"     . counsel-yank-pop)
   ("C-x C-f" . counsel-find-file)
   ("C-x C-r" . counsel-recentf)
   ("C-c f"   . counsel-git)
   ("C-c j"   . counsel-file-jump)
   ("C-c r"   . counsel-rg)
   ("C-c s"   . counsel-git-grep)
   ("C-c l"   . counsel-locate)
   ("C-h f"   . counsel-describe-function)
   ("C-h v"   . counsel-describe-variable)
   ("C-h s"   . counsel-info-lookup-symbol)
   ("C-h l"   . counsel-find-library)
   ("C-h u"   . counsel-unicode-char))
  )

(use-package swiper
  :bind
  (("C-s" . swiper))
  )

(use-package avy
  :bind
  (("C-;" . avy-goto-char-timer)
   ("C-:" . avy-goto-char-2)
   ("C-'" . avy-goto-line)
   ("M-g w" . avy-goto-word-1)
   ("M-g e" . avy-goto-word-0)
   )
  :init
  (avy-setup-default)
  )

(use-package ace-window
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

(use-package ace-link
  :config
  (ace-link-setup-default))


(provide 'init-ivy)
