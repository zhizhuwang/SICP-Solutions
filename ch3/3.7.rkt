> (define (make-account balance password)
    (define (withdraw amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))
    
    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)
    
    (define (dispatch p m)
      (cond ((not (eq? p password)) (error "Incorrect password"))
            ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            (else (error "Unknown request -- MAKE-ACCOUNT"
                         m))))
    
    dispatch)

    
> (define acc (make-account 100 'www))
> ((acc 'qwe 'deposit) 10)
Incorrect password
> ((acc 'www 'deposit) 10)
110
> ((acc 'www 'withdraw) 50)
60



(define (make-joint origin-acc origin-password new-password )
    (lambda (given-password mode)
      (if (eq? given-password new-password)
          (origin-acc origin-password mode)
          (error "Wrong password!")))
    )

> (define new-acc (make-joint acc 'www 'xxx))
> ((new-acc 'xxx 'withdraw) 20)
80

> ((new-acc 'xxxx 'withdraw) 20)
Wrong password!

