(define (deriv exp var)
	(cond ((number? exp) 0)
		  ((variable? exp) (if (same-variable? exp var) 1 0))
		  (else ((get 'deriv (operator exp)) (operands exp)))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

a. The new procedure transforms the deriv into data-directed style.
	We can't assimilate the predictes number? and same-variable? into the data-directed dispatch, because the numbers and variables can not be listed in the table.

b.
(define (install-sum-package)
	;;; internal procedures
	(define (addend s) (car s))

	(define (augend s) (cadr s))

	(define (make-sum x y)
		(cond ((= x 0) y)
			  ((= y 0) x)
			  ((and (number? x) (number? y))
			    (+ x y))
			  (else
			  	(attach-tag '+ x y))))

	;;; interface to the rest of system
	(put 'addend '+ addend)
	(put 'augend '+ augend)
	(put 'make-sum '+ make-sum)

	(put 'deriv '+
		(lambda (exp var)
			(make-sum (deriv (addend exp) var)

'done			          (deriv (augend exp) var))))
)

(define (make-sum x y)
	((get 'make-sum 'x) x y))

(define (addend sum)
	((get 'addend '+) (contents sum)))

(define (augend sum)
	((get 'augend '+) (contents sum)))