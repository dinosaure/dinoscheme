	.file	"opcode.ll"
	.text
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
.Ltmp2:
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbx
.Ltmp3:
	.cfi_def_cfa_offset 16
	subq	$16, %rsp
.Ltmp4:
	.cfi_def_cfa_offset 32
.Ltmp5:
	.cfi_offset %rbx, -16
	movl	$4, %edi
	callq	malloc
	movq	%rax, %rbx
	movl	$16, %edi
	callq	malloc
	movq	$fa, (%rax)
	movl	%ebx, 8(%rax)
	movl	%eax, %eax
	movl	8(%rax), %esi
	movl	$42, %edi
	callq	*(%rax)
	movl	%eax, %eax
	movl	8(%rax), %esi
	movl	$21, %edi
	callq	*(%rax)
	addq	$16, %rsp
	popq	%rbx
	ret
.Ltmp6:
	.size	main, .Ltmp6-main
.Ltmp7:
	.cfi_endproc
.Leh_func_end0:

	.globl	fa
	.align	16, 0x90
	.type	fa,@function
fa:                                     # @fa
.Ltmp11:
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%r14
.Ltmp12:
	.cfi_def_cfa_offset 16
	pushq	%rbx
.Ltmp13:
	.cfi_def_cfa_offset 24
	pushq	%rax
.Ltmp14:
	.cfi_def_cfa_offset 32
.Ltmp15:
	.cfi_offset %rbx, -24
.Ltmp16:
	.cfi_offset %r14, -16
	movl	%esi, %ebx
	movl	$8, %edi
	callq	malloc
	movq	%rax, %r14
	movl	$16, %edi
	callq	malloc
	movq	$fb, (%rax)
	movl	%r14d, 8(%rax)
	movl	%ebx, %ecx
	movl	(%rcx), %ecx
	movl	%ecx, 4(%r14)
                                        # kill: EAX<def> EAX<kill> RAX<kill>
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	ret
.Ltmp17:
	.size	fa, .Ltmp17-fa
.Ltmp18:
	.cfi_endproc
.Leh_func_end1:

	.globl	fb
	.align	16, 0x90
	.type	fb,@function
fb:                                     # @fb
.Ltmp19:
	.cfi_startproc
# BB#0:                                 # %entry
	movl	%esi, %eax
	movl	4(%rax), %eax
	ret
.Ltmp20:
	.size	fb, .Ltmp20-fb
.Ltmp21:
	.cfi_endproc
.Leh_func_end2:


	.section	".note.GNU-stack","",@progbits
