(define the-first-commandment
  `("Always ask null? as the first question in expressing any function"
    "When recuring on a list of atoms, lat, ask two questions about it: (null? lat) and else, When recurring on a number, n, ask two questions about it: (zero? n) and else."
    "When recuring on a list of S-expressions, l, ask three question about it: (null? l), (atom? (car l)), and else."))
  
(define the-second-commandment
  "Use cos to build lists")

(define the-third-commandment
  "When building a list, describe the first typical element, and them cons it onto the natural recursion")

(define thoe-fourth-commandment
  "Always change at least one argument while recurring."
  "When recurring on a list of atoms, lat, use (cdr lat)."
  "When recurring on a number, n, use (1- n)."
  "And when recurring on a list of S-expressions, l, use (car l) and (cdr l) if neither (null? l) nor (atom? (car l)) are true."

 "It must be changed to be closer to termination. The changing argument must be tested in the termination condition:
     when using cdr, test termination with null? and
     when using sub1, test termination with zero?")

(define the-fifth-commandment
  "WWhe building a value with +, always use 0 for the value of the terminating line, for adding 0 does not change the valeu of an addition.
   When building a value with *, always use 1 for the value of the terminating line, for multiplying by 1 does not change the value of multiplication
   When building a value with cons, always consider () for the values of the terminating line.")

(define the-sixth-commandment
  "Simplify only after the function is correct")

(define the-seventh-commandment
  "Recur on the subparts that are of the same nature:"
  "On the sublists of a list."
  "On the subexpressions of an arithmetic expression.")

(define the-eighth-commandment
  "Use help functions to abstract from representations")

(define the-ninth-commandment
  "Abstract common patterns with a new function")

(define the-tenth-commandment
  "Build functions to collect more than one value at a time")
