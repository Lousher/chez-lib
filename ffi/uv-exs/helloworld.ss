(import (ffi uv))

(define main
  (let ([loop (foreign-alloc (ftype-sizeof uv_loop_t))])
    (uv_loop_init loop)

    (display "Now quitting.\n")
    (uv_run loop UV_RUN_DEFAULT)

    (uv_loop_close loop)
    (foreign-free loop)
    ))
