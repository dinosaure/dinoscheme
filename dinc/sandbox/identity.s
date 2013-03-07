	.file	"identity.ll"
	.text
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
.Ltmp1:
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rax
.Ltmp2:
	.cfi_def_cfa_offset 16
	movl	$6, 4(%rsp)
	movl	$6, %edi
	callq	fa
	popq	%rdx
	ret
.Ltmp3:
	.size	main, .Ltmp3-main
.Ltmp4:
	.cfi_endproc
.Leh_func_end0:

	.globl	fa
	.align	16, 0x90
	.type	fa,@function
fa:                                     # @fa
.Ltmp5:
	.cfi_startproc
# BB#0:                                 # %entry
	leal	5(%rdi), %eax
	ret
.Ltmp6:
	.size	fa, .Ltmp6-fa
.Ltmp7:
	.cfi_endproc
.Leh_func_end1:


	.section	".note.GNU-stack","",@progbits
