(library
    (extension arity)

  (export
   procedure-arity-predicate

   )

  (import
   (chezscheme))

(define procedure-arity-predicate
  (lambda (f)
    (assert (procedure? f))
    (let ([mask (procedure-arity-mask f)])
      (lambda args
	(assert (for-all integer? args))
	(for-all
	 (lambda (n) (bitwise-bit-set? mask n))
	 args)))))

		

		
)
