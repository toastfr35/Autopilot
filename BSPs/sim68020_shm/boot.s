# (c) 2020-2021 Rapita Systems Ltd 

.section .init

# Stack pointer points to end of 1MB RAM
.long   _sstack

# PC
.long   _start

.section .vector_table

# Interrupt vector table
.fill   30, 4, 0x400  /* vectors 2..32 */
	dc.l trap_handler /* Trap #0 */
	dc.l trap_handler
	dc.l trap_handler
	dc.l trap_handler
	dc.l trap_handler
	dc.l trap_handler
	dc.l trap_handler
	dc.l trap_handler
	dc.l trap_handler
	dc.l trap_handler
	dc.l trap_handler
	dc.l trap_handler
	dc.l trap_handler
	dc.l trap_handler
	dc.l trap_handler
	dc.l trap_handler /* Trap #15 */
.fill   208, 4, 0x400 


.section .interrupt_handlers

# default interrupt handler (does nothing)
.global default_interrupt_handler
default_interrupt_handler:
	bra		default_interrupt_handler  /* Infinite loop. The simulator will stop at this address (0x400) */

# trap handler
.global c_trap_handler
.global trap_handler
trap_handler:
	ori.w	#0x0700,%sr /* Disable interrupts */
	link.w	%fp,#0
	jsr		c_trap_handler   
	unlk	%fp
	andi.w	#0xF8FF,%sr /* Enable interrupts */
	rte


.section .text

.global _endsimulator
_endsimulator:
	jmp 0x4

.global _start
_start:
	move.l	#4,(%sp)	/* Set the return address to 0x4. This will cause the simulator to stop when returning from _startup */
	bra.l	main     	/* Call _startup (C code) */

c_trap_handler:
    linkw %fp,#-8
    movel %fp,%d0
    movel %d0,%fp@(-4)
    moveaw #18,%a0
    addal %fp@(-4),%a0
    movew %a0@,%d0
    lsrw #2,%d0
    movew %d0,%d1
    addiw #-32,%d1
    movew %d1,%fp@(-6)
    unlk %fp
    rts


