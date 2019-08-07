;; auto completion of pairs and quotations
(electric-pair-mode 1)
(show-paren-mode 1)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq require-final-newline 1)

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

(add-hook 'before-save-hook #'delete-trailing-whitespace)

;; mac specific settings
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  (add-to-list 'default-frame-alist '(font . "Menlo-20"))
  )

(provide 'edit-settings)
