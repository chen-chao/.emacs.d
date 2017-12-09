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
             (setq org-directory "~/org/")
             (setq org-default-notes-file (concat org-directory "/notes.org"))
             
             ;; capture templates
             (setq org-capture-templates
                   '(("t" "TODO" entry (file+headline "~/org/gtd.org" "Tasks")
                      "* TODO %?\n %i\n %a")
                     ("j" "Journal" entry (file+datetree "~/org/journal.org")
                      "* %?\nEntered on %U\n %i\n %a")
                     ))
             (add-to-list 'org-structure-template-alist
                          '("p" "#+BEGIN_SRC python\n?\n#+END_SRC"))
             )

(provide 'org-settings)

