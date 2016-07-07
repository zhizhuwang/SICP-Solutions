> (define (make-account balance password)
    (let ((mismatch-count 0)
          (max-tries 7))
      
    (define (withdraw amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))
    
    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)
    
      (define (call-the-cops) "call the cops")
      
    (define (dispatch p m)
      (if (not (eq? p password))
          (lambda (m)
            (if (> (+ mismatch-count 1) max-tries) (call-the-cops)
                (begin (set! mismatch-count (+ mismatch-count 1))
                       "Incorrect password")))
          (begin (set! mismatch-count 0)
                 (cond ((eq? m 'withdraw) withdraw)
                       ((eq? m 'deposit) deposit)
                       (else (error "Unknown request -- MAKE-ACCOUNT" m))))))
      dispatch))
    
> (define acc (make-account 100 'www))
> ((acc 'www 'withdraw )10)
90
> ((acc 'ww 'withdraw )10)
"Incorrect password"
> ((acc 'ww 'withdraw )10)
"Incorrect password"
> ((acc 'ww 'withdraw )10)
"Incorrect password"
> ((acc 'ww 'withdraw )10)
"Incorrect password"
> ((acc 'ww 'withdraw )10)
"Incorrect password"
> ((acc 'ww 'withdraw )10)
"Incorrect password"
> ((acc 'ww 'withdraw )10)
"Incorrect password"
> ((acc 'ww 'withdraw )10)
"call the cops"
