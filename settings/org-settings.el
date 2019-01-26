;; org-mode settings

(defun prepare-org-files ()
  (unless (file-directory-p "~/org/") (make-directory "~/org/"))
  (unless (file-exists-p "~/org/notes.org") (write-region "" nil "~/org/notes.org"))
  (unless (file-exists-p "~/org/gtd.org") (write-region "" nil "~/org/gtd.org"))
  (unless (file-exists-p "~/org/journal.org") (write-region "" nil "~/org/journal.org"))
  )


(use-package org
  :ensure t

  :bind
  (("C-c l" . org-store-link)
   ("C-c a" . org-agenda)
   ("C-c b" . org-iswitchb)
   ("C-c c" . org-capture)
   :map org-mode-map
   ("C-c z" . org-add-note)
   ("C-c <" . outline-promote)
   ("C-c >" . outline-demote)
   ("C-c [" . org-agenda-file-to-front)
   ("C-c ]" . org-remove-file)
   ("C-c C-a" . org-archive-subtree)
   )

  :config
  (setq org-log-done 'time)
  (setq org-log-done 'note)
  (setq org-todo-keywords '((sequence "TODO" "|" "DONE" "CANCELED(c!)") ) )

  (require 'org-habit)
  ;; (add-to-list 'org-modules 'org-habit)

  (prepare-org-files)

  ;; refile targets
  (setq org-refile-targets '((nil . (:level . 1))
                             ("~/org/notes.org" . (:level . 1))
                             ("~/org/gtd.org" . (:level . 1))))
  
  ;; capture templates
  (setq org-capture-templates
  '(("t" "TODO" entry (file+headline "~/org/gtd.org" "Tasks") "* TODO %?\n %i\n %a")
    ("j" "Journal" entry (file+datetree "~/org/journal.org") "* %?\nEntered on %U\n %i\n")
    ("n" "Note" item (file+headline "~/org/notes.org" "Notes") "%?\nEntered on %U\n %i\n %a")))
  
  (add-to-list 'org-structure-template-alist
               '("p" "#+BEGIN_SRC python\n?\n#+END_SRC")
               '("l" "#+BEGIN_SRC shell\n?\n#+END_SRC"))

  ;; org html export
  ;; remove xml header
  (setq org-html-xml-declaration
        '(("html" . "")
          ("xml" . "<?xml version=\"1.0\" encoding=\"%s\"?>")
          ("php" . "<?php echo \"<?xml version=\\\"1.0\\\" encoding=\\\"%s\\\" ?>\"; ?>")))
  (setq org-html-preamble nil)
  (setq org-html-postamble nil)

  ;; show holidays and anniversaries in org agenda
  (setq org-agenda-include-diary t)

  ;; from https://emacs-china.org/t/topic/2119/13
  ;; change name to org-chinese-anniversary
  
  (defun org-chinese-anniversary (lunar-month lunar-day &optional year mark)
    (if year
	(let* ((d-date (diary-make-date lunar-month lunar-day year))
               (a-date (calendar-absolute-from-gregorian d-date))
               (c-date (calendar-chinese-from-absolute a-date))
               (cycle (car c-date))
               (yy (cadr c-date))
               (y (+ (* 100 cycle) yy)))
          (diary-chinese-anniversary lunar-month lunar-day y mark))
      (diary-chinese-anniversary lunar-month lunar-day year mark))
    )

  (setq org-anni-file "~/org/anniversaries.org")
  (when (and (file-exists-p org-anni-file) (not (member org-anni-file org-agenda-files)))
    (add-to-list org-agenda-files org-anni-file)
    )
  )

;; holidays and chinese holidays
(use-package cal-china-x
  :ensure t
  :config
  (setq western-general-holidays
	'((holiday-fixed 2 14 "Valentine's Day")
	  (holiday-fixed 4 1 "April Fools' Day")
	  (holiday-float 5 0 2 "Mother's Day")
	  (holiday-float 6 0 3 "Father's Day")
	  (holiday-fixed 10 31 "Halloween")
	  (holiday-fixed 12 25 "Christmas"))
	)
  
  (setq cal-china-x-general-holidays
	'((holiday-lunar 1 15 "元宵节" 0)
	  (holiday-fixed 3 8 "妇女节")
	  (holiday-fixed 5 4 "青年节")
	  (holiday-fixed 6 1 "儿童节")
	  (holiday-fixed 9 10 "教师节")
	  (holiday-lunar 7 7 "七夕" 0)
	  (holiday-lunar 9 9 "重阳节" 0)
	  )
	)
  
  (setq calendar-holidays (append cal-china-x-chinese-holidays
				  cal-china-x-general-holidays
				  western-general-holidays))
  )

(provide 'org-settings)

