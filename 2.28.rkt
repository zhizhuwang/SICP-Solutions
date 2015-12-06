(define (fringe ls)
    (cond ((not (pair? ls)) (list ls))
          ((null? (cdr ls)) (fringe (car ls)))
          (else (append (fringe (car ls)) (fringe (cdr ls)))
           )
          )
  )
  
(define x (list (list 1 2) (list 3 4)))

> (fringe x)
'(1 2 3 4)

> (fringe 1)
'(1)

> (fringe (list x x))
'(1 2 3 4 1 2 3 4)