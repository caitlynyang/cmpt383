(define is-pair?
	(lambda (x)
		(and
			(list? x)
			(not (equal? '() (cdr x)))
			(equal? '() (cdr (cdr x)))
		)
	)
)
