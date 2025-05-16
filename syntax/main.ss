(library
    (syntax main)
  (export
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
)
	   

