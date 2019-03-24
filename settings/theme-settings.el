;; general settings
(setq inhibit-startup-screen 1)
(menu-bar-mode 0)
(tool-bar-mode 0)

;; maximize window at startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; theme settings
(setq custom-safe-themes t)

(use-package eclipse-theme
  :ensure t
  :init (load-theme 'eclipse)
  )

;; enable/disable theme for window-system/terminal
(defun switch-color-theme (frame)
  (select-frame frame)
  (if (window-system frame)
      (progn
	(enable-theme 'eclipse)
	(set-face-foreground 'minibuffer-prompt "medium blue")
	)
    (progn
      (disable-theme 'eclipse)
      ;; set the minibuffer color
      (set-face-foreground 'minibuffer-prompt "cyan")
      )
    ))

;; (add-hook 'after-make-frame-functions 'switch-color-theme)

;; (if window-system (enable-theme 'eclipse)
;;   (progn (disable-theme 'eclipse) (setq frame-background-mode 'dark)))


;; determine the width of characters on the screen
;; from https://emacs.stackexchange.com/questions/5495/how-can-i-determine-the-width-of-characters-on-the-screen

(defun get-char-font-width-on-screen (s) 
  "Return the width in pixels of a character in the current
window's default font.  More precisely, this returns the
width of the letter ‘m’.  If the font is mono-spaced, this
will also be the width of all other printable characters."
  (let ((window (selected-window))
        (remapping face-remapping-alist))
    (with-temp-buffer
      (make-local-variable 'face-remapping-alist)
      (setq face-remapping-alist remapping)
      (set-window-buffer window (current-buffer))
      (insert s)
      (aref (aref (font-get-glyphs (font-at 1) 1 2) 0) 4))))


(defun get-char-font-height-on-screen (s)
  (aref (font-info (face-font 'default nil s)) 2)
  )

(defun set-fontset-font-size (fset charset font size)
  (set-fontset-font fset charset
		    (font-spec :family font :size size))
  )

(defun get-char-font-size-of-width (char charset width &optional action)
  (let* ((font (split-string (face-font 'default nil char) "-"))
	 (fontname (nth 2 font))
	 (fontsize (string-to-number (nth 7 font)))
	 (tempsize fontsize)
	 (fset (frame-parameter nil 'font))
	 )

    (while (< (get-char-font-width-on-screen char) width)
      (setq tempsize (1+ tempsize))
      (set-fontset-font-size fset charset fontname tempsize)
      )
    (while (> (get-char-font-width-on-screen char) width)
      (setq tempsize (1- tempsize))
      (set-fontset-font-size fset charset fontname tempsize)
      )

    (unless action
      (set-fontset-font-size fset charset fontname fontsize)
      )
    tempsize
    )
  )

(defun cc/set-twice-en-width-han-font-size ()
  (interactive)
  (let ((expected-width (* 2 (get-char-font-width-on-screen ?m))))
    (get-char-font-size-of-width ?中 'han expected-width t)
    )
  )

(defun cc/set-same-en-height-han-font-size ()
  (interactive)
  (let* ((fset (frame-parameter nil 'font))
	 (font (split-string (face-font 'default nil ?中) "-"))
	 (fontname (nth 2 font))
	 (fontsize (get-char-font-height-on-screen ?m))
	 )
    (set-fontset-font-size fset 'han fontname fontsize)
    )
  )

;; fontset for org table
;; from https://zcodes.net/2016/08/22/emacs-notes-config.html
(defun cc/fontset-for-org-table ()
  (let* ((expected-width (* 2 (get-char-font-width-on-screen ?m)))
	 (cn-fontsize (get-char-font-size-of-width ?中 'han expected-width))
	 (cn-font (split-string (face-font 'default nil ?中) "-"))
	 (cn-fontname (nth 2 cn-font))
	 (fset (frame-parameter nil 'font))
	 (fset-string (replace-regexp-in-string "-iso.*$" "-fontset-orgtable" fset))
	 (fset-org-table (create-fontset-from-fontset-spec fset-string))
	 )
    (set-fontset-font-size fset-org-table 'han cn-fontname cn-fontsize)
    fset-org-table
    )
  )

(provide 'theme-settings)
