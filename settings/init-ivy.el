;; init ivy mode

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :init
  (which-key-mode)
  :config
  (setq which-key-idle-delay 0.5)
  )

(use-package ivy
  :ensure t
  :diminish ivy-mode        ; not display ivy in the modeline
  :init (ivy-mode 1)        ; enable ivy globally at startup
  :bind
  (:map ivy-mode-map			; bind in the ivy buffer
	;; ("C-'" . ivy-avy)
	("C-c C-r" . ivy-resume)	; recalls completion session
	)
  :config
  (setq ivy-use-virtual-buffers t)   ; extend searching to bookmarks and …
  (setq ivy-height 20)               ; set height of the ivy window
  (setq ivy-count-format "(%d/%d) ") ; count format, from the ivy help page
  (setq ivy-wrap t)		     ; enable "C-n" "C-p" to cycle past the first and last candidates
  )

;; Correcting words with flyspell via Ivy
(use-package flyspell-correct-ivy
  :after flyspell
  :init (setq flyspell-correct-interface #'flyspell-correct-ivy)
  :bind (:map flyspell-mode-map
	      ([remap flyspell-correct-word-before-point] . flyspell-correct-previous-word-generic)
	      ("C-M-i" . flyspell-correct-wrapper)
	      ))

(use-package counsel
  :ensure t
  :bind                            ; load counsel when pressed
  (("M-x"     . counsel-M-x)       ; M-x use counsel
   ("C-x C-f" . counsel-find-file) ; C-x C-f use counsel-find-file
   ("C-x C-r" . counsel-recentf)   ; search recently edited files
   ("C-c f"   . counsel-git)       ; search for files in git repo
   ("C-c r"   . counsel-rg)        ; search for regexp in current folder using rg(ripgrep)
   ("C-c s"   . counsel-git-grep)  ; search for regexp in git repo
   ("C-c l"   . counsel-locate)    ; search for files or else using locate
   ("C-h f"   . counsel-describe-function)
   ("C-h v"   . counsel-describe-variable)
   ("C-h s"   . counsel-info-lookup-symbol)
   ("C-h l"   . counsel-find-library)
   ("C-h u"   . counsel-unicode-char)
   )
  )

(use-package swiper
  :ensure t
  :bind
  (("C-s" . swiper))
  )

(use-package avy
  :ensure t
  :bind
  (("C-;" . avy-goto-char-timer)
   ("C-:" . avy-goto-char-2)
   ;; ("C-'" . avy-goto-char-2)
   ("C-'" . avy-goto-line)
   ("M-g w" . avy-goto-word-1)
   ("M-g e" . avy-goto-word-0)
   )
  :config
  (avy-setup-default)
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

(use-package window-numbering
  :ensure t
  :init (window-numbering-mode)
  :config
  (setq window-numbering-auto-assign-0-to-minibuffer t))

(provide 'init-ivy)
