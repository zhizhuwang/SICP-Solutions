(define (make-monitored f)
    (let ((count 0))
      (define (how-many-calls?) count)
      (define (reset-count) (begin (set! count 0) count))
      (define (dispatch m)
        (cond ((eq? m 'how-many-calls?) (how-many-calls?))
              ((eq? m 'reset-count) (reset-count))
              (else (begin
                      (set! count (+ count 1))
                      (f m)))))

      dispatch))
>  (define s (make-monitored sqrt))
> (s 4)
2
> (s 9)
3
> (s 'how-many-calls?)
2
> (s 'reset-count)
0
> (s 'how-many-calls?)
0
> (s 8)
2.8284271247461903
> (s 'how-many-calls?)
1
