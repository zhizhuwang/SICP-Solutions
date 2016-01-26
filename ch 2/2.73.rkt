(define (deriv exp var)
	(cond ((number? exp) 0)
		  ((variable? exp) (if (same-variable? exp var) 1 0))
		  (else ((get 'deriv (operator exp)) (operands exp)))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

a. The new procedure transforms the deriv into data-directed style.
	We can't assimilate the predictes number? and same-variable? into the data-directed dispatch, because the numbers and variables can not be listed in the table.

