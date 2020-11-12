;; org-mode settings

(use-package org
  ;; :init (require 'org-protocol)
  :bind
  (("C-c a" . org-agenda)
   ("C-c c" . org-capture)
   :map org-mode-map
   ("C-c z" . org-add-note)
   ("C-c <" . outline-promote)
   ("C-c >" . outline-demote)
   ("C-c [" . org-agenda-file-to-front)
   ("C-c ]" . org-remove-file)
   ("C-c C-a" . org-archive-subtree)
   ("C-," . org-cycle-agenda-files))

  :config
  (unbind-key "C-'" org-mode-map)

  (setq org-log-done 'note)
  (setq org-todo-keywords '((sequence "TODO(t)" "PENDING(p@/!)" "|" "DONE" "CANCELED(c@)")))

  (require 'org-habit)

  ;; refile targets
  (setq org-refile-targets '((org-agenda-files . (:maxlevel . 1))))

  ;; capture templates
  (setq-default org-capture-templates
		'(("t" "TODO" entry (file "~/org/gtd.org") "* TODO %?\n %i\n %a")
		  ("j" "Journal" entry (file+olp+datetree "~/org/journal.org") "* %?\nEntered on %U\n %i\n")
		  ("n" "Note" entry (file+headline "~/org/notes.org" "Notes") "* %?\nEntered on %U\n %i\n %a")))

  ;; for org html export
  (use-package htmlize)
  ;; remove xml header
  (setq-default org-html-xml-declaration
		'(("html" . "")
		  ("xml" . "<?xml version=\"1.0\" encoding=\"%s\"?>")
		  ("php" . "<?php echo \"<?xml version=\\\"1.0\\\" encoding=\\\"%s\\\" ?>\"; ?>")))
  (setq-default org-html-preamble nil)
  (setq-default org-html-postamble nil)

  ;; show holidays and anniversaries in org agenda
  (setq-default org-agenda-include-diary t)

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

  (setq-default org-agenda-start-day "-1d")
  (setq-default org-agenda-span 7)
  (setq-default org-agenda-start-on-weekday nil)

  ;; set org table attribute
  ;; (zh-align-set-faces '(org-table))

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

  ;; clocking
  (setq-default org-clock-persist 'history)
  (org-clock-persistence-insinuate)
  )

(provide 'init-org)
