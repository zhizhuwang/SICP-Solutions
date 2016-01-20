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
> (define z (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))
> z
'(1 (2 (3 (4 (5 (6 7))))))
> (cdr z)
> (cadr z)
'(2 (3 (4 (5 (6 7)))))
> (cdadr z)
'((3 (4 (5 (6 7)))))
> (cadadr z)
'(3 (4 (5 (6 7))))
> (car (cadadr z))
3
> (cdr (cadadr z))
'((4 (5 (6 7))))
> (cadr (cadadr z))
'(4 (5 (6 7)))
> (cdadr (cadadr z))
'((5 (6 7)))
> (cadadr (cadadr z))
'(5 (6 7))
> (cdr (cadadr (cadadr z)))
'((6 7))
> (cadr (cadadr (cadadr z)))
'(6 7)
> (cdadr (cadadr (cadadr z)))
'(7)
> (cadadr (cadadr (cadadr z)))
7
> 