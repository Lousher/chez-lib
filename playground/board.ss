(define try-step
  (lambda (piece board direction path)
    (let ([new-coords (coords+ (piece-coords piece) direction)])
      (and (is-position-on-board? new-coords board))
      (case (position-info new-coords board)
	[(unoccupied)
	 (and (not (path-contains-jumps? path))
	      (cons (make-simple-move new-coords piece board) path))]
	[(occupied-by-opponent)
	 (let ([landing (coords+ new-coords direction)])
	   (and (is-position-on-board? landing board)
		(is-position-unoccupied? landing board)
		(cons (make-jump landing new-coords piece board) path)))]
	[(occupied-by-self) #f]
	[else (error "Unknown position info")]))))

(define compute-next-steps
  (lambda (piece board path)
    (filter-map (lambda (direction)
		  (try-step piece board direction path))
		(possible-directions piece))))
