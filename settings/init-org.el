;; org-mode settings

(use-package org
  :bind (("C-c a" . org-agenda)
	 ("C-c c" . org-capture)
	 :map org-mode-map
	 ("C-c z" . org-add-note)
	 ("C-c <" . outline-promote)
	 ("C-c >" . outline-demote))

  :config
  (unbind-key "C-'" org-mode-map)

  (setq org-modules nil)
  (setq org-capture-templates
	'(("j" "Journal" entry
    	   (file+olp+datetree "~/org/journal.org")
    	   "* %?\nEntered on %U\n %i\n")))
  (setq org-todo-keywords
	'((sequence "TODO(t@/!)" "PENDING(p@/!)" "STAGING(s@/!)" "|" "DONE(d@/!)" "CANCELED(c@/!)")))
  (setq org-agenda-files "~/Sync/emacs/agendas.org")
  (setq org-agenda-start-on-weekday nil)
  (setq org-log-into-drawer "LOGBOOK")
  (setq org-agenda-clockreport-parameter-plist '(:link t :level 4 :fileskip0 t :stepskip0 t))

  ;; @see https://emacs-china.org/t/topic/2119/13
  (defun org-chinese-anniversary (lunar-month lunar-day &optional year mark)
    (if year
	(let* ((d-date (diary-make-date lunar-month lunar-day year))
	       (a-date (calendar-absolute-from-gregorian d-date))
	       (c-date (calendar-chinese-from-absolute a-date))
	       (cycle (car c-date))
	       (yy (cadr c-date))
	       (y (+ (* 100 cycle) yy)))
	  (diary-chinese-anniversary lunar-month lunar-day y mark))
      (diary-chinese-anniversary lunar-month lunar-day year mark)))

  ;; org babel
  (org-babel-do-load-languages 'org-babel-load-languages
			       '((emacs-lisp . t)
				 (python . t)
				 (shell . t)
				 (C . t)
				 (asymptote . t)
				 (octave . t)
				 (latex . t)
				 (ruby . t)
				 (org . t)))
  )

(use-package valign)

(use-package org-roam
  :ensure t
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture))
  :config
  (setq org-roam-directory "~/Sync/emacs/org-roam/")
  (setq org-roam-db-location "~/Sync/emacs/org-roam.db")
  (setq org-roam-v2-ack t)
  (org-roam-setup))

(provide 'init-org)
