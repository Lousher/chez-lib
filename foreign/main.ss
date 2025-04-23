(library
  (foreign main)

  (export
    ftype-valid?
    param-type-valid?
    res-type-valid?)

  (import
    (only (base) ->boolean)
    (chezscheme))

  (define PARAM_TYPES '("integer-8" "unsigned-8" "integer-16" "unsigned-16"
			"integer-32" "unsigned-32" "integer-64" "unsigned-64"
			"double-float" "single-float" "short" "unsigned-short" "int"
			"unsigned" "unsigned-int" "long" "unsigned-long" "long-long"
			"unsigned-long-long" "ptrdiff_t" "size_t" "ssize_t" "iptr"
			"uptr" "void*" "fixnum" "boolean" "char" "wchar_t" "wchar"
			"double" "float" "scheme-object" "ptr" "u8*" "u16*" "u32*"
			"utf-8" "utf-16le" "utf-16be" "utf-32le" "utf-32be" "string"
			"wstring"))

  (define-syntax ftype-valid?
    (syntax-rules ()
      [(_ name)
       (guard (ex [else #f])
	 (eval '(ftype-sizeof name))
	 #t)]))

  (define-syntax param-type-valid?
    (syntax-rules ()
      [(_ (* ftype)) (ftype-valid? ftype)]
      [(_ (& ftype)) (ftype-valid? ftype)]
      [(_ name) ((->boolean member) (symbol->string 'name) PARAM_TYPES)]))

  (define-syntax res-type-valid?
    (syntax-rules ()
      [(_ name)
       (or (eqv? 'name 'void)
	   (param-type-valid? name))]))

  )
