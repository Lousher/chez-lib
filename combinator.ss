
(define identity (lambda (x) x))

(define compose-2
  (lambda (f g)
    (assert (for-all procedure? (list f g)))
    (lambda args
      (
