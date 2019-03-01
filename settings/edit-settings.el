(defun join-next-line (&optional N)
  "join next lines"
  (interactive "*p")

  (let ((count 0)
	(times (or N 1))
	)
    (while (and (< count times) (< (point) (point-max)))
      (join-line t)
      (setq count (1+ count))
      )

    (message "joined %d line%s%s" count (if (= count 1) "" "s")
	     (if (= (point) (point-max)) ", END reached" "")
	     )
    )
  )

(global-set-key (kbd "M-j") 'join-next-line)

(defun copy-current-line (arg)
  (interactive "p")
  (let* ((beg (line-beginning-position))
	(end (line-end-position arg))
	(lines (count-lines beg end))
	)
    (kill-ring-save beg end)
    (message "%d line%s copied" lines (if (= 1 lines) "" "s"))
    )
  )

(global-set-key (kbd "M-k") 'copy-current-line)

(global-set-key (kbd "M-;") 'comment-line)


(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(global-set-key (kbd "C-c k") 'kill-current-buffer)


(defun my-open-line (N)
  (interactive "*p")
  (if (> N 0)
      (progn
	(move-end-of-line 1)
	(dotimes (var N)
	  (newline-and-indent))
	)
    (progn
      (setq N (- 0 N))
      (back-to-indentation)
      (dotimes (var N)
	(newline-and-indent))
      (dotimes (var N)
	(previous-line)
	(indent-for-tab-command))
      )
    )
  )


(global-set-key (kbd "C-o") 'my-open-line)

;; avoid Ctrl-Space key binding on Windows
(when
    (string-match "Microsoft"
		  (with-temp-buffer (shell-command "uname -r" t)
				    (goto-char (point-max))
				    (delete-char -1)
				    (buffer-string)))
  (global-set-key (kbd "C-c SPC") 'set-mark-command)
  )

;; enable dired function
(put 'dired-find-alternate-file 'disabled nil)

(provide 'edit-settings)
