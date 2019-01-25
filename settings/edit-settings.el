(defun join-next-line (arg)
  (interactive "p")
  (dotimes (n arg)
    (join-line t)
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

(provide 'edit-settings)
