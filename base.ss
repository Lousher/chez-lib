(library
  (base)

  (export
    ->boolean
    list-cartesian-product
    current-continuation
    loose-car
    loose-cdr
    list-join
    string-trim
    string-index
    string-index-back
    string-empty?
    string-unbracket
    string-split
    string-remove
    read-enclosed
    read-till
    read-lines
    read-match
    vector-tail
    vector-head
    list-group
    cycle?
    rgb-str->rgb-nums
    show-color
    )

  (import
    (chezscheme))

  (define ->boolean
    (lambda (f)
      (lambda args
	(if (apply f args) #t #f))))
  
  (define show-color
    (lambda (str)
      (let* ([rgb-nums (rgb-str->rgb-nums str)]
	     [ansi-cmd (apply format "\x1B;[48;2;~a;~a;~am~a\x1B;[0m" (append rgb-nums (list str)))])
	(display ansi-cmd))))

  (define rgb-str->rgb-nums
    (lambda (hexstr)
      (and (char=? #\# (string-ref hexstr 0))
	   (map (lambda (s) (string->number s 16))
		(map list->string
		     (list-group (string->list (substring hexstr 1 7)) 2))))))

  (define to-list
    (lambda (obj)
      (if (list? obj) obj
	(list obj))))

  (define list-cartesian-product
    (case-lambda
      [(l1 l2)
       (let acc ([rest l1] [res '()])
	 (if (null? rest) res
	   (acc (cdr rest)
		(append res (map (lambda (i) (append (to-list (car rest)) (list i))) l2)))))]
      [rest (apply list-cartesian-product (list-cartesian-product (car rest) (cadr rest)) (cddr rest))]))

  (define list-group
    (lambda (lst n)
      (let acc ([rest lst] [res '()])
	(cond
	  [(null? rest) (reverse res)]
	  [(< (length rest) n) (reverse (cons rest res))]
	  [else (acc (list-tail rest n)
		     (cons (list-head rest n) res))]))))

  (define list-join
    (lambda (li item)
      (fold-left
	(lambda (acc next)
	  (append acc (list item) (list next)))
	(list (car li))
	(cdr li))))

  (define read-lines
    (lambda (p)
      (let next-line ([data (get-line p)]
		      [res '()])
	(if (eof-object? data) (reverse res)
	  (next-line
	    (get-line p) 
	    (cons
	      (string-remove data #\return)
	      res))))))

  (define vector-tail
    (lambda (v n)
      (list->vector
	(list-tail
	  (vector->list v) n))))

  (define vector-head
    (lambda (v n)
      (list->vector
	(list-head
	  (vector->list v) n))))

  (define current-continuation
    (lambda ()
      (call/cc (lambda (cc) (cc cc)))))

  (define cycle?
    (lambda (li)
      (if (or (null? li) (null? (cdr li)))
	#f
	(let check ([fast (cddr li)] [slow (cdr li)])
	  (cond 
	    [(or (null? fast) (null? (cdr fast))) #f]
	    [(equal? fast slow) #t]
	    [else (check (cddr li) (cdr li))]
	    )))))

  (define loose-car
    (lambda (p)
      (if (null? p)
	'()
	(car p))))

  (define loose-cdr
    (lambda (p)
      (if (null? p)
	'()
	(cdr p))))


  (define read-match
    (lambda (port str)
      (let consume ([rest (string->list str)])
	(cond
	  [(null? rest) str]
	  [(char=? (car rest) (peek-char port))
	   (begin
	     (read-char port)
	     (consume (cdr rest)))]
	  [else #f]))))

  (define string-trim
    (lambda (str)
      (list->string
	(filter (lambda (ch)
		  (not (char-whitespace? ch)))
		(string->list str)))))

  (define string-index-back
    (lambda (str ch)
      (let ([len (string-length str)])
	(let find ([index (sub1 len)])
	  (cond 
	    [(= -1 index) -1]
	    [(char=? ch (string-ref str index))
	     index]
	    [else (find (sub1 index))])))))

  (define string-index
    (lambda (str ch)
      (let ([len (string-length str)])
	(let find ([index 0])
	  (cond
	    [(= len index) -1]
	    [(char=? ch (string-ref str index)) index]
	    [else (find (+ index 1))])))))


  (define right-bracket
    (lambda (left-bk)
      (cond 
	[(char=? #\( left-bk) #\)]
	[(char=? #\[ left-bk) #\]]
	[(char=? #\{ left-bk) #\}]
	[(char=? #\< left-bk) #\>])))

  (define string-find
    (lambda (str chs)
      (let find ([index 0])
	(let ([res (memv (string-ref str index) chs)])
	  (if res
	    (cons index (car res))
	    (find (+ index 1)))))))

  (define string-back-index
    (lambda (str ch)
      (let ([len (string-length str)])
	(let find ([index (- len 1)])
	  (if (char=? ch (string-ref str index))
	    index
	    (find (- index 1)))))))

  (define find-enclosed-bracket
    (lambda (str)
      (let* ([left (string-find str '(#\( #\[ #\{ #\<))]
	     [right (string-back-index str (right-bracket (cdr left)))])
	(values (car left) right))))

  (define string-unbracket
    (lambda (str layer)
      (if (= 0 layer)
	str
	(let-values
	  ([(left right) (find-enclosed-bracket str)])
	  (string-unbracket
	    (substring str (+ left 1) right)
	    (- layer 1))))))

  (define string-remove
    (lambda (str ch)
      (let ([str-st (string-split str ch)])
	(fold-left
	  (lambda (st str)
	    (string-append st str))
	  ""
	  str-st))))

  (define string-empty?
    (lambda (s)
      (= 0 (string-length s))))

  (define string-split
    (case-lambda 
      [(str ch) (string-split-all str ch)]
      )) 

  (define string-split-all
    (lambda (str ch)
      (let ([len (string-length str)])
	(let collect ([res '()] [from 0] [to 0])
	  (cond
	    [(= len to) 
	     (filter
	       (lambda (s)
		 (not (string-empty? s)))
	       (reverse
		 (cons (substring str from to) res)))]
	    [(char=? ch (string-ref str to))
	     (collect 
	       (cons (substring str from to) res)
	       (+ to 1) (+ to 1))]
	    [else (collect res from (+ to 1))])))))

  (define match?
    (lambda (left right)
      (cond
	[(and (char=? #\{ left) (char=? #\} right)) #t]
	[(and (char=? #\[ left) (char=? #\] right)) #t]
	[(and (char=? #\( left) (char=? #\) right)) #t]
	[(and (char=? #\< left) (char=? #\> right)) #t]
	[else #f]
	)))

  (define read-enclosed
    (lambda (port)
      (let ([left (read-char port)])
	(let collect ([ch (peek-char port)] 
		      [res (list left)]
		      [layer 1])
	  (cond
	    [(eof-object? ch)
	     (list->string (reverse res))]
	    [(and (= layer 1) (match? left ch))
	     (list->string
	       (reverse (cons (read-char port) res)))]
	    [(char=? left ch)
	     (let ([consumed (read-char port)])
	       (collect (peek-char port)
			(cons consumed res)
			(+ layer 1)))]
	    [(match? left ch)
	     (let ([consumed (read-char port)])
	       (collect (peek-char port)
			(cons consumed res)
			(- layer 1)))]
	    [else
	      (let ([consumed (read-char port)])
		(collect (peek-char port)
			 (cons consumed res)
			 layer))]
	    )))))

  (define read-till
    (lambda (port predicate)
      (let collect ([ch (peek-char port)] [res '()])
	(cond 
	  [(eof-object? ch) 
	   (list->string (reverse res))]
	  [(predicate ch) 
	   (list->string (reverse res))]
	  [else (let ([consumed (read-char port)])
		  (collect (peek-char port)
			   (cons consumed res)))]
	  ))))

  ;; not imported yet
  (define lazy
    (lambda (t)
      (let ([val #f] [flag #f])
	(lambda ()
	  (if (not flag)
	    (begin (set! val (t))
		   (set! flag #t)))
	  val))))
  )
