
(import (base))
(define (display-syntax)
  (for-each
    (lambda (name)
      (display (SDL3_WIKI_Syntax_String name))
      (newline))
    (list-tail
      (read-lines (open-input-file "SDL3_Functions"))
      SUCCESS)))
