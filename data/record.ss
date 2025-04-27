
(import (only (base) all-of any-of complement))
(define record-simple-value?
  (any-of
   number? boolean? string?))

(define record-simple-list?
  (lambda (li)
    (all-of list?
	    (lambda (li)
	      (for-all record-simple-value? li)))))
	 
