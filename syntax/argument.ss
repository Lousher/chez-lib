(library
    (syntax argument)

  (export
   argument-permute
   )
  
  (import
   (syntax combinator)
   (extension arity)
   (chezscheme))

  (define argument-permute
    (lambda (mute-f)
      (lambda (f)
	(compose f mute-f))))
 #| (define argument-permute
    (lambda (mute-f)
      (assert (procedure? mute-f))
      (lambda (f)
	(assert (procedure? f))
	(let ([mask (procedure-arity-mask f)])
	  (procedure-arity-restrict
	   (lambda args
	     (apply f (apply mute-f args)))
	   mask))))) |#
  )
   

