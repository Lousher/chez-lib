;; -*- mode: scheme; coding: utf-8 -*-
;; Copyright (c) 2025 Song Lin
;; SPDX-License-Identifier: MIT
#!r6rs

(library (chez-lib)
  (export hello)
  (import (rnrs))

(define (hello whom)
  (string-append "Hello " whom "!")))
