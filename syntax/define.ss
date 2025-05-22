(library
    (syntax define)

  (export
   define-concat)

  (import
   (syntax combinator)
   (chezscheme))

  (meta define-syntax define-concat
    (lambda (stx)
      (syntax-case stx ()
	[(k (id ...) proc)
	 (let* ([comb-ids (syntax->datum #'(id ...))]
		[comb-id (apply (compose string->symbol string-append) (map symbol->string comb-ids))])
	   (with-syntax ([id (datum->syntax #'k comb-id)])
	     #'(define id proc)))])))
  )
