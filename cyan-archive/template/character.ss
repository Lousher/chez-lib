(define-record-type character
  (fields (mutable $type) (mutable name) (mutable faceId)
    (mutable startingPos) (mutable endingPos) (mutable emoticon)
    (mutable action) (mutable effect) (mutable appear)
    (mutable shapeOverride)))
