(define (deep-reverse ls) 
    (cond ((null? ls) '())
          ((pair? (car ls)) 
           (cons (deep-reverse (car ls)) (deep-reverse (cdr ls))) )
          (else (append (deep-reverse (cdr ls)) (list (car ls))))
    )
  )
  
> (define x (list (list 1 2) (list 3 4)))
> x
'((1 2) (3 4))

> (deep-reverse x)
'((2 1) (4 3))

> (reverse x)
'((3 4) (1 2))
