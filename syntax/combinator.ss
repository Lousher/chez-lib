(library
    (syntax combinator)

  (export
   parallel-combine
   iterate
   compose-2
   compose
   complement
   identity
   )

  (import
   (extension arity)
   (syntax base)
   (syntax main)
   (chezscheme))

  (define identity (lambda args (apply values args)))
  
  (define complement
    (lambda (proc)
      (let ([mask (procedure-arity-mask proc)]
	    [func (lambda args (not (apply proc args)))])
	(procedure-arity-restrict func mask))))
  
  (define compose-2
    (lambda (f g)
      (assert (for-all procedure? (list f g)))
      (let ([mask (procedure-arity-mask g)]
	    [comb-proc (lambda args (call-with-values
					(lambda () (apply g args))
				      (lambda consumes
					(unless (procedure-arity-valid? f (length consumes))
					  (error 'compose "Not compatible compose between" f g)) 
					(apply f consumes))))])
	(procedure-arity-restrict comb-proc mask))))
  (define compose
    (lambda procs
      (assert (for-all procedure? procs))
      (fold-right
       (lambda (pre-proc comb-proc)
	 (compose-2 pre-proc comb-proc))
       (car (last-pair procs))
       (list-head procs (- (length procs) 1)))))

  (define iterate
    (lambda (n)
      (assert ((all-of fixnum? positive?) n))
      (lambda (f)
	(assert (procedure? f))
	(if (= n 1) f
	    (compose f ((iterate (- n 1)) f))))))

  (define parallel-combine
    (lambda (comb . procs)
      (assert (procedure-arity-valid? comb (length procs)))
      (let ([mask (apply procedures-arity-mask procs)])
	(assert (not (fxzero? mask)))
	(let ([the-comb (lambda args
		 (apply comb (map ((partial % args) apply) procs)))])
	  (procedure-arity-restrict the-comb mask)))))

  )
      

