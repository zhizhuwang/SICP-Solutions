(define rand
    (let ((status init))
      (lambda (cmd)
        (cond ((eq? 'reset cmd) 
               (lambda (new-status)
                 (begin 
                   (set! status new-status) 
                   new-status)))
              ((eq? 'generate cmd) 
               (begin (set! status (random status)) 
                status))
              (else 
               error "unknown command")))
      ))
> (rand 'generate)
1212853
> (rand 'generate)
633693
> (rand 'generate)
491846
> ((rand 'reset) 12)
12
> (rand 'generate)
8
> (rand 'generate)
2
> (rand 'generate)
1
> 