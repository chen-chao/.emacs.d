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
  )

(provide 'org-settings)

