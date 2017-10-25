;;; MATLAB and octave .m file settings

(setq auto-mode-alist (cons '("\\.m$" . octave-mode) auto-mode-alist))


(defun fix-octave-comments ()
    (make-local-variable 'comment-start)
    (set 'comment-start "%")
    (set 'comment-column 0))

(add-hook 'octave-mode-hook 'fix-octave-comments)

(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1))))

(provide 'matlab-settings)

