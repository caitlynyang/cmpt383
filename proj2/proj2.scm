(define pets
       '((cat 1) (dog 1) (fish 1) (cat 2) (fish 2))
)

(define is-pair?
	(lambda (x)
		(and
			(list? x)
			(not (equal? '() (cdr x)))
			(equal? '() (cdr (cdr x)))
		)
	)
)

(define is-alist?
	(lambda (x)
		(or
			(equal? '() x)
			(and
				(list? x)
				(is-pair? (car x))
				(is-alist? (cdr x))
			)
		)
	)
)
