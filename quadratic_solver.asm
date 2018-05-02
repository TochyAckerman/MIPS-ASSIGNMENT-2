.data
	msg1: .asciiz "Enter a vaule for A:\n"
	msg2: .asciiz "Enter a vaule for B:\n"
	msg3: .asciiz "Enter a vaule for C:\n"
	msg4: .asciiz "Complex Root"
	four: .float 4
	two: .float 2
	answer: .asciiz "The value of x1 is:"
	answer1: .asciiz "\nThe value of x2 is:"


.text
main:
	l.s $f2, four
	l.s $f3, two

	li $v0, 4
	la $a0, msg1
	syscall

	li $v0, 6 #input for A
	syscall
	mov.s $f1, $f0

	li $v0, 4
	la $a0, msg2
	syscall

	li $v0, 6 #input B
	syscall
	mov.s $f4, $f0

	li $v0, 4
	la $a0, msg3
	syscall

	li $v0, 6 #input C
	syscall
	mov.s $f5, $f0

	jal quad_solve

#print answers
	li $v0, 4
	la $a0, answer
	syscall

	li $v0, 2
	mov.s $f12, $f14
	syscall

	li $v0, 4
	la $a0, answer1
	syscall

	li $v0, 2
	mov.s $f12, $f16
	syscall

	li $v0, 10
	syscall


quad_solve:
	mul.s $f6, $f1, $f5 #$f6 = AC
	mul.s $f6, $f6, $f2 #$f6, $f2 = 4AC
	mul.s $f7, $f4, $f4 #$f7 = B^2
	sub.s $f8, $f7, $f6 #$f7, $f6 = B^2 - 4AC
	mfc1 $t0, $f8 #move B - 4AC to $t0
	bltz $t0, complex
	neg.s $f9, $f4 #$f9 will have a negative B (-B)
	sqrt.s $f22, $f8 #sqrt of B^2 - 4AC
	mul.s $f25, $f3, $f1 # 2A
	add.s $f17, $f9, $f22 #-B + sqrt(B^2 - 4AC)
	sub.s $f13, $f9, $f22 #-B - sqrt(B^2 - 4AC)
	div.s $f14, $f17, $f25 #-B + sqrt(B^2 - 4AC)/2A
	div.s $f16, $f13, $f25 #-B - sqrt(B^2 - 4AC)/2A
	jr $ra


complex:
	li $v0, 4
	la $a0, msg4
	syscall





