(define intersect
  (lambda (s1 s2)
    (cond
     [(null? s1) '()]
     [(member (car s1) s2)
      (cons (car s1) (intersect (cdr s1) s2))]
     [else (intersect (cdr s1) s2)])))

(define intersectall
  (lambda (l-set)
    (cond
     [(null? (cdr l-set)) (car l-set)]
     [else (intersect (car l-set)
		      (intersectall (cdr l-set)))])))
