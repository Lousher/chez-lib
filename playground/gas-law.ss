;; PV = nRT
(define gas-law-volume
  (lambda (pressure temperature amount)
    (/ (* amount gas-constant temperature) pressure)))

(define gas-constant 8.3144621) ;J/(K*mol)

(define sphere-radius
  (lambda (volume)
    (expt (/ volume (* 4/3 pi)) 1/3)))

(define pi (* 4 (atan 1 1)))


;; unit converter
(define fahrenheit-to-celsius
  (make-unit-conversion (lambda (f) (* 5/9 (- f 32)))
			(lambda (c) (+ (* c 9/5) 32))))

(define celsius-to-kelvin
  (let ([zero-celsius 273.15])
    (make-unit-conversion (lambda (c) (+ c zero-celsius))
			  (lambda (k) (- k zero-celsius)))))

(define INVERT (gensym))
(define unit:invert
  (lambda (conversion)
    (conversion INVERT)))
    
(define make-unit-conversion
  (lambda (seq rev)
    (lambda (input)
      (if (eqv? input INVERT) rev
	  (seq input)))))

;; customize wrapper
