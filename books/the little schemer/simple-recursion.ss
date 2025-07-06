(define s-expression?
  (lambda (i)
    (or (atom? i)
	(list? i))))

(define list-of-atom?
  (lambda (li)
    (and (list? li)
	 (for-all atom? li))))

(define lat?
  (lambda (li)
    (cond
     [(null? li) #t]
     [(atom? (car li)) (lat? (cdr li))]
     [else #f])))

(define member?
  (lambda (i lat)
    (assert (list-of-atom? lat))
    (cond
     [(null? li) #f]
     [else (or (eq? (car lat) i)
		(member? a (cdr lat)))])))

(define rember-1
  (lambda (a lat)
    (assert (list-of-atom? lat))
    (assert (atom? a))
    (cond
     [(null? lat) '()]
     [else (cond
	    [(eq? (car lat) a) (cdr lat)]
	    [else (cons (car lat) (rember a (cdr lat)))])])))

(define rember
  (lambda (a lat)
    (cond
     [(null? lat) '()]
     [(eq? (car lat) a) (cdr lat)]
     [else (cons (car lat)
		 (rember a (cdr lat)))])))

(define firsts
  (lambda (li)
    (cond
     [(null? li) '()]
     [else (cons (caar li) (firsts (cdr li)))])))

(define insertR
  (lambda (new old lat)
    (cond
     [(null? lat) '()]
     [else (cond
	    [(eq? old (car lat)) (cons old (cons new (cdr lat)))]
	    [else (cons (car lat)
			(insertR new old (cdr lat)))])])))

(define insertL
  (lambda (new old lat)
    (cond
     [(null? lat) '()]
     [(eq? old (car lat))
      (cons new lat)]
     [else (cons (car lat)
		 (insertL new old (cdr lat)))])))

(define subst
  (lambda (new old lat)
    (cond
     [(null? lat) '()]
     [(eq? (car lat) old)
      (cons new (cdr lat))]
     [else (cons (car lat)
		 (subst new old (cdr lat)))])))

(define subst2
  (lambda (new o1 o2 lat)
    (cond
     [(null? lat) '()]
     [(or (eq? (car lat) o1) (eq? (car lat) o2))
      (cons new (cdr lat))]
     [else (cons (car lat)
		 (subst2 new o1 o2 (cdr lat)))])))

(define multirember
  (lambda (a lat)
    (cond
     [(null? lat) '()]
     [(eq? (car lat) a) (multirember a (cdr lat))]
     [else (cons (car lat) (multirember a (cdr lat)))])))

(define multiinsertR
  (lambda (new old lat)
    (cond
     [(null? lat) '()]
     [(eq? (car lat) old)
      (cons old (cons new (multiinsertR new old (cdr lat))))]
     [else (cons (car lat)
		 (multiinsertR new old (cdr lat)))])))

(define multisubst
  (lambda (new old lat)
    (cond
     [(null? lat) '()]
     [(eq? (car lat) old)
      (cons new (multisubst new old (cdr lat)))]
     [else
      (cons (car lat)
	    (multisubst new old (cdr lat)))])))

;; numbers begin
(define o+
  (lambda (n m)
    (cond
     [(zero? m) n]
     [else (1+ (o+ n (1- m)))])))

(define o-
  (lambda (n m)
    (cond
     [(zero? m) n]
     [else (1- (- n (1- m)))])))

(define addtup
  (lambda (tup)
    (cond
     [(null? tup) 0]
     [else (o+ (car tup)
	       (addtup (cdr tup)))])))

(define o*
  (lambda (n m)
    (cond
     [(zero? m) 0]
     [else (o+ n (o* n (1- m)))])))

(define tup+
  (lambda (tup1 tup2)
    (cond
     [(null? tup1) tup2]
     [(null? tup2) tup1]
     [else (cons (o+ (car tup1) (car tup2))
		 (tup+ (cdr tup1) (cdr tup2)))])))

;; condition order matters!
(define >
  (lambda (n m)
    (cond
     [(zero? m) #t] ;; will get wrong result
     [(zero? n) #f]
     [else (> (1- n) (1- m))])))

(define >
  (lambda (n m)
    (cond
     [(zero? n) #f]
     [(zero? m) #t]
     [else (> (1- n) (1- m))])))

(define <
  (lambda (n m)
    (cond
     [(zero? m) #f]
     [(zero? n) #t]
     [else (< (1- n) (1- m))])))

(define expt
  (lambda (n m)
    (cond
     [(zero? m) 1]
     [else (* n (expt n (1- m)))])))

(define length
  (lambda (lat)
    (cond
     [(null? lat) 0]
     [else (1+ (length (cdr lat)))])))

(define pick
  (lambda (n lat)
    (cond
     [(zero? (1- n)) (car lat)]
     [else (pick (1- n) (cdr lat))])))

(define rempick
  (lambda (n lat)
    (cond
     [(zero? (1- n)) (cdr lat)]
     [else (cons (car lat)
		 (rempick (1- n) (cdr lat)))])))

(define no-nums
  (lambda (lat)
    (cond
     [(null? lat) '()]
     [(number? (car lat)) (no-nums (cdr lat))]
     [else (cons (car lat) (no-nums (cdr lat)))])))

(define all-nums
  (lambda (lat)
    (cond
     [(null? lat) '()]
     [(number? (car lat)) (cons (car lat) (all-nums (cdr lat)))]
     [else (all-nums (cdr lat))])))
