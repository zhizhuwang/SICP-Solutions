#lang racket
(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segmetn))))
    segment-list)))

(define top-left (make-vect 0.0 1.0))
(define top-right (make-vect 1.0 1.0))
(define bottom-left (make-vect 0.0 0.0))
(define botton-right (make-vect 1.0 0.0))
(define top (make-segment top-left top-right))
(define left (make-segment top-left bottom-left))
(define right (make-segment top-right bottom-right))
(define bottom (make-segment bottom-left bottom-right))

(segments->painter (list top left right bottom))



(define left-top (make-vect 0.0 1.0))
(define right-bottom (make-vect 1.0 0.0))
(define right-top (make-vect 1.0 1.0))
(define left-bottom (make-vect 0.0 0.0))
(define left-top-to-right-bottom (make-segment left-top
                                                right-bottom))
(define right-top-to-left-bottom (make-segment right-top
                                               left-bottom))

(segments->painter (list left-top-to-right-bottom right-top-to-left-bottom))





