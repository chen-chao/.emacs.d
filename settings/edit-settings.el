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

(provide 'edit-settings)