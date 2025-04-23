(define syntax-atom?
  (lambda (stx)
    (syntax-case stx ()
      [() #f]
      [(_ . _) #f]
      [_ #t])))

(define SDL_Identifier?
  (lambda (stx)
    (guard (ex [else #f])
    (and (syntax-atom? stx)
	 (string=? "SDL" (substring (symbol->string (syntax->datum stx)) 0 3))))))

(define SDL3_WIKI_URL "https://wiki.libsdl.org/SDL3")

(define SDL3_WIKI_CategoryAPI_URL (format "~a/~a" SDL3_WIKI_URL "CategoryAPI"))

(define SDL3_WIKI_Syntax_String
  (lambda (name)
    (let* ([url (format "~a/~a" SDL3_WIKI_URL name)]
	   [cmd (format "curl -s \"~a\" | pup '~a' | tr -d '\n\r\t'" url "h2#syntax + div code text{}")])
      (get-string-all (car (process cmd))))))

(define SDL_Expand_Syntax
  (lambda (stx)
    (cond
     [(SDL_Identifier? stx) #`(sdl-find #,stx)]
     [(syntax-atom? stx) stx]
     [else
      (map SDL_Expand_Syntax (syntax->list stx))])))

(define-syntax SDL_Context
  (lambda (stx)
    (syntax-case stx ()
      [(_) #'(void)]
      [(_ exp)
       (SDL_Expand_Syntax #'exp)]
      [(_ exp rest ...)
       #`(begin
	   (SDL_Context exp)
	   (SDL_Context rest ...))])))

