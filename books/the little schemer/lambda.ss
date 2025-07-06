(define multirember&go
  (lambda (a lat col)
    (cond
     [(null? lat)
      (col '() '())]
     [(eq? (car lat) a)
      (multirember&go a (cdr lat)
		      (lambda (new seen)
			(col new
			     (cons (car lat) seen))))]
     [else
      (multirember&go a (cdr lat)
		      (lambda (new seen)
			(col (cons (car lat) new)
			     seen)))])))

(define shift
  (lambda (pair)
    (cons (car (car pair))
	  (cons (cdr (car pair))
		(cdr pair)))))


