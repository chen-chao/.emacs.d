;; init ivy mode

(use-package which-key
  :config
  (setq which-key-idle-delay 0.5))

(use-package ivy
  :init (ivy-mode)
  :bind (:map ivy-mode-map
	("C-c C-r" . ivy-resume))
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-wrap t))

(use-package ivy-yasnippet
  :after yasnippet
  :bind ("C-c C-y" . ivy-yasnippet))

(use-package counsel
  :bind (("M-x"     . counsel-M-x)
	 ("M-y"     . counsel-yank-pop)
	 ("C-x C-f" . counsel-find-file)
	 ("C-x C-r" . counsel-recentf)
	 ("C-c g"   . counsel-git)
	 ("C-c j"   . counsel-file-jump)
	 ("C-c r"   . counsel-rg)
	 ("C-c z"   . counsel-fzf)))

(use-package counsel-fd
  :bind (("C-c f" . counsel-fd-file-jump)))

(use-package swiper :bind (("C-s" . swiper)))

(use-package avy
  :init (avy-setup-default)
  :bind (("C-;" . avy-goto-char-timer)
	 ("C-'" . avy-goto-line)))

(use-package ace-window
  :bind (("C-x o" . ace-window))
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (setq aw-ignore-on nil))

(use-package ace-link :config (ace-link-setup-default))


(provide 'init-ivy)
