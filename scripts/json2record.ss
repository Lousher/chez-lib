#!/usr/local/bin/chez --script
(import (json))
(import (base))
(define-syntax simple-define-mutable-record
  (lambda (stx)
    (syntax-case stx ()
      [(_ name (keys ...))
       #`(define-record-type name
	   (fields
	    #,@(map
		(lambda (stx)
		  #`(mutable #,stx))
		(syntax->list #'(keys ...)))))])))
(define-syntax expand-top-level
  (syntax-rules ()
    [(_ '(stx rest ...))
     (syntax->datum
      ((top-level-syntax 'stx) #'(_ rest ...)))]))
(define json-file->record-file!
  (lambda (json-name)
    (let* ([von (call-with-input-file json-name json-read)]
	   [keys (vector-map (lambda (item) (string->symbol (car item))) von)]
	   [name (filename-name json-name)])
      (call-with-output-file (format "~a.ss" name)
	(lambda (out)
	  (pretty-print
	   (eval `(expand-top-level
		   '(simple-define-mutable-record
		     ,(string->symbol name)
		     ,(vector->list keys))))
	   out))))))
 
(let ([file-names (cdr (command-line))])
  (assert (for-all (lambda (name) (string=? "json" (filename-suffix name))) file-names))
  (for-each json-file->record-file! file-names))
