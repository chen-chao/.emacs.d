;; general settings
(setq inhibit-startup-screen 1)
(menu-bar-mode 0)
(tool-bar-mode 0)

;; maximize window at startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; auto completion of pairs and quotations
(electric-pair-mode 1)
(show-paren-mode 1)

(setq require-final-newline 1)

;; show line numbers in the left margin
(setq global-display-line-numbers t)

;; theme settings
(setq custom-safe-themes t)

(require 'eclipse-theme)
(load-theme 'eclipse)

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

(defun set-fontset-font-size (fset font size)
  (set-fontset-font (frame-parameter nil 'font) fset
		    (font-spec :family font :size size))
  )

(defun set-width-han-font-size (expected_width)
  (let* ((cn_font (split-string (face-font 'default nil ?中) "-"))
	 (cn_fontname (nth 2 cn_font))
	 (cn_fontsize (string-to-number (nth 7 cn_font)))
	 )

    (while (< (get-char-font-width-on-screen ?中) expected_width)
      (setq cn_fontsize (1+ cn_fontsize))
      (set-fontset-font-size 'han cn_fontname cn_fontsize)
      )
    (while (> (get-char-font-width-on-screen ?中) expected_width)
      (setq cn_fontsize (1- cn_fontsize))
      (set-fontset-font-size 'han cn_fontname cn_fontsize)
      )
    )
  )


(defun set-height-han-font-size (expected_height)
  (let* ((cn_font (split-string (face-font 'default nil ?中) "-"))
	 (cn_fontname (nth 2 cn_font))
	 (cn_fontsize (string-to-number (nth 7 cn_font)))
	 )
    (while (< (get-char-font-height-on-screen ?中) expected_height)
      (setq cn_fontsize (1+ cn_fontsize))
      (set-fontset-font-size 'han cn_fontname cn_fontsize)
      )
    (while (> (get-char-font-height-on-screen ?中) expected_height)
      (setq cn_fontsize (1- cn_fontsize))
      (set-fontset-font-size 'han cn_fontname cn_fontsize)
      )
    )
  )

(defun set-twice-en-width-han-font-size ()
  (interactive)
  (let ((expected_width (* 2 (get-char-font-width-on-screen ?m))))
    (set-width-han-font-size expected_width)
    )
  )

(defun set-same-en-height-han-font-size ()
  (interactive)
  (let ((expected_height (get-char-font-height-on-screen ?m)))
    (set-height-han-font-size expected_height)
    )
  )


(provide 'theme-settings)
