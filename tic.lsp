(setf *S* #\space)
(setf *board* '((#\space #\space #\space)
		(#\space #\space #\space)
		(#\space #\space #\space))
)

#|
(setf *board* '((O X X)
                (O O X)
                (X O O) )
)
|#

(defun tic-tac-toe ()
	(format t "Let's play tic-tac-toe!~%Who will go first, (H)uman or (C)omputer?~%>")
	(defparameter starter (read))
	(if (eql starter 'H)
		(progn
			(format t "Human starts.~%Input row and column separated by a space or a newline~%Ex: 1 2~%>")
			(h-move (read) (read))
		)
	(if (eql starter 'C)
		(progn
			(format t "Computer starts:~%")
			(c-move)
		)
	(progn
		(format t "Input Error!~A~%Please input H or C~%" starter)
		(tic-tac-toe)
	)))
)

(defun h-move (row col)
	(format t "H-Move ~A ~A~%~%" row col)
	(if (eql (get-sym row col) #\space)
		(setf (nth col (nth row *board*)) 'H)
	(progn
		(format t "Invalid input, try again~%>")
		(h-move (read) (read))
	))
	
	(print-board)
	(if (check-win 'H) "You Win!"
	(c-move) )
)

(defun c-move()
	(format t "hmmm...~%~%")
	(if (sleep 1) "Oh... uh... this is embarassing. You were never supposed to see this :/"
	
	;set board...
	(format t "TO DO: make a move.~%")
	)
	(print-board)
	(format t "~%>")
	(if (check-win 'C) (format t "You Win!")
	(h-move (read) (read)) )
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
	(if (and 
		(eql sym (get-sym 0 0)) 
		(eql sym (get-sym 0 1))
		(eql sym (get-sym 0 2)) )
	t
	(if (and
                (eql sym (get-sym 1 0))  
                (eql sym (get-sym 1 1))
                (eql sym (get-sym 1 2)) )
	t
        (if (and
                (eql sym (get-sym 2 0))
                (eql sym (get-sym 2 1))
                (eql sym (get-sym 2 2)) )
	t
        (if (and
                (eql sym (get-sym 0 0))
                (eql sym (get-sym 1 0))
                (eql sym (get-sym 2 0)) )
	t
        (if (and
                (eql sym (get-sym 0 1))
                (eql sym (get-sym 1 1))
                (eql sym (get-sym 2 1)) )
	t
        (if (and
                (eql sym (get-sym 0 2))
                (eql sym (get-sym 1 2))
                (eql sym (get-sym 2 2)) )
	t
        (if (and
                (eql sym (get-sym 0 0))
                (eql sym (get-sym 1 1))
                (eql sym (get-sym 2 2)) )
	t
        (if (and
                (eql sym (get-sym 0 2))
                (eql sym (get-sym 1 1))
                (eql sym (get-sym 2 0)) )
	t ))))))))
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

(defun get-sym(r c)
	(if (> r 2) nil
	(if (< r 0) nil
	(if (> c 2) nil
	(if (< c 0) nil
	(nth c (nth r *board*) )))))
)
