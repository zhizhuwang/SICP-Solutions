(define (make-accumulator init)
    (lambda (n)
      (begin
          (set! init (+ n init))
          init)
    ))

(define acc (make-accumulator 5))
> (acc 5)
10
> (acc 5)
15

