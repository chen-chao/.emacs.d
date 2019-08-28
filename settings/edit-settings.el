;; auto completion of pairs and quotations
(electric-pair-mode 1)
(show-paren-mode 1)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq require-final-newline 1)

;; override built-in fixup-whitespace for cjk support
(defun fixup-whitespace-for-cjk ()
  "Fixup white space between objects around point.
Leave one space or none, according to the context."
  (interactive "*")
  (save-excursion
    (delete-horizontal-space)
    (if (or (looking-at "^\\|$\\|\\s)\\|\\cc\\|\\cj\\|\\ch") ; Note: the char after point
	    (save-excursion (forward-char -1)
			    (looking-at "$\\|\\s(\\|\\s'\\|\\cc\\|\\cj\\|\\ch")))  ; Note: the char before point
	nil
      (insert ?\s))))

(advice-add 'fixup-whitespace :override #'fixup-whitespace-for-cjk)

(defun cc/join-next-line (&optional N)
  "join next lines"
  (interactive "*p")

  (let ((count 0)
	(times (or N 1)))
    (while (and (< count times) (< (point) (point-max)))
      (join-line t)
      (setq count (1+ count)))

    (message "joined %d line%s%s" count (if (= count 1) "" "s")
	     (if (= (point) (point-max)) ", END reached" "")))
  )

(defun cc/copy-current-line (arg)
  (interactive "p")
  (let* ((beg (line-beginning-position))
	(end (line-end-position arg))
	(lines (count-lines beg end)))
    (kill-ring-save beg end)
    (message "%d line%s copied" lines (if (= 1 lines) "" "s")))
  )

(defun cc/kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(defun cc/open-line (N)
  (interactive "*p")
  (if (> N 0)
      (progn
	(move-end-of-line 1)
	(dotimes (var N)
	  (newline-and-indent)))
    (progn
      (setq N (- 0 N))
      (back-to-indentation)
      (dotimes (var N)
	(newline-and-indent))
      (dotimes (var N)
	(previous-line)
	(indent-for-tab-command))))
  )


(global-set-key (kbd "M-+") 'text-scale-increase)
(global-set-key (kbd "M--") 'text-scale-decrease)
(global-set-key (kbd "M-j") 'cc/join-next-line)
(global-set-key (kbd "M-k") 'cc/copy-current-line)
(global-set-key (kbd "M-;") 'comment-line)
(global-set-key (kbd "C-c k") 'cc/kill-current-buffer)
(global-set-key (kbd "C-o") 'cc/open-line)
(global-set-key (kbd "C->") 'forward-list)
(global-set-key (kbd "C-<") 'backward-list)

(add-hook 'before-save-hook #'delete-trailing-whitespace)

(use-package recentf
  :config
  (setq recentf-max-saved-items 100)
  )

(use-package multiple-cursors
  :bind
  (("C-c C->" . mc/edit-lines)
   ("C-c >" . mc/mark-next-like-this)
   ("C-c <" . mc/mark-previous-like-this)
   ("C-c C-<" . mc/mark-all-like-this)
   ("C-c C-n" . mc/insert-numbers))
  )

(provide 'edit-settings)
