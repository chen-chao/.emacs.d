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

  (setq org-log-done 'time)
  (setq org-log-done 'note)
  (setq org-todo-keywords '((sequence "TODO" "|" "DONE" "CANCELED(c!)")))

  (require 'org-habit)

  ;; refile targets
  (setq org-refile-targets '((nil . (:level . 1))
			     ("~/org/notes.org" . (:level . 1))
			     ("~/org/gtd.org" . (:level . 1))))

  ;; capture templates
  (setq-default org-capture-templates
		'(("t" "TODO" entry (file+headline "~/org/gtd.org" "Tasks") "* TODO %?\n %i\n %a")
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

  ;; add anniversaries to org agenda
  (when (and (file-exists-p "~/org/anniversaries.org")
	     (not (member "~/org/anniversaries.org" org-agenda-files)))
    (setq org-agenda-files (cons "~/org/anniversaries.org" org-agenda-files)))

  (setq-default org-agenda-start-day "-1d")
  (setq-default org-agenda-span 7)
  (setq-default org-agenda-start-on-weekday nil)

  ;; set org table attribute
  (zh-align-set-faces '(org-table))

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

(use-package org-download
  :defer t
  :bind (:map org-mode-map
	      ("C-c d" . org-download-screenshot))
  :config
  (setq org-download-method 'attach)
  (setq org-download-backend "curl \"%s\" -o \"%s\"")
  (when (eq system-type 'darwin)
    (setq org-download-screenshot-method "screencapture -i %s"))
  (when (eq system-type 'linux)
    (setq org-download-screenshot-method "scrot -s %s"))
  (org-download-enable)
  )

(use-package pdf-tools
  :commands (pdf-tools-enable-minor-modes)
  :mode (("\\.pdf\\'" . pdf-view-mode))
  :bind (:map pdf-view-mode-map
	      ("C-s" . isearch-forward))
  :config
  (add-hook 'pdf-view-mode-hook 'pdf-tools-enable-minor-modes))

(provide 'init-org)
