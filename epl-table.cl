;;; downloads and prints EPL table

(ql:quickload "drakma" :silent t)
(ql:quickload "xmls" :silent t)

(defvar url "http://www.footballwebpages.co.uk/league.xml?comp=1")

;;marks the home team differently
(defvar hometeam "Arsenal")

(defvar xmls-output (xmls:parse (drakma:http-request url)))
(defun epl-table ()
  (format t "  ~3a ~21a ~7a ~6a ~4a ~%" "POS" "Name" "Played" "GD" "Pts.")
  (loop for team in (xmls:xmlrep-find-child-tags "team" xmls-output)
     do (let ((name (caddr (xmls:xmlrep-find-child-tag "name" team)))
	      (pos (caddr (xmls:xmlrep-find-child-tag "position" team)))
	      (played (caddr (xmls:xmlrep-find-child-tag "played" team)))
	      (GD (caddr (xmls:xmlrep-find-child-tag "goalDifference" team)))
	      (points (caddr (xmls:xmlrep-find-child-tag "points"team))))
	  (if (equal name hometeam)
	      (format t "=>~3a ~23a ~5a ~6a ~3a <=~%" pos name played GD points)
	      (format t "  ~3a ~23a ~5a ~6a ~3a~%"  pos name played GD points)))))



;;GO
(epl-table)
