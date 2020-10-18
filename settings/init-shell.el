;; https://oremacs.com/2015/01/01/three-ansi-term-tips/
(defun kill-term-after-exit ()
  (let* ((buff (current-buffer))
	 (proc (get-buffer-process buff)))
    (set-process-sentinel
     proc
     `(lambda (process event)
	(if (or (string= event "finished\n") (string= event "exit\n"))
	    (kill-buffer ,buff)))))
  )

(add-hook 'term-exec-hook 'kill-term-after-exit)

;; helper commands for interactive shells
(defun run-command-in-term (command &optional other)
  (let ((command-path (executable-find command))
	(new-window (or other nil)))
    (if command-path
	(progn
	  (when new-window
	    (progn
	      (split-window-below)
	      (other-window 1)))
	  (term command-path))
      (message "cannot find %s in the path" command)))
  )

(defun bash (&optional other)
  (interactive "P")
  (run-command-in-term "bash" other)
  )

(defun ipython (&optional other)
  (interactive "P")
  (run-command-in-term "ipython" other)
  )

(provide 'init-shell)
