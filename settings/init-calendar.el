;; settings for calendar and holiday

(setq calendar-offset 0)

(setq chinese-calendar-celestial-stem
      ["甲" "乙" "丙" "丁" "戊" "己" "庚" "辛" "壬" "癸"]
      chinese-calendar-terrestrial-branch
      ["子" "丑" "寅" "卯" "辰" "巳" "午" "未" "申" "酉" "戌" "亥"])

;; disable holiday
(setq holiday-christian-holidays nil
      holiday-hebrew-holidays nil
      holiday-islamic-holidays nil
      holiday-bahai-holidays nil
      )

;; show holidays in calendar
(setq mark-holidays-in-calendar t)

;; (setq calendar-view-calendar-holidays-initially-flag nil)

(setq holiday-general-holidays '((holiday-fixed 1 1   "New Year's Day")
                                 (holiday-fixed 2 14  "Valentine's Day")
                                 (holiday-fixed 3 8   "Women's Day")
                                 (holiday-fixed 4 1   "April Fool's Day")
                                 (holiday-fixed 5 1   "Labor Day")
                                 (holiday-fixed 5 4   "Youth Day")
                                 (holiday-float 5 0 2 "Mother's Day")
                                 (holiday-fixed 6 1   "Children's Day")
                                 (holiday-float 6 0 3 "Father's Day")
                                 (holiday-fixed 9 10  "Teacher's Day")
                                 (holiday-fixed 10 1  "National Day")
                                 (holiday-fixed 10 31 "Halloween")
                                 (holiday-fixed 12 25 "Christmas")
                                 (holiday-chinese 12 30 "New Year's Eve")
                                 ))
;; (setq holiday-local-holidays '((birthday-fixed 10 1  "birthday")
                               ;; (holiday-chinese 5 29 "birthday")
                               ;; ))
(provide 'init-calendar)
