(setq explicite-shell-file-name "/bin/bash")


;; https://oremacs.com/2015/01/01/three-ansi-term-tips/
(defun kill-term-after-exit ()
  (let* ((buff (current-buffer))
	 (proc (get-buffer-process buff)))
    (set-process-sentinel
     proc
     `(lambda (process event)
	(if (string= event "finished\n")
	    (kill-buffer ,buff)))
     )
    )
  )

(add-hook 'term-exec-hook 'kill-term-after-exit)

(eval-after-load "term"
  '(define-key term-raw-map (kbd "C-c C-y") 'term-paste)
  )

(defun ipython (&optional other)
  (interactive "P")
  (let ((ipython-path (or (executable-find "ipython") (executable-find "ipython3")))
	(new-window (or other nil))
	)
    (if ipython-path
	(progn
	  (when new-window
	    (progn
	      (split-window-below)
	      (other-window 1)))
	  (term ipython-path)
	)
      (message "cannot find ipython in the path"))
    )
  )

(provide 'init-shell)
