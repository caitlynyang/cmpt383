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

(define get-all-pairs
	(lambda (key lst)
		(cond
			((equal? '() lst) '())
			((or (not (list? lst)) (not (is-pair? (car lst)))) "lst is not an association list")
			((equal? key (car (car lst))) (cons (car lst) (get-all-pairs key (cdr lst))))
			(else (get-all-pairs key (cdr lst)))
		)
	)
)
