(import (chezscheme csv7))
(import (base))
(import (data von))
    
(define record->von
  (lambda (r)
    (unless (record? r)
      (error 'record->json "Not a record" r))
    (let* ([rtd (record-rtd r)]
	   [fields (record-type-field-names rtd)]
	   [field-accessor (lambda (name)
			     ((record-field-accessor rtd name) r))]
	   [vals (map field-accessor fields)])
      (fold-left
       (lambda (vec key val)
	 (if ((any-of von-simple-array? von-simple-value?) val)
	     (vector-append vec (vector (cons key val)))
	     (vector-append vec (vector (cons key (record->von val))))))
       (make-vector 0)
       fields
       vals))))

   
