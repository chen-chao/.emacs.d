;; org-mode settings
;; auto expand item tree
(use-package org
             :ensure t

             :bind (("C-c l" . org-store-link)
                    ("C-c a" . org-agenda)
                    ("C-c b" . org-iswitchb)
                    ("C-c c" . org-capture))

             :config
             (require 'org-habit)
             (setq org-startup-folded nil)
             (setq org-log-done 'time)
             (setq org-log-done 'note)
             (setq org-todo-keywords '((sequence "TODO" "|" "DONE" "CANCELED(c!)") ) )

             ;;(add-to-list 'org-modules' "org-habit")

             ;; set default target file for notes
             (unless (file-directory-p "~/org/") (make-directory "~/org/"))
             (setq org-directory "~/org/")
             (setq org-notes-file (concat org-directory "/notes.org"))
             (unless (file-exists-p org-notes-file) (write-region "" nil org-notes-file))
             (setq org-default-notes-file org-notes-file)

             ;; capture templates
             (setq org-gtd-file (concat org-directory "/gtd.org"))
             (unless (file-exists-p org-gtd-file) (write-region "" nil org-gtd-file))
             (setq org-journal-file (concat org-directory "/journal.org"))
             (unless (file-exists-p org-journal-file) (write-region "" nil org-journal-file))
             (setq org-capture-templates
                   '(("t" "TODO" entry (file+headline org-gtd-file "Tasks")
                      "* TODO %?\n %i\n %a")
                     ("j" "Journal" entry (file+datetree org-journal-file)
                      "* %?\nEntered on %U\n %i\n %a")
                     ))
             (add-to-list 'org-structure-template-alist
                          '("p" "#+BEGIN_SRC python\n?\n#+END_SRC"))
             )

(provide 'org-settings)

