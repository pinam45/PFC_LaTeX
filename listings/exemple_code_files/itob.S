	.text
	.syntax unified
	.global itob
@ void itob(int a, int* tab);
itob:
	push {r4,r5,r6,r7}
	mov r5, #0 @ 0
	mov r6, #1 @ 1
	mov r2, #1 @ binary mask
	mov r3, #124 @ counter (from 31 * 4 to 0)
	itobloop:
		and r4, r0, r2
		cmp r4, #0
		streq r5, [r1,+r3]
		strne r6, [r1,+r3]
		cmp r3, #0
		beq itobendloop
		sub r3, #4
		lsl r2, #1
		b itobloop
	itobendloop:
	pop {r4,r5,r6,r7}
	bx lr
