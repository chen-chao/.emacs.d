(setq explicite-shell-file-name "/bin/bash")

(use-package term
  :config
  (unbind-key "M-0" term-raw-map)
  (unbind-key "M-1" term-raw-map)
  (unbind-key "M-2" term-raw-map)
  (unbind-key "M-3" term-raw-map)
  (unbind-key "M-4" term-raw-map)
  (unbind-key "M-5" term-raw-map)
  (unbind-key "M-6" term-raw-map)
  (unbind-key "M-7" term-raw-map)
  )

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

(eval-after-load "term"
  '(define-key term-raw-map (kbd "C-c C-y") 'term-paste))


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
