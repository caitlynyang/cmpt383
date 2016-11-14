(define double-the-cheese
	(lambda (pizza)
		(cond
			((null? pizza)
				'()
			)
			((equal? (car pizza) 'cheese)
				(cons 'cheese (cons 'cheese (double-the-cheese (cdr pizza))))
			)
			(else
				(cons (car pizza) (double-the-cheese (cdr pizza)))
			)
		)
	)
)

(define my-last
	(lambda (lst)
		(cond
			((null? lst)
				(error "empty list")
			)
			((null? (cdr lst))
				(car lst)
			)
			(else
				(my-last (cdr lst))
			)
		)
	)
)

(define deep-sum
	(lambda (lst)
		(cond
			((null? lst)
				0
			)
			((list? (car lst))
				(+ (deep-sum (car lst)) (deep-sum (cdr lst)))
			)
			((number? (car lst))
				(+ (car lst) (deep-sum (cdr lst)))
			)
			(else
				(deep-sum (cdr lst))
			)
		)
	)
)

(define is-bit?
	(lambda (x)
		(or (equal? 1 x) (equal? 0 x))
	)
)

(define is-bit-seq?
	(lambda (lst)
		(or
			(null? lst)
			(and
				(is-bit? (car lst))
				(is-bit-seq? (cdr lst))
			)
		)
	)
)

(define make-bit-seq
	(lambda (val n)
		(cond
			((equal? n 0)
				'()
			)
			(else
				(cons (remainder val 2) (make-bit-seq (floor (/ val 2)) (- n 1)))
			)
		)
	)
)

(define find-bit-seqs
	(lambda (curr max n)
		(cond
			((< n 1)
				'()
			)
			((equal? curr max)
				'()
			)
			(else
				(cons (make-bit-seq curr n) (find-bit-seqs (+ curr 1) max n))
			)
		)
	)
)

(define all-bit-seqs
	(lambda (n)
		(find-bit-seqs 0 (expt 2 n) n)
	)
)

(define range
	(lambda (n)
		(cond
			((< n 1)
				'()
			)
			((equal? n 1)
				'(0)
			)
			(else
				(append (range (- n 1)) (list (- n 1)))
			)
		)
	)
)

(define rec-prime
	(lambda (curr n)
		(cond
			((> (* curr curr) n) #t)
			((equal? 0 (remainder n curr)) #f)
			(else (rec-prime (+ curr 1) n))
		)
	)
)

(define is-prime?
	(lambda (n)
		(or
			(equal? n 2)
			(equal? n 3)
			(equal? n 5)
			(equal? n 7)
			(rec-prime 2 n)
		)
	)
)

(define count-primes
	(lambda (n)
		(cond
			((< n 2)
				0
			)
			((is-prime? n)
				(+ 1 (count-primes (- n 1)))
			)
			(else
				(count-primes (- n 1))
			)
		)
	)
)







