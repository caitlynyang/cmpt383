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
			((or (not (list? lst)) (not (is-pair? (car lst)))) (error "lst is not an association list"))
			((equal? key (car (car lst))) (cons (car lst) (get-all-pairs key (cdr lst))))
			(else (get-all-pairs key (cdr lst)))
		)
	)
)

(define get-first-pair
	(lambda (key lst)
		(cond
			((equal? '() lst) '())
			((or (not (list? lst)) (not (is-pair? (car lst)))) (error "lst is not an association list"))
			((equal? key (car (car lst))) (car lst))
			(else (get-first-pair key (cdr lst)))
		)
	)
)

(define del-all-pairs
	(lambda (key lst)
		(cond
			((equal? '() lst) '())
			((or (not (list? lst)) (not (is-pair? (car lst)))) (error "lst is not an association list"))
			((equal? key (car (car lst))) (del-all-pairs key (cdr lst)))
			(else (cons (car lst) (del-all-pairs key (cdr lst))))
		)
	)
)

(define del-first-pair
	(lambda (key lst)
		(cond
			((equal? '() lst) '())
			((or (not (list? lst)) (not (is-pair? (car lst)))) (error "lst is not an association list"))
			((equal? key (car (car lst))) (cdr lst))
			(else (cons (car lst) (del-first-pair key (cdr lst))))
		)
	)
)

(define myeval
	(lambda (expr environment)
       		(cond
           		((number? expr)
               			expr)
            		((symbol? expr)
            			(car (cdr (get-first-pair expr environment))))
           		(else
				(let	((left (myeval (car expr) environment))
                   	 		(op (car (cdr expr)))
                   	 		(right (myeval (car (cdr (cdr expr))) environment))
                   	 		)
                   			(cond
                       				((equal? op '+) (+ left right))
                       				((equal? op '-) (- left right))
                       				((equal? op '*) (* left right))
                       				((equal? op '/) (/ left right))
                       				((equal? op '**) (expt left right))
					 	(else (error "invalid expression"))
					)
				)
			)
		)
	)
)
