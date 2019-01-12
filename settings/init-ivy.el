;; init ivy mode

(use-package ivy
  :ensure t
  :diminish (ivy-mode . "") ; does not display ivy in the modeline
  :init (ivy-mode 1)        ; enable ivy globally at startup
  :bind
  (:map ivy-mode-map			; bind in the ivy buffer
        ("C-'"     . ivy-avy)		; C-' to ivy-avy
	("C-c C-r" . ivy-resume)	; recalls completion session
	)
  :config
  (setq ivy-use-virtual-buffers t)   ; extend searching to bookmarks and …
  (setq ivy-height 20)               ; set height of the ivy window
  (setq ivy-count-format "(%d/%d) ") ; count format, from the ivy help page
  (setq ivy-wrap t)		     ; enable "C-n" "C-p" to cycle past the first and last candidates
  )

(use-package counsel
  :ensure t
  :bind*                           ; load counsel when pressed
  (("M-x"     . counsel-M-x)       ; M-x use counsel
   ("C-x C-f" . counsel-find-file) ; C-x C-f use counsel-find-file
   ("C-x C-r" . counsel-recentf)   ; search recently edited files
   ("C-c g"   . counsel-git)       ; search for files in git repo
   ("C-c s"   . counsel-git-grep)  ; search for regexp in git repo
   ("C-c k"   . counsel-ag)        ; search for regexp in git repo using ag
   ("C-c l"   . counsel-locate)    ; search for files or else using locate
   ("C-h f"   . counsel-describe-function)
   ("C-h v"   . counsel-describe-variable)
   ("C-h i"   . counsel-info-lookup-symbol)
   ("C-h l"   . counsel-find-library)
   ("C-h u"   . counsel-unicode-char)
   )
  )

(use-package swiper
  :ensure t
  :bind
  (("C-s" . swiper))
  )

(provide 'init-ivy)
