	.file	"Graph.cpp"
	.section .rdata,"dr"
__ZStL19piecewise_construct:
	.space 1
	.section	.text$_ZnwjPv,"x"
	.linkonce discard
	.globl	__ZnwjPv
	.def	__ZnwjPv;	.scl	2;	.type	32;	.endef
__ZnwjPv:
LFB345:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	12(%ebp), %eax
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE345:
	.text
	.def	___gthread_active_p;	.scl	3;	.type	32;	.endef
___gthread_active_p:
LFB977:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	__CRT_MT, %eax
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE977:
	.def	__ZN9__gnu_cxxL18__exchange_and_addEPVii;	.scl	3;	.type	32;	.endef
__ZN9__gnu_cxxL18__exchange_and_addEPVii:
LFB993:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	12(%ebp), %edx
	movl	8(%ebp), %eax
	lock xaddl	%edx, (%eax)
	movl	%edx, %eax
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE993:
	.def	__ZN9__gnu_cxxL25__exchange_and_add_singleEPii;	.scl	3;	.type	32;	.endef
__ZN9__gnu_cxxL25__exchange_and_add_singleEPii:
LFB995:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -4(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	12(%ebp), %eax
	addl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	movl	-4(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE995:
	.def	__ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii;	.scl	3;	.type	32;	.endef
__ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii:
LFB997:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	call	___gthread_active_p
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	L10
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZN9__gnu_cxxL18__exchange_and_addEPVii
	jmp	L11
L10:
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZN9__gnu_cxxL25__exchange_and_add_singleEPii
L11:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE997:
	.section .rdata,"dr"
__ZStL13allocator_arg:
	.space 1
__ZStL6ignore:
	.space 1
	.align 4
__ZN9__gnu_cxxL21__default_lock_policyE:
	.long	2
	.section	.text$_ZNK7Japetus4Node2idEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNK7Japetus4Node2idEv
	.def	__ZNK7Japetus4Node2idEv;	.scl	2;	.type	32;	.endef
__ZNK7Japetus4Node2idEv:
LFB2525:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	36(%eax), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2525:
	.section	.text$_ZNK7Japetus4Node7cost_idEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNK7Japetus4Node7cost_idEv
	.def	__ZNK7Japetus4Node7cost_idEv;	.scl	2;	.type	32;	.endef
__ZNK7Japetus4Node7cost_idEv:
LFB2526:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	40(%eax), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2526:
	.section	.text$_ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EED2Ev,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EED2Ev
	.def	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EED2Ev;	.scl	2;	.type	32;	.endef
__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EED2Ev:
LFB2535:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	addl	$4, %eax
	movl	%eax, %ecx
	call	__ZNSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EED1Ev
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2535:
	.section	.text$_ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EED1Ev,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EED1Ev
	.def	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EED1Ev;	.scl	2;	.type	32;	.endef
__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EED1Ev:
LFB2536:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	addl	$4, %eax
	movl	%eax, %ecx
	call	__ZNSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EED1Ev
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2536:
	.section	.text$_ZNSt10shared_ptrIN7Japetus7FunctorEED1Ev,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt10shared_ptrIN7Japetus7FunctorEED1Ev
	.def	__ZNSt10shared_ptrIN7Japetus7FunctorEED1Ev;	.scl	2;	.type	32;	.endef
__ZNSt10shared_ptrIN7Japetus7FunctorEED1Ev:
LFB2541:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EED2Ev
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2541:
	.section	.text$_ZNK7Japetus4Edge2idEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNK7Japetus4Edge2idEv
	.def	__ZNK7Japetus4Edge2idEv;	.scl	2;	.type	32;	.endef
__ZNK7Japetus4Edge2idEv:
LFB2544:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	8(%eax), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2544:
	.section	.text$_ZN7Japetus4EdgeC1Ev,"x"
	.linkonce discard
	.align 2
	.globl	__ZN7Japetus4EdgeC1Ev
	.def	__ZN7Japetus4EdgeC1Ev;	.scl	2;	.type	32;	.endef
__ZN7Japetus4EdgeC1Ev:
LFB2549:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2549:
	.section	.text$_ZNSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EEC1Ev,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EEC1Ev
	.def	__ZNSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EEC1Ev;	.scl	2;	.type	32;	.endef
__ZNSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EEC1Ev:
LFB2557:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	$0, (%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2557:
	.section	.text$_ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEC2Ev,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEC2Ev
	.def	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEC2Ev;	.scl	2;	.type	32;	.endef
__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEC2Ev:
LFB2558:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	$0, (%eax)
	movl	-12(%ebp), %eax
	addl	$4, %eax
	movl	%eax, %ecx
	call	__ZNSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EEC1Ev
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2558:
	.section	.text$_ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEC1Ev,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEC1Ev
	.def	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEC1Ev;	.scl	2;	.type	32;	.endef
__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEC1Ev:
LFB2559:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	$0, (%eax)
	movl	-12(%ebp), %eax
	addl	$4, %eax
	movl	%eax, %ecx
	call	__ZNSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EEC1Ev
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2559:
	.section	.text$_ZNSt10shared_ptrIN7Japetus7FunctorEEC1Ev,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt10shared_ptrIN7Japetus7FunctorEEC1Ev
	.def	__ZNSt10shared_ptrIN7Japetus7FunctorEEC1Ev;	.scl	2;	.type	32;	.endef
__ZNSt10shared_ptrIN7Japetus7FunctorEEC1Ev:
LFB2561:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEC2Ev
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2561:
	.section	.text$_ZNSt10shared_ptrIN7Japetus7FunctorEEC1EDn,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt10shared_ptrIN7Japetus7FunctorEEC1EDn
	.def	__ZNSt10shared_ptrIN7Japetus7FunctorEEC1EDn;	.scl	2;	.type	32;	.endef
__ZNSt10shared_ptrIN7Japetus7FunctorEEC1EDn:
LFB2563:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNSt10shared_ptrIN7Japetus7FunctorEEC1Ev
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2563:
	.text
	.align 2
	.globl	__ZN7Japetus4NodeC2Ev
	.def	__ZN7Japetus4NodeC2Ev;	.scl	2;	.type	32;	.endef
__ZN7Japetus4NodeC2Ev:
LFB2564:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	addl	$4, %eax
	movl	$0, (%esp)
	movl	%eax, %ecx
	call	__ZNSt10shared_ptrIN7Japetus7FunctorEEC1EDn
	subl	$4, %esp
	movl	-12(%ebp), %eax
	addl	$12, %eax
	movl	%eax, %ecx
	call	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EEC1Ev
	movl	-12(%ebp), %eax
	addl	$24, %eax
	movl	%eax, %ecx
	call	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EEC1Ev
	movl	-12(%ebp), %eax
	movl	$-1, 36(%eax)
	movl	-12(%ebp), %eax
	movl	$-1, 40(%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2564:
	.globl	__ZN7Japetus4NodeC1Ev
	.def	__ZN7Japetus4NodeC1Ev;	.scl	2;	.type	32;	.endef
	.set	__ZN7Japetus4NodeC1Ev,__ZN7Japetus4NodeC2Ev
	.section	.text$_ZSt4moveIRSt10shared_ptrIN7Japetus7FunctorEEEONSt16remove_referenceIT_E4typeEOS6_,"x"
	.linkonce discard
	.globl	__ZSt4moveIRSt10shared_ptrIN7Japetus7FunctorEEEONSt16remove_referenceIT_E4typeEOS6_
	.def	__ZSt4moveIRSt10shared_ptrIN7Japetus7FunctorEEEONSt16remove_referenceIT_E4typeEOS6_;	.scl	2;	.type	32;	.endef
__ZSt4moveIRSt10shared_ptrIN7Japetus7FunctorEEEONSt16remove_referenceIT_E4typeEOS6_:
LFB2567:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2567:
	.text
	.align 2
	.globl	__ZN7Japetus4Node10initializeEiiSt10shared_ptrINS_7FunctorEE
	.def	__ZN7Japetus4Node10initializeEiiSt10shared_ptrINS_7FunctorEE;	.scl	2;	.type	32;	.endef
__ZN7Japetus4Node10initializeEiiSt10shared_ptrINS_7FunctorEE:
LFB2566:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	8(%ebp), %edx
	movl	%edx, 36(%eax)
	movl	-12(%ebp), %eax
	movl	12(%ebp), %edx
	movl	%edx, 40(%eax)
	movl	16(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt4moveIRSt10shared_ptrIN7Japetus7FunctorEEEONSt16remove_referenceIT_E4typeEOS6_
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	addl	$4, %eax
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt10shared_ptrIN7Japetus7FunctorEEaSEOS2_
	subl	$4, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$12
	.cfi_endproc
LFE2566:
	.align 2
	.globl	__ZN7Japetus4Node5clearEv
	.def	__ZN7Japetus4Node5clearEv;	.scl	2;	.type	32;	.endef
__ZN7Japetus4Node5clearEv:
LFB2568:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$56, %esp
	movl	%ecx, -28(%ebp)
	movl	-28(%ebp), %eax
	addl	$12, %eax
	movl	%eax, %ecx
	call	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE5clearEv
	movl	-28(%ebp), %eax
	addl	$24, %eax
	movl	%eax, %ecx
	call	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE5clearEv
	movl	-28(%ebp), %eax
	movl	$-1, 36(%eax)
	movl	-28(%ebp), %eax
	movl	$-1, 40(%eax)
	movl	-28(%ebp), %eax
	addl	$4, %eax
	movl	%eax, %ecx
	call	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EE5resetEv
	leal	-16(%ebp), %eax
	movl	$0, (%esp)
	movl	%eax, %ecx
	call	__ZNSt10shared_ptrIN7Japetus7FunctorEEC1EDn
	subl	$4, %esp
	movl	-28(%ebp), %eax
	leal	4(%eax), %edx
	leal	-16(%ebp), %eax
	movl	%eax, (%esp)
	movl	%edx, %ecx
	call	__ZNSt10shared_ptrIN7Japetus7FunctorEEaSEOS2_
	subl	$4, %esp
	leal	-16(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNSt10shared_ptrIN7Japetus7FunctorEED1Ev
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2568:
	.align 2
	.globl	__ZN7Japetus4Edge5clearEv
	.def	__ZN7Japetus4Edge5clearEv;	.scl	2;	.type	32;	.endef
__ZN7Japetus4Edge5clearEv:
LFB2569:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	$-1, 8(%eax)
	movl	-4(%ebp), %eax
	movl	$0, (%eax)
	movl	-4(%ebp), %eax
	movl	$-1, 12(%eax)
	movl	-4(%ebp), %eax
	movl	$0, 4(%eax)
	movl	-4(%ebp), %eax
	movl	$-1, 16(%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2569:
	.align 2
	.globl	__ZN7Japetus5Graph13allocate_nodeESt10shared_ptrINS_7FunctorEEPKNS_4NodeE
	.def	__ZN7Japetus5Graph13allocate_nodeESt10shared_ptrINS_7FunctorEEPKNS_4NodeE;	.scl	2;	.type	32;	.endef
__ZN7Japetus5Graph13allocate_nodeESt10shared_ptrINS_7FunctorEEPKNS_4NodeE:
LFB2570:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$68, %esp
	.cfi_offset 3, -12
	movl	%ecx, -44(%ebp)
	movl	$0, -28(%ebp)
	movl	-44(%ebp), %eax
	addl	$12, %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE5emptyEv
	testb	%al, %al
	je	L34
	movl	$44, (%esp)
	call	__Znwj
	movl	%eax, %ebx
	movl	%ebx, %ecx
	call	__ZN7Japetus4NodeC1Ev
	movl	%ebx, -28(%ebp)
	jmp	L35
L34:
	movl	-44(%ebp), %eax
	addl	$12, %eax
	movl	%eax, %ecx
	call	__ZNSt6vectorIPN7Japetus4NodeESaIS2_EE4backEv
	movl	(%eax), %eax
	movl	%eax, -28(%ebp)
	movl	-44(%ebp), %eax
	addl	$12, %eax
	movl	%eax, %ecx
	call	__ZNSt6vectorIPN7Japetus4NodeESaIS2_EE8pop_backEv
L35:
	movl	-28(%ebp), %eax
	movl	-44(%ebp), %edx
	movl	%edx, (%eax)
	movl	-44(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE4sizeEv
	movl	%eax, -12(%ebp)
	cmpl	$0, 12(%ebp)
	je	L36
	movl	12(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNK7Japetus4Node7cost_idEv
	jmp	L37
L36:
	movl	-12(%ebp), %eax
L37:
	movl	%eax, -16(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt4moveIRSt10shared_ptrIN7Japetus7FunctorEEEONSt16remove_referenceIT_E4typeEOS6_
	movl	%eax, %edx
	leal	-24(%ebp), %eax
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt10shared_ptrIN7Japetus7FunctorEEC1EOS2_
	subl	$4, %esp
	movl	-28(%ebp), %eax
	leal	-24(%ebp), %edx
	movl	%edx, 8(%esp)
	movl	-16(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	-12(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZN7Japetus4Node10initializeEiiSt10shared_ptrINS_7FunctorEE
	subl	$12, %esp
	leal	-24(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNSt10shared_ptrIN7Japetus7FunctorEED1Ev
	movl	-44(%ebp), %eax
	leal	-28(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt6vectorIPN7Japetus4NodeESaIS2_EE9push_backERKS2_
	subl	$4, %esp
	movl	-28(%ebp), %eax
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret	$8
	.cfi_endproc
LFE2570:
	.align 2
	.globl	__ZN7Japetus5Graph12release_nodeEPNS_4NodeE
	.def	__ZN7Japetus5Graph12release_nodeEPNS_4NodeE;	.scl	2;	.type	32;	.endef
__ZN7Japetus5Graph12release_nodeEPNS_4NodeE:
LFB2571:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNK7Japetus4Node2idEv
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt6vectorIPN7Japetus4NodeESaIS2_EEixEj
	subl	$4, %esp
	movl	$0, (%eax)
	movl	-12(%ebp), %eax
	addl	$12, %eax
	leal	8(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt6vectorIPN7Japetus4NodeESaIS2_EE9push_backERKS2_
	subl	$4, %esp
	movl	8(%ebp), %eax
	movl	%eax, %ecx
	call	__ZN7Japetus4Node5clearEv
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2571:
	.align 2
	.globl	__ZN7Japetus5Graph11remove_nodeEPNS_4NodeE
	.def	__ZN7Japetus5Graph11remove_nodeEPNS_4NodeE;	.scl	2;	.type	32;	.endef
__ZN7Japetus5Graph11remove_nodeEPNS_4NodeE:
LFB2572:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	8(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZN7Japetus5Graph12release_nodeEPNS_4NodeE
	subl	$4, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2572:
	.align 2
	.globl	__ZN7Japetus5Graph13allocate_edgeEPNS_4NodeEiS2_i
	.def	__ZN7Japetus5Graph13allocate_edgeEPNS_4NodeEiS2_i;	.scl	2;	.type	32;	.endef
__ZN7Japetus5Graph13allocate_edgeEPNS_4NodeEiS2_i:
LFB2573:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$52, %esp
	.cfi_offset 3, -12
	movl	%ecx, -28(%ebp)
	movl	$0, -12(%ebp)
	movl	-28(%ebp), %eax
	addl	$36, %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE5emptyEv
	testb	%al, %al
	je	L42
	movl	$20, (%esp)
	call	__Znwj
	movl	%eax, %ebx
	movl	%ebx, %ecx
	call	__ZN7Japetus4EdgeC1Ev
	movl	%ebx, -12(%ebp)
	jmp	L43
L42:
	movl	-28(%ebp), %eax
	addl	$36, %eax
	movl	%eax, %ecx
	call	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE4backEv
	movl	(%eax), %eax
	movl	%eax, -12(%ebp)
	movl	-28(%ebp), %eax
	addl	$36, %eax
	movl	%eax, %ecx
	call	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE8pop_backEv
L43:
	movl	-12(%ebp), %ebx
	movl	-28(%ebp), %eax
	addl	$24, %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE4sizeEv
	movl	%eax, 8(%ebx)
	movl	-12(%ebp), %eax
	movl	8(%ebp), %edx
	movl	%edx, (%eax)
	movl	-12(%ebp), %eax
	movl	12(%ebp), %edx
	movl	%edx, 12(%eax)
	movl	-12(%ebp), %eax
	movl	16(%ebp), %edx
	movl	%edx, 4(%eax)
	movl	-12(%ebp), %eax
	movl	20(%ebp), %edx
	movl	%edx, 16(%eax)
	movl	-28(%ebp), %eax
	leal	24(%eax), %edx
	leal	-12(%ebp), %eax
	movl	%eax, (%esp)
	movl	%edx, %ecx
	call	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE9push_backERKS2_
	subl	$4, %esp
	movl	-12(%ebp), %eax
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret	$16
	.cfi_endproc
LFE2573:
	.align 2
	.globl	__ZN7Japetus5Graph12release_edgeEPNS_4EdgeE
	.def	__ZN7Japetus5Graph12release_edgeEPNS_4EdgeE;	.scl	2;	.type	32;	.endef
__ZN7Japetus5Graph12release_edgeEPNS_4EdgeE:
LFB2574:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNK7Japetus4Edge2idEv
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	addl	$24, %eax
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EEixEj
	subl	$4, %esp
	movl	$0, (%eax)
	movl	-12(%ebp), %eax
	addl	$36, %eax
	leal	8(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE9push_backERKS2_
	subl	$4, %esp
	movl	8(%ebp), %eax
	movl	%eax, %ecx
	call	__ZN7Japetus4Edge5clearEv
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2574:
	.align 2
	.globl	__ZN7Japetus5Graph8add_edgeEPNS_4NodeEiS2_i
	.def	__ZN7Japetus5Graph8add_edgeEPNS_4NodeEiS2_i;	.scl	2;	.type	32;	.endef
__ZN7Japetus5Graph8add_edgeEPNS_4NodeEiS2_i:
LFB2575:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$56, %esp
	movl	%ecx, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	20(%ebp), %edx
	movl	%edx, 12(%esp)
	movl	16(%ebp), %edx
	movl	%edx, 8(%esp)
	movl	12(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	8(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZN7Japetus5Graph13allocate_edgeEPNS_4NodeEiS2_i
	subl	$16, %esp
	movl	%eax, -12(%ebp)
	movl	8(%ebp), %eax
	leal	24(%eax), %edx
	leal	-12(%ebp), %eax
	movl	%eax, (%esp)
	movl	%edx, %ecx
	call	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE9push_backERKS2_
	subl	$4, %esp
	movl	16(%ebp), %eax
	leal	12(%eax), %edx
	leal	-12(%ebp), %eax
	movl	%eax, (%esp)
	movl	%edx, %ecx
	call	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE9push_backERKS2_
	subl	$4, %esp
	movl	-12(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$16
	.cfi_endproc
LFE2575:
	.align 2
	.globl	__ZN7Japetus5Graph11remove_edgeEPNS_4EdgeE
	.def	__ZN7Japetus5Graph11remove_edgeEPNS_4EdgeE;	.scl	2;	.type	32;	.endef
__ZN7Japetus5Graph11remove_edgeEPNS_4EdgeE:
LFB2576:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	8(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZN7Japetus5Graph12release_edgeEPNS_4EdgeE
	subl	$4, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2576:
	.section	.text$_ZNSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EED1Ev,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EED1Ev
	.def	__ZNSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EED1Ev;	.scl	2;	.type	32;	.endef
__ZNSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EED1Ev:
LFB2747:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	je	L51
	movl	-12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, %ecx
	call	__ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
L51:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2747:
	.section	.text$_ZNSt6vectorIPN7Japetus4EdgeESaIS2_EEC1Ev,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EEC1Ev
	.def	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EEC1Ev;	.scl	2;	.type	32;	.endef
__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EEC1Ev:
LFB2750:
	.cfi_startproc
	.cfi_personality 0,___gxx_personality_v0
	.cfi_lsda 0,LLSDA2750
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EEC2Ev
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2750:
	.def	___gxx_personality_v0;	.scl	2;	.type	32;	.endef
	.section	.gcc_except_table,"w"
LLSDA2750:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 LLSDACSE2750-LLSDACSB2750
LLSDACSB2750:
LLSDACSE2750:
	.section	.text$_ZNSt6vectorIPN7Japetus4EdgeESaIS2_EEC1Ev,"x"
	.linkonce discard
	.section	.text$_ZNSt10shared_ptrIN7Japetus7FunctorEEaSEOS2_,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt10shared_ptrIN7Japetus7FunctorEEaSEOS2_
	.def	__ZNSt10shared_ptrIN7Japetus7FunctorEEaSEOS2_;	.scl	2;	.type	32;	.endef
__ZNSt10shared_ptrIN7Japetus7FunctorEEaSEOS2_:
LFB2751:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt4moveIRSt10shared_ptrIN7Japetus7FunctorEEEONSt16remove_referenceIT_E4typeEOS6_
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_
	subl	$4, %esp
	movl	-12(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2751:
	.section	.text$_ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE5clearEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE5clearEv
	.def	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE5clearEv;	.scl	2;	.type	32;	.endef
__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE5clearEv:
LFB2752:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	(%eax), %edx
	movl	-12(%ebp), %eax
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE15_M_erase_at_endEPS2_
	subl	$4, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2752:
	.section	.text$_ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EE5resetEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EE5resetEv
	.def	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EE5resetEv;	.scl	2;	.type	32;	.endef
__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EE5resetEv:
LFB2753:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$56, %esp
	movl	%ecx, -28(%ebp)
	leal	-16(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEC1Ev
	leal	-16(%ebp), %eax
	movl	-28(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_
	subl	$4, %esp
	leal	-16(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EED1Ev
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2753:
	.section	.text$_ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE5emptyEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE5emptyEv
	.def	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE5emptyEv;	.scl	2;	.type	32;	.endef
__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE5emptyEv:
LFB2754:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$56, %esp
	movl	%ecx, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE3endEv
	movl	%eax, -16(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE5beginEv
	movl	%eax, -12(%ebp)
	leal	-16(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZN9__gnu_cxxeqIPKPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEEbRKNS_17__normal_iteratorIT_T0_EESE_
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2754:
	.section	.text$_ZNSt6vectorIPN7Japetus4NodeESaIS2_EE4backEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt6vectorIPN7Japetus4NodeESaIS2_EE4backEv
	.def	__ZNSt6vectorIPN7Japetus4NodeESaIS2_EE4backEv;	.scl	2;	.type	32;	.endef
__ZNSt6vectorIPN7Japetus4NodeESaIS2_EE4backEv:
LFB2755:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$56, %esp
	movl	%ecx, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNSt6vectorIPN7Japetus4NodeESaIS2_EE3endEv
	movl	%eax, -12(%ebp)
	leal	-12(%ebp), %eax
	movl	$1, (%esp)
	movl	%eax, %ecx
	call	__ZNK9__gnu_cxx17__normal_iteratorIPPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEmiEi
	subl	$4, %esp
	movl	%eax, -16(%ebp)
	leal	-16(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNK9__gnu_cxx17__normal_iteratorIPPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEdeEv
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2755:
	.section	.text$_ZNSt6vectorIPN7Japetus4NodeESaIS2_EE8pop_backEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt6vectorIPN7Japetus4NodeESaIS2_EE8pop_backEv
	.def	__ZNSt6vectorIPN7Japetus4NodeESaIS2_EE8pop_backEv;	.scl	2;	.type	32;	.endef
__ZNSt6vectorIPN7Japetus4NodeESaIS2_EE8pop_backEv:
LFB2756:
	.cfi_startproc
	.cfi_personality 0,___gxx_personality_v0
	.cfi_lsda 0,LLSDA2756
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	4(%eax), %eax
	leal	-4(%eax), %edx
	movl	-12(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	-12(%ebp), %eax
	movl	4(%eax), %edx
	movl	-12(%ebp), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	__ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE7destroyIS2_EEvRS3_PT_
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2756:
	.section	.gcc_except_table,"w"
LLSDA2756:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 LLSDACSE2756-LLSDACSB2756
LLSDACSB2756:
LLSDACSE2756:
	.section	.text$_ZNSt6vectorIPN7Japetus4NodeESaIS2_EE8pop_backEv,"x"
	.linkonce discard
	.section	.text$_ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE4sizeEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE4sizeEv
	.def	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE4sizeEv;	.scl	2;	.type	32;	.endef
__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE4sizeEv:
LFB2757:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, %edx
	movl	-4(%ebp), %eax
	movl	(%eax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	sarl	$2, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2757:
	.section	.text$_ZNSt10shared_ptrIN7Japetus7FunctorEEC1EOS2_,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt10shared_ptrIN7Japetus7FunctorEEC1EOS2_
	.def	__ZNSt10shared_ptrIN7Japetus7FunctorEEC1EOS2_;	.scl	2;	.type	32;	.endef
__ZNSt10shared_ptrIN7Japetus7FunctorEEC1EOS2_:
LFB2760:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt4moveIRSt10shared_ptrIN7Japetus7FunctorEEEONSt16remove_referenceIT_E4typeEOS6_
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEC2EOS4_
	subl	$4, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2760:
	.section	.text$_ZNSt6vectorIPN7Japetus4NodeESaIS2_EE9push_backERKS2_,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt6vectorIPN7Japetus4NodeESaIS2_EE9push_backERKS2_
	.def	__ZNSt6vectorIPN7Japetus4NodeESaIS2_EE9push_backERKS2_;	.scl	2;	.type	32;	.endef
__ZNSt6vectorIPN7Japetus4NodeESaIS2_EE9push_backERKS2_:
LFB2761:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	4(%eax), %edx
	movl	-12(%ebp), %eax
	movl	8(%eax), %eax
	cmpl	%eax, %edx
	je	L66
	movl	-12(%ebp), %eax
	movl	4(%eax), %edx
	movl	-12(%ebp), %eax
	movl	8(%ebp), %ecx
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	__ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE9constructIS2_JRKS2_EEEvRS3_PT_DpOT0_
	movl	-12(%ebp), %eax
	movl	4(%eax), %eax
	leal	4(%eax), %edx
	movl	-12(%ebp), %eax
	movl	%edx, 4(%eax)
	jmp	L68
L66:
	movl	-12(%ebp), %eax
	movl	8(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt6vectorIPN7Japetus4NodeESaIS2_EE19_M_emplace_back_auxIJRKS2_EEEvDpOT_
	subl	$4, %esp
L68:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2761:
	.section	.text$_ZNSt6vectorIPN7Japetus4NodeESaIS2_EEixEj,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt6vectorIPN7Japetus4NodeESaIS2_EEixEj
	.def	__ZNSt6vectorIPN7Japetus4NodeESaIS2_EEixEj;	.scl	2;	.type	32;	.endef
__ZNSt6vectorIPN7Japetus4NodeESaIS2_EEixEj:
LFB2762:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	(%eax), %eax
	movl	8(%ebp), %edx
	sall	$2, %edx
	addl	%edx, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2762:
	.section	.text$_ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE5emptyEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE5emptyEv
	.def	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE5emptyEv;	.scl	2;	.type	32;	.endef
__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE5emptyEv:
LFB2763:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$56, %esp
	movl	%ecx, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE3endEv
	movl	%eax, -16(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE5beginEv
	movl	%eax, -12(%ebp)
	leal	-16(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZN9__gnu_cxxeqIPKPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEEbRKNS_17__normal_iteratorIT_T0_EESE_
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2763:
	.section	.text$_ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE4backEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE4backEv
	.def	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE4backEv;	.scl	2;	.type	32;	.endef
__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE4backEv:
LFB2764:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$56, %esp
	movl	%ecx, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE3endEv
	movl	%eax, -12(%ebp)
	leal	-12(%ebp), %eax
	movl	$1, (%esp)
	movl	%eax, %ecx
	call	__ZNK9__gnu_cxx17__normal_iteratorIPPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEmiEi
	subl	$4, %esp
	movl	%eax, -16(%ebp)
	leal	-16(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNK9__gnu_cxx17__normal_iteratorIPPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEdeEv
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2764:
	.section	.text$_ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE8pop_backEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE8pop_backEv
	.def	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE8pop_backEv;	.scl	2;	.type	32;	.endef
__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE8pop_backEv:
LFB2765:
	.cfi_startproc
	.cfi_personality 0,___gxx_personality_v0
	.cfi_lsda 0,LLSDA2765
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	4(%eax), %eax
	leal	-4(%eax), %edx
	movl	-12(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	-12(%ebp), %eax
	movl	4(%eax), %edx
	movl	-12(%ebp), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	__ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE7destroyIS2_EEvRS3_PT_
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2765:
	.section	.gcc_except_table,"w"
LLSDA2765:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 LLSDACSE2765-LLSDACSB2765
LLSDACSB2765:
LLSDACSE2765:
	.section	.text$_ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE8pop_backEv,"x"
	.linkonce discard
	.section	.text$_ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE4sizeEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE4sizeEv
	.def	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE4sizeEv;	.scl	2;	.type	32;	.endef
__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE4sizeEv:
LFB2766:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, %edx
	movl	-4(%ebp), %eax
	movl	(%eax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	sarl	$2, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2766:
	.section	.text$_ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE9push_backERKS2_,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE9push_backERKS2_
	.def	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE9push_backERKS2_;	.scl	2;	.type	32;	.endef
__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE9push_backERKS2_:
LFB2767:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	4(%eax), %edx
	movl	-12(%ebp), %eax
	movl	8(%eax), %eax
	cmpl	%eax, %edx
	je	L79
	movl	-12(%ebp), %eax
	movl	4(%eax), %edx
	movl	-12(%ebp), %eax
	movl	8(%ebp), %ecx
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	__ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE9constructIS2_JRKS2_EEEvRS3_PT_DpOT0_
	movl	-12(%ebp), %eax
	movl	4(%eax), %eax
	leal	4(%eax), %edx
	movl	-12(%ebp), %eax
	movl	%edx, 4(%eax)
	jmp	L81
L79:
	movl	-12(%ebp), %eax
	movl	8(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE19_M_emplace_back_auxIJRKS2_EEEvDpOT_
	subl	$4, %esp
L81:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2767:
	.section	.text$_ZNSt6vectorIPN7Japetus4EdgeESaIS2_EEixEj,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EEixEj
	.def	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EEixEj;	.scl	2;	.type	32;	.endef
__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EEixEj:
LFB2768:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	(%eax), %eax
	movl	8(%ebp), %edx
	sall	$2, %edx
	addl	%edx, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2768:
	.section	.text$_ZNKSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE19_M_get_Tp_allocatorEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNKSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE19_M_get_Tp_allocatorEv
	.def	__ZNKSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE19_M_get_Tp_allocatorEv;	.scl	2;	.type	32;	.endef
__ZNKSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE19_M_get_Tp_allocatorEv:
LFB2833:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	-4(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2833:
	.section	.text$_ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE5beginEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE5beginEv
	.def	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE5beginEv;	.scl	2;	.type	32;	.endef
__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE5beginEv:
LFB2846:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$56, %esp
	movl	%ecx, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -12(%ebp)
	leal	-16(%ebp), %eax
	leal	-12(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZN9__gnu_cxx17__normal_iteratorIPKPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEC1ERKS5_
	subl	$4, %esp
	movl	-16(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2846:
	.section	.text$_ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE3endEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE3endEv
	.def	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE3endEv;	.scl	2;	.type	32;	.endef
__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE3endEv:
LFB2847:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$56, %esp
	movl	%ecx, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -12(%ebp)
	leal	-16(%ebp), %eax
	leal	-12(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZN9__gnu_cxx17__normal_iteratorIPKPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEC1ERKS5_
	subl	$4, %esp
	movl	-16(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2847:
	.section	.text$_ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE19_M_get_Tp_allocatorEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE19_M_get_Tp_allocatorEv
	.def	__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE19_M_get_Tp_allocatorEv;	.scl	2;	.type	32;	.endef
__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE19_M_get_Tp_allocatorEv:
LFB2848:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	-4(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2848:
	.section	.text$_ZSt8_DestroyIPPN7Japetus4EdgeES2_EvT_S4_RSaIT0_E,"x"
	.linkonce discard
	.globl	__ZSt8_DestroyIPPN7Japetus4EdgeES2_EvT_S4_RSaIT0_E
	.def	__ZSt8_DestroyIPPN7Japetus4EdgeES2_EvT_S4_RSaIT0_E;	.scl	2;	.type	32;	.endef
__ZSt8_DestroyIPPN7Japetus4EdgeES2_EvT_S4_RSaIT0_E:
LFB2850:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt8_DestroyIPPN7Japetus4EdgeEEvT_S4_
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2850:
	.section	.text$_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv
	.def	__ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv;	.scl	2;	.type	32;	.endef
__ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv:
LFB2852:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	addl	$4, %eax
	movl	$-1, 4(%esp)
	movl	%eax, (%esp)
	call	__ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii
	cmpl	$1, %eax
	sete	%al
	testb	%al, %al
	je	L95
	movl	-12(%ebp), %eax
	movl	(%eax), %eax
	addl	$8, %eax
	movl	(%eax), %eax
	movl	-12(%ebp), %edx
	movl	%edx, %ecx
	call	*%eax
	movl	-12(%ebp), %eax
	addl	$8, %eax
	movl	$-1, 4(%esp)
	movl	%eax, (%esp)
	call	__ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii
	cmpl	$1, %eax
	sete	%al
	testb	%al, %al
	je	L95
	movl	-12(%ebp), %eax
	movl	(%eax), %eax
	addl	$12, %eax
	movl	(%eax), %eax
	movl	-12(%ebp), %edx
	movl	%edx, %ecx
	call	*%eax
L95:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2852:
	.section	.text$_ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EEC2Ev,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EEC2Ev
	.def	__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EEC2Ev;	.scl	2;	.type	32;	.endef
__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EEC2Ev:
LFB2854:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE12_Vector_implC1Ev
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2854:
	.section	.text$_ZSt4moveIRSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEEONSt16remove_referenceIT_E4typeEOS8_,"x"
	.linkonce discard
	.globl	__ZSt4moveIRSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEEONSt16remove_referenceIT_E4typeEOS8_
	.def	__ZSt4moveIRSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEEONSt16remove_referenceIT_E4typeEOS8_;	.scl	2;	.type	32;	.endef
__ZSt4moveIRSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEEONSt16remove_referenceIT_E4typeEOS8_:
LFB2857:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2857:
	.section	.text$_ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_
	.def	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_;	.scl	2;	.type	32;	.endef
__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEaSEOS4_:
LFB2856:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$56, %esp
	movl	%ecx, -28(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt4moveIRSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEEONSt16remove_referenceIT_E4typeEOS8_
	movl	%eax, %edx
	leal	-16(%ebp), %eax
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEC1EOS4_
	subl	$4, %esp
	leal	-16(%ebp), %eax
	movl	-28(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_
	subl	$4, %esp
	leal	-16(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EED1Ev
	movl	-28(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2856:
	.section	.text$_ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE15_M_erase_at_endEPS2_,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE15_M_erase_at_endEPS2_
	.def	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE15_M_erase_at_endEPS2_;	.scl	2;	.type	32;	.endef
__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE15_M_erase_at_endEPS2_:
LFB2858:
	.cfi_startproc
	.cfi_personality 0,___gxx_personality_v0
	.cfi_lsda 0,LLSDA2858
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE19_M_get_Tp_allocatorEv
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	movl	4(%eax), %eax
	movl	%edx, 8(%esp)
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt8_DestroyIPPN7Japetus4EdgeES2_EvT_S4_RSaIT0_E
	movl	-12(%ebp), %eax
	movl	8(%ebp), %edx
	movl	%edx, 4(%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2858:
	.section	.gcc_except_table,"w"
LLSDA2858:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 LLSDACSE2858-LLSDACSB2858
LLSDACSB2858:
LLSDACSE2858:
	.section	.text$_ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE15_M_erase_at_endEPS2_,"x"
	.linkonce discard
	.section	.text$_ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_
	.def	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_;	.scl	2;	.type	32;	.endef
__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EE4swapERS4_:
LFB2859:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	8(%ebp), %edx
	movl	-12(%ebp), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	__ZSt4swapIPN7Japetus7FunctorEENSt9enable_ifIXsrSt6__and_IJSt21is_move_constructibleIT_ESt18is_move_assignableIS6_EEE5valueEvE4typeERS6_SD_
	movl	8(%ebp), %eax
	leal	4(%eax), %edx
	movl	-12(%ebp), %eax
	addl	$4, %eax
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EE7_M_swapERS2_
	subl	$4, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2859:
	.section	.text$_ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE5beginEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE5beginEv
	.def	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE5beginEv;	.scl	2;	.type	32;	.endef
__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE5beginEv:
LFB2860:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$56, %esp
	movl	%ecx, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -12(%ebp)
	leal	-16(%ebp), %eax
	leal	-12(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZN9__gnu_cxx17__normal_iteratorIPKPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEC1ERKS5_
	subl	$4, %esp
	movl	-16(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2860:
	.section	.text$_ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE3endEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE3endEv
	.def	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE3endEv;	.scl	2;	.type	32;	.endef
__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE3endEv:
LFB2861:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$56, %esp
	movl	%ecx, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -12(%ebp)
	leal	-16(%ebp), %eax
	leal	-12(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZN9__gnu_cxx17__normal_iteratorIPKPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEC1ERKS5_
	subl	$4, %esp
	movl	-16(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2861:
	.section	.text$_ZN9__gnu_cxxeqIPKPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEEbRKNS_17__normal_iteratorIT_T0_EESE_,"x"
	.linkonce discard
	.globl	__ZN9__gnu_cxxeqIPKPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEEbRKNS_17__normal_iteratorIT_T0_EESE_
	.def	__ZN9__gnu_cxxeqIPKPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEEbRKNS_17__normal_iteratorIT_T0_EESE_;	.scl	2;	.type	32;	.endef
__ZN9__gnu_cxxeqIPKPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEEbRKNS_17__normal_iteratorIT_T0_EESE_:
LFB2862:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$4, %esp
	.cfi_offset 3, -12
	movl	8(%ebp), %ecx
	call	__ZNK9__gnu_cxx17__normal_iteratorIPKPN7Japetus4NodeESt6vectorIS3_SaIS3_EEE4baseEv
	movl	(%eax), %ebx
	movl	12(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNK9__gnu_cxx17__normal_iteratorIPKPN7Japetus4NodeESt6vectorIS3_SaIS3_EEE4baseEv
	movl	(%eax), %eax
	cmpl	%eax, %ebx
	sete	%al
	addl	$4, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2862:
	.section	.text$_ZNSt6vectorIPN7Japetus4NodeESaIS2_EE3endEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt6vectorIPN7Japetus4NodeESaIS2_EE3endEv
	.def	__ZNSt6vectorIPN7Japetus4NodeESaIS2_EE3endEv;	.scl	2;	.type	32;	.endef
__ZNSt6vectorIPN7Japetus4NodeESaIS2_EE3endEv:
LFB2863:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$56, %esp
	movl	%ecx, -28(%ebp)
	movl	-28(%ebp), %eax
	leal	4(%eax), %edx
	leal	-12(%ebp), %eax
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZN9__gnu_cxx17__normal_iteratorIPPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEC1ERKS4_
	subl	$4, %esp
	movl	-12(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2863:
	.section	.text$_ZNK9__gnu_cxx17__normal_iteratorIPPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEmiEi,"x"
	.linkonce discard
	.align 2
	.globl	__ZNK9__gnu_cxx17__normal_iteratorIPPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEmiEi
	.def	__ZNK9__gnu_cxx17__normal_iteratorIPPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEmiEi;	.scl	2;	.type	32;	.endef
__ZNK9__gnu_cxx17__normal_iteratorIPPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEmiEi:
LFB2864:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$56, %esp
	movl	%ecx, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	(%eax), %eax
	movl	8(%ebp), %edx
	sall	$2, %edx
	negl	%edx
	addl	%edx, %eax
	movl	%eax, -12(%ebp)
	leal	-16(%ebp), %eax
	leal	-12(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZN9__gnu_cxx17__normal_iteratorIPPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEC1ERKS4_
	subl	$4, %esp
	movl	-16(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2864:
	.section	.text$_ZNK9__gnu_cxx17__normal_iteratorIPPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEdeEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNK9__gnu_cxx17__normal_iteratorIPPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEdeEv
	.def	__ZNK9__gnu_cxx17__normal_iteratorIPPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEdeEv;	.scl	2;	.type	32;	.endef
__ZNK9__gnu_cxx17__normal_iteratorIPPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEdeEv:
LFB2865:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	(%eax), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2865:
	.section	.text$_ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE7destroyIS2_EEvRS3_PT_,"x"
	.linkonce discard
	.globl	__ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE7destroyIS2_EEvRS3_PT_
	.def	__ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE7destroyIS2_EEvRS3_PT_;	.scl	2;	.type	32;	.endef
__ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE7destroyIS2_EEvRS3_PT_:
LFB2866:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	movl	8(%ebp), %ecx
	call	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE7destroyIS3_EEvPT_
	subl	$4, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2866:
	.section	.text$_ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEC2EOS4_,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEC2EOS4_
	.def	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEC2EOS4_;	.scl	2;	.type	32;	.endef
__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEC2EOS4_:
LFB2868:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	-12(%ebp), %eax
	movl	%edx, (%eax)
	movl	-12(%ebp), %eax
	addl	$4, %eax
	movl	%eax, %ecx
	call	__ZNSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EEC1Ev
	movl	8(%ebp), %eax
	leal	4(%eax), %edx
	movl	-12(%ebp), %eax
	addl	$4, %eax
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EE7_M_swapERS2_
	subl	$4, %esp
	movl	8(%ebp), %eax
	movl	$0, (%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2868:
	.section	.text$_ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEC1EOS4_,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEC1EOS4_
	.def	__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEC1EOS4_;	.scl	2;	.type	32;	.endef
__ZNSt12__shared_ptrIN7Japetus7FunctorELN9__gnu_cxx12_Lock_policyE2EEC1EOS4_:
LFB2869:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	-12(%ebp), %eax
	movl	%edx, (%eax)
	movl	-12(%ebp), %eax
	addl	$4, %eax
	movl	%eax, %ecx
	call	__ZNSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EEC1Ev
	movl	8(%ebp), %eax
	leal	4(%eax), %edx
	movl	-12(%ebp), %eax
	addl	$4, %eax
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EE7_M_swapERS2_
	subl	$4, %esp
	movl	8(%ebp), %eax
	movl	$0, (%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2869:
	.section	.text$_ZSt7forwardIRKPN7Japetus4NodeEEOT_RNSt16remove_referenceIS5_E4typeE,"x"
	.linkonce discard
	.globl	__ZSt7forwardIRKPN7Japetus4NodeEEOT_RNSt16remove_referenceIS5_E4typeE
	.def	__ZSt7forwardIRKPN7Japetus4NodeEEOT_RNSt16remove_referenceIS5_E4typeE;	.scl	2;	.type	32;	.endef
__ZSt7forwardIRKPN7Japetus4NodeEEOT_RNSt16remove_referenceIS5_E4typeE:
LFB2871:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2871:
	.section	.text$_ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE9constructIS2_JRKS2_EEEvRS3_PT_DpOT0_,"x"
	.linkonce discard
	.globl	__ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE9constructIS2_JRKS2_EEEvRS3_PT_DpOT0_
	.def	__ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE9constructIS2_JRKS2_EEEvRS3_PT_DpOT0_;	.scl	2;	.type	32;	.endef
__ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE9constructIS2_JRKS2_EEEvRS3_PT_DpOT0_:
LFB2870:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	16(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt7forwardIRKPN7Japetus4NodeEEOT_RNSt16remove_referenceIS5_E4typeE
	movl	%eax, 4(%esp)
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	movl	8(%ebp), %ecx
	call	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE9constructIS3_JRKS3_EEEvPT_DpOT0_
	subl	$8, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2870:
	.section .rdata,"dr"
LC0:
	.ascii "vector::_M_emplace_back_aux\0"
	.section	.text$_ZNSt6vectorIPN7Japetus4NodeESaIS2_EE19_M_emplace_back_auxIJRKS2_EEEvDpOT_,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt6vectorIPN7Japetus4NodeESaIS2_EE19_M_emplace_back_auxIJRKS2_EEEvDpOT_
	.def	__ZNSt6vectorIPN7Japetus4NodeESaIS2_EE19_M_emplace_back_auxIJRKS2_EEEvDpOT_;	.scl	2;	.type	32;	.endef
__ZNSt6vectorIPN7Japetus4NodeESaIS2_EE19_M_emplace_back_auxIJRKS2_EEEvDpOT_:
LFB2872:
	.cfi_startproc
	.cfi_personality 0,___gxx_personality_v0
	.cfi_lsda 0,LLSDA2872
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$52, %esp
	.cfi_offset 3, -12
	movl	%ecx, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	$LC0, 4(%esp)
	movl	$1, (%esp)
	movl	%eax, %ecx
LEHB0:
	call	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE12_M_check_lenEjPKc
	subl	$8, %esp
	movl	%eax, -16(%ebp)
	movl	-28(%ebp), %eax
	movl	-16(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt12_Vector_baseIPN7Japetus4NodeESaIS2_EE11_M_allocateEj
LEHE0:
	subl	$4, %esp
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt7forwardIRKPN7Japetus4NodeEEOT_RNSt16remove_referenceIS5_E4typeE
	movl	%eax, %ebx
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE4sizeEv
	leal	0(,%eax,4), %edx
	movl	-20(%ebp), %eax
	addl	%eax, %edx
	movl	-28(%ebp), %eax
	movl	%ebx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	__ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE9constructIS2_JRKS2_EEEvRS3_PT_DpOT0_
	movl	$0, -12(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNSt12_Vector_baseIPN7Japetus4NodeESaIS2_EE19_M_get_Tp_allocatorEv
	movl	%eax, %ecx
	movl	-28(%ebp), %eax
	movl	4(%eax), %edx
	movl	-28(%ebp), %eax
	movl	(%eax), %eax
	movl	%ecx, 12(%esp)
	movl	-20(%ebp), %ecx
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
LEHB1:
	call	__ZSt34__uninitialized_move_if_noexcept_aIPPN7Japetus4NodeES3_SaIS2_EET0_T_S6_S5_RT1_
LEHE1:
	movl	%eax, -12(%ebp)
	addl	$4, -12(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNSt12_Vector_baseIPN7Japetus4NodeESaIS2_EE19_M_get_Tp_allocatorEv
	movl	%eax, %ecx
	movl	-28(%ebp), %eax
	movl	4(%eax), %edx
	movl	-28(%ebp), %eax
	movl	(%eax), %eax
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
LEHB2:
	call	__ZSt8_DestroyIPPN7Japetus4NodeES2_EvT_S4_RSaIT0_E
	movl	-28(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, %edx
	movl	-28(%ebp), %eax
	movl	(%eax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	sarl	$2, %eax
	movl	%eax, %ecx
	movl	-28(%ebp), %eax
	movl	(%eax), %edx
	movl	-28(%ebp), %eax
	movl	%ecx, 4(%esp)
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt12_Vector_baseIPN7Japetus4NodeESaIS2_EE13_M_deallocateEPS2_j
LEHE2:
	subl	$8, %esp
	movl	-28(%ebp), %eax
	movl	-20(%ebp), %edx
	movl	%edx, (%eax)
	movl	-28(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	%edx, 4(%eax)
	movl	-16(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	-20(%ebp), %eax
	addl	%eax, %edx
	movl	-28(%ebp), %eax
	movl	%edx, 8(%eax)
	jmp	L128
L126:
	movl	%eax, (%esp)
	call	___cxa_begin_catch
	cmpl	$0, -12(%ebp)
	jne	L123
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE4sizeEv
	leal	0(,%eax,4), %edx
	movl	-20(%ebp), %eax
	addl	%eax, %edx
	movl	-28(%ebp), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	__ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE7destroyIS2_EEvRS3_PT_
	jmp	L124
L123:
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNSt12_Vector_baseIPN7Japetus4NodeESaIS2_EE19_M_get_Tp_allocatorEv
	movl	%eax, 8(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-20(%ebp), %eax
	movl	%eax, (%esp)
LEHB3:
	call	__ZSt8_DestroyIPPN7Japetus4NodeES2_EvT_S4_RSaIT0_E
L124:
	movl	-28(%ebp), %eax
	movl	-16(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	-20(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt12_Vector_baseIPN7Japetus4NodeESaIS2_EE13_M_deallocateEPS2_j
	subl	$8, %esp
	call	___cxa_rethrow
LEHE3:
L127:
	movl	%eax, %ebx
	call	___cxa_end_catch
	movl	%ebx, %eax
	movl	%eax, (%esp)
LEHB4:
	call	__Unwind_Resume
LEHE4:
L128:
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2872:
	.section	.gcc_except_table,"w"
	.align 4
LLSDA2872:
	.byte	0xff
	.byte	0
	.uleb128 LLSDATT2872-LLSDATTD2872
LLSDATTD2872:
	.byte	0x1
	.uleb128 LLSDACSE2872-LLSDACSB2872
LLSDACSB2872:
	.uleb128 LEHB0-LFB2872
	.uleb128 LEHE0-LEHB0
	.uleb128 0
	.uleb128 0
	.uleb128 LEHB1-LFB2872
	.uleb128 LEHE1-LEHB1
	.uleb128 L126-LFB2872
	.uleb128 0x1
	.uleb128 LEHB2-LFB2872
	.uleb128 LEHE2-LEHB2
	.uleb128 0
	.uleb128 0
	.uleb128 LEHB3-LFB2872
	.uleb128 LEHE3-LEHB3
	.uleb128 L127-LFB2872
	.uleb128 0
	.uleb128 LEHB4-LFB2872
	.uleb128 LEHE4-LEHB4
	.uleb128 0
	.uleb128 0
LLSDACSE2872:
	.byte	0x1
	.byte	0
	.align 4
	.long	0
LLSDATT2872:
	.section	.text$_ZNSt6vectorIPN7Japetus4NodeESaIS2_EE19_M_emplace_back_auxIJRKS2_EEEvDpOT_,"x"
	.linkonce discard
	.section	.text$_ZN9__gnu_cxxeqIPKPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEEbRKNS_17__normal_iteratorIT_T0_EESE_,"x"
	.linkonce discard
	.globl	__ZN9__gnu_cxxeqIPKPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEEbRKNS_17__normal_iteratorIT_T0_EESE_
	.def	__ZN9__gnu_cxxeqIPKPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEEbRKNS_17__normal_iteratorIT_T0_EESE_;	.scl	2;	.type	32;	.endef
__ZN9__gnu_cxxeqIPKPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEEbRKNS_17__normal_iteratorIT_T0_EESE_:
LFB2873:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$4, %esp
	.cfi_offset 3, -12
	movl	8(%ebp), %ecx
	call	__ZNK9__gnu_cxx17__normal_iteratorIPKPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEE4baseEv
	movl	(%eax), %ebx
	movl	12(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNK9__gnu_cxx17__normal_iteratorIPKPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEE4baseEv
	movl	(%eax), %eax
	cmpl	%eax, %ebx
	sete	%al
	addl	$4, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2873:
	.section	.text$_ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE3endEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE3endEv
	.def	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE3endEv;	.scl	2;	.type	32;	.endef
__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE3endEv:
LFB2874:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$56, %esp
	movl	%ecx, -28(%ebp)
	movl	-28(%ebp), %eax
	leal	4(%eax), %edx
	leal	-12(%ebp), %eax
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZN9__gnu_cxx17__normal_iteratorIPPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEC1ERKS4_
	subl	$4, %esp
	movl	-12(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2874:
	.section	.text$_ZNK9__gnu_cxx17__normal_iteratorIPPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEmiEi,"x"
	.linkonce discard
	.align 2
	.globl	__ZNK9__gnu_cxx17__normal_iteratorIPPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEmiEi
	.def	__ZNK9__gnu_cxx17__normal_iteratorIPPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEmiEi;	.scl	2;	.type	32;	.endef
__ZNK9__gnu_cxx17__normal_iteratorIPPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEmiEi:
LFB2875:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$56, %esp
	movl	%ecx, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	(%eax), %eax
	movl	8(%ebp), %edx
	sall	$2, %edx
	negl	%edx
	addl	%edx, %eax
	movl	%eax, -12(%ebp)
	leal	-16(%ebp), %eax
	leal	-12(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZN9__gnu_cxx17__normal_iteratorIPPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEC1ERKS4_
	subl	$4, %esp
	movl	-16(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2875:
	.section	.text$_ZNK9__gnu_cxx17__normal_iteratorIPPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEdeEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNK9__gnu_cxx17__normal_iteratorIPPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEdeEv
	.def	__ZNK9__gnu_cxx17__normal_iteratorIPPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEdeEv;	.scl	2;	.type	32;	.endef
__ZNK9__gnu_cxx17__normal_iteratorIPPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEdeEv:
LFB2876:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	(%eax), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2876:
	.section	.text$_ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE7destroyIS2_EEvRS3_PT_,"x"
	.linkonce discard
	.globl	__ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE7destroyIS2_EEvRS3_PT_
	.def	__ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE7destroyIS2_EEvRS3_PT_;	.scl	2;	.type	32;	.endef
__ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE7destroyIS2_EEvRS3_PT_:
LFB2877:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	movl	8(%ebp), %ecx
	call	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE7destroyIS3_EEvPT_
	subl	$4, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2877:
	.section	.text$_ZSt7forwardIRKPN7Japetus4EdgeEEOT_RNSt16remove_referenceIS5_E4typeE,"x"
	.linkonce discard
	.globl	__ZSt7forwardIRKPN7Japetus4EdgeEEOT_RNSt16remove_referenceIS5_E4typeE
	.def	__ZSt7forwardIRKPN7Japetus4EdgeEEOT_RNSt16remove_referenceIS5_E4typeE;	.scl	2;	.type	32;	.endef
__ZSt7forwardIRKPN7Japetus4EdgeEEOT_RNSt16remove_referenceIS5_E4typeE:
LFB2879:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2879:
	.section	.text$_ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE9constructIS2_JRKS2_EEEvRS3_PT_DpOT0_,"x"
	.linkonce discard
	.globl	__ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE9constructIS2_JRKS2_EEEvRS3_PT_DpOT0_
	.def	__ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE9constructIS2_JRKS2_EEEvRS3_PT_DpOT0_;	.scl	2;	.type	32;	.endef
__ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE9constructIS2_JRKS2_EEEvRS3_PT_DpOT0_:
LFB2878:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	16(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt7forwardIRKPN7Japetus4EdgeEEOT_RNSt16remove_referenceIS5_E4typeE
	movl	%eax, 4(%esp)
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	movl	8(%ebp), %ecx
	call	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE9constructIS3_JRKS3_EEEvPT_DpOT0_
	subl	$8, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2878:
	.section	.text$_ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE19_M_emplace_back_auxIJRKS2_EEEvDpOT_,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE19_M_emplace_back_auxIJRKS2_EEEvDpOT_
	.def	__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE19_M_emplace_back_auxIJRKS2_EEEvDpOT_;	.scl	2;	.type	32;	.endef
__ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE19_M_emplace_back_auxIJRKS2_EEEvDpOT_:
LFB2880:
	.cfi_startproc
	.cfi_personality 0,___gxx_personality_v0
	.cfi_lsda 0,LLSDA2880
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$52, %esp
	.cfi_offset 3, -12
	movl	%ecx, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	$LC0, 4(%esp)
	movl	$1, (%esp)
	movl	%eax, %ecx
LEHB5:
	call	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE12_M_check_lenEjPKc
	subl	$8, %esp
	movl	%eax, -16(%ebp)
	movl	-28(%ebp), %eax
	movl	-16(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE11_M_allocateEj
LEHE5:
	subl	$4, %esp
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt7forwardIRKPN7Japetus4EdgeEEOT_RNSt16remove_referenceIS5_E4typeE
	movl	%eax, %ebx
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE4sizeEv
	leal	0(,%eax,4), %edx
	movl	-20(%ebp), %eax
	addl	%eax, %edx
	movl	-28(%ebp), %eax
	movl	%ebx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	__ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE9constructIS2_JRKS2_EEEvRS3_PT_DpOT0_
	movl	$0, -12(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE19_M_get_Tp_allocatorEv
	movl	%eax, %ecx
	movl	-28(%ebp), %eax
	movl	4(%eax), %edx
	movl	-28(%ebp), %eax
	movl	(%eax), %eax
	movl	%ecx, 12(%esp)
	movl	-20(%ebp), %ecx
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
LEHB6:
	call	__ZSt34__uninitialized_move_if_noexcept_aIPPN7Japetus4EdgeES3_SaIS2_EET0_T_S6_S5_RT1_
LEHE6:
	movl	%eax, -12(%ebp)
	addl	$4, -12(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE19_M_get_Tp_allocatorEv
	movl	%eax, %ecx
	movl	-28(%ebp), %eax
	movl	4(%eax), %edx
	movl	-28(%ebp), %eax
	movl	(%eax), %eax
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
LEHB7:
	call	__ZSt8_DestroyIPPN7Japetus4EdgeES2_EvT_S4_RSaIT0_E
	movl	-28(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, %edx
	movl	-28(%ebp), %eax
	movl	(%eax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	sarl	$2, %eax
	movl	%eax, %ecx
	movl	-28(%ebp), %eax
	movl	(%eax), %edx
	movl	-28(%ebp), %eax
	movl	%ecx, 4(%esp)
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE13_M_deallocateEPS2_j
LEHE7:
	subl	$8, %esp
	movl	-28(%ebp), %eax
	movl	-20(%ebp), %edx
	movl	%edx, (%eax)
	movl	-28(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	%edx, 4(%eax)
	movl	-16(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	-20(%ebp), %eax
	addl	%eax, %edx
	movl	-28(%ebp), %eax
	movl	%edx, 8(%eax)
	jmp	L148
L146:
	movl	%eax, (%esp)
	call	___cxa_begin_catch
	cmpl	$0, -12(%ebp)
	jne	L143
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE4sizeEv
	leal	0(,%eax,4), %edx
	movl	-20(%ebp), %eax
	addl	%eax, %edx
	movl	-28(%ebp), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	__ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE7destroyIS2_EEvRS3_PT_
	jmp	L144
L143:
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE19_M_get_Tp_allocatorEv
	movl	%eax, 8(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-20(%ebp), %eax
	movl	%eax, (%esp)
LEHB8:
	call	__ZSt8_DestroyIPPN7Japetus4EdgeES2_EvT_S4_RSaIT0_E
L144:
	movl	-28(%ebp), %eax
	movl	-16(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	-20(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE13_M_deallocateEPS2_j
	subl	$8, %esp
	call	___cxa_rethrow
LEHE8:
L147:
	movl	%eax, %ebx
	call	___cxa_end_catch
	movl	%ebx, %eax
	movl	%eax, (%esp)
LEHB9:
	call	__Unwind_Resume
LEHE9:
L148:
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2880:
	.section	.gcc_except_table,"w"
	.align 4
LLSDA2880:
	.byte	0xff
	.byte	0
	.uleb128 LLSDATT2880-LLSDATTD2880
LLSDATTD2880:
	.byte	0x1
	.uleb128 LLSDACSE2880-LLSDACSB2880
LLSDACSB2880:
	.uleb128 LEHB5-LFB2880
	.uleb128 LEHE5-LEHB5
	.uleb128 0
	.uleb128 0
	.uleb128 LEHB6-LFB2880
	.uleb128 LEHE6-LEHB6
	.uleb128 L146-LFB2880
	.uleb128 0x1
	.uleb128 LEHB7-LFB2880
	.uleb128 LEHE7-LEHB7
	.uleb128 0
	.uleb128 0
	.uleb128 LEHB8-LFB2880
	.uleb128 LEHE8-LEHB8
	.uleb128 L147-LFB2880
	.uleb128 0
	.uleb128 LEHB9-LFB2880
	.uleb128 LEHE9-LEHB9
	.uleb128 0
	.uleb128 0
LLSDACSE2880:
	.byte	0x1
	.byte	0
	.align 4
	.long	0
LLSDATT2880:
	.section	.text$_ZNSt6vectorIPN7Japetus4EdgeESaIS2_EE19_M_emplace_back_auxIJRKS2_EEEvDpOT_,"x"
	.linkonce discard
	.section	.text$_ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE13_M_deallocateEPS2_j,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE13_M_deallocateEPS2_j
	.def	__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE13_M_deallocateEPS2_j;	.scl	2;	.type	32;	.endef
__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE13_M_deallocateEPS2_j:
LFB2957:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	cmpl	$0, 8(%ebp)
	je	L151
	movl	-12(%ebp), %eax
	movl	12(%ebp), %edx
	movl	%edx, 8(%esp)
	movl	8(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	__ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE10deallocateERS3_PS2_j
L151:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$8
	.cfi_endproc
LFE2957:
	.section	.text$_ZN9__gnu_cxx17__normal_iteratorIPKPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEC1ERKS5_,"x"
	.linkonce discard
	.align 2
	.globl	__ZN9__gnu_cxx17__normal_iteratorIPKPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEC1ERKS5_
	.def	__ZN9__gnu_cxx17__normal_iteratorIPKPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEC1ERKS5_;	.scl	2;	.type	32;	.endef
__ZN9__gnu_cxx17__normal_iteratorIPKPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEC1ERKS5_:
LFB2960:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	-4(%ebp), %eax
	movl	%edx, (%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2960:
	.section	.text$_ZSt8_DestroyIPPN7Japetus4EdgeEEvT_S4_,"x"
	.linkonce discard
	.globl	__ZSt8_DestroyIPPN7Japetus4EdgeEEvT_S4_
	.def	__ZSt8_DestroyIPPN7Japetus4EdgeEEvT_S4_;	.scl	2;	.type	32;	.endef
__ZSt8_DestroyIPPN7Japetus4EdgeEEvT_S4_:
LFB2962:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZNSt12_Destroy_auxILb1EE9__destroyIPPN7Japetus4EdgeEEEvT_S6_
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2962:
	.section	.text$_ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE12_Vector_implC1Ev,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE12_Vector_implC1Ev
	.def	__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE12_Vector_implC1Ev;	.scl	2;	.type	32;	.endef
__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE12_Vector_implC1Ev:
LFB2966:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNSaIPN7Japetus4EdgeEEC2Ev
	movl	-12(%ebp), %eax
	movl	$0, (%eax)
	movl	-12(%ebp), %eax
	movl	$0, 4(%eax)
	movl	-12(%ebp), %eax
	movl	$0, 8(%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2966:
	.section	.text$_ZSt4moveIRPN7Japetus7FunctorEEONSt16remove_referenceIT_E4typeEOS5_,"x"
	.linkonce discard
	.globl	__ZSt4moveIRPN7Japetus7FunctorEEONSt16remove_referenceIT_E4typeEOS5_
	.def	__ZSt4moveIRPN7Japetus7FunctorEEONSt16remove_referenceIT_E4typeEOS5_;	.scl	2;	.type	32;	.endef
__ZSt4moveIRPN7Japetus7FunctorEEONSt16remove_referenceIT_E4typeEOS5_:
LFB2968:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2968:
	.section	.text$_ZSt4swapIPN7Japetus7FunctorEENSt9enable_ifIXsrSt6__and_IJSt21is_move_constructibleIT_ESt18is_move_assignableIS6_EEE5valueEvE4typeERS6_SD_,"x"
	.linkonce discard
	.globl	__ZSt4swapIPN7Japetus7FunctorEENSt9enable_ifIXsrSt6__and_IJSt21is_move_constructibleIT_ESt18is_move_assignableIS6_EEE5valueEvE4typeERS6_SD_
	.def	__ZSt4swapIPN7Japetus7FunctorEENSt9enable_ifIXsrSt6__and_IJSt21is_move_constructibleIT_ESt18is_move_assignableIS6_EEE5valueEvE4typeERS6_SD_;	.scl	2;	.type	32;	.endef
__ZSt4swapIPN7Japetus7FunctorEENSt9enable_ifIXsrSt6__and_IJSt21is_move_constructibleIT_ESt18is_move_assignableIS6_EEE5valueEvE4typeERS6_SD_:
LFB2967:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt4moveIRPN7Japetus7FunctorEEONSt16remove_referenceIT_E4typeEOS5_
	movl	(%eax), %eax
	movl	%eax, -12(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt4moveIRPN7Japetus7FunctorEEONSt16remove_referenceIT_E4typeEOS5_
	movl	(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	leal	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt4moveIRPN7Japetus7FunctorEEONSt16remove_referenceIT_E4typeEOS5_
	movl	(%eax), %edx
	movl	12(%ebp), %eax
	movl	%edx, (%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2967:
	.section	.text$_ZNSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EE7_M_swapERS2_,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EE7_M_swapERS2_
	.def	__ZNSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EE7_M_swapERS2_;	.scl	2;	.type	32;	.endef
__ZNSt14__shared_countILN9__gnu_cxx12_Lock_policyE2EE7_M_swapERS2_:
LFB2969:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$20, %esp
	movl	%ecx, -20(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -4(%ebp)
	movl	-20(%ebp), %eax
	movl	(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	movl	-20(%ebp), %eax
	movl	-4(%ebp), %edx
	movl	%edx, (%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2969:
	.section	.text$_ZN9__gnu_cxx17__normal_iteratorIPKPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEC1ERKS5_,"x"
	.linkonce discard
	.align 2
	.globl	__ZN9__gnu_cxx17__normal_iteratorIPKPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEC1ERKS5_
	.def	__ZN9__gnu_cxx17__normal_iteratorIPKPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEC1ERKS5_;	.scl	2;	.type	32;	.endef
__ZN9__gnu_cxx17__normal_iteratorIPKPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEC1ERKS5_:
LFB2972:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	-4(%ebp), %eax
	movl	%edx, (%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2972:
	.section	.text$_ZNK9__gnu_cxx17__normal_iteratorIPKPN7Japetus4NodeESt6vectorIS3_SaIS3_EEE4baseEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNK9__gnu_cxx17__normal_iteratorIPKPN7Japetus4NodeESt6vectorIS3_SaIS3_EEE4baseEv
	.def	__ZNK9__gnu_cxx17__normal_iteratorIPKPN7Japetus4NodeESt6vectorIS3_SaIS3_EEE4baseEv;	.scl	2;	.type	32;	.endef
__ZNK9__gnu_cxx17__normal_iteratorIPKPN7Japetus4NodeESt6vectorIS3_SaIS3_EEE4baseEv:
LFB2973:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	-4(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2973:
	.section	.text$_ZN9__gnu_cxx17__normal_iteratorIPPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEC1ERKS4_,"x"
	.linkonce discard
	.align 2
	.globl	__ZN9__gnu_cxx17__normal_iteratorIPPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEC1ERKS4_
	.def	__ZN9__gnu_cxx17__normal_iteratorIPPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEC1ERKS4_;	.scl	2;	.type	32;	.endef
__ZN9__gnu_cxx17__normal_iteratorIPPN7Japetus4NodeESt6vectorIS3_SaIS3_EEEC1ERKS4_:
LFB2976:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	-4(%ebp), %eax
	movl	%edx, (%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2976:
	.section	.text$_ZN9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE7destroyIS3_EEvPT_,"x"
	.linkonce discard
	.align 2
	.globl	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE7destroyIS3_EEvPT_
	.def	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE7destroyIS3_EEvPT_;	.scl	2;	.type	32;	.endef
__ZN9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE7destroyIS3_EEvPT_:
LFB2977:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2977:
	.section	.text$_ZN9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE9constructIS3_JRKS3_EEEvPT_DpOT0_,"x"
	.linkonce discard
	.align 2
	.globl	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE9constructIS3_JRKS3_EEEvPT_DpOT0_
	.def	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE9constructIS3_JRKS3_EEEvPT_DpOT0_;	.scl	2;	.type	32;	.endef
__ZN9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE9constructIS3_JRKS3_EEEvPT_DpOT0_:
LFB2978:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$36, %esp
	.cfi_offset 3, -12
	movl	%ecx, -12(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt7forwardIRKPN7Japetus4NodeEEOT_RNSt16remove_referenceIS5_E4typeE
	movl	(%eax), %ebx
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$4, (%esp)
	call	__ZnwjPv
	testl	%eax, %eax
	je	L167
	movl	%ebx, (%eax)
L167:
	nop
	addl	$36, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$8
	.cfi_endproc
LFE2978:
	.section	.text$_ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE12_M_check_lenEjPKc,"x"
	.linkonce discard
	.align 2
	.globl	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE12_M_check_lenEjPKc
	.def	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE12_M_check_lenEjPKc;	.scl	2;	.type	32;	.endef
__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE12_M_check_lenEjPKc:
LFB2979:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$52, %esp
	.cfi_offset 3, -12
	movl	%ecx, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE8max_sizeEv
	movl	%eax, %ebx
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE4sizeEv
	movl	%ebx, %edx
	subl	%eax, %edx
	movl	8(%ebp), %eax
	cmpl	%eax, %edx
	setb	%al
	testb	%al, %al
	je	L169
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt20__throw_length_errorPKc
L169:
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE4sizeEv
	movl	%eax, %ebx
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE4sizeEv
	movl	%eax, -16(%ebp)
	leal	8(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-16(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt3maxIjERKT_S2_S2_
	movl	(%eax), %eax
	addl	%ebx, %eax
	movl	%eax, -12(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE4sizeEv
	cmpl	-12(%ebp), %eax
	ja	L170
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE8max_sizeEv
	cmpl	-12(%ebp), %eax
	jnb	L171
L170:
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE8max_sizeEv
	jmp	L172
L171:
	movl	-12(%ebp), %eax
L172:
	addl	$52, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$8
	.cfi_endproc
LFE2979:
	.section	.text$_ZNSt12_Vector_baseIPN7Japetus4NodeESaIS2_EE11_M_allocateEj,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt12_Vector_baseIPN7Japetus4NodeESaIS2_EE11_M_allocateEj
	.def	__ZNSt12_Vector_baseIPN7Japetus4NodeESaIS2_EE11_M_allocateEj;	.scl	2;	.type	32;	.endef
__ZNSt12_Vector_baseIPN7Japetus4NodeESaIS2_EE11_M_allocateEj:
LFB2980:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	cmpl	$0, 8(%ebp)
	je	L175
	movl	-12(%ebp), %eax
	movl	8(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	__ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE8allocateERS3_j
	jmp	L177
L175:
	movl	$0, %eax
L177:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2980:
	.section	.text$_ZNSt12_Vector_baseIPN7Japetus4NodeESaIS2_EE19_M_get_Tp_allocatorEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt12_Vector_baseIPN7Japetus4NodeESaIS2_EE19_M_get_Tp_allocatorEv
	.def	__ZNSt12_Vector_baseIPN7Japetus4NodeESaIS2_EE19_M_get_Tp_allocatorEv;	.scl	2;	.type	32;	.endef
__ZNSt12_Vector_baseIPN7Japetus4NodeESaIS2_EE19_M_get_Tp_allocatorEv:
LFB2981:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	-4(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2981:
	.section	.text$_ZSt34__uninitialized_move_if_noexcept_aIPPN7Japetus4NodeES3_SaIS2_EET0_T_S6_S5_RT1_,"x"
	.linkonce discard
	.globl	__ZSt34__uninitialized_move_if_noexcept_aIPPN7Japetus4NodeES3_SaIS2_EET0_T_S6_S5_RT1_
	.def	__ZSt34__uninitialized_move_if_noexcept_aIPPN7Japetus4NodeES3_SaIS2_EET0_T_S6_S5_RT1_;	.scl	2;	.type	32;	.endef
__ZSt34__uninitialized_move_if_noexcept_aIPPN7Japetus4NodeES3_SaIS2_EET0_T_S6_S5_RT1_:
LFB2982:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$20, %esp
	.cfi_offset 3, -12
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt32__make_move_if_noexcept_iteratorIPN7Japetus4NodeESt13move_iteratorIPS2_EET0_PT_
	movl	%eax, %ebx
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt32__make_move_if_noexcept_iteratorIPN7Japetus4NodeESt13move_iteratorIPS2_EET0_PT_
	movl	%eax, %edx
	movl	20(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	%ebx, 4(%esp)
	movl	%edx, (%esp)
	call	__ZSt22__uninitialized_copy_aISt13move_iteratorIPPN7Japetus4NodeEES4_S3_ET0_T_S7_S6_RSaIT1_E
	addl	$20, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2982:
	.section	.text$_ZSt8_DestroyIPPN7Japetus4NodeES2_EvT_S4_RSaIT0_E,"x"
	.linkonce discard
	.globl	__ZSt8_DestroyIPPN7Japetus4NodeES2_EvT_S4_RSaIT0_E
	.def	__ZSt8_DestroyIPPN7Japetus4NodeES2_EvT_S4_RSaIT0_E;	.scl	2;	.type	32;	.endef
__ZSt8_DestroyIPPN7Japetus4NodeES2_EvT_S4_RSaIT0_E:
LFB2983:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt8_DestroyIPPN7Japetus4NodeEEvT_S4_
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2983:
	.section	.text$_ZNSt12_Vector_baseIPN7Japetus4NodeESaIS2_EE13_M_deallocateEPS2_j,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt12_Vector_baseIPN7Japetus4NodeESaIS2_EE13_M_deallocateEPS2_j
	.def	__ZNSt12_Vector_baseIPN7Japetus4NodeESaIS2_EE13_M_deallocateEPS2_j;	.scl	2;	.type	32;	.endef
__ZNSt12_Vector_baseIPN7Japetus4NodeESaIS2_EE13_M_deallocateEPS2_j:
LFB2984:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	cmpl	$0, 8(%ebp)
	je	L185
	movl	-12(%ebp), %eax
	movl	12(%ebp), %edx
	movl	%edx, 8(%esp)
	movl	8(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	__ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE10deallocateERS3_PS2_j
L185:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$8
	.cfi_endproc
LFE2984:
	.section	.text$_ZNK9__gnu_cxx17__normal_iteratorIPKPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEE4baseEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNK9__gnu_cxx17__normal_iteratorIPKPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEE4baseEv
	.def	__ZNK9__gnu_cxx17__normal_iteratorIPKPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEE4baseEv;	.scl	2;	.type	32;	.endef
__ZNK9__gnu_cxx17__normal_iteratorIPKPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEE4baseEv:
LFB2985:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	-4(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2985:
	.section	.text$_ZN9__gnu_cxx17__normal_iteratorIPPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEC1ERKS4_,"x"
	.linkonce discard
	.align 2
	.globl	__ZN9__gnu_cxx17__normal_iteratorIPPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEC1ERKS4_
	.def	__ZN9__gnu_cxx17__normal_iteratorIPPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEC1ERKS4_;	.scl	2;	.type	32;	.endef
__ZN9__gnu_cxx17__normal_iteratorIPPN7Japetus4EdgeESt6vectorIS3_SaIS3_EEEC1ERKS4_:
LFB2988:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	-4(%ebp), %eax
	movl	%edx, (%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2988:
	.section	.text$_ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE7destroyIS3_EEvPT_,"x"
	.linkonce discard
	.align 2
	.globl	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE7destroyIS3_EEvPT_
	.def	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE7destroyIS3_EEvPT_;	.scl	2;	.type	32;	.endef
__ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE7destroyIS3_EEvPT_:
LFB2989:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2989:
	.section	.text$_ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE9constructIS3_JRKS3_EEEvPT_DpOT0_,"x"
	.linkonce discard
	.align 2
	.globl	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE9constructIS3_JRKS3_EEEvPT_DpOT0_
	.def	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE9constructIS3_JRKS3_EEEvPT_DpOT0_;	.scl	2;	.type	32;	.endef
__ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE9constructIS3_JRKS3_EEEvPT_DpOT0_:
LFB2990:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$36, %esp
	.cfi_offset 3, -12
	movl	%ecx, -12(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt7forwardIRKPN7Japetus4EdgeEEOT_RNSt16remove_referenceIS5_E4typeE
	movl	(%eax), %ebx
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$4, (%esp)
	call	__ZnwjPv
	testl	%eax, %eax
	je	L193
	movl	%ebx, (%eax)
L193:
	nop
	addl	$36, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$8
	.cfi_endproc
LFE2990:
	.section	.text$_ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE12_M_check_lenEjPKc,"x"
	.linkonce discard
	.align 2
	.globl	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE12_M_check_lenEjPKc
	.def	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE12_M_check_lenEjPKc;	.scl	2;	.type	32;	.endef
__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE12_M_check_lenEjPKc:
LFB2991:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$52, %esp
	.cfi_offset 3, -12
	movl	%ecx, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE8max_sizeEv
	movl	%eax, %ebx
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE4sizeEv
	movl	%ebx, %edx
	subl	%eax, %edx
	movl	8(%ebp), %eax
	cmpl	%eax, %edx
	setb	%al
	testb	%al, %al
	je	L195
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt20__throw_length_errorPKc
L195:
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE4sizeEv
	movl	%eax, %ebx
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE4sizeEv
	movl	%eax, -16(%ebp)
	leal	8(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-16(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt3maxIjERKT_S2_S2_
	movl	(%eax), %eax
	addl	%ebx, %eax
	movl	%eax, -12(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE4sizeEv
	cmpl	-12(%ebp), %eax
	ja	L196
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE8max_sizeEv
	cmpl	-12(%ebp), %eax
	jnb	L197
L196:
	movl	-28(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE8max_sizeEv
	jmp	L198
L197:
	movl	-12(%ebp), %eax
L198:
	addl	$52, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$8
	.cfi_endproc
LFE2991:
	.section	.text$_ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE11_M_allocateEj,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE11_M_allocateEj
	.def	__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE11_M_allocateEj;	.scl	2;	.type	32;	.endef
__ZNSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE11_M_allocateEj:
LFB2992:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	cmpl	$0, 8(%ebp)
	je	L201
	movl	-12(%ebp), %eax
	movl	8(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	__ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE8allocateERS3_j
	jmp	L203
L201:
	movl	$0, %eax
L203:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE2992:
	.section	.text$_ZSt34__uninitialized_move_if_noexcept_aIPPN7Japetus4EdgeES3_SaIS2_EET0_T_S6_S5_RT1_,"x"
	.linkonce discard
	.globl	__ZSt34__uninitialized_move_if_noexcept_aIPPN7Japetus4EdgeES3_SaIS2_EET0_T_S6_S5_RT1_
	.def	__ZSt34__uninitialized_move_if_noexcept_aIPPN7Japetus4EdgeES3_SaIS2_EET0_T_S6_S5_RT1_;	.scl	2;	.type	32;	.endef
__ZSt34__uninitialized_move_if_noexcept_aIPPN7Japetus4EdgeES3_SaIS2_EET0_T_S6_S5_RT1_:
LFB2993:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$20, %esp
	.cfi_offset 3, -12
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt32__make_move_if_noexcept_iteratorIPN7Japetus4EdgeESt13move_iteratorIPS2_EET0_PT_
	movl	%eax, %ebx
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt32__make_move_if_noexcept_iteratorIPN7Japetus4EdgeESt13move_iteratorIPS2_EET0_PT_
	movl	%eax, %edx
	movl	20(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	%ebx, 4(%esp)
	movl	%edx, (%esp)
	call	__ZSt22__uninitialized_copy_aISt13move_iteratorIPPN7Japetus4EdgeEES4_S3_ET0_T_S7_S6_RSaIT1_E
	addl	$20, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE2993:
	.section	.text$_ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE10deallocateERS3_PS2_j,"x"
	.linkonce discard
	.globl	__ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE10deallocateERS3_PS2_j
	.def	__ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE10deallocateERS3_PS2_j;	.scl	2;	.type	32;	.endef
__ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE10deallocateERS3_PS2_j:
LFB3035:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	16(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	movl	8(%ebp), %ecx
	call	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE10deallocateEPS3_j
	subl	$8, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3035:
	.section	.text$_ZNSt12_Destroy_auxILb1EE9__destroyIPPN7Japetus4EdgeEEEvT_S6_,"x"
	.linkonce discard
	.globl	__ZNSt12_Destroy_auxILb1EE9__destroyIPPN7Japetus4EdgeEEEvT_S6_
	.def	__ZNSt12_Destroy_auxILb1EE9__destroyIPPN7Japetus4EdgeEEEvT_S6_;	.scl	2;	.type	32;	.endef
__ZNSt12_Destroy_auxILb1EE9__destroyIPPN7Japetus4EdgeEEEvT_S6_:
LFB3037:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3037:
	.section	.text$_ZNSaIPN7Japetus4EdgeEEC2Ev,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSaIPN7Japetus4EdgeEEC2Ev
	.def	__ZNSaIPN7Japetus4EdgeEEC2Ev;	.scl	2;	.type	32;	.endef
__ZNSaIPN7Japetus4EdgeEEC2Ev:
LFB3043:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, %ecx
	call	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEEC2Ev
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3043:
	.section	.text$_ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE8max_sizeEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE8max_sizeEv
	.def	__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE8max_sizeEv;	.scl	2;	.type	32;	.endef
__ZNKSt6vectorIPN7Japetus4NodeESaIS2_EE8max_sizeEv:
LFB3045:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt12_Vector_baseIPN7Japetus4NodeESaIS2_EE19_M_get_Tp_allocatorEv
	movl	%eax, (%esp)
	call	__ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE8max_sizeERKS3_
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3045:
	.section	.text$_ZSt3maxIjERKT_S2_S2_,"x"
	.linkonce discard
	.globl	__ZSt3maxIjERKT_S2_S2_
	.def	__ZSt3maxIjERKT_S2_S2_;	.scl	2;	.type	32;	.endef
__ZSt3maxIjERKT_S2_S2_:
LFB3046:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	cmpl	%eax, %edx
	jnb	L212
	movl	12(%ebp), %eax
	jmp	L213
L212:
	movl	8(%ebp), %eax
L213:
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3046:
	.section	.text$_ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE8allocateERS3_j,"x"
	.linkonce discard
	.globl	__ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE8allocateERS3_j
	.def	__ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE8allocateERS3_j;	.scl	2;	.type	32;	.endef
__ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE8allocateERS3_j:
LFB3047:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	$0, 4(%esp)
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	movl	8(%ebp), %ecx
	call	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE8allocateEjPKv
	subl	$8, %esp
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3047:
	.section	.text$_ZSt32__make_move_if_noexcept_iteratorIPN7Japetus4NodeESt13move_iteratorIPS2_EET0_PT_,"x"
	.linkonce discard
	.globl	__ZSt32__make_move_if_noexcept_iteratorIPN7Japetus4NodeESt13move_iteratorIPS2_EET0_PT_
	.def	__ZSt32__make_move_if_noexcept_iteratorIPN7Japetus4NodeESt13move_iteratorIPS2_EET0_PT_;	.scl	2;	.type	32;	.endef
__ZSt32__make_move_if_noexcept_iteratorIPN7Japetus4NodeESt13move_iteratorIPS2_EET0_PT_:
LFB3048:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	leal	-12(%ebp), %eax
	movl	8(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt13move_iteratorIPPN7Japetus4NodeEEC1ES3_
	subl	$4, %esp
	movl	-12(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3048:
	.section	.text$_ZSt22__uninitialized_copy_aISt13move_iteratorIPPN7Japetus4NodeEES4_S3_ET0_T_S7_S6_RSaIT1_E,"x"
	.linkonce discard
	.globl	__ZSt22__uninitialized_copy_aISt13move_iteratorIPPN7Japetus4NodeEES4_S3_ET0_T_S7_S6_RSaIT1_E
	.def	__ZSt22__uninitialized_copy_aISt13move_iteratorIPPN7Japetus4NodeEES4_S3_ET0_T_S7_S6_RSaIT1_E;	.scl	2;	.type	32;	.endef
__ZSt22__uninitialized_copy_aISt13move_iteratorIPPN7Japetus4NodeEES4_S3_ET0_T_S7_S6_RSaIT1_E:
LFB3049:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt18uninitialized_copyISt13move_iteratorIPPN7Japetus4NodeEES4_ET0_T_S7_S6_
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3049:
	.section	.text$_ZSt8_DestroyIPPN7Japetus4NodeEEvT_S4_,"x"
	.linkonce discard
	.globl	__ZSt8_DestroyIPPN7Japetus4NodeEEvT_S4_
	.def	__ZSt8_DestroyIPPN7Japetus4NodeEEvT_S4_;	.scl	2;	.type	32;	.endef
__ZSt8_DestroyIPPN7Japetus4NodeEEvT_S4_:
LFB3050:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZNSt12_Destroy_auxILb1EE9__destroyIPPN7Japetus4NodeEEEvT_S6_
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3050:
	.section	.text$_ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE10deallocateERS3_PS2_j,"x"
	.linkonce discard
	.globl	__ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE10deallocateERS3_PS2_j
	.def	__ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE10deallocateERS3_PS2_j;	.scl	2;	.type	32;	.endef
__ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE10deallocateERS3_PS2_j:
LFB3051:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	16(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	movl	8(%ebp), %ecx
	call	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE10deallocateEPS3_j
	subl	$8, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3051:
	.section	.text$_ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE8max_sizeEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE8max_sizeEv
	.def	__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE8max_sizeEv;	.scl	2;	.type	32;	.endef
__ZNKSt6vectorIPN7Japetus4EdgeESaIS2_EE8max_sizeEv:
LFB3052:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNKSt12_Vector_baseIPN7Japetus4EdgeESaIS2_EE19_M_get_Tp_allocatorEv
	movl	%eax, (%esp)
	call	__ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE8max_sizeERKS3_
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3052:
	.section	.text$_ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE8allocateERS3_j,"x"
	.linkonce discard
	.globl	__ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE8allocateERS3_j
	.def	__ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE8allocateERS3_j;	.scl	2;	.type	32;	.endef
__ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE8allocateERS3_j:
LFB3053:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	$0, 4(%esp)
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	movl	8(%ebp), %ecx
	call	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE8allocateEjPKv
	subl	$8, %esp
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3053:
	.section	.text$_ZSt32__make_move_if_noexcept_iteratorIPN7Japetus4EdgeESt13move_iteratorIPS2_EET0_PT_,"x"
	.linkonce discard
	.globl	__ZSt32__make_move_if_noexcept_iteratorIPN7Japetus4EdgeESt13move_iteratorIPS2_EET0_PT_
	.def	__ZSt32__make_move_if_noexcept_iteratorIPN7Japetus4EdgeESt13move_iteratorIPS2_EET0_PT_;	.scl	2;	.type	32;	.endef
__ZSt32__make_move_if_noexcept_iteratorIPN7Japetus4EdgeESt13move_iteratorIPS2_EET0_PT_:
LFB3054:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	leal	-12(%ebp), %eax
	movl	8(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, %ecx
	call	__ZNSt13move_iteratorIPPN7Japetus4EdgeEEC1ES3_
	subl	$4, %esp
	movl	-12(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3054:
	.section	.text$_ZSt22__uninitialized_copy_aISt13move_iteratorIPPN7Japetus4EdgeEES4_S3_ET0_T_S7_S6_RSaIT1_E,"x"
	.linkonce discard
	.globl	__ZSt22__uninitialized_copy_aISt13move_iteratorIPPN7Japetus4EdgeEES4_S3_ET0_T_S7_S6_RSaIT1_E
	.def	__ZSt22__uninitialized_copy_aISt13move_iteratorIPPN7Japetus4EdgeEES4_S3_ET0_T_S7_S6_RSaIT1_E;	.scl	2;	.type	32;	.endef
__ZSt22__uninitialized_copy_aISt13move_iteratorIPPN7Japetus4EdgeEES4_S3_ET0_T_S7_S6_RSaIT1_E:
LFB3055:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt18uninitialized_copyISt13move_iteratorIPPN7Japetus4EdgeEES4_ET0_T_S7_S6_
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3055:
	.section	.text$_ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE10deallocateEPS3_j,"x"
	.linkonce discard
	.align 2
	.globl	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE10deallocateEPS3_j
	.def	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE10deallocateEPS3_j;	.scl	2;	.type	32;	.endef
__ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE10deallocateEPS3_j:
LFB3105:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZdlPv
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$8
	.cfi_endproc
LFE3105:
	.section	.text$_ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEEC2Ev,"x"
	.linkonce discard
	.align 2
	.globl	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEEC2Ev
	.def	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEEC2Ev;	.scl	2;	.type	32;	.endef
__ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEEC2Ev:
LFB3108:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3108:
	.section	.text$_ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE8max_sizeERKS3_,"x"
	.linkonce discard
	.globl	__ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE8max_sizeERKS3_
	.def	__ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE8max_sizeERKS3_;	.scl	2;	.type	32;	.endef
__ZNSt16allocator_traitsISaIPN7Japetus4NodeEEE8max_sizeERKS3_:
LFB3110:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	movl	8(%ebp), %ecx
	call	__ZNK9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE8max_sizeEv
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3110:
	.section	.text$_ZNKSt12_Vector_baseIPN7Japetus4NodeESaIS2_EE19_M_get_Tp_allocatorEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNKSt12_Vector_baseIPN7Japetus4NodeESaIS2_EE19_M_get_Tp_allocatorEv
	.def	__ZNKSt12_Vector_baseIPN7Japetus4NodeESaIS2_EE19_M_get_Tp_allocatorEv;	.scl	2;	.type	32;	.endef
__ZNKSt12_Vector_baseIPN7Japetus4NodeESaIS2_EE19_M_get_Tp_allocatorEv:
LFB3111:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	-4(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3111:
	.section	.text$_ZN9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE8allocateEjPKv,"x"
	.linkonce discard
	.align 2
	.globl	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE8allocateEjPKv
	.def	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE8allocateEjPKv;	.scl	2;	.type	32;	.endef
__ZN9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE8allocateEjPKv:
LFB3112:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNK9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE8max_sizeEv
	cmpl	8(%ebp), %eax
	setb	%al
	testb	%al, %al
	je	L237
	call	__ZSt17__throw_bad_allocv
L237:
	movl	8(%ebp), %eax
	sall	$2, %eax
	movl	%eax, (%esp)
	call	__Znwj
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$8
	.cfi_endproc
LFE3112:
	.section	.text$_ZNSt13move_iteratorIPPN7Japetus4NodeEEC1ES3_,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt13move_iteratorIPPN7Japetus4NodeEEC1ES3_
	.def	__ZNSt13move_iteratorIPPN7Japetus4NodeEEC1ES3_;	.scl	2;	.type	32;	.endef
__ZNSt13move_iteratorIPPN7Japetus4NodeEEC1ES3_:
LFB3115:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	8(%ebp), %edx
	movl	%edx, (%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE3115:
	.section	.text$_ZSt18uninitialized_copyISt13move_iteratorIPPN7Japetus4NodeEES4_ET0_T_S7_S6_,"x"
	.linkonce discard
	.globl	__ZSt18uninitialized_copyISt13move_iteratorIPPN7Japetus4NodeEES4_ET0_T_S7_S6_
	.def	__ZSt18uninitialized_copyISt13move_iteratorIPPN7Japetus4NodeEES4_ET0_T_S7_S6_;	.scl	2;	.type	32;	.endef
__ZSt18uninitialized_copyISt13move_iteratorIPPN7Japetus4NodeEES4_ET0_T_S7_S6_:
LFB3116:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movb	$1, -9(%ebp)
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZNSt20__uninitialized_copyILb1EE13__uninit_copyISt13move_iteratorIPPN7Japetus4NodeEES6_EET0_T_S9_S8_
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3116:
	.section	.text$_ZNSt12_Destroy_auxILb1EE9__destroyIPPN7Japetus4NodeEEEvT_S6_,"x"
	.linkonce discard
	.globl	__ZNSt12_Destroy_auxILb1EE9__destroyIPPN7Japetus4NodeEEEvT_S6_
	.def	__ZNSt12_Destroy_auxILb1EE9__destroyIPPN7Japetus4NodeEEEvT_S6_;	.scl	2;	.type	32;	.endef
__ZNSt12_Destroy_auxILb1EE9__destroyIPPN7Japetus4NodeEEEvT_S6_:
LFB3117:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3117:
	.section	.text$_ZN9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE10deallocateEPS3_j,"x"
	.linkonce discard
	.align 2
	.globl	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE10deallocateEPS3_j
	.def	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE10deallocateEPS3_j;	.scl	2;	.type	32;	.endef
__ZN9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE10deallocateEPS3_j:
LFB3118:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZdlPv
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$8
	.cfi_endproc
LFE3118:
	.section	.text$_ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE8max_sizeERKS3_,"x"
	.linkonce discard
	.globl	__ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE8max_sizeERKS3_
	.def	__ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE8max_sizeERKS3_;	.scl	2;	.type	32;	.endef
__ZNSt16allocator_traitsISaIPN7Japetus4EdgeEEE8max_sizeERKS3_:
LFB3119:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	movl	8(%ebp), %ecx
	call	__ZNK9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE8max_sizeEv
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3119:
	.section	.text$_ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE8allocateEjPKv,"x"
	.linkonce discard
	.align 2
	.globl	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE8allocateEjPKv
	.def	__ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE8allocateEjPKv;	.scl	2;	.type	32;	.endef
__ZN9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE8allocateEjPKv:
LFB3120:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	%ecx, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, %ecx
	call	__ZNK9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE8max_sizeEv
	cmpl	8(%ebp), %eax
	setb	%al
	testb	%al, %al
	je	L247
	call	__ZSt17__throw_bad_allocv
L247:
	movl	8(%ebp), %eax
	sall	$2, %eax
	movl	%eax, (%esp)
	call	__Znwj
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$8
	.cfi_endproc
LFE3120:
	.section	.text$_ZNSt13move_iteratorIPPN7Japetus4EdgeEEC1ES3_,"x"
	.linkonce discard
	.align 2
	.globl	__ZNSt13move_iteratorIPPN7Japetus4EdgeEEC1ES3_
	.def	__ZNSt13move_iteratorIPPN7Japetus4EdgeEEC1ES3_;	.scl	2;	.type	32;	.endef
__ZNSt13move_iteratorIPPN7Japetus4EdgeEEC1ES3_:
LFB3123:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	8(%ebp), %edx
	movl	%edx, (%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	$4
	.cfi_endproc
LFE3123:
	.section	.text$_ZSt18uninitialized_copyISt13move_iteratorIPPN7Japetus4EdgeEES4_ET0_T_S7_S6_,"x"
	.linkonce discard
	.globl	__ZSt18uninitialized_copyISt13move_iteratorIPPN7Japetus4EdgeEES4_ET0_T_S7_S6_
	.def	__ZSt18uninitialized_copyISt13move_iteratorIPPN7Japetus4EdgeEES4_ET0_T_S7_S6_;	.scl	2;	.type	32;	.endef
__ZSt18uninitialized_copyISt13move_iteratorIPPN7Japetus4EdgeEES4_ET0_T_S7_S6_:
LFB3124:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movb	$1, -9(%ebp)
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZNSt20__uninitialized_copyILb1EE13__uninit_copyISt13move_iteratorIPPN7Japetus4EdgeEES6_EET0_T_S9_S8_
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3124:
	.section	.text$_ZNK9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE8max_sizeEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNK9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE8max_sizeEv
	.def	__ZNK9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE8max_sizeEv;	.scl	2;	.type	32;	.endef
__ZNK9__gnu_cxx13new_allocatorIPN7Japetus4NodeEE8max_sizeEv:
LFB3153:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	$1073741823, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3153:
	.section	.text$_ZNSt20__uninitialized_copyILb1EE13__uninit_copyISt13move_iteratorIPPN7Japetus4NodeEES6_EET0_T_S9_S8_,"x"
	.linkonce discard
	.globl	__ZNSt20__uninitialized_copyILb1EE13__uninit_copyISt13move_iteratorIPPN7Japetus4NodeEES6_EET0_T_S9_S8_
	.def	__ZNSt20__uninitialized_copyILb1EE13__uninit_copyISt13move_iteratorIPPN7Japetus4NodeEES6_EET0_T_S9_S8_;	.scl	2;	.type	32;	.endef
__ZNSt20__uninitialized_copyILb1EE13__uninit_copyISt13move_iteratorIPPN7Japetus4NodeEES6_EET0_T_S9_S8_:
LFB3154:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt4copyISt13move_iteratorIPPN7Japetus4NodeEES4_ET0_T_S7_S6_
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3154:
	.section	.text$_ZNK9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE8max_sizeEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNK9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE8max_sizeEv
	.def	__ZNK9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE8max_sizeEv;	.scl	2;	.type	32;	.endef
__ZNK9__gnu_cxx13new_allocatorIPN7Japetus4EdgeEE8max_sizeEv:
LFB3155:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	$1073741823, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3155:
	.section	.text$_ZNSt20__uninitialized_copyILb1EE13__uninit_copyISt13move_iteratorIPPN7Japetus4EdgeEES6_EET0_T_S9_S8_,"x"
	.linkonce discard
	.globl	__ZNSt20__uninitialized_copyILb1EE13__uninit_copyISt13move_iteratorIPPN7Japetus4EdgeEES6_EET0_T_S9_S8_
	.def	__ZNSt20__uninitialized_copyILb1EE13__uninit_copyISt13move_iteratorIPPN7Japetus4EdgeEES6_EET0_T_S9_S8_;	.scl	2;	.type	32;	.endef
__ZNSt20__uninitialized_copyILb1EE13__uninit_copyISt13move_iteratorIPPN7Japetus4EdgeEES6_EET0_T_S9_S8_:
LFB3156:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt4copyISt13move_iteratorIPPN7Japetus4EdgeEES4_ET0_T_S7_S6_
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3156:
	.section	.text$_ZSt12__niter_baseIPPN7Japetus4EdgeEET_S4_,"x"
	.linkonce discard
	.globl	__ZSt12__niter_baseIPPN7Japetus4EdgeEET_S4_
	.def	__ZSt12__niter_baseIPPN7Japetus4EdgeEET_S4_;	.scl	2;	.type	32;	.endef
__ZSt12__niter_baseIPPN7Japetus4EdgeEET_S4_:
LFB3172:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3172:
	.section	.text$_ZSt4copyISt13move_iteratorIPPN7Japetus4NodeEES4_ET0_T_S7_S6_,"x"
	.linkonce discard
	.globl	__ZSt4copyISt13move_iteratorIPPN7Japetus4NodeEES4_ET0_T_S7_S6_
	.def	__ZSt4copyISt13move_iteratorIPPN7Japetus4NodeEES4_ET0_T_S7_S6_;	.scl	2;	.type	32;	.endef
__ZSt4copyISt13move_iteratorIPPN7Japetus4NodeEES4_ET0_T_S7_S6_:
LFB3174:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$20, %esp
	.cfi_offset 3, -12
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt12__miter_baseIPPN7Japetus4NodeEEDTcl12__miter_basecldtfp_4baseEEESt13move_iteratorIT_E
	movl	%eax, %ebx
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt12__miter_baseIPPN7Japetus4NodeEEDTcl12__miter_basecldtfp_4baseEEESt13move_iteratorIT_E
	movl	%eax, %edx
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	%ebx, 4(%esp)
	movl	%edx, (%esp)
	call	__ZSt14__copy_move_a2ILb1EPPN7Japetus4NodeES3_ET1_T0_S5_S4_
	addl	$20, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3174:
	.section	.text$_ZSt4copyISt13move_iteratorIPPN7Japetus4EdgeEES4_ET0_T_S7_S6_,"x"
	.linkonce discard
	.globl	__ZSt4copyISt13move_iteratorIPPN7Japetus4EdgeEES4_ET0_T_S7_S6_
	.def	__ZSt4copyISt13move_iteratorIPPN7Japetus4EdgeEES4_ET0_T_S7_S6_;	.scl	2;	.type	32;	.endef
__ZSt4copyISt13move_iteratorIPPN7Japetus4EdgeEES4_ET0_T_S7_S6_:
LFB3175:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$20, %esp
	.cfi_offset 3, -12
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt12__miter_baseIPPN7Japetus4EdgeEEDTcl12__miter_basecldtfp_4baseEEESt13move_iteratorIT_E
	movl	%eax, %ebx
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt12__miter_baseIPPN7Japetus4EdgeEEDTcl12__miter_basecldtfp_4baseEEESt13move_iteratorIT_E
	movl	%eax, %edx
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	%ebx, 4(%esp)
	movl	%edx, (%esp)
	call	__ZSt14__copy_move_a2ILb1EPPN7Japetus4EdgeES3_ET1_T0_S5_S4_
	addl	$20, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3175:
	.section	.text$_ZSt12__miter_baseIPPN7Japetus4NodeEEDTcl12__miter_basecldtfp_4baseEEESt13move_iteratorIT_E,"x"
	.linkonce discard
	.globl	__ZSt12__miter_baseIPPN7Japetus4NodeEEDTcl12__miter_basecldtfp_4baseEEESt13move_iteratorIT_E
	.def	__ZSt12__miter_baseIPPN7Japetus4NodeEEDTcl12__miter_basecldtfp_4baseEEESt13move_iteratorIT_E;	.scl	2;	.type	32;	.endef
__ZSt12__miter_baseIPPN7Japetus4NodeEEDTcl12__miter_basecldtfp_4baseEEESt13move_iteratorIT_E:
LFB3186:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	leal	8(%ebp), %ecx
	call	__ZNKSt13move_iteratorIPPN7Japetus4NodeEE4baseEv
	movl	%eax, (%esp)
	call	__ZSt12__miter_baseIPPN7Japetus4NodeEET_S4_
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3186:
	.section	.text$_ZSt14__copy_move_a2ILb1EPPN7Japetus4NodeES3_ET1_T0_S5_S4_,"x"
	.linkonce discard
	.globl	__ZSt14__copy_move_a2ILb1EPPN7Japetus4NodeES3_ET1_T0_S5_S4_
	.def	__ZSt14__copy_move_a2ILb1EPPN7Japetus4NodeES3_ET1_T0_S5_S4_;	.scl	2;	.type	32;	.endef
__ZSt14__copy_move_a2ILb1EPPN7Japetus4NodeES3_ET1_T0_S5_S4_:
LFB3187:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%esi
	pushl	%ebx
	subl	$16, %esp
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	movl	16(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt12__niter_baseIPPN7Japetus4NodeEET_S4_
	movl	%eax, %esi
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt12__niter_baseIPPN7Japetus4NodeEET_S4_
	movl	%eax, %ebx
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt12__niter_baseIPPN7Japetus4NodeEET_S4_
	movl	%esi, 8(%esp)
	movl	%ebx, 4(%esp)
	movl	%eax, (%esp)
	call	__ZSt13__copy_move_aILb1EPPN7Japetus4NodeES3_ET1_T0_S5_S4_
	addl	$16, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3187:
	.section	.text$_ZSt12__miter_baseIPPN7Japetus4EdgeEEDTcl12__miter_basecldtfp_4baseEEESt13move_iteratorIT_E,"x"
	.linkonce discard
	.globl	__ZSt12__miter_baseIPPN7Japetus4EdgeEEDTcl12__miter_basecldtfp_4baseEEESt13move_iteratorIT_E
	.def	__ZSt12__miter_baseIPPN7Japetus4EdgeEEDTcl12__miter_basecldtfp_4baseEEESt13move_iteratorIT_E;	.scl	2;	.type	32;	.endef
__ZSt12__miter_baseIPPN7Japetus4EdgeEEDTcl12__miter_basecldtfp_4baseEEESt13move_iteratorIT_E:
LFB3188:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	leal	8(%ebp), %ecx
	call	__ZNKSt13move_iteratorIPPN7Japetus4EdgeEE4baseEv
	movl	%eax, (%esp)
	call	__ZSt12__miter_baseIPPN7Japetus4EdgeEET_S4_
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3188:
	.section	.text$_ZSt14__copy_move_a2ILb1EPPN7Japetus4EdgeES3_ET1_T0_S5_S4_,"x"
	.linkonce discard
	.globl	__ZSt14__copy_move_a2ILb1EPPN7Japetus4EdgeES3_ET1_T0_S5_S4_
	.def	__ZSt14__copy_move_a2ILb1EPPN7Japetus4EdgeES3_ET1_T0_S5_S4_;	.scl	2;	.type	32;	.endef
__ZSt14__copy_move_a2ILb1EPPN7Japetus4EdgeES3_ET1_T0_S5_S4_:
LFB3189:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%esi
	pushl	%ebx
	subl	$16, %esp
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	movl	16(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt12__niter_baseIPPN7Japetus4EdgeEET_S4_
	movl	%eax, %esi
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt12__niter_baseIPPN7Japetus4EdgeEET_S4_
	movl	%eax, %ebx
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZSt12__niter_baseIPPN7Japetus4EdgeEET_S4_
	movl	%esi, 8(%esp)
	movl	%ebx, 4(%esp)
	movl	%eax, (%esp)
	call	__ZSt13__copy_move_aILb1EPPN7Japetus4EdgeES3_ET1_T0_S5_S4_
	addl	$16, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3189:
	.section	.text$_ZNKSt13move_iteratorIPPN7Japetus4NodeEE4baseEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNKSt13move_iteratorIPPN7Japetus4NodeEE4baseEv
	.def	__ZNKSt13move_iteratorIPPN7Japetus4NodeEE4baseEv;	.scl	2;	.type	32;	.endef
__ZNKSt13move_iteratorIPPN7Japetus4NodeEE4baseEv:
LFB3196:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	(%eax), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3196:
	.section	.text$_ZSt12__miter_baseIPPN7Japetus4NodeEET_S4_,"x"
	.linkonce discard
	.globl	__ZSt12__miter_baseIPPN7Japetus4NodeEET_S4_
	.def	__ZSt12__miter_baseIPPN7Japetus4NodeEET_S4_;	.scl	2;	.type	32;	.endef
__ZSt12__miter_baseIPPN7Japetus4NodeEET_S4_:
LFB3197:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3197:
	.section	.text$_ZSt12__niter_baseIPPN7Japetus4NodeEET_S4_,"x"
	.linkonce discard
	.globl	__ZSt12__niter_baseIPPN7Japetus4NodeEET_S4_
	.def	__ZSt12__niter_baseIPPN7Japetus4NodeEET_S4_;	.scl	2;	.type	32;	.endef
__ZSt12__niter_baseIPPN7Japetus4NodeEET_S4_:
LFB3198:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3198:
	.section	.text$_ZSt13__copy_move_aILb1EPPN7Japetus4NodeES3_ET1_T0_S5_S4_,"x"
	.linkonce discard
	.globl	__ZSt13__copy_move_aILb1EPPN7Japetus4NodeES3_ET1_T0_S5_S4_
	.def	__ZSt13__copy_move_aILb1EPPN7Japetus4NodeES3_ET1_T0_S5_S4_;	.scl	2;	.type	32;	.endef
__ZSt13__copy_move_aILb1EPPN7Japetus4NodeES3_ET1_T0_S5_S4_:
LFB3199:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movb	$1, -9(%ebp)
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZNSt11__copy_moveILb1ELb1ESt26random_access_iterator_tagE8__copy_mIPN7Japetus4NodeEEEPT_PKS6_S9_S7_
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3199:
	.section	.text$_ZNKSt13move_iteratorIPPN7Japetus4EdgeEE4baseEv,"x"
	.linkonce discard
	.align 2
	.globl	__ZNKSt13move_iteratorIPPN7Japetus4EdgeEE4baseEv
	.def	__ZNKSt13move_iteratorIPPN7Japetus4EdgeEE4baseEv;	.scl	2;	.type	32;	.endef
__ZNKSt13move_iteratorIPPN7Japetus4EdgeEE4baseEv:
LFB3200:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	%ecx, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	(%eax), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3200:
	.section	.text$_ZSt12__miter_baseIPPN7Japetus4EdgeEET_S4_,"x"
	.linkonce discard
	.globl	__ZSt12__miter_baseIPPN7Japetus4EdgeEET_S4_
	.def	__ZSt12__miter_baseIPPN7Japetus4EdgeEET_S4_;	.scl	2;	.type	32;	.endef
__ZSt12__miter_baseIPPN7Japetus4EdgeEET_S4_:
LFB3201:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	8(%ebp), %eax
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3201:
	.section	.text$_ZSt13__copy_move_aILb1EPPN7Japetus4EdgeES3_ET1_T0_S5_S4_,"x"
	.linkonce discard
	.globl	__ZSt13__copy_move_aILb1EPPN7Japetus4EdgeES3_ET1_T0_S5_S4_
	.def	__ZSt13__copy_move_aILb1EPPN7Japetus4EdgeES3_ET1_T0_S5_S4_;	.scl	2;	.type	32;	.endef
__ZSt13__copy_move_aILb1EPPN7Japetus4EdgeES3_ET1_T0_S5_S4_:
LFB3202:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movb	$1, -9(%ebp)
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	__ZNSt11__copy_moveILb1ELb1ESt26random_access_iterator_tagE8__copy_mIPN7Japetus4EdgeEEEPT_PKS6_S9_S7_
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3202:
	.section	.text$_ZNSt11__copy_moveILb1ELb1ESt26random_access_iterator_tagE8__copy_mIPN7Japetus4NodeEEEPT_PKS6_S9_S7_,"x"
	.linkonce discard
	.globl	__ZNSt11__copy_moveILb1ELb1ESt26random_access_iterator_tagE8__copy_mIPN7Japetus4NodeEEEPT_PKS6_S9_S7_
	.def	__ZNSt11__copy_moveILb1ELb1ESt26random_access_iterator_tagE8__copy_mIPN7Japetus4NodeEEEPT_PKS6_S9_S7_;	.scl	2;	.type	32;	.endef
__ZNSt11__copy_moveILb1ELb1ESt26random_access_iterator_tagE8__copy_mIPN7Japetus4NodeEEEPT_PKS6_S9_S7_:
LFB3203:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	12(%ebp), %edx
	movl	8(%ebp), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	sarl	$2, %eax
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	je	L289
	movl	-12(%ebp), %eax
	sall	$2, %eax
	movl	%eax, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	16(%ebp), %eax
	movl	%eax, (%esp)
	call	_memmove
L289:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	16(%ebp), %eax
	addl	%edx, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3203:
	.section	.text$_ZNSt11__copy_moveILb1ELb1ESt26random_access_iterator_tagE8__copy_mIPN7Japetus4EdgeEEEPT_PKS6_S9_S7_,"x"
	.linkonce discard
	.globl	__ZNSt11__copy_moveILb1ELb1ESt26random_access_iterator_tagE8__copy_mIPN7Japetus4EdgeEEEPT_PKS6_S9_S7_
	.def	__ZNSt11__copy_moveILb1ELb1ESt26random_access_iterator_tagE8__copy_mIPN7Japetus4EdgeEEEPT_PKS6_S9_S7_;	.scl	2;	.type	32;	.endef
__ZNSt11__copy_moveILb1ELb1ESt26random_access_iterator_tagE8__copy_mIPN7Japetus4EdgeEEEPT_PKS6_S9_S7_:
LFB3204:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	12(%ebp), %edx
	movl	8(%ebp), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	sarl	$2, %eax
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	je	L292
	movl	-12(%ebp), %eax
	sall	$2, %eax
	movl	%eax, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	16(%ebp), %eax
	movl	%eax, (%esp)
	call	_memmove
L292:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	16(%ebp), %eax
	addl	%edx, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE3204:
	.ident	"GCC: (MinGW.org GCC-6.3.0-1) 6.3.0"
	.def	__Znwj;	.scl	2;	.type	32;	.endef
	.def	___cxa_begin_catch;	.scl	2;	.type	32;	.endef
	.def	___cxa_rethrow;	.scl	2;	.type	32;	.endef
	.def	___cxa_end_catch;	.scl	2;	.type	32;	.endef
	.def	__Unwind_Resume;	.scl	2;	.type	32;	.endef
	.def	__ZSt20__throw_length_errorPKc;	.scl	2;	.type	32;	.endef
	.def	__ZdlPv;	.scl	2;	.type	32;	.endef
	.def	__ZSt17__throw_bad_allocv;	.scl	2;	.type	32;	.endef
	.def	_memmove;	.scl	2;	.type	32;	.endef
