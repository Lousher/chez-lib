(define numbered?
  (lambda (aexp)
    (cond
     [(atom? aexp) (number? aexp)]
     [else (and (numbered? (car aexp))
		(numbered? (caddr aexp)))]
     )))

(define value
  (lambda (nexp)
    (cond
     [(atom? nexp) nexp]
     [(eq? (cadr nexp) '+) (+ (value (car nexp))
			      (value (caddr nexp)))]
     [(eq? (cadr nexp) '-) (- (value (car nexp))
			      (value (caddr nexp)))]
     [(eq? (cadr nexp) '*) (* (value (car nexp))
			      (value (caddr nexp)))]
     [(eq? (cadr nexp) '/) (/ (value (car nexp))
			      (value   (caddr nexp)))]
     )))


;; numbers are just representations

(define sero? (lambda (n) (null? n)))
(define edd1 (lambda (n) (cons '() n)))
(define zub1 (lambda (n) (cdr n)))
(define zad (lambda (n m)
	      (cond
	       [(sero? m) n]
	       [else (edd1 (zad n (zub1 m)))])))
