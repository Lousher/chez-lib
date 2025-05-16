(library
    (extension bitwise)

  (export
   bitwise-include?)

  (import
   (chezscheme))

  (define bitwise-include?
    (lambda (exint1 exint2)
      (= exint2 (bitwise-and exint1 exint2))))

  )
