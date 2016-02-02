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
	((get 'make-sum '+) x y))

(define (addend sum)
	((get 'addend '+) (contents sum)))

(define (augend sum)
	((get 'augend '+) (contents sum)))




(define (install-product-package)
	;;; internal procedures
	(define (multiplier p) (car p))

	(define (multiplicand p) (cadr s))

	(define (make-product x y)
		(cond ((or (= x 0) (= y 0)) 0)
			  ((= x 1) y)
			  ((= y 1) x)
			  ((and (number? x) (number? y))
			    (* x y))
			  (else
			  	(attach-tag '* x y))))

	;;; interface to the rest of system
	(put 'multiplier '* multiplier)
	(put 'multiplicand '+ multiplicand)
	(put 'make-product '+ make-product)

	(put 'deriv '*
		(lambda (exp var)
			(make-sum 
				(make-product (multiplier exp)
							  (deriv (multiplicand exp) var))
				(make-product (deriv (multiplier exp) var)
				               (multiplicand exp)))))

'done
)

(define (make-product x y)
	((get 'make-product '*) x y))

(define (multiplier product)
	((get 'multiplier '*) (contents product)))

(define (multiplicand product)
	((get 'multiplicand '*) (contents product)))
	
	
(define (attach-tag type-tag x y)
	(list type-tag x y))

(define (type-tag datumn)
	(car datumn))

(define (contents datumn)
	(cdr datumn))	
	
	
	
