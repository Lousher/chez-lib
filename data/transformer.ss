
(define record->von
  (lambda (r)
    (unless (record? r)
      (error 'record->von "Not a record type"))
    (if (record-simple? r)
	
