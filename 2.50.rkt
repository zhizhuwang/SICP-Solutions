(define (flip-horiz painter)
  (let ((split-point (make-vect 0.5 0)))
    (let ((painter-left (transform-painter painter
                    (make-vect (0.5 0))
                    (make-vect (0.5 1))
                    (make-vect (0 0))))
          (painter-right (transform-painter painter
                    (make-vect (0.5 0))
                    (make-vect (1 0))
                    (make-vect (0.5 1)))))
          (lambda (frame)
            (painter-left frame)
            (painter-left frame)))))


(define (rotate-180 painter)
  (let ((new-painter (transform-painter painter
                      (make-vect 1 1)
                      (make-vect 0 1)
                      (make-vect 1 0))))
        (lambda (frame)
          (new-painter frame))))
