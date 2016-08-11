> (define f
    (lambda (first-value)
      (begin 
        (set! f (lambda (second-value) 0)))
        first-value))
> (+ (f 0) (f 1))
0



> (define f
    (lambda (first-value)
      (begin 
        (set! f (lambda (second-value) 0)))
        first-value))
> (+ (f 1) (f 0))
1
> 