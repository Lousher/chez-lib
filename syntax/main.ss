(library
    (syntax main)
  (export
   expand-top-level)

  (import

   (chezscheme))
  
(define-syntax expand-top-level
  (syntax-rules ()
    [(_ '(keyword body ...))
     (syntax->datum
      ((top-level-syntax 'keyword) #'(_ body ...)))]))

(define-syntax all-of
  (syntax-rules ()
    [(_ pred ...)
     (let ([n (proced

)
