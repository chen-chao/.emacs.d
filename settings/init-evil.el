;; init evil

(use-package evil
  :ensure t
  :init (evil-mode 1)
  )

(use-package window-numbering
  :ensure t
  :init (window-numbering-mode)
  :config
  (setq window-numbering-auto-assign-0-to-minibuffer t))

(require 'org-evil)

(defun load-current-buffer ()
  (interactive)
    (load-file (buffer-file-name))
  )

(defun load-startup-file ()
  (interactive)
    (load-file (expand-file-name "~/.emacs.d/init.el")))

(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(defun kill-current-buffer-window ()
  (interactive)
  (kill-current-buffer)
  (delete-window))

(use-package general
  :ensure t
  :config
  (general-evil-setup t)
 
  (general-define-key :keymaps 'org-mode-map
                      :states '(normal motion insert emacs)
                      "TAB" 'org-cycle)

  (general-define-key :keymaps 'org-mode-map
                      :states '(normal motion emacs)
                      "<" 'outline-promote
                      ">" 'outline-demote)

  (general-define-key :keymaps 'org-mode-map
                      :states '(normal motion emacs)
                      :prefix ","
                      "a" 'org-achive-subtree-default
                      "d" 'org-deadline
                      "f" 'org-refile
                      "m" 'org-schedule-today
                      "n" 'org-add-note
                      "o" 'org-open-at-point
                      "p" 'org-time-stamp-inactive
                      "s" 'org-schedule
                      "t" 'org-todo
                      "y" 'org-todo-yesterday
                      )

  (general-define-key :keymaps 'apropos-mode-map
                      "f" 'apropos-follow)

  (general-define-key
   :states '(normal motion emacs)
   ;; :keymaps 'normal
   :prefix "SPC"
   ;; :non-normal-prefix "M-SPC"
   ;; "SPC" '(counsel-M-x :which-key "M-x")
   ;; "ar" '(ranger :which-key "call ranger")
   "0" 'select-window-0
   "1" 'select-window-1
   "2" 'select-window-2
   "3" 'select-window-3
   ;; "4" 'select-window-4
   ;; "5" 'select-window-5
   ;; "6" 'select-window-6
   ;; "7" 'select-window-7
   ;; "8" 'select-window-8
   ;; "9" 'select-window-9
   "b" '(:ignore t :which-key "Buffer")
   "bb" 'ivy-switch-buffer
   "bs" 'save-buffer
   "f" '(:ignore t :which-key "Files")
   "d" 'dired
   "ff" 'counsel-find-file
   "g"  '(:ignore t :which-key "Git")
   "gs" 'magit-status
   "h" '(:ignore t :which-key "Help")
   "ha" 'apropos-command
   "hk" 'describe-key
   "hf" 'describe-function
   "hv" 'describe-variable
   "hm" 'describe-mode
   "hp" 'describe-package
   "hc" 'describe-coding-system
   "k" '(:ignore t :which-key "Kill")
   "kb" 'kill-buffer
   "kc" 'kill-current-buffer
   "kd" 'delete-window
   "kw" 'kill-current-buffer-window
   "l" '(:ignore t :which-key "Load")
   "lc" 'load-current-buffer
   "ls" 'load-startup-file
   "o" '(:ignore t :which-key "Org")
   "oc" 'org-capture
   "oa" 'org-agenda
   "p" '(:ignore t :which-key "Package")
   "pi" 'package-install
   "pr" 'package-refreshc-contents
   "pl" 'package-list-packages
   "s" 'shell
   "w" '(:ignore t :which-key "Windows")
   "wb" 'split-window-below
   "wr" 'split-window-right
   "ww" 'delete-other-windows
   "we" 'balance-windows
   "y" '(:ignore t :which-key "Yasnippet")
   "yn" 'yas-new-snippet
   "yl" 'my-yas-reload-all
   )
  )

(provide 'init-evil)
