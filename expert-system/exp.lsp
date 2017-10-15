;;;; exp5.lsp
;;;; Backwards-chaining expert system
;;;; Edric Yu & Alison Bell

(defun prove? (goal facts rules)
        (defparameter *past-goals* '()); symbols we have tried to prove true earlier; prevents infinite recusion in some cases
        (defparameter *exp-path* '()); list of rules followed to a true result
        (let ((result (prove-r goal facts rules)))
                (if result
                        (if *exp-path*
                        (format t "Rules followed to result: ~A" *exp-path*)
                        (format t "Goal was a given fact."))
                )
                result
        )
)

(defun prove-r (goal facts rules)
        (if (is-true goal facts) t
                (let ((cand-rules (get-cand-rules rules goal)))
                        (setf *past-goals* (cons goal *past-goals*))
                        (if (null cand-rules) nil
                                (check-rules cand-rules rules facts)
                        )
                )
        )
)

(defun is-true(goal facts)
        (member goal facts)
)

(defun get-cand-rules (rules goal)
    (if (null rules) nil
        (if (and (eql goal (second (car rules)))
		(not (member (car (car (car rules))) *past-goals*)) )
            (cons (car rules)(get-cand-rules (cdr rules) goal))
            (get-cand-rules (cdr rules) goal)
                )
        )
)

(defun check-rules (rules-to-check rules-full facts)
    (if (null rules-to-check) nil
                (let ((test (translate-condition (car (car rules-to-check)) facts rules-full)))
                        (if test
                                (progn (setf *exp-path* (cons (car rules-to-check) *exp-path*)) t)
                                (check-rules (cdr rules-to-check) rules-full facts)
                        )
                )
        )
)

(defun translate-condition (con facts rules)
        (if (eql (car con) 'and);       can't apply and -- use (notany #'null arglist)
                (notany #'null (expand-con (cdr con) facts rules))
        (if (eql (car con)  'or);       can't apply or -- use (notevery #'null arglist)
                (notevery #'null (expand-con (cdr con) facts rules))
        (if (eql (car con) 'not)
                (every #'null (expand-con (cdr con) facts rules))
        (if (member (car con) *past-goals*)
                nil
                (prove-r (car con) facts rules); the condition is just a symbol; prove it
    ))))
)

(defun expand-con (args facts rules)
        (if (null args)
                ()
                (if (not (listp (car args)))
                        (cons (translate-condition (cons (car args) nil) facts rules)
                                    (expand-con (cdr args) facts rules));       handle item arg
                        (cons (translate-condition (car args) facts rules)
                                    (expand-con (cdr args) facts rules));       handle list arg
                )
        )
)

