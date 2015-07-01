#lang racket

(define (square-list-3 items)
    (define (iter things answer)
      (if (null? things)
          (reverse answer) ;reverse here
          (iter (cdr things)
                (cons (square (car things))
                      answer))))
    (iter items '()))