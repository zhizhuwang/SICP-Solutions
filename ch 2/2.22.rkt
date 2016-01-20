#lang racket

(define (append list1 list2)
    (if (null? list1)
        list2
    (cons (car list1) (append (cdr list1) list2))))

(define (reverse l)
    (if (null? (cdr l)) 
        (list (car l))
        (append (reverse (cdr l)) (list (car l)) )))

(define (square-list-3 items)
    (define (iter things answer)
      (if (null? things)
          (reverse answer) ;reverse here
          (iter (cdr things)
                (cons (square (car things))
                      answer))))
    (iter items '()))
