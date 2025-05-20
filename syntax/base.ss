(library
    (syntax base)


  (export
   partial)

  (import
   (chezscheme))
  
  (define-syntax partial
    (lambda (stx)
      (syntax-case stx ()
	[(k parm ...)
	 (let* ([parm-val (syntax->datum #'(parm ...))]
		[%-list (filter (lambda (i) (eqv? '% i)) parm-val)]
		[temp-ids (generate-temporaries %-list)]
		[final-parms (let ([ref -1])
			       (fold-left
				(lambda (lst item)
				  (if (eqv? '% item)
				      (begin
					(set! ref (+ ref 1))
					(append lst (list (list-ref temp-ids ref))))

				      (append lst (list item))))
				'()
				parm-val))])
	   (with-syntax ([(temp-ids ...) (datum->syntax #'k temp-ids)]
			 [% (datum->syntax #'k '%)]
			 [(final-parms ...) (datum->syntax #'k final-parms)])
	     #`(lambda (proc)
		 (assert (procedure? proc))
		 (lambda (temp-ids ...)
		   (apply proc (list final-parms ...))))))
	 ])))

  
  )
