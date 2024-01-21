
option casemap:none

null equ 0;

.data
	minimalValue qword ?
	maximalValue qword ?
	_length byte ?
.code
externdef rand:proc ; rand c function
externdef srand:proc ; srand c function
externdef time:proc ; time from ctime

public Generate
Generate proc 
	mov qword ptr _length, rcx
	sub rsp, 40 ; required by ABI
	mov rcx, null ; we put function parameter to rcx.
	call time
	call srand
	call rand
	
	; calculating minimal number
	push rax ; we want to save result
	mov rax, 10 ; to calculate minimal number we shall multiply 10 (length-1) times
	mov rbx, qword ptr _length
	sub rbx, 2 ; rbx now length-1
	mov rcx, 0 ; rcx is counter, like i in for cycle
	mov r8, 10 ; we can`t use mul with numbers, so we put number to register

	startLoop:
	
	cmp rcx, rbx 
	je endLoop
	inc rcx
	mul r8
	jmp startLoop
	endLoop:
	; loop end

	mov minimalValue, rax

	;calculating maximal number
	mov rbx, 10
	mul rbx ; now rax is minimalValue * 10
	dec rax ; now we got maximalValue! 
	mov maximalValue, rax

	pop rax ; restored result
	mov rdx, 0
	div maximalValue ; we divided rdx:rax by maximalValue, now remainder of the division
					  ; is in rdx, this value can`t be greater than maximalValue.
	
	; result
	mov rax, rdx
	add rax, minimalValue

	add rsp, 40
	ret
Generate endp
end