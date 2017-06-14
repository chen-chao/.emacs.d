;; org-mode settings
;; auto expand item tree
(setq org-startup-folded nil)

(setq org-log-done 'time)
(setq org-log-done 'note)
(setq org-todo-keywords '((sequence "TODO" "|" "DONE" "CANCELED(c!)") ) )
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
;;(add-to-list 'org-modules' "org-habit")

;; set default target file for notes
(setq org-directory "~/org/")
(setq org-default-notes-file (concat org-directory "/notes.org"))
;; global key to capture notes
(global-set-key "\C-cc" 'org-capture)
;; (define-key global-map "\C-cc" 'org-capture)

;; capture templates
(setq org-capture-templates
      '(("t" "TODO" entry (file+headline "~/org/gtd.org" "Tasks")
         "* TODO %?\n %i\n %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n %i\n %a")
        ) )

;; macro templates
;; (defcustom org-structure-template-alist '(("p" "#+Begin_SRC python\n\n#+End_SRC" "<src lang=\"?\">\n\n</src>")))

(provide 'org-settings)

