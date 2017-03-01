(setf *S* #\space)
(setf *board* '((#\space #\space #\space)
		(#\space #\space #\space)
		(#\space #\space #\space))
)

(defun tic-tac-toe ()
	(format t "Let's play tic-tac-toe!~%Who will go first, (H)uman or (C)omputer?~%>")
	(defparameter starter (read))
	(if (eql starter 'H)
		(progn
			(format t "Human starts: ~%>")
			(h-move (read) (read))
		)
	(if (eql starter 'C)
		(progn
			(format t "Computer starts:~%")
			(c-move)
		)
	(format t "Input Error! ~A~%" starter)	
	))
)

(defun h-move (row col)
	(format t "H-Move ~A ~A~%" row col)
	
)

(defun c-move()
	(format t "C-Move")
	
)

(defun print-board()
	(format t "~A|~A|~A~%-+-+-~%~A|~A|~A~%-+-+-~%~A|~A|~A~%" 
		(caar *board*)
		(cadar *board*)
		(car (cddar *board*));	can't use caddar :(
		(caadr *board*)
		(car (cdadr *board*))
		(car (cddadr *board*))
		(caar(cddr *board*))
		(cadar(cddr *board*))
		(caddr(caddr *board*))
	)
)

(defun check-win(sym)
	(if (and (eql sym (car
)

(defun is-space(x)
	(eql x #\space)
)

(defun is-board-full()
	(and 
		(every #'null (mapcar #'is-space (car *board*)))
		(every #'null (mapcar #'is-space (cadr *board*)))
		(every #'null (mapcar #'is-space (caddr *board*)))
	)
)
