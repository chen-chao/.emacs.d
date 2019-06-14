;; auto completion of pairs and quotations
(electric-pair-mode 1)
(show-paren-mode 1)

(setq require-final-newline 1)

(global-set-key (kbd "M-+") 'text-scale-increase)
(global-set-key (kbd "M--") 'text-scale-decrease)


(defun cc/join-next-line (&optional N)
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

(global-set-key (kbd "M-j") 'cc/join-next-line)

(defun cc/copy-current-line (arg)
  (interactive "p")
  (let* ((beg (line-beginning-position))
	(end (line-end-position arg))
	(lines (count-lines beg end))
	)
    (kill-ring-save beg end)
    (message "%d line%s copied" lines (if (= 1 lines) "" "s"))
    )
  )

(global-set-key (kbd "M-k") 'cc/copy-current-line)

(global-set-key (kbd "M-;") 'comment-line)


(defun cc/kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(global-set-key (kbd "C-c k") 'cc/kill-current-buffer)


(defun cc/open-line (N)
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


(global-set-key (kbd "C-o") 'cc/open-line)

;; from https://github.com/seagle0128/.emacs.d/lisp/init-edit.el
;; On-the-fly spell checker
(use-package flyspell
  :ensure nil
  :diminish
  :if (executable-find "aspell")
  :hook (((text-mode outline-mode) . flyspell-mode)
         (flyspell-mode . (lambda ()
                            (dolist (key '("C-;" "C-," "C-."))
                              (unbind-key key flyspell-mode-map)))))
  :init
  (setq flyspell-issue-message-flag nil)
  (setq ispell-program-name "aspell")
  (setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US" "--run-together")))


;; enable dired function
(put 'dired-find-alternate-file 'disabled nil)

;; avoid Ctrl-Space key binding on Windows
(when
    (string-match "Microsoft"
		  (with-temp-buffer (shell-command "uname -r" t)
				    (goto-char (point-max))
				    (delete-char -1)
				    (buffer-string)))
  (global-set-key (kbd "C-c SPC") 'set-mark-command)
  )


;; mac specific settings
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  (add-to-list 'default-frame-alist '(font . "Monaco-20"))
  )

(provide 'edit-settings)
