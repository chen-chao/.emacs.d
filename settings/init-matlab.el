;;; MATLAB and octave .m file settings

(setq auto-mode-alist (cons '("\\.m$" . octave-mode) auto-mode-alist))


(defun fix-octave-comments ()
    (make-local-variable 'comment-start)
    (setq comment-start "%")
    (setq comment-column 0))

(add-hook 'octave-mode-hook 'fix-octave-comments)

(provide 'matlab-settings)

