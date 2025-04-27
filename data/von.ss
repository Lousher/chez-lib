(library (data von)
  (export
   von-simple-array?
   von-simple-value?
   von-simple-object?)
  
  (import
   (chezscheme)
   (only (base) any-of json-null?))
      
(define von-simple-value?
  (any-of string? number? boolean? json-null?))

(define von-simple-array?
  (lambda (li)
    (and (list? li)
    (for-all von-simple-value? li))))

(define von-simple-object?
  (lambda (von)
    (guard (e [else #f])
    (for-all
     (any-of von-simple-value? von-simple-array?)
     (vector->list (vector-map cdr von))))))
     
)
