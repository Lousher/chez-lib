
(library
    (extension arity)

  (export
   negative-arity->procedure-wrapper
   positive-arity->procedure-wrapper
   procedures-arity-mask
   procedure-arity-restrict
   )

  (import
   (combinator)
   (extension bitwise)
   (chezscheme))

  (define-syntax negative-arity->procedure-wrapper
    (lambda (stx)
      (syntax-case stx ()
	[(k mask)
	 (let* ([mask-num (syntax->datum #'mask)]
		[option-from (bitwise-length (bitwise-not mask-num))]
		[avail-nums (filter ((partial mask-num %) bitwise-bit-set?) (iota option-from))])
	   (with-syntax ([(cases ...) (map (lambda (n)
					     (let ([temp-ids (generate-temporaries (iota n))])
					       (with-syntax ([(temp-ids ...) (datum->syntax #'k temp-ids)])
						 #`[(temp-ids ...) (apply proc (list temp-ids ...))])))
					   avail-nums)]
			 [option-case (let ([ids (generate-temporaries (iota option-from))])
					(with-syntax ([(ids ...) (datum->syntax #'k ids)])
					  #`[(ids ... . rest) (apply proc #,@#'(ids ...) rest)]))])
	     #`(lambda (proc)
		 (case-lambda
		   cases ...
		   option-case))))])))
  
  (define-syntax positive-arity->procedure-wrapper
    (lambda (stx)
      (syntax-case stx ()
	[(k mask)
	 (let* ([mask-num (syntax->datum #'mask)]
		[len (bitwise-length mask-num)]
		[avail-nums (filter ((partial mask-num %) bitwise-bit-set?) (iota len))])
	   (with-syntax ([(cases ...) (map (lambda (n)
					     (let ([temp-ids (generate-temporaries (iota n))])
					       (with-syntax ([(temp-ids ...) (datum->syntax #'k temp-ids)])
						 #`[(temp-ids ...) (apply proc (list temp-ids ...))])))
					   avail-nums)])
	     #`(lambda (proc)
		 (case-lambda
		   cases ...))))])))
  
  (define procedures-arity-mask
    (lambda procs
      (assert (for-all procedure? procs))
      (let ([masks (map procedure-arity-mask procs)])
	(apply bitwise-and masks))))

  (define procedure-arity-restrict
    (lambda (proc n)
      (assert (procedure? proc))
      (assert (fixnum? n))
      (let ([wrapper (if (positive? n)
	  (eval `(positive-arity->procedure-wrapper ,n) (environment '(extension arity)))
	  (eval `(negative-arity->procedure-wrapper ,n) (environment '(extension arity))))])
	(wrapper proc))))

)
