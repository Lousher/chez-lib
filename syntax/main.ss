(library
    (syntax main)
  (export
   values->list
   values-as-list
   all-of
   any-of
   expand-top-level)

  (import
   (extension arity)
   (chezscheme))
  
(define-syntax expand-top-level
  (syntax-rules ()
    [(_ '(keyword body ...))
     (syntax->datum
      ((top-level-syntax 'keyword) #'(_ body ...)))]))

(define-syntax all-of
  (syntax-rules ()
    [(_ pred ...)
     (let ([mask (procedures-arity-mask pred ...)])
       (if (fxzero? mask) (error 'all-of "Predicates not valid")
	   (let ([preds (lambda args (and (apply pred args) ...))])
	     (procedure-arity-restrict preds mask))))]))

(define-syntax any-of
  (syntax-rules ()
    [(_ pred ...)
     (let ([mask (procedures-arity-mask pred ...)])
       (if (fxzero? mask) (error 'any-of "Predicates not valid")
	   (let ([preds (lambda args (or (apply pred args) ...))])
	     (procedure-arity-restrict preds mask))))]))

(define values-as-list
  (lambda (proc)
    (assert (procedure? proc))
    (let ([mask (procedure-arity-mask proc)])
      (let ([comb (lambda args
		    (call-with-values
			(lambda () (apply proc args))
		      (lambda li li)))])
	(procedure-arity-restrict comb mask)))))
 (define-syntax values->list
  (syntax-rules ()
    [(_ exp)
     (call-with-values
	 (lambda () exp)
       (lambda li li))]))
)
	   


