(1 3 (5 7) 9)

> (define x (list 1 3 (list 5 7) 9))
> (cdr x)
'(3 (5 7) 9)
> (cddr x)
'((5 7) 9)
> (cdddr x)
'(9)
> (caddr x)
'(5 7)
> (cdaddr x)
'(7)
> (car (cdaddr x))
7



((7))
> (define y (list (list 7)))
> y
'((7))
> (caar y)
7


(1 (2 (3 (4 (5 (6 7))))))