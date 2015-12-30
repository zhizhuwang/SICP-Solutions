#lang racket


(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((top-painter (transform-painter painter
                    split-point
                    (make-vect (1.0 0.5))
                    (make-vect (0.0 1.0))))
          (bottom-painter (transform-painter painter
                    (make-vect (0.0 0.0))
                    (make-vect (1.0 0.0))
                    split-point)))
          (lambda (frame)
            (top-painter frame)
            (bottom-painter frame)))))

