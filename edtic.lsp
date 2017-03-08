(defparameter *S* #\space)
(setf *board* '((#\space #\space #\space)
                (#\space #\space #\space)
                (#\space #\space #\space))
)
(setf *table1* '(
	nil
	(1 1)
	(2 0)
	(1 1)
	(2 2)
	(1 1)
	(0 2)
	(1 1)
	(0 2)
		)
)

(setf *table2* '(
	(1 1 
		(
		nil
		(0 2)
		(0 1)
		(2 0)
		nil
		(2 2)
		(1 0)
		(2 2)
		(2 1)
		)
	)
	(1 1)
	(1 1)
	(1 1)
	(0 0)
	(1 1)
	(1 1)
	(1 1)
	(1 1)
		)
)
(setf *turns* 0)
(setf *lookup* nil)


(defun tic-tac-toe ()
	(format t "Let's play tic-tac-toe!~%Who will go first, (H)uman or (C)omputer?~%>")
	(clear-board)
	(setf *turns* 0)
	(defparameter starter (read))
		(if (eql starter 'H)
			(progn
				(setf *lookup* *table2*)
				(format t "Human starts.~%Input row and column separated by a space or a newline~%Ex: 1 2~%Your Move>")
				(h-move (read) (read))
			)
		(if (eql starter 'C)
			(progn
				(format t "Computer starts:~%")
				(format t "~%hmmm...~%~%")
				(if (sleep 1) "Oh... uh... this is embarassing. You were never supposed to see this :/")
				(setf (nth 0 (nth 0 *board*)) 'C)
				(print-board)
				(setf *lookup* *table1*)
				(format t "Your turn.~%Input row and column separated by a space or a newline~%Ex: 1 2~%Your Move>")
				(h-move (read) (read))
			)
		(progn
			(format t "Input Error! ~A~%Please input H or C~%~%" starter)
			(tic-tac-toe)
		)))
)

(defun clear-board()
	(loop for r from 0 to 2
		do (loop for c from 0 to 2
			do (setf (nth c (nth r *board*)) '#\space)
		)
	)
)

(defun h-move (row col)
	(format t "H-Move ~A ~A~%~%" row col)
	(if (eql (get-sym row col) #\space)
		(setf (nth col (nth row *board*)) 'H)
	(progn
		(format t "Invalid input, try again~%Your Move>")
		(h-move (read) (read))
	))
	
	(print-board)
	(if (check-win 'H) "You Win!"
		(if (check-tie) "Tie."
			(c-move row col)
		)
	)
)

(defun c-move(row col)
	(format t "~%hmmm...~%~%")
	(if (sleep 1) "Oh... uh... this is embarassing. You were never supposed to see this :/")
	(if (< *turns* 3) (progn
		(setf (nth 
			(second (nth (+ col (* row 3)) *lookup*))
		(nth
			(car (nth (+ col (* row 3)) *lookup*))
		*board*)) 'C)
		(setf *lookup* (third (nth (+ col (* row 3)) *lookup*)))
		(setf *turns* (+ 1 *turns*))
		)
	)
	
	(print-board)
	(if (check-win 'C) "Computer Wins!"
		(if (check-tie) "Tie."
			(progn 
				(format t "~%Your Move>")
				(h-move (read) (read))
			)
		)
	)
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

(defun check-tie()
	(and (notany #'is-space (car *board*))
		 (notany #'is-space (car (cdr *board*)))
		 (notany #'is-space (car (cdr (cdr *board*))))
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
	(if (not (integerp r)) nil
	(if (not (integerp c)) nil
	(if (> r 2) nil
	(if (< r 0) nil
	(if (> c 2) nil
	(if (< c 0) nil
	(nth c (nth r *board*) )))))))
)

#| (defun get-cell-score(r c)
	; add weights of surrounding cells
	(+ (get-cell-weight (- r 1) c) ;vertical line
	   (get-cell-weight (+ r 1) c)
	   (* 1.5 (get-cell-weight (- r 2) c))
	   (* 1.5 (get-cell-weight (+ r 2) c))
	   (get-cell-weight r (- c 1)) ;horizontal line
	   (get-cell-weight r (+ c 1))
	   (* 1.5 (get-cell-weight r (- c 2)))
	   (* 1.5 (get-cell-weight r (+ c 2)))
	   (get-cell-weight (- r 1) (- c 1)) ;negative diagonal
	   (get-cell-weight (+ r 1) (+ c 1))
	   (* 1.5 (get-cell-weight (- r 2) (- c 2)))
	   (* 1.5 (get-cell-weight (+ r 2) (+ c 2)))
	   (get-cell-weight (- r 1) (+ c 1)) ;positive diagonal
	   (get-cell-weight (+ r 1) (- c 1))
	   (* 1.5 (get-cell-weight (- r 2) (+ c 2)))
	   (* 1.5 (get-cell-weight (+ r 2) (- c 2))))	
)
|#

(defun get-cell-score(r c)
	(let ((vertical (get-line-score (+ r 1) c (+ r 2) c (- r 1) c (- r 2) c))
	   	  (horizontal (get-line-score r (+ c 1) r (+ c 2) r (- c 1) r (- c 2)))
	   	  (positive-diag (get-line-score (+ r 1) (+ c 1) (+ r 2) (+ c 2) (- r 1) (- c 1) (- r 2) (- c 2)))
	   	  (negative-diag (get-line-score (+ r 1) (- c 1) (+ r 2) (- c 2) (- r 1) (+ c 1) (- r 2) (+ c 2))))
		
		(let ((max-score (max vertical horizontal positive-diag negative-diag)))
			(* max-score (num-occurrences max-score 
						 (list vertical horizontal positive-diag negative-diag)))
		)
	)
)

(defun num-occurrences(obj lst)
	(if (null lst)
		0
		(if (eq (car lst) obj)
			(+ 1 (num-occurrences obj (cdr lst)))
			(num-occurrences obj (cdr lst))
		)
	)
)

#| (defun get-cell-weight(r c)
	(let ((occupant (get-sym r c)))
		(cond
			((eq occupant nil) 0)
			((is-space occupant) 1)
			((eq occupant 'H) 5)
			((eq occupant 'C) 6)
			(T 0)
		)
	)
)

(defun get-placement-score(cell1 cell2 cell3 cell4)
	(let ((score 0))
		(if (not (null cell1))
			(progn
				(if (eq cell1 cell2)
					(setf score (+ 1 score)))
				(if (eq cell1 cell3)
					(setf score (+ 1 score)))
				(if (eq cell1 cell4)
					(setf score (+ 1 score))))
		)
		(if (not (null cell2))
			(progn
				(if (eq cell2 cell3)
					(setf score (+ 1 score)))
				(if (eq cell2 cell4)
					(setf score (+ 1 score))))
		)
		(if (not (null cell3))
			(if (eq cell3 cell4)
				(setf score (+ 1 score)))
		)
		score
	)
) |#

(defun get-line-score(cell1r cell1c cell2r cell2c cell3r cell3c cell4r cell4c)
	(let ((sym1 (get-sym cell1r cell1c)) 
		  (sym2 (get-sym cell2r cell2c)) 
		  (sym3 (get-sym cell3r cell3c)) 
		  (sym4 (get-sym cell4r cell4c)))
		(let ((spaces-to-score (remove nil (list sym1 sym2 sym3 sym4))))
			(score-spaces (car spaces-to-score) (car (cdr spaces-to-score)))
		)
	)
)

; cell scores: CC = 8, HH = 7, C space = 3, H space = 2, space space = 1, CH = 0
(defun score-spaces(sym1 sym2)
	(if (or (null sym1) (null sym2))
		0
		(if (eq sym1 sym2)
			(if (eq sym1 'C) 8
				(if (eq sym1 'H) 7
					1
				)
			)
			(if (or (is-space sym1) (is-space sym2))
				(if (is-space sym1)
					(if (eq sym2 'H) 2 3)
					(if (eq sym1 'H) 2 3)
				)
				0
			)
		)
	)
)

