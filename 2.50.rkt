(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
      (origin-frame frame)
        (add-vect (scale-vect (xcor-vect v)
                              (edge1-frame frame))
                  (scale-vect (ycor-vect v)
                              (esge2-frame frame))))))

(define (transfor-printer painter origin coner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter
            (make-frame new-origin
                        (sub-vect (m corner1) new-origin)
                        (sub-vect (m corner2) new-origin)))))))
                        
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

(define (rotate-270 painter)
  (let ((new-painter (transform-painter painter
                      (make-vect 0 1)
                      (make-vect 0 1)
                      (make-vect 1 1))))
        (lambda (frame)
          (new-painter frame))))
