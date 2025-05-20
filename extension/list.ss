(library
    (extension list)

  (export
   partition-lengths)

  (import
   (chezscheme))

   (define partition-lengths
     (lambda (lens li)
       (assert (fx<= (apply + lens) (length li)))
       (if (null? lens) '()
	   (cons (list-head li (car lens))
		 (partition-lengths (cdr lens) (list-tail li (car lens)))))))
)
