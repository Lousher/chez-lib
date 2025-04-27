(define-record-type ConnectionsTo
  (fields (mutable $type) (mutable $values))
  (protocol
    (lambda (new)
      (lambda ($type $values) (apply new (list $type $values))))))
