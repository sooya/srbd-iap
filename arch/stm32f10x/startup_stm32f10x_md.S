/* File: startup_stm32f10x_hd.S
 * Purpose: startup file for Cortex-M3 devices, STM32f10X_hd. Should use with
 *   GCC for ARM Embedded Processors
 * Version: V1.3
 * Date: 08 Feb 2012
 *
 * Copyright (c) 2012, ARM Limited
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the ARM Limited nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL ARM LIMITED BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
    .syntax unified
    .arch armv7-m

    .section .stack
    .align 3
#ifdef __STACK_SIZE
    .equ    Stack_Size, __STACK_SIZE
#else
    .equ    Stack_Size, 0x400
#endif
    .globl    __StackTop
    .globl    __StackLimit
__StackLimit:
    .space    Stack_Size
    .size __StackLimit, . - __StackLimit
__StackTop:
    .size __StackTop, . - __StackTop

    .section .heap
    .align 3
#ifdef __HEAP_SIZE
    .equ    Heap_Size, __HEAP_SIZE
#else
    .equ    Heap_Size, 0xC00
#endif
    .globl    __HeapBase
    .globl    __HeapLimit
__HeapBase:
    .if    Heap_Size
    .space    Heap_Size
    .endif
    .size __HeapBase, . - __HeapBase
__HeapLimit:
    .size __HeapLimit, . - __HeapLimit

    .section .isr_vector
    .align 2
    .globl __isr_vector
__isr_vector:
    .long    __StackTop            /* Top of Stack */
    .long    Reset_Handler         /* Reset Handler */
    .long    NMI_Handler           /* NMI Handler */
    .long    HardFault_Handler     /* Hard Fault Handler */
    .long    MemManage_Handler     /* MPU Fault Handler */
    .long    BusFault_Handler      /* Bus Fault Handler */
    .long    UsageFault_Handler    /* Usage Fault Handler */
    .long    0                     /* Reserved */
    .long    0                     /* Reserved */
    .long    0                     /* Reserved */
    .long    0                     /* Reserved */
    .long    SVC_Handler           /* SVCall Handler */
    .long    DebugMon_Handler      /* Debug Monitor Handler */
    .long    0                     /* Reserved */
    .long    PendSV_Handler        /* PendSV Handler */
    .long    SysTick_Handler        /* SysTick Handler */
    /* External interrupts */
    .long    WWDG_IRQHandler        /*  0:  Watchdog Timer            */
    .long    PVD_IRQHandler        /*  1:  PVD through EXTI Line detection     */
    .long    TAMPER_IRQHandler		/* 2: tamper                   */
    .long    RTC_IRQHandler        /*  3:  Real Time Clock           */
    .long    FLASH_IRQHandler		/* 4: flash global                   */
    .long    RCC_IRQHandler		/* 5: RCC global                   */
    .long    EXTI0_IRQHandler		/* 6: EXTI Line0                   */
    .long    EXTI1_IRQHandler		/* 7: EXTI Line1                   */
    .long    EXTI2_IRQHandler		/* 8: EXTI Line2                   */
    .long    EXTI3_IRQHandler		/* 9: EXTI Line3                   */
    .long    EXTI4_IRQHandler		/* 10: EXTI Line4                   */
    .long    DMA1_Channel1_IRQHandler	/* 11: DMA1 Channel1 global   */
    .long    DMA1_Channel2_IRQHandler	/* 12: DMA1 Channel2 global   */
    .long    DMA1_Channel3_IRQHandler	/* 13: DMA1 Channel3 global   */
    .long    DMA1_Channel4_IRQHandler	/* 14: DMA1 Channel4 global   */
    .long    DMA1_Channel5_IRQHandler	/* 15: DMA1 Channel5 global   */
    .long    DMA1_Channel6_IRQHandler	/* 16: DMA1 Channel6 global   */
    .long    DMA1_Channel7_IRQHandler	/* 17: DMA1 Channel7 global   */
    .long    ADC1_2_IRQHandler		/* 18: ADC1 and ADC2 global   */
    .long    USB_HP_CAN_TX_IRQHandler	/* 19: CAN1 TX			*/
    .long    USB_LP_CAN_RX0_IRQHandler	/* 20: CAN1 RX0			*/
    .long    CAN_RX1_IRQHandler		/* 21: CAN1 RX1			*/
    .long    CAN_SCE_IRQHandler		/* 22: CAN1 SCE			*/
    .long    EXTI9_5_IRQHandler		/* 23: EXTI Line5-9                   */
    .long    TIM1_BRK_IRQHandler	/* 24: TIM1 Break				*/
    .long    TIM1_UP_IRQHandler		/* 25: TIM1 Update			*/
    .long    TIM1_TRG_COM_IRQHandler	/* 26: TIM1 Trigger and Commutation	*/
    .long    TIM1_CC_IRQHandler		/* 27: TIM1 Capture Compare	*/
    .long    TIM2_IRQHandler		/*  28:  Timer2 global			*/
    .long    TIM3_IRQHandler		/*  29:  Timer3 global			*/
    .long    TIM4_IRQHandler		/*  30:  Timer4 global			*/
    .long    I2C1_EV_IRQHandler		/* 31: I2C1 event		*/
    .long    I2C1_ER_IRQHandler		/* 32: I2C1 error		*/
    .long    I2C2_EV_IRQHandler		/* 33: I2C2 event		*/
    .long    I2C2_ER_IRQHandler		/* 34: I2C2 error		*/
    .long    SPI1_IRQHandler		/* 35: SPI1 global		*/
    .long    SPI2_IRQHandler		/* 36: SPI2 global		*/
    .long    USART1_IRQHandler		/* 37: USART1 global	*/
    .long    USART2_IRQHandler		/* 38: USART2 global	*/
    .long    USART3_IRQHandler		/* 39: USART3 global	*/
    .long    EXTI15_10_IRQHandler	/* 40: EXTI Line10-15		*/
    .long    RTCAlarm_IRQHandler	/* 41: RTC alarm through EXTI line	*/
    .long    USBWakeUp_IRQHandler	/* 42: USB OTG FS Wakeup through EXTI line	*/
    .long    0                     		/* 62: Ethernet Wakeup through EXTI line	*/
    .long    0                     		/* 63: CAN2 TX			*/
    .long    0                     		/* 64: CAN2 RX0			*/
    .long    0                     		/* 65: CAN2 RX1			*/
    .long    0                     		/* 66: CAN2 SCE			*/
    .long    0                     		/* 67: USB OTG FS global	*/
    .size    __isr_vector, . - __isr_vector

    .text
    .thumb
    .thumb_func
    .align 2
    .globl    Reset_Handler
    .type    Reset_Handler, %function
Reset_Handler:
/*     Loop to copy data from read only memory to RAM. The ranges
 *      of copy from/to are specified by following symbols evaluated in
 *      linker script.
 *      __etext: End of code section, i.e., begin of data sections to copy from.
 *      __data_start__/__data_end__: RAM address range that data should be
 *      copied to. Both must be aligned to 4 bytes boundary.  */
    ldr    r1, =__etext
    ldr    r2, =__data_start__
    ldr    r3, =__data_end__

#if 1
/* Here are two copies of loop implemenations. First one favors code size
 * and the second one favors performance. Default uses the first one.
 * Change to "#if 0" to use the second one */
.flash_to_ram_loop:
    cmp     r2, r3
    ittt    lt
    ldrlt   r0, [r1], #4
    strlt   r0, [r2], #4
    blt    .flash_to_ram_loop
#else
    subs    r3, r2
    ble    .flash_to_ram_loop_end
.flash_to_ram_loop:
    subs    r3, #4
    ldr    r0, [r1, r3]
    str    r0, [r2, r3]
    bgt    .flash_to_ram_loop
.flash_to_ram_loop_end:
#endif

/*     Loop to fill zero to the bss segment.. The ranges
 *      of copy from/to are specified by following symbols evaluated in
 *      linker script.
 *      __bss_start__/__bss_end__: RAM address range that data should be
 *      filled to 0. Both must be aligned to 4 bytes boundary.  */
    movs    r1, #0x0
    ldr    r2, =__bss_start__
    ldr    r3, =__bss_end__
.clear_bss_loop:
    str    r1, [r2], #0x4
    cmp     r2, r3
    blt    .clear_bss_loop

#ifndef __NO_SYSTEM_INIT		// call SystemInit in main()
    ldr    r0, =SystemInit
    blx    r0
#endif

    ldr    r0, =main
    bx    r0
    .pool
    .size Reset_Handler, . - Reset_Handler

/*    Macro to define default handlers. Default handler
 *    will be weak symbol and just dead loops. They can be
 *    overwritten by other handlers */
    .macro    def_irq_handler    handler_name
    .align 1
    .thumb_func
    .weak    \handler_name
    .type    \handler_name, %function
\handler_name :
    b    .
    .size    \handler_name, . - \handler_name
    .endm
/*
    def_irq_handler    NMI_Handler
    def_irq_handler    HardFault_Handler
    def_irq_handler    MemManage_Handler
    def_irq_handler    BusFault_Handler
    def_irq_handler    UsageFault_Handler
    def_irq_handler    SVC_Handler
    def_irq_handler    DebugMon_Handler
    def_irq_handler    PendSV_Handler
    def_irq_handler    SysTick_Handler
*/
    def_irq_handler    WWDG_IRQHandler        /*  0:  Watchdog Timer            */
    def_irq_handler    PVD_IRQHandler        /*  1:  PVD through EXTI Line detection     */
    def_irq_handler    TAMPER_IRQHandler		/* 2: tamper                   */
    def_irq_handler    RTC_IRQHandler        /*  3:  Real Time Clock           */
    def_irq_handler    FLASH_IRQHandler		/* 4: flash global                   */
    def_irq_handler    RCC_IRQHandler		/* 5: RCC global                   */
    def_irq_handler    EXTI0_IRQHandler		/* 6: EXTI Line0                   */
    def_irq_handler    EXTI1_IRQHandler		/* 7: EXTI Line1                   */
    def_irq_handler    EXTI2_IRQHandler		/* 8: EXTI Line2                   */
    def_irq_handler    EXTI3_IRQHandler		/* 9: EXTI Line3                   */
    def_irq_handler    EXTI4_IRQHandler		/* 10: EXTI Line4                   */
    def_irq_handler    DMA1_Channel1_IRQHandler	/* 11: DMA1 Channel1 global   */
    def_irq_handler    DMA1_Channel2_IRQHandler	/* 12: DMA1 Channel2 global   */
    def_irq_handler    DMA1_Channel3_IRQHandler	/* 13: DMA1 Channel3 global   */
    def_irq_handler    DMA1_Channel4_IRQHandler	/* 14: DMA1 Channel4 global   */
    def_irq_handler    DMA1_Channel5_IRQHandler	/* 15: DMA1 Channel5 global   */
    def_irq_handler    DMA1_Channel6_IRQHandler	/* 16: DMA1 Channel6 global   */
    def_irq_handler    DMA1_Channel7_IRQHandler	/* 17: DMA1 Channel7 global   */
    def_irq_handler    ADC1_2_IRQHandler		/* 18: ADC1 and ADC2 global   */
    def_irq_handler    USB_HP_CAN_TX_IRQHandler	/* 19: CAN1 TX			*/
    def_irq_handler    USB_LP_CAN_RX0_IRQHandler	/* 20: CAN1 RX0			*/
    def_irq_handler    CAN_RX1_IRQHandler		/* 21: CAN1 RX1			*/
    def_irq_handler    CAN_SCE_IRQHandler		/* 22: CAN1 SCE			*/
    def_irq_handler    EXTI9_5_IRQHandler		/* 23: EXTI Line5-9                   */
    def_irq_handler    TIM1_BRK_IRQHandler	/* 24: TIM1 Break				*/
    def_irq_handler    TIM1_UP_IRQHandler		/* 25: TIM1 Update			*/
    def_irq_handler    TIM1_TRG_COM_IRQHandler	/* 26: TIM1 Trigger and Commutation	*/
    def_irq_handler    TIM1_CC_IRQHandler		/* 27: TIM1 Capture Compare	*/
    def_irq_handler    TIM2_IRQHandler		/*  28:  Timer2 global			*/
    def_irq_handler    TIM3_IRQHandler		/*  29:  Timer3 global			*/
    def_irq_handler    TIM4_IRQHandler		/*  30:  Timer4 global			*/
    def_irq_handler    I2C1_EV_IRQHandler		/* 31: I2C1 event		*/
    def_irq_handler    I2C1_ER_IRQHandler		/* 32: I2C1 error		*/
    def_irq_handler    I2C2_EV_IRQHandler		/* 33: I2C2 event		*/
    def_irq_handler    I2C2_ER_IRQHandler		/* 34: I2C2 error		*/
    def_irq_handler    SPI1_IRQHandler		/* 35: SPI1 global		*/
    def_irq_handler    SPI2_IRQHandler		/* 36: SPI2 global		*/
    def_irq_handler    USART1_IRQHandler		/* 37: USART1 global	*/
    def_irq_handler    USART2_IRQHandler		/* 38: USART2 global	*/
    def_irq_handler    USART3_IRQHandler		/* 39: USART3 global	*/
    def_irq_handler    EXTI15_10_IRQHandler	/* 40: EXTI Line10-15		*/
    def_irq_handler    RTCAlarm_IRQHandler	/* 41: RTC alarm through EXTI line	*/
    def_irq_handler    USBWakeUp_IRQHandler	/* 42: USB OTG FS Wakeup through EXTI line	*/
    .end
