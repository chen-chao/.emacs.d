;; email sending
(require 'message)
(require 'sendmail)

(setq send-mail-function 'sendmail-send-it
      message-send-mail-function 'sendmail-send-it
      sendmail-program (executable-find "msmtp")
      message-sendmail-extra-arguments '("--read-envelope-from")
      mail-specify-envelope-from t
      mail-envelope-from 'header
      ;; mail-envelope-from will be automatically loaded if
      ;; sendmail.el is loaded, this is in case
      message-sendmail-envelope-from 'header
      )

;; for asynchronously RSS feeding
;; using wget

(require 'nnrss)
(require 'gnus-group)

(setq nnrss-use-local t)
(setq my-nnrss-download-script-file "~/bin/nnrsscrawler")

(defun my-nnrss-generate-download-script ()
  "same as nnrss-generate-download-script, but read urls from `nnrss-group-alist'
instead of `nnrss-group-data'"
  (interactive)
  (with-temp-buffer
    (progn
      (insert "#!/bin/sh\n")
      (insert "WGET=wget\n")
      (insert "RSSDIR='" (expand-file-name nnrss-directory) "'\n")
      (dolist (elem nnrss-group-alist)
	(let ((xmlname (nnrss-translate-file-chars (concat (car elem) ".xml")))
	      (url (nth 1 elem)))
	  (insert "$WGET -q -O \"$RSSDIR\"/'" xmlname "' '" url "'\n")))
      (write-file my-nnrss-download-script-file)
      (shell-command (concat "chmod u+x " my-nnrss-download-script-file)))
    )
  )

(defun my-save-crawler-after-make-rss-group (original-fun &rest args)
  "save newly added group to `my-nnrss-download-script-file'"
  (let ((old-length (length nnrss-group-alist)))
    (apply original-fun args)
    (if (file-exists-p my-nnrss-download-script-file)
	;; compare old and new nnrss-group-alist to get new added rss groups
	(unless (= old-length (length nnrss-group-alist))
	  (let* ((elem (car nnrss-group-alist))
		 (xmlname (nnrss-translate-file-chars (concat (car elem) ".xml")))
		 (url (nth 1 elem))
		 (cmd-string (concat "$WGET -q -O \"$RSSDIR\"/'" xmlname "' '" url "'\n")))
	    (write-region cmd-string nil my-nnrss-download-script-file 'append)
	    )
	  )
      (my-nnrss-generate-download-script my-nnrss-download-script-file)
      )
    )
  )

(advice-add 'gnus-group-make-rss-group :around #'my-save-crawler-after-make-rss-group)

(setq my-nnrss-default-prefix
      #s(hash-table size 20
		    test equal
		    data ("http://purl.org/rss/1.0/modules/content/" "content:"))
      )

(defun my-nnrss-get-namespace-prefix (el uri)
  "same as `nnrss-get-namespace-prefix', but provides default `content:'
for `content:encoded' tag if not given"
  (let* ((prefix (car (rassoc uri (cadar el))))
	 (nslist (if prefix
		     (split-string (symbol-name prefix) ":")))
	 (ns (cond ((eq (length nslist) 1) ; no prefix given
		    "")
		   ((eq (length nslist) 2) ; extract prefix
		    (cadr nslist)))))
    (if (and ns (not (string= ns "")))
	(concat ns ":")
      (or (gethash uri my-nnrss-default-prefix) ns))))

(advice-add 'nnrss-get-namespace-prefix :override #'my-nnrss-get-namespace-prefix)


(require 'gnus)

;; RSS feeding
(setq gnus-nntp-server nil)
(setq gnus-select-method '(nnrss ""))

;; mail reading

;; from manateelazycat, see
;; https://github.com/manateelazycat/lazycat-emacs/blob/master/site-lisp/config/init-gnus.el

;; reading mail from local directory
(setq gnus-secondary-select-methods '((nnmaildir "Mail" (directory "~/Mail/"))))

(gnus-agentize)                                     ;开启代理功能, 以支持离线浏览
(setq gnus-inhibit-startup-message t)               ;关闭启动时的画面
(setq gnus-show-threads t)                          ;显示邮件线索
(setq gnus-interactive-exit nil)                    ;退出时不进行交互式询问
(setq gnus-use-dribble-file nil)                    ;不创建恢复文件
(setq gnus-always-read-dribble-file nil)            ;不读取恢复文件
(setq gnus-asynchronous t)                          ;异步操作
(setq gnus-summary-ignore-duplicates t)             ;忽略具有相同ID的消息
(setq gnus-treat-fill-long-lines t)                 ;如果有很长的行, 不提示
(setq message-confirm-send t)                       ;防止误发邮件, 发邮件前需要确认
(setq message-kill-buffer-on-exit t)                ;设置发送邮件后删除buffer
(setq message-from-style 'angles)                   ;`From' 头的显示风格
(setq message-syntax-checks '((sender . disabled))) ;语法检查
(setq nnmail-expiry-wait 7)                         ;邮件自动删除的期限 (单位: 天)
(setq nnmairix-allowfast-default t)                 ;加快进入搜索结果的组

;; 窗口布局
(gnus-add-configuration
 '(article
   (vertical 1.0
             (summary .35 point)
             (article 1.0))))

;; 显示设置
;; (setq mm-text-html-renderer 'w3m)                     ;用W3M显示HTML格式的邮件
(setq mm-inline-large-images t)                       ;显示内置图片
(auto-image-file-mode)                                ;自动加载图片
(add-to-list 'mm-attachment-override-types "image/*") ;附件显示图片

;; fontset for gnus summary
(require 'theme-settings)
(dolist (face '(gnus-summary-normal-read
		gnus-summary-normal-ancient
		gnus-summary-normal-undownloaded
		gnus-summary-normal-ticked
		gnus-summary-normal-unread
		))
	(set-face-attribute face nil :fontset (cc/fontset-for-org-table))
	)

;; 概要显示设置
(setq gnus-summary-gather-subject-limit 'fuzzy) ;聚集题目用模糊算法
(setq gnus-summary-line-format "%4P %U%R%z%O %{%5k%} %{%14&user-date;%}   %{%-20,20n%} %{%ua%} %B %(%I%-60,60s%)\n")

(defun gnus-user-format-function-a (header) ;用户的格式函数 `%ua'
  (let ((myself (concat "<" "my-mail" ">"))
        (references (mail-header-references header))
        (message-id (mail-header-id header)))
    (if (or (and (stringp references)
                 (string-match myself references))
            (and (stringp message-id)
                 (string-match myself message-id)))
        "X" "│")))
(setq gnus-user-date-format-alist             ;用户的格式列表 `user-date'
      '(((gnus-seconds-today) . "TD %H:%M")   ;当天
        (604800 . "W%w %H:%M")                ;七天之内
        ((gnus-seconds-month) . "%d %H:%M")   ;当月
        ((gnus-seconds-year) . "%m-%d %H:%M") ;今年
        (t . "%y-%m-%d %H:%M")))              ;其他

;; leading symbols of thread tree
(setq gnus-summary-same-subject "")
(setq gnus-sum-thread-tree-indent "    ")
(setq gnus-sum-thread-tree-single-indent "◎ ")
(setq gnus-sum-thread-tree-root "● ")
(setq gnus-sum-thread-tree-false-root "☆")
;; (setq gnus-sum-thread-tree-vertical "│")
(setq gnus-sum-thread-tree-leaf-with-other "├─► ")
(setq gnus-sum-thread-tree-single-leaf "╰─► ")
;; 时间显示
(add-hook 'gnus-article-prepare-hook 'gnus-article-date-local) ;将邮件的发出时间转换为本地时间
(add-hook 'gnus-select-group-hook 'gnus-group-set-timestamp)   ;跟踪组的时间轴
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)              ;新闻组分组

(setq
 gnus-use-trees t
 gnus-tree-minimize-window nil
 gnus-fetch-old-headers 'some
 gnus-large-newsgroup nil
 gnus-generate-tree-function 'gnus-generate-horizontal-tree
 gnus-summary-thread-gathering-function 'gnus-gather-threads-by-subject
 )

;; 设置邮件报头显示的信息
(setq gnus-visible-headers
      (mapconcat 'regexp-quote
                 '("From:" "Newsgroups:" "Subject:" "Date:"
                   "Organization:" "To:" "Cc:" "Followup-To" "Gnus-Warnings:"
                   "X-Sent:" "X-URL:" "User-Agent:" "X-Newsreader:"
                   "X-Mailer:" "Reply-To:" "X-Spam:" "X-Spam-Status:" "X-Now-Playing"
                   "X-Attachments" "X-Diagnostic")
                 "\\|"))

;; 用 Supercite 显示多种多样的引文形式
(setq sc-attrib-selection-list nil
      sc-auto-fill-region-p nil
      sc-blank-lines-after-headers 1
      sc-citation-delimiter-regexp "[>]+\\|\\(: \\)+"
      sc-cite-blank-lines-p nil
      sc-confirm-always-p nil
      sc-electric-references-p nil
      sc-fixup-whitespace-p t
      sc-nested-citation-p nil
      sc-preferred-header-style 4
      sc-use-only-preference-p nil)

;; 时间的逆序
(setq gnus-thread-sort-functions '((not gnus-thread-sort-by-date)))

;; 自动跳到第一个没有阅读的组
(add-hook 'gnus-switch-on-after-hook 'gnus-group-first-unread-group) ;gnus切换时
(add-hook 'gnus-summary-exit-hook 'gnus-group-first-unread-group)    ;退出Summary时

(provide 'init-gnus)
