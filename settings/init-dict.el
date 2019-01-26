(use-package youdao-dictionary
  :ensure t
  :bind
  (("C-c y s" . youdao-dictionary-search-at-point-tooltip)
   ("C-c y i" . youdao-dictionary-search-from-input)
   ("C-c y v" . youdao-dictionary-play-voice-at-point)
   )
  :config
  (setq url-automatic-caching t)	;enable cache
  (setq youdao-dictionary-search-history-file "~/.emacs.d/.youdao_hist")
  )

(defun youdao-dictionary-search-and-play-at-point ()
  (interactive)
  (youdao-dictionary-play-voice-at-point)
  (youdao-dictionary-search-at-point)
  )

(provide 'init-dict)
