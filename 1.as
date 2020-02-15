opt subtitle "HI-TECH Software Omniscient Code Generator (PRO mode) build 10920"

opt pagewidth 120

	opt pm

	processor	16F685
clrc	macro
	bcf	3,0
	endm
clrz	macro
	bcf	3,2
	endm
setc	macro
	bsf	3,0
	endm
setz	macro
	bsf	3,2
	endm
skipc	macro
	btfss	3,0
	endm
skipz	macro
	btfss	3,2
	endm
skipnc	macro
	btfsc	3,0
	endm
skipnz	macro
	btfsc	3,2
	endm
indf	equ	0
indf0	equ	0
pc	equ	2
pcl	equ	2
status	equ	3
fsr	equ	4
fsr0	equ	4
c	equ	1
z	equ	0
pclath	equ	10
	FNCALL	_main,_OSC_INIT
	FNCALL	_main,_TIMER0_INITIAL
	FNCALL	_main,_TIMER2_INITIAL
	FNCALL	_main,_INT_INITIAL
	FNCALL	_main,_EEPROM_Read
	FNCALL	_main,_WDT_INITIAL
	FNCALL	_main,_EX_INT_FallingEdge
	FNCALL	_EEPROM_Read,_EEPROM_ReadWord
	FNCALL	_EEPROM_Read,_IAPRead
	FNCALL	_EEPROM_ReadWord,_IAPRead
	FNCALL	_INT_INITIAL,_EX_INT_FallingEdge
	FNROOT	_main
	FNCALL	_ISR,_EX_INT_RisingEdge
	FNCALL	_ISR,i1_EX_INT_FallingEdge
	FNCALL	_ISR,___wmul
	FNCALL	_ISR,_led1_debug
	FNCALL	_ISR,_KEYSCAN
	FNCALL	_ISR,_KEY
	FNCALL	_KEY,_CH1_EEPROM_Write
	FNCALL	_KEY,_CH2_EEPROM_Write
	FNCALL	_KEY,_CH3_EEPROM_Write
	FNCALL	_KEY,_led1_debug
	FNCALL	_CH3_EEPROM_Write,_IAPWrite
	FNCALL	_CH2_EEPROM_Write,_IAPWrite
	FNCALL	_CH1_EEPROM_Write,_IAPWrite
	FNCALL	intlevel1,_ISR
	global	intlevel1
	FNROOT	intlevel1
	global	_Match_remotekey
	global	_KEY3_LongPress
	global	_KEY_Match_counter
	global	_LONGPRESS_OverTime_Counter
	global	_PRESS_FLAG
	global	_match_slice
	global	_ms16_counter
	global	_num
	global	_remotekey_Receive_num
	global	_remotekey_slice
	global	_buff
	global	_FLAGs
	global	_KEY1_LongPress
	global	_KEY2_LongPress
	global	_PRESSED
	global	_Ctrl_remotekey
	global	_remotekey
	global	_HIndata
	global	_Indata
	global	_LIndata
	global	_i
	global	_CH1_remotekey
	global	_CH2_remotekey
	global	_CH3_remotekey
	global	_ANSEL
psect	text677,local,class=CODE,delta=2
global __ptext677
__ptext677:
_ANSEL	set	286
	DABS	1,286,1	;_ANSEL

	global	_ANSELH
_ANSELH	set	287
	DABS	1,287,1	;_ANSELH

	global	_CM1CON0
_CM1CON0	set	281
	DABS	1,281,1	;_CM1CON0

	global	_CM2CON0
_CM2CON0	set	282
	DABS	1,282,1	;_CM2CON0

	global	_CM2CON1
_CM2CON1	set	283
	DABS	1,283,1	;_CM2CON1

	global	_EEADRH
_EEADRH	set	271
	DABS	1,271,1	;_EEADRH

	global	_EEDATH
_EEDATH	set	270
	DABS	1,270,1	;_EEDATH

	global	_IOCB
_IOCB	set	278
	DABS	1,278,1	;_IOCB

	global	_PSTRCON
_PSTRCON	set	413
	DABS	1,413,1	;_PSTRCON

	global	_SRCON
_SRCON	set	414
	DABS	1,414,1	;_SRCON

	global	_VRCON
_VRCON	set	280
	DABS	1,280,1	;_VRCON

	global	_WPUB
_WPUB	set	277
	DABS	1,277,1	;_WPUB

	global	_ANS0
_ANS0	set	2288
	DABS	1,286,1	;_ANS0

	global	_ANS1
_ANS1	set	2289
	DABS	1,286,1	;_ANS1

	global	_ANS10
_ANS10	set	2298
	DABS	1,287,1	;_ANS10

	global	_ANS11
_ANS11	set	2299
	DABS	1,287,1	;_ANS11

	global	_ANS2
_ANS2	set	2290
	DABS	1,286,1	;_ANS2

	global	_ANS3
_ANS3	set	2291
	DABS	1,286,1	;_ANS3

	global	_ANS4
_ANS4	set	2292
	DABS	1,286,1	;_ANS4

	global	_ANS5
_ANS5	set	2293
	DABS	1,286,1	;_ANS5

	global	_ANS6
_ANS6	set	2294
	DABS	1,286,1	;_ANS6

	global	_ANS7
_ANS7	set	2295
	DABS	1,286,1	;_ANS7

	global	_ANS8
_ANS8	set	2296
	DABS	1,287,1	;_ANS8

	global	_ANS9
_ANS9	set	2297
	DABS	1,287,1	;_ANS9

	global	_C1CH0
_C1CH0	set	2248
	DABS	1,281,1	;_C1CH0

	global	_C1CH1
_C1CH1	set	2249
	DABS	1,281,1	;_C1CH1

	global	_C1OE
_C1OE	set	2253
	DABS	1,281,1	;_C1OE

	global	_C1ON
_C1ON	set	2255
	DABS	1,281,1	;_C1ON

	global	_C1OUT
_C1OUT	set	2254
	DABS	1,281,1	;_C1OUT

	global	_C1POL
_C1POL	set	2252
	DABS	1,281,1	;_C1POL

	global	_C1R
_C1R	set	2250
	DABS	1,281,1	;_C1R

	global	_C1SEN
_C1SEN	set	3317
	DABS	1,414,1	;_C1SEN

	global	_C1VREN
_C1VREN	set	2247
	DABS	1,280,1	;_C1VREN

	global	_C2CH0
_C2CH0	set	2256
	DABS	1,282,1	;_C2CH0

	global	_C2CH1
_C2CH1	set	2257
	DABS	1,282,1	;_C2CH1

	global	_C2OE
_C2OE	set	2261
	DABS	1,282,1	;_C2OE

	global	_C2ON
_C2ON	set	2263
	DABS	1,282,1	;_C2ON

	global	_C2OUT
_C2OUT	set	2262
	DABS	1,282,1	;_C2OUT

	global	_C2POL
_C2POL	set	2260
	DABS	1,282,1	;_C2POL

	global	_C2R
_C2R	set	2258
	DABS	1,282,1	;_C2R

	global	_C2REN
_C2REN	set	3316
	DABS	1,414,1	;_C2REN

	global	_C2SYNC
_C2SYNC	set	2264
	DABS	1,283,1	;_C2SYNC

	global	_C2VREN
_C2VREN	set	2246
	DABS	1,280,1	;_C2VREN

	global	_EEPGD
_EEPGD	set	3175
	DABS	1,396,1	;_EEPGD

	global	_IOCB4
_IOCB4	set	2228
	DABS	1,278,1	;_IOCB4

	global	_IOCB5
_IOCB5	set	2229
	DABS	1,278,1	;_IOCB5

	global	_IOCB6
_IOCB6	set	2230
	DABS	1,278,1	;_IOCB6

	global	_IOCB7
_IOCB7	set	2231
	DABS	1,278,1	;_IOCB7

	global	_MC1OUT
_MC1OUT	set	2271
	DABS	1,283,1	;_MC1OUT

	global	_MC2OUT
_MC2OUT	set	2270
	DABS	1,283,1	;_MC2OUT

	global	_PULSR
_PULSR	set	3314
	DABS	1,414,1	;_PULSR

	global	_PULSS
_PULSS	set	3315
	DABS	1,414,1	;_PULSS

	global	_SR0
_SR0	set	3318
	DABS	1,414,1	;_SR0

	global	_SR1
_SR1	set	3319
	DABS	1,414,1	;_SR1

	global	_STRA
_STRA	set	3304
	DABS	1,413,1	;_STRA

	global	_STRB
_STRB	set	3305
	DABS	1,413,1	;_STRB

	global	_STRC
_STRC	set	3306
	DABS	1,413,1	;_STRC

	global	_STRD
_STRD	set	3307
	DABS	1,413,1	;_STRD

	global	_STRSYNC
_STRSYNC	set	3308
	DABS	1,413,1	;_STRSYNC

	global	_T1GSS
_T1GSS	set	2265
	DABS	1,283,1	;_T1GSS

	global	_VP6EN
_VP6EN	set	2244
	DABS	1,280,1	;_VP6EN

	global	_VR0
_VR0	set	2240
	DABS	1,280,1	;_VR0

	global	_VR1
_VR1	set	2241
	DABS	1,280,1	;_VR1

	global	_VR2
_VR2	set	2242
	DABS	1,280,1	;_VR2

	global	_VR3
_VR3	set	2243
	DABS	1,280,1	;_VR3

	global	_VRR
_VRR	set	2245
	DABS	1,280,1	;_VRR

	global	_WPUB4
_WPUB4	set	2220
	DABS	1,277,1	;_WPUB4

	global	_WPUB5
_WPUB5	set	2221
	DABS	1,277,1	;_WPUB5

	global	_WPUB6
_WPUB6	set	2222
	DABS	1,277,1	;_WPUB6

	global	_WPUB7
_WPUB7	set	2223
	DABS	1,277,1	;_WPUB7

	global	_WREN
_WREN	set	3170
	DABS	1,396,1	;_WREN

	global	_CH1_remotekey_num
psect	nvBANK0,class=BANK0,space=1
global __pnvBANK0
__pnvBANK0:
_CH1_remotekey_num:
       ds      1

	global	_CH2_remotekey_num
_CH2_remotekey_num:
       ds      1

	global	_CH3_remotekey_num
_CH3_remotekey_num:
       ds      1

	global	_INTCON
_INTCON	set	11
	global	_PORTA
_PORTA	set	5
	global	_PORTC
_PORTC	set	7
	global	_T2CON0
_T2CON0	set	18
	global	_TMR0
_TMR0	set	1
	global	_TMR2H
_TMR2H	set	19
	global	_TMR2L
_TMR2L	set	17
	global	_WDTCON
_WDTCON	set	24
	global	_EEIF
_EEIF	set	103
	global	_GIE
_GIE	set	95
	global	_INTE
_INTE	set	92
	global	_INTF
_INTF	set	89
	global	_PA2
_PA2	set	42
	global	_PA3
_PA3	set	43
	global	_PA4
_PA4	set	44
	global	_PA5
_PA5	set	45
	global	_PA6
_PA6	set	46
	global	_PA7
_PA7	set	47
	global	_PC0
_PC0	set	56
	global	_PC4
_PC4	set	60
	global	_PC5
_PC5	set	61
	global	_PEIE
_PEIE	set	94
	global	_T0IE
_T0IE	set	93
	global	_T0IF
_T0IF	set	90
	global	_TMR2IF
_TMR2IF	set	97
	global	_TMR2ON
_TMR2ON	set	146
	global	_EEADR
_EEADR	set	155
	global	_EECON1
_EECON1	set	156
	global	_EEDAT
_EEDAT	set	154
	global	_OPTION
_OPTION	set	129
	global	_OSCCON
_OSCCON	set	143
	global	_PR2H
_PR2H	set	146
	global	_PR2L
_PR2L	set	145
	global	_PSINKA
_PSINKA	set	151
	global	_PSINKC
_PSINKC	set	159
	global	_PSRCA
_PSRCA	set	136
	global	_PSRCC
_PSRCC	set	148
	global	_T2CON1
_T2CON1	set	158
	global	_TRISA
_TRISA	set	133
	global	_TRISC
_TRISC	set	135
	global	_WPUA
_WPUA	set	149
	global	_WPUC
_WPUC	set	147
	global	_INTEDG
_INTEDG	set	1038
	global	_IOCA2
_IOCA2	set	1202
	global	_PSA
_PSA	set	1035
	global	_RD
_RD	set	1248
	global	_T0CS
_T0CS	set	1037
	global	_TMR2IE
_TMR2IE	set	1121
	global	_TRISA2
_TRISA2	set	1066
	global	_WR
_WR	set	1256
	global	_CH1_remotekey_Latest
psect	nvBANK1,class=BANK1,space=1
global __pnvBANK1
__pnvBANK1:
_CH1_remotekey_Latest:
       ds      1

	global	_CH2_remotekey_Latest
_CH2_remotekey_Latest:
       ds      1

	global	_CH3_remotekey_Latest
_CH3_remotekey_Latest:
       ds      1

	global	_EE_Buff
_EE_Buff:
       ds      1

	file	"1.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

psect	bssCOMMON,class=COMMON,space=1
global __pbssCOMMON
__pbssCOMMON:
_buff:
       ds      2

_FLAGs:
       ds      1

_KEY1_LongPress:
       ds      1

_KEY2_LongPress:
       ds      1

_PRESSED:
       ds      1

psect	bssBANK0,class=BANK0,space=1
global __pbssBANK0
__pbssBANK0:
_Match_remotekey:
       ds      4

_KEY3_LongPress:
       ds      1

_KEY_Match_counter:
       ds      1

_LONGPRESS_OverTime_Counter:
       ds      1

_PRESS_FLAG:
       ds      1

_match_slice:
       ds      1

_ms16_counter:
       ds      1

_num:
       ds      1

_remotekey_Receive_num:
       ds      1

_remotekey_slice:
       ds      1

_CH1_remotekey:
       ds      16

_CH2_remotekey:
       ds      16

_CH3_remotekey:
       ds      16

psect	bssBANK1,class=BANK1,space=1
global __pbssBANK1
__pbssBANK1:
_Ctrl_remotekey:
       ds      4

_remotekey:
       ds      4

_HIndata:
       ds      2

_Indata:
       ds      2

_LIndata:
       ds      2

_i:
       ds      1

psect clrtext,class=CODE,delta=2
global clear_ram
;	Called with FSR containing the base address, and
;	W with the last address+1
clear_ram:
	clrwdt			;clear the watchdog before getting into this loop
clrloop:
	clrf	indf		;clear RAM location pointed to by FSR
	incf	fsr,f		;increment pointer
	xorwf	fsr,w		;XOR with final address
	btfsc	status,2	;have we reached the end yet?
	retlw	0		;all done for this memory range, return
	xorwf	fsr,w		;XOR again to restore value
	goto	clrloop		;do the next byte

; Clear objects allocated to COMMON
psect cinit,class=CODE,delta=2
	movlw	low(__pbssCOMMON)
	movwf	fsr
	movlw	low((__pbssCOMMON)+06h)
	fcall	clear_ram
; Clear objects allocated to BANK0
psect cinit,class=CODE,delta=2
	bcf	status, 7	;select IRP bank0
	movlw	low(__pbssBANK0)
	movwf	fsr
	movlw	low((__pbssBANK0)+03Dh)
	fcall	clear_ram
; Clear objects allocated to BANK1
psect cinit,class=CODE,delta=2
	movlw	low(__pbssBANK1)
	movwf	fsr
	movlw	low((__pbssBANK1)+0Fh)
	fcall	clear_ram
psect cinit,class=CODE,delta=2
global end_of_initialization

;End of C runtime variable initialization code

end_of_initialization:
clrf status
ljmp _main	;jump to C main() function
psect	cstackBANK1,class=BANK1,space=1
global __pcstackBANK1
__pcstackBANK1:
	global	??_EX_INT_FallingEdge
??_EX_INT_FallingEdge:	; 0 bytes @ 0x0
	global	??_INT_INITIAL
??_INT_INITIAL:	; 0 bytes @ 0x0
	global	??_OSC_INIT
??_OSC_INIT:	; 0 bytes @ 0x0
	global	??_WDT_INITIAL
??_WDT_INITIAL:	; 0 bytes @ 0x0
	global	??_TIMER0_INITIAL
??_TIMER0_INITIAL:	; 0 bytes @ 0x0
	global	??_TIMER2_INITIAL
??_TIMER2_INITIAL:	; 0 bytes @ 0x0
	global	??_IAPRead
??_IAPRead:	; 0 bytes @ 0x0
	global	IAPRead@EEAddr
IAPRead@EEAddr:	; 1 bytes @ 0x0
	ds	1
	global	IAPRead@ReEEPROMread
IAPRead@ReEEPROMread:	; 1 bytes @ 0x1
	ds	1
	global	?_EEPROM_ReadWord
?_EEPROM_ReadWord:	; 0 bytes @ 0x2
	global	EEPROM_ReadWord@data
EEPROM_ReadWord@data:	; 1 bytes @ 0x2
	ds	1
	global	??_EEPROM_ReadWord
??_EEPROM_ReadWord:	; 0 bytes @ 0x3
	ds	4
	global	EEPROM_ReadWord@buff
EEPROM_ReadWord@buff:	; 1 bytes @ 0x7
	ds	1
	global	??_EEPROM_Read
??_EEPROM_Read:	; 0 bytes @ 0x8
	global	??_main
??_main:	; 0 bytes @ 0x8
psect	cstackCOMMON,class=COMMON,space=1
global __pcstackCOMMON
__pcstackCOMMON:
	global	?_EX_INT_RisingEdge
?_EX_INT_RisingEdge:	; 0 bytes @ 0x0
	global	??_EX_INT_RisingEdge
??_EX_INT_RisingEdge:	; 0 bytes @ 0x0
	global	?_EX_INT_FallingEdge
?_EX_INT_FallingEdge:	; 0 bytes @ 0x0
	global	?_led1_debug
?_led1_debug:	; 0 bytes @ 0x0
	global	??_led1_debug
??_led1_debug:	; 0 bytes @ 0x0
	global	?_KEYSCAN
?_KEYSCAN:	; 0 bytes @ 0x0
	global	??_KEYSCAN
??_KEYSCAN:	; 0 bytes @ 0x0
	global	?_KEY
?_KEY:	; 0 bytes @ 0x0
	global	?_ISR
?_ISR:	; 0 bytes @ 0x0
	global	?_INT_INITIAL
?_INT_INITIAL:	; 0 bytes @ 0x0
	global	?_OSC_INIT
?_OSC_INIT:	; 0 bytes @ 0x0
	global	?_WDT_INITIAL
?_WDT_INITIAL:	; 0 bytes @ 0x0
	global	?_TIMER0_INITIAL
?_TIMER0_INITIAL:	; 0 bytes @ 0x0
	global	?_TIMER2_INITIAL
?_TIMER2_INITIAL:	; 0 bytes @ 0x0
	global	?_IAPWrite
?_IAPWrite:	; 0 bytes @ 0x0
	global	?_CH1_EEPROM_Write
?_CH1_EEPROM_Write:	; 0 bytes @ 0x0
	global	?_CH2_EEPROM_Write
?_CH2_EEPROM_Write:	; 0 bytes @ 0x0
	global	?_CH3_EEPROM_Write
?_CH3_EEPROM_Write:	; 0 bytes @ 0x0
	global	?_EEPROM_Read
?_EEPROM_Read:	; 0 bytes @ 0x0
	global	?i1_EX_INT_FallingEdge
?i1_EX_INT_FallingEdge:	; 0 bytes @ 0x0
	global	??i1_EX_INT_FallingEdge
??i1_EX_INT_FallingEdge:	; 0 bytes @ 0x0
	global	?_IAPRead
?_IAPRead:	; 1 bytes @ 0x0
	global	?_main
?_main:	; 2 bytes @ 0x0
	global	?___wmul
?___wmul:	; 2 bytes @ 0x0
	global	IAPWrite@Data
IAPWrite@Data:	; 1 bytes @ 0x0
	global	___wmul@multiplier
___wmul@multiplier:	; 2 bytes @ 0x0
	ds	1
	global	??_IAPWrite
??_IAPWrite:	; 0 bytes @ 0x1
	global	IAPWrite@EEAddr
IAPWrite@EEAddr:	; 1 bytes @ 0x1
	ds	1
	global	??_KEY
??_KEY:	; 0 bytes @ 0x2
	global	??_CH1_EEPROM_Write
??_CH1_EEPROM_Write:	; 0 bytes @ 0x2
	global	??_CH2_EEPROM_Write
??_CH2_EEPROM_Write:	; 0 bytes @ 0x2
	global	??_CH3_EEPROM_Write
??_CH3_EEPROM_Write:	; 0 bytes @ 0x2
	global	___wmul@multiplicand
___wmul@multiplicand:	; 2 bytes @ 0x2
	ds	2
	global	??___wmul
??___wmul:	; 0 bytes @ 0x4
	global	___wmul@product
___wmul@product:	; 2 bytes @ 0x4
	ds	2
psect	cstackBANK0,class=BANK0,space=1
global __pcstackBANK0
__pcstackBANK0:
	global	??_ISR
??_ISR:	; 0 bytes @ 0x0
	ds	10
;;Data sizes: Strings 0, constant 0, data 0, bss 82, persistent 7 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON          14      6      12
;; BANK0           80     10      74
;; BANK1           32      8      27

;;
;; Pointer list with targets:

;; ?___wmul	unsigned int  size(1) Largest target is 0
;;
;; EEPROM_ReadWord@buff	PTR unsigned long  size(1) Largest target is 16
;;		 -> CH3_remotekey(BANK0[16]), CH2_remotekey(BANK0[16]), CH1_remotekey(BANK0[16]), 
;;


;;
;; Critical Paths under _main in COMMON
;;
;;   None.
;;
;; Critical Paths under _ISR in COMMON
;;
;;   _ISR->___wmul
;;   _CH3_EEPROM_Write->_IAPWrite
;;   _CH2_EEPROM_Write->_IAPWrite
;;   _CH1_EEPROM_Write->_IAPWrite
;;
;; Critical Paths under _main in BANK0
;;
;;   None.
;;
;; Critical Paths under _ISR in BANK0
;;
;;   None.
;;
;; Critical Paths under _main in BANK1
;;
;;   _EEPROM_Read->_EEPROM_ReadWord
;;   _EEPROM_ReadWord->_IAPRead
;;
;; Critical Paths under _ISR in BANK1
;;
;;   None.

;;
;;Main: autosize = 0, tempsize = 0, incstack = 0, save=0
;;

;;
;;Call Graph Tables:
;;
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (0) _main                                                 0     0      0     471
;;                           _OSC_INIT
;;                     _TIMER0_INITIAL
;;                     _TIMER2_INITIAL
;;                        _INT_INITIAL
;;                        _EEPROM_Read
;;                        _WDT_INITIAL
;;                 _EX_INT_FallingEdge
;; ---------------------------------------------------------------------------------
;; (1) _EEPROM_Read                                          0     0      0     471
;;                    _EEPROM_ReadWord
;;                            _IAPRead
;; ---------------------------------------------------------------------------------
;; (2) _EEPROM_ReadWord                                      6     5      1     406
;;                                              2 BANK1      6     5      1
;;                            _IAPRead
;; ---------------------------------------------------------------------------------
;; (1) _INT_INITIAL                                          0     0      0       0
;;                 _EX_INT_FallingEdge
;; ---------------------------------------------------------------------------------
;; (2) _IAPRead                                              2     2      0      65
;;                                              0 BANK1      2     2      0
;; ---------------------------------------------------------------------------------
;; (1) _TIMER2_INITIAL                                       0     0      0       0
;; ---------------------------------------------------------------------------------
;; (1) _TIMER0_INITIAL                                       0     0      0       0
;; ---------------------------------------------------------------------------------
;; (1) _WDT_INITIAL                                          0     0      0       0
;; ---------------------------------------------------------------------------------
;; (1) _OSC_INIT                                             0     0      0       0
;; ---------------------------------------------------------------------------------
;; (1) _EX_INT_FallingEdge                                   0     0      0       0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 2
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (4) _ISR                                                 10    10      0     224
;;                                              0 BANK0     10    10      0
;;                  _EX_INT_RisingEdge
;;               i1_EX_INT_FallingEdge
;;                             ___wmul
;;                         _led1_debug
;;                            _KEYSCAN
;;                                _KEY
;; ---------------------------------------------------------------------------------
;; (5) _KEY                                                  2     2      0     132
;;                                              2 COMMON     2     2      0
;;                   _CH1_EEPROM_Write
;;                   _CH2_EEPROM_Write
;;                   _CH3_EEPROM_Write
;;                         _led1_debug
;; ---------------------------------------------------------------------------------
;; (6) _CH3_EEPROM_Write                                     0     0      0      44
;;                           _IAPWrite
;; ---------------------------------------------------------------------------------
;; (6) _CH2_EEPROM_Write                                     0     0      0      44
;;                           _IAPWrite
;; ---------------------------------------------------------------------------------
;; (6) _CH1_EEPROM_Write                                     0     0      0      44
;;                           _IAPWrite
;; ---------------------------------------------------------------------------------
;; (5) i1_EX_INT_FallingEdge                                 0     0      0       0
;; ---------------------------------------------------------------------------------
;; (5) ___wmul                                               6     2      4      92
;;                                              0 COMMON     6     2      4
;; ---------------------------------------------------------------------------------
;; (7) _IAPWrite                                             2     1      1      44
;;                                              0 COMMON     2     1      1
;; ---------------------------------------------------------------------------------
;; (5) _KEYSCAN                                              0     0      0       0
;; ---------------------------------------------------------------------------------
;; (6) _led1_debug                                           0     0      0       0
;; ---------------------------------------------------------------------------------
;; (5) _EX_INT_RisingEdge                                    0     0      0       0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 7
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;   _OSC_INIT
;;   _TIMER0_INITIAL
;;   _TIMER2_INITIAL
;;   _INT_INITIAL
;;     _EX_INT_FallingEdge
;;   _EEPROM_Read
;;     _EEPROM_ReadWord
;;       _IAPRead
;;     _IAPRead
;;   _WDT_INITIAL
;;   _EX_INT_FallingEdge
;;
;; _ISR (ROOT)
;;   _EX_INT_RisingEdge
;;   i1_EX_INT_FallingEdge
;;   ___wmul
;;   _led1_debug
;;   _KEYSCAN
;;   _KEY
;;     _CH1_EEPROM_Write
;;       _IAPWrite
;;     _CH2_EEPROM_Write
;;       _IAPWrite
;;     _CH3_EEPROM_Write
;;       _IAPWrite
;;     _led1_debug
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;BITCOMMON            E      0       0       0        0.0%
;;EEDATA             100      0       0       0        0.0%
;;NULL                 0      0       0       0        0.0%
;;CODE                 0      0       0       0        0.0%
;;COMMON               E      6       C       1       85.7%
;;BITSFR0              0      0       0       1        0.0%
;;SFR0                 0      0       0       1        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;SFR1                 0      0       0       2        0.0%
;;STACK                0      0       B       2        0.0%
;;BITBANK0            50      0       0       3        0.0%
;;BANK0               50      A      4A       4       92.5%
;;BANK1               20      8      1B       5       84.4%
;;ABS                  0      0      71       6        0.0%
;;BITBANK1            20      0       0       7        0.0%
;;DATA                 0      0      7C       8        0.0%

	global	_main
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:

;; *************** function _main *****************
;; Defined at:
;;		line 781 in file "1.C"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  2  1056[COMMON] int 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 0/0
;;		Unchanged: FFE00/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels required when called:    7
;; This function calls:
;;		_OSC_INIT
;;		_TIMER0_INITIAL
;;		_TIMER2_INITIAL
;;		_INT_INITIAL
;;		_EEPROM_Read
;;		_WDT_INITIAL
;;		_EX_INT_FallingEdge
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"1.C"
	line	781
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 1
; Regs used in _main: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	782
	
l3805:	
;1.C: 782: OSC_INIT();
	fcall	_OSC_INIT
	line	783
;1.C: 783: TIMER0_INITIAL();
	fcall	_TIMER0_INITIAL
	line	784
;1.C: 784: TIMER2_INITIAL();
	fcall	_TIMER2_INITIAL
	line	785
	
l3807:	
;1.C: 785: INT_INITIAL();
	fcall	_INT_INITIAL
	line	786
	
l3809:	
;1.C: 786: EEPROM_Read();
	fcall	_EEPROM_Read
	line	787
	
l3811:	
;1.C: 787: WDT_INITIAL();
	fcall	_WDT_INITIAL
	line	788
	
l3813:	
;1.C: 788: PC0 = 1;
	bsf	(56/8),(56)&7
	line	789
	
l3815:	
;1.C: 789: PA7 = 1;
	bsf	(47/8),(47)&7
	line	790
	
l3817:	
;1.C: 790: PA6 = 1;
	bsf	(46/8),(46)&7
	line	791
	
l3819:	
;1.C: 791: PA5 = 1;
	bsf	(45/8),(45)&7
	line	793
	
l3821:	
;1.C: 793: PA3 = 0;
	bcf	(43/8),(43)&7
	line	794
	
l3823:	
;1.C: 794: FLAGs &= ~0x08;
	bcf	(_FLAGs)+(3/8),(3)&7
	line	795
	
l3825:	
;1.C: 795: EX_INT_FallingEdge();
	fcall	_EX_INT_FallingEdge
	line	796
	
l3827:	
;1.C: 796: INTE =1;
	bsf	(92/8),(92)&7
	line	797
	
l3829:	
;1.C: 797: TMR2ON =1;
	bcf	status, 5	;RP0=0, select bank0
	bsf	(146/8),(146)&7
	line	799
	
l3831:	
;1.C: 799: PEIE = 1;
	bsf	(94/8),(94)&7
	line	800
	
l3833:	
;1.C: 800: GIE = 1;
	bsf	(95/8),(95)&7
	line	802
	
l3835:	
# 802 "1.C"
clrwdt ;#
psect	maintext
	goto	l3835
	global	start
	ljmp	start
	opt stack 0
psect	maintext
	line	805
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,90
	global	_EEPROM_Read
psect	text678,local,class=CODE,delta=2
global __ptext678
__ptext678:

;; *************** function _EEPROM_Read *****************
;; Defined at:
;;		line 566 in file "1.C"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 17F/20
;;		On exit  : 17F/20
;;		Unchanged: FFE80/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    6
;; This function calls:
;;		_EEPROM_ReadWord
;;		_IAPRead
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text678
	file	"1.C"
	line	566
	global	__size_of_EEPROM_Read
	__size_of_EEPROM_Read	equ	__end_of_EEPROM_Read-_EEPROM_Read
	
_EEPROM_Read:	
	opt	stack 1
; Regs used in _EEPROM_Read: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	567
	
l3797:	
;1.C: 567: EEPROM_ReadWord(&CH1_remotekey[0],0x00);
	clrf	(?_EEPROM_ReadWord)^080h
	movlw	(_CH1_remotekey)&0ffh
	fcall	_EEPROM_ReadWord
	line	568
;1.C: 568: EEPROM_ReadWord(&CH2_remotekey[0],0x04);
	movlw	(04h)
	movwf	(?_EEPROM_ReadWord)^080h
	movlw	(_CH2_remotekey)&0ffh
	fcall	_EEPROM_ReadWord
	line	569
;1.C: 569: EEPROM_ReadWord(&CH3_remotekey[0],0x08);
	movlw	(08h)
	movwf	(?_EEPROM_ReadWord)^080h
	movlw	(_CH3_remotekey)&0ffh
	fcall	_EEPROM_ReadWord
	line	570
;1.C: 570: EEPROM_ReadWord(&CH1_remotekey[1],0x0C);
	movlw	(0Ch)
	movwf	(?_EEPROM_ReadWord)^080h
	movlw	(_CH1_remotekey+04h)&0ffh
	fcall	_EEPROM_ReadWord
	line	571
;1.C: 571: EEPROM_ReadWord(&CH2_remotekey[1],0x10);
	movlw	(010h)
	movwf	(?_EEPROM_ReadWord)^080h
	movlw	(_CH2_remotekey+04h)&0ffh
	fcall	_EEPROM_ReadWord
	line	572
;1.C: 572: EEPROM_ReadWord(&CH3_remotekey[1],0x14);
	movlw	(014h)
	movwf	(?_EEPROM_ReadWord)^080h
	movlw	(_CH3_remotekey+04h)&0ffh
	fcall	_EEPROM_ReadWord
	line	573
;1.C: 573: EEPROM_ReadWord(&CH1_remotekey[2],0x18);
	movlw	(018h)
	movwf	(?_EEPROM_ReadWord)^080h
	movlw	(_CH1_remotekey+08h)&0ffh
	fcall	_EEPROM_ReadWord
	line	574
;1.C: 574: EEPROM_ReadWord(&CH2_remotekey[2],0x1C);
	movlw	(01Ch)
	movwf	(?_EEPROM_ReadWord)^080h
	movlw	(_CH2_remotekey+08h)&0ffh
	fcall	_EEPROM_ReadWord
	line	575
;1.C: 575: EEPROM_ReadWord(&CH3_remotekey[2],0x20);
	movlw	(020h)
	movwf	(?_EEPROM_ReadWord)^080h
	movlw	(_CH3_remotekey+08h)&0ffh
	fcall	_EEPROM_ReadWord
	line	576
;1.C: 576: EEPROM_ReadWord(&CH1_remotekey[3],0x24);
	movlw	(024h)
	movwf	(?_EEPROM_ReadWord)^080h
	movlw	(_CH1_remotekey+0Ch)&0ffh
	fcall	_EEPROM_ReadWord
	line	577
;1.C: 577: EEPROM_ReadWord(&CH2_remotekey[3],0x28);
	movlw	(028h)
	movwf	(?_EEPROM_ReadWord)^080h
	movlw	(_CH2_remotekey+0Ch)&0ffh
	fcall	_EEPROM_ReadWord
	line	578
;1.C: 578: EEPROM_ReadWord(&CH3_remotekey[3],0x2C);
	movlw	(02Ch)
	movwf	(?_EEPROM_ReadWord)^080h
	movlw	(_CH3_remotekey+0Ch)&0ffh
	fcall	_EEPROM_ReadWord
	line	579
	
l3799:	
;1.C: 579: CH1_remotekey_Latest = CH1_remotekey_num = IAPRead(0x30);
	movlw	(030h)
	fcall	_IAPRead
	bcf	status, 5	;RP0=0, select bank0
	movwf	(_CH1_remotekey_num)
	bsf	status, 5	;RP0=1, select bank1
	movwf	(_CH1_remotekey_Latest)^080h
	line	580
	
l3801:	
;1.C: 580: CH2_remotekey_Latest = CH2_remotekey_num = IAPRead(0x31);
	movlw	(031h)
	fcall	_IAPRead
	bcf	status, 5	;RP0=0, select bank0
	movwf	(_CH2_remotekey_num)
	bsf	status, 5	;RP0=1, select bank1
	movwf	(_CH2_remotekey_Latest)^080h
	line	581
	
l3803:	
;1.C: 581: CH3_remotekey_Latest = CH3_remotekey_num = IAPRead(0x32);
	movlw	(032h)
	fcall	_IAPRead
	bcf	status, 5	;RP0=0, select bank0
	movwf	(_CH3_remotekey_num)
	bsf	status, 5	;RP0=1, select bank1
	movwf	(_CH3_remotekey_Latest)^080h
	line	582
	
l990:	
	return
	opt stack 0
GLOBAL	__end_of_EEPROM_Read
	__end_of_EEPROM_Read:
;; =============== function _EEPROM_Read ends ============

	signat	_EEPROM_Read,88
	global	_EEPROM_ReadWord
psect	text679,local,class=CODE,delta=2
global __ptext679
__ptext679:

;; *************** function _EEPROM_ReadWord *****************
;; Defined at:
;;		line 555 in file "1.C"
;; Parameters:    Size  Location     Type
;;  buff            1    wreg     PTR unsigned long 
;;		 -> CH3_remotekey(16), CH2_remotekey(16), CH1_remotekey(16), 
;;  data            1    2[BANK1 ] unsigned char 
;; Auto vars:     Size  Location     Type
;;  buff            1    7[BANK1 ] PTR unsigned long 
;;		 -> CH3_remotekey(16), CH2_remotekey(16), CH1_remotekey(16), 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 17F/20
;;		On exit  : 17F/20
;;		Unchanged: FFE80/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       1
;;      Locals:         0       0       1
;;      Temps:          0       0       4
;;      Totals:         0       0       6
;;Total ram usage:        6 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    5
;; This function calls:
;;		_IAPRead
;; This function is called by:
;;		_EEPROM_Read
;; This function uses a non-reentrant model
;;
psect	text679
	file	"1.C"
	line	555
	global	__size_of_EEPROM_ReadWord
	__size_of_EEPROM_ReadWord	equ	__end_of_EEPROM_ReadWord-_EEPROM_ReadWord
	
_EEPROM_ReadWord:	
	opt	stack 1
; Regs used in _EEPROM_ReadWord: [wreg-fsr0h+status,2+status,0+pclath+cstack]
;EEPROM_ReadWord@buff stored from wreg
	movwf	(EEPROM_ReadWord@buff)^080h
	line	556
	
l3783:	
;1.C: 556: *buff = 0;
	movf	(EEPROM_ReadWord@buff)^080h,w
	movwf	fsr0
	
	clrf	indf
	incf	fsr0,f
	clrf	indf
	incf	fsr0,f
	clrf	indf
	incf	fsr0,f
	clrf	indf
	line	557
	
l3785:	
;1.C: 557: EE_Buff = IAPRead(data+2);
	movf	(EEPROM_ReadWord@data)^080h,w
	addlw	02h
	fcall	_IAPRead
	movwf	(_EE_Buff)^080h
	line	558
	
l3787:	
;1.C: 558: *buff |= EE_Buff;
	movf	(_EE_Buff)^080h,w
	movwf	(??_EEPROM_ReadWord+0)^080h+0
	clrf	((??_EEPROM_ReadWord+0)^080h+0+1)
	clrf	((??_EEPROM_ReadWord+0)^080h+0+2)
	clrf	((??_EEPROM_ReadWord+0)^080h+0+3)
	movf	(EEPROM_ReadWord@buff)^080h,w
	movwf	fsr0
	movf	0+(??_EEPROM_ReadWord+0)^080h+0,w
	iorwf	indf,f
	incf	fsr0,f
	movf	1+(??_EEPROM_ReadWord+0)^080h+0,w
	iorwf	indf,f
	incf	fsr0,f
	movf	2+(??_EEPROM_ReadWord+0)^080h+0,w
	iorwf	indf,f
	incf	fsr0,f
	movf	3+(??_EEPROM_ReadWord+0)^080h+0,w
	iorwf	indf,f
	line	559
	
l3789:	
;1.C: 559: *buff = *buff<<8;
	movf	(EEPROM_ReadWord@buff)^080h,w
	movwf	fsr0
	movf	indf,w
	movwf	(??_EEPROM_ReadWord+0)^080h+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_EEPROM_ReadWord+0)^080h+0+1
	incf	fsr0,f
	movf	indf,w
	movwf	(??_EEPROM_ReadWord+0)^080h+0+2
	incf	fsr0,f
	movf	indf,w
	movwf	(??_EEPROM_ReadWord+0)^080h+0+3
	movf	(??_EEPROM_ReadWord+0)^080h+2,w
	movwf	(??_EEPROM_ReadWord+0)^080h+3
	movf	(??_EEPROM_ReadWord+0)^080h+1,w
	movwf	(??_EEPROM_ReadWord+0)^080h+2
	movf	(??_EEPROM_ReadWord+0)^080h+0,w
	movwf	(??_EEPROM_ReadWord+0)^080h+1
	clrf	(??_EEPROM_ReadWord+0)^080h+0
	movf	(EEPROM_ReadWord@buff)^080h,w
	movwf	fsr0
	movf	0+(??_EEPROM_ReadWord+0)^080h+0,w
	movwf	indf
	incf	fsr0,f
	movf	1+(??_EEPROM_ReadWord+0)^080h+0,w
	movwf	indf
	incf	fsr0,f
	movf	2+(??_EEPROM_ReadWord+0)^080h+0,w
	movwf	indf
	incf	fsr0,f
	movf	3+(??_EEPROM_ReadWord+0)^080h+0,w
	movwf	indf
	line	560
	
l3791:	
;1.C: 560: EE_Buff = IAPRead(data+1);
	incf	(EEPROM_ReadWord@data)^080h,w
	fcall	_IAPRead
	movwf	(_EE_Buff)^080h
	line	561
;1.C: 561: *buff |= EE_Buff;
	movf	(_EE_Buff)^080h,w
	movwf	(??_EEPROM_ReadWord+0)^080h+0
	clrf	((??_EEPROM_ReadWord+0)^080h+0+1)
	clrf	((??_EEPROM_ReadWord+0)^080h+0+2)
	clrf	((??_EEPROM_ReadWord+0)^080h+0+3)
	movf	(EEPROM_ReadWord@buff)^080h,w
	movwf	fsr0
	movf	0+(??_EEPROM_ReadWord+0)^080h+0,w
	iorwf	indf,f
	incf	fsr0,f
	movf	1+(??_EEPROM_ReadWord+0)^080h+0,w
	iorwf	indf,f
	incf	fsr0,f
	movf	2+(??_EEPROM_ReadWord+0)^080h+0,w
	iorwf	indf,f
	incf	fsr0,f
	movf	3+(??_EEPROM_ReadWord+0)^080h+0,w
	iorwf	indf,f
	line	562
;1.C: 562: *buff = *buff<<8;
	movf	(EEPROM_ReadWord@buff)^080h,w
	movwf	fsr0
	movf	indf,w
	movwf	(??_EEPROM_ReadWord+0)^080h+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_EEPROM_ReadWord+0)^080h+0+1
	incf	fsr0,f
	movf	indf,w
	movwf	(??_EEPROM_ReadWord+0)^080h+0+2
	incf	fsr0,f
	movf	indf,w
	movwf	(??_EEPROM_ReadWord+0)^080h+0+3
	movf	(??_EEPROM_ReadWord+0)^080h+2,w
	movwf	(??_EEPROM_ReadWord+0)^080h+3
	movf	(??_EEPROM_ReadWord+0)^080h+1,w
	movwf	(??_EEPROM_ReadWord+0)^080h+2
	movf	(??_EEPROM_ReadWord+0)^080h+0,w
	movwf	(??_EEPROM_ReadWord+0)^080h+1
	clrf	(??_EEPROM_ReadWord+0)^080h+0
	movf	(EEPROM_ReadWord@buff)^080h,w
	movwf	fsr0
	movf	0+(??_EEPROM_ReadWord+0)^080h+0,w
	movwf	indf
	incf	fsr0,f
	movf	1+(??_EEPROM_ReadWord+0)^080h+0,w
	movwf	indf
	incf	fsr0,f
	movf	2+(??_EEPROM_ReadWord+0)^080h+0,w
	movwf	indf
	incf	fsr0,f
	movf	3+(??_EEPROM_ReadWord+0)^080h+0,w
	movwf	indf
	line	563
	
l3793:	
;1.C: 563: EE_Buff = IAPRead(data);
	movf	(EEPROM_ReadWord@data)^080h,w
	fcall	_IAPRead
	movwf	(_EE_Buff)^080h
	line	564
	
l3795:	
;1.C: 564: *buff |= EE_Buff;
	movf	(_EE_Buff)^080h,w
	movwf	(??_EEPROM_ReadWord+0)^080h+0
	clrf	((??_EEPROM_ReadWord+0)^080h+0+1)
	clrf	((??_EEPROM_ReadWord+0)^080h+0+2)
	clrf	((??_EEPROM_ReadWord+0)^080h+0+3)
	movf	(EEPROM_ReadWord@buff)^080h,w
	movwf	fsr0
	movf	0+(??_EEPROM_ReadWord+0)^080h+0,w
	iorwf	indf,f
	incf	fsr0,f
	movf	1+(??_EEPROM_ReadWord+0)^080h+0,w
	iorwf	indf,f
	incf	fsr0,f
	movf	2+(??_EEPROM_ReadWord+0)^080h+0,w
	iorwf	indf,f
	incf	fsr0,f
	movf	3+(??_EEPROM_ReadWord+0)^080h+0,w
	iorwf	indf,f
	line	565
	
l987:	
	return
	opt stack 0
GLOBAL	__end_of_EEPROM_ReadWord
	__end_of_EEPROM_ReadWord:
;; =============== function _EEPROM_ReadWord ends ============

	signat	_EEPROM_ReadWord,8312
	global	_INT_INITIAL
psect	text680,local,class=CODE,delta=2
global __ptext680
__ptext680:

;; *************** function _INT_INITIAL *****************
;; Defined at:
;;		line 402 in file "1.C"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 17F/20
;;		Unchanged: FFE80/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    5
;; This function calls:
;;		_EX_INT_FallingEdge
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text680
	file	"1.C"
	line	402
	global	__size_of_INT_INITIAL
	__size_of_INT_INITIAL	equ	__end_of_INT_INITIAL-_INT_INITIAL
	
_INT_INITIAL:	
	opt	stack 2
; Regs used in _INT_INITIAL: [status,2+status,0+pclath+cstack]
	line	403
	
l3775:	
;1.C: 403: TRISA2 =1;
	bsf	status, 5	;RP0=1, select bank1
	bsf	(1066/8)^080h,(1066)&7
	line	404
;1.C: 404: IOCA2 =0;
	bcf	(1202/8)^080h,(1202)&7
	line	405
	
l3777:	
;1.C: 405: EX_INT_FallingEdge();
	fcall	_EX_INT_FallingEdge
	line	406
	
l3779:	
;1.C: 406: INTF =0;
	bcf	(89/8),(89)&7
	line	408
	
l3781:	
;1.C: 408: INTE =0;
	bcf	(92/8),(92)&7
	line	409
	
l945:	
	return
	opt stack 0
GLOBAL	__end_of_INT_INITIAL
	__end_of_INT_INITIAL:
;; =============== function _INT_INITIAL ends ============

	signat	_INT_INITIAL,88
	global	_IAPRead
psect	text681,local,class=CODE,delta=2
global __ptext681
__ptext681:

;; *************** function _IAPRead *****************
;; Defined at:
;;		line 480 in file "1.C"
;; Parameters:    Size  Location     Type
;;  EEAddr          1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  EEAddr          1    0[BANK1 ] unsigned char 
;;  ReEEPROMread    1    1[BANK1 ] unsigned char 
;; Return value:  Size  Location     Type
;;                  1    wreg      unsigned char 
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 17F/20
;;		On exit  : 17F/20
;;		Unchanged: FFE80/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       2
;;      Temps:          0       0       0
;;      Totals:         0       0       2
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    4
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_EEPROM_ReadWord
;;		_EEPROM_Read
;; This function uses a non-reentrant model
;;
psect	text681
	file	"1.C"
	line	480
	global	__size_of_IAPRead
	__size_of_IAPRead	equ	__end_of_IAPRead-_IAPRead
	
_IAPRead:	
	opt	stack 2
; Regs used in _IAPRead: [wreg]
;IAPRead@EEAddr stored from wreg
	line	482
	movwf	(IAPRead@EEAddr)^080h
	
l3769:	
;1.C: 481: unsigned char ReEEPROMread;
;1.C: 482: EEADR = EEAddr;
	movf	(IAPRead@EEAddr)^080h,w
	movwf	(155)^080h	;volatile
	line	483
	
l3771:	
;1.C: 483: RD = 1;
	bsf	(1248/8)^080h,(1248)&7
	line	484
;1.C: 484: ReEEPROMread = EEDAT;
	movf	(154)^080h,w	;volatile
	movwf	(IAPRead@ReEEPROMread)^080h
	line	485
;1.C: 485: return ReEEPROMread;
	movf	(IAPRead@ReEEPROMread)^080h,w
	line	486
	
l966:	
	return
	opt stack 0
GLOBAL	__end_of_IAPRead
	__end_of_IAPRead:
;; =============== function _IAPRead ends ============

	signat	_IAPRead,4217
	global	_TIMER2_INITIAL
psect	text682,local,class=CODE,delta=2
global __ptext682
__ptext682:

;; *************** function _TIMER2_INITIAL *****************
;; Defined at:
;;		line 456 in file "1.C"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 17F/0
;;		Unchanged: FFE80/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    4
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text682
	file	"1.C"
	line	456
	global	__size_of_TIMER2_INITIAL
	__size_of_TIMER2_INITIAL	equ	__end_of_TIMER2_INITIAL-_TIMER2_INITIAL
	
_TIMER2_INITIAL:	
	opt	stack 3
; Regs used in _TIMER2_INITIAL: [wreg+status,2]
	line	457
	
l3753:	
;1.C: 457: T2CON0 = 0B00000001;
	movlw	(01h)
	movwf	(18)	;volatile
	line	463
	
l3755:	
;1.C: 463: T2CON1 = 0B00000000;
	bsf	status, 5	;RP0=1, select bank1
	clrf	(158)^080h	;volatile
	line	468
	
l3757:	
;1.C: 468: TMR2H = (53)/256;
	bcf	status, 5	;RP0=0, select bank0
	clrf	(19)	;volatile
	line	469
;1.C: 469: TMR2L = (53)%256;
	movlw	(035h)
	movwf	(17)	;volatile
	line	472
	
l3759:	
;1.C: 472: PR2H = (53)/256;
	bsf	status, 5	;RP0=1, select bank1
	clrf	(146)^080h	;volatile
	line	473
	
l3761:	
;1.C: 473: PR2L = (53)%256;
	movlw	(035h)
	movwf	(145)^080h	;volatile
	line	475
	
l3763:	
;1.C: 475: TMR2IF = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	(97/8),(97)&7
	line	476
	
l3765:	
;1.C: 476: TMR2IE = 1;
	bsf	status, 5	;RP0=1, select bank1
	bsf	(1121/8)^080h,(1121)&7
	line	478
	
l3767:	
;1.C: 478: TMR2ON =0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	(146/8),(146)&7
	line	479
	
l963:	
	return
	opt stack 0
GLOBAL	__end_of_TIMER2_INITIAL
	__end_of_TIMER2_INITIAL:
;; =============== function _TIMER2_INITIAL ends ============

	signat	_TIMER2_INITIAL,88
	global	_TIMER0_INITIAL
psect	text683,local,class=CODE,delta=2
global __ptext683
__ptext683:

;; *************** function _TIMER0_INITIAL *****************
;; Defined at:
;;		line 446 in file "1.C"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 17F/20
;;		On exit  : 17F/0
;;		Unchanged: FFE80/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    4
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text683
	file	"1.C"
	line	446
	global	__size_of_TIMER0_INITIAL
	__size_of_TIMER0_INITIAL	equ	__end_of_TIMER0_INITIAL-_TIMER0_INITIAL
	
_TIMER0_INITIAL:	
	opt	stack 3
; Regs used in _TIMER0_INITIAL: [wreg+status,2+status,0]
	line	447
	
l3743:	
;1.C: 447: T0CS = 0;
	bcf	(1037/8)^080h,(1037)&7
	line	448
;1.C: 448: PSA = 0;
	bcf	(1035/8)^080h,(1035)&7
	line	449
	
l3745:	
;1.C: 449: OPTION &= 0xF8;
	movlw	(0F8h)
	andwf	(129)^080h,f	;volatile
	line	450
;1.C: 450: OPTION |= 0x06;
	movlw	(06h)
	iorwf	(129)^080h,f	;volatile
	line	452
	
l3747:	
;1.C: 452: TMR0 = 5;
	movlw	(05h)
	bcf	status, 5	;RP0=0, select bank0
	movwf	(1)	;volatile
	line	453
	
l3749:	
;1.C: 453: T0IE = 1;
	bsf	(93/8),(93)&7
	line	454
	
l3751:	
;1.C: 454: T0IF = 0;
	bcf	(90/8),(90)&7
	line	455
	
l960:	
	return
	opt stack 0
GLOBAL	__end_of_TIMER0_INITIAL
	__end_of_TIMER0_INITIAL:
;; =============== function _TIMER0_INITIAL ends ============

	signat	_TIMER0_INITIAL,88
	global	_WDT_INITIAL
psect	text684,local,class=CODE,delta=2
global __ptext684
__ptext684:

;; *************** function _WDT_INITIAL *****************
;; Defined at:
;;		line 441 in file "1.C"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 17F/20
;;		On exit  : 20/0
;;		Unchanged: FFE00/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    4
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text684
	file	"1.C"
	line	441
	global	__size_of_WDT_INITIAL
	__size_of_WDT_INITIAL	equ	__end_of_WDT_INITIAL-_WDT_INITIAL
	
_WDT_INITIAL:	
	opt	stack 3
; Regs used in _WDT_INITIAL: [wreg]
	line	442
	
l3739:	
# 442 "1.C"
clrwdt ;#
psect	text684
	line	443
	
l3741:	
;1.C: 443: WDTCON = 0B00010110;
	movlw	(016h)
	bcf	status, 5	;RP0=0, select bank0
	movwf	(24)	;volatile
	line	445
	
l957:	
	return
	opt stack 0
GLOBAL	__end_of_WDT_INITIAL
	__end_of_WDT_INITIAL:
;; =============== function _WDT_INITIAL ends ============

	signat	_WDT_INITIAL,88
	global	_OSC_INIT
psect	text685,local,class=CODE,delta=2
global __ptext685
__ptext685:

;; *************** function _OSC_INIT *****************
;; Defined at:
;;		line 418 in file "1.C"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 17F/20
;;		Unchanged: FFE80/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    4
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text685
	file	"1.C"
	line	418
	global	__size_of_OSC_INIT
	__size_of_OSC_INIT	equ	__end_of_OSC_INIT-_OSC_INIT
	
_OSC_INIT:	
	opt	stack 3
; Regs used in _OSC_INIT: [wreg+status,2]
	line	419
	
l3717:	
;1.C: 419: OSCCON = 0B01100001;
	movlw	(061h)
	bsf	status, 5	;RP0=1, select bank1
	movwf	(143)^080h	;volatile
	line	424
	
l3719:	
;1.C: 424: INTCON = 0;
	clrf	(11)	;volatile
	line	426
	
l3721:	
;1.C: 426: PORTA = 0B00000000;
	bcf	status, 5	;RP0=0, select bank0
	clrf	(5)	;volatile
	line	427
;1.C: 427: TRISA = 0B00010111;
	movlw	(017h)
	bsf	status, 5	;RP0=1, select bank1
	movwf	(133)^080h	;volatile
	line	428
	
l3723:	
;1.C: 428: WPUA = 0B00000000;
	clrf	(149)^080h	;volatile
	line	429
	
l3725:	
;1.C: 429: PSRCA = 0B11111111;
	movlw	(0FFh)
	movwf	(136)^080h	;volatile
	line	430
	
l3727:	
;1.C: 430: PSINKA = 0B11111111;
	movlw	(0FFh)
	movwf	(151)^080h	;volatile
	line	432
	
l3729:	
;1.C: 432: PORTC = 0B00000000;
	bcf	status, 5	;RP0=0, select bank0
	clrf	(7)	;volatile
	line	433
;1.C: 433: TRISC = 0B11110000;
	movlw	(0F0h)
	bsf	status, 5	;RP0=1, select bank1
	movwf	(135)^080h	;volatile
	line	434
	
l3731:	
;1.C: 434: WPUC = 0B00000000;
	clrf	(147)^080h	;volatile
	line	435
	
l3733:	
;1.C: 435: PSRCC = 0B11111111;
	movlw	(0FFh)
	movwf	(148)^080h	;volatile
	line	436
	
l3735:	
;1.C: 436: PSINKC = 0B11111111;
	movlw	(0FFh)
	movwf	(159)^080h	;volatile
	line	438
	
l3737:	
;1.C: 438: OPTION = 0B00001000;
	movlw	(08h)
	movwf	(129)^080h	;volatile
	line	440
	
l954:	
	return
	opt stack 0
GLOBAL	__end_of_OSC_INIT
	__end_of_OSC_INIT:
;; =============== function _OSC_INIT ends ============

	signat	_OSC_INIT,88
	global	_EX_INT_FallingEdge
psect	text686,local,class=CODE,delta=2
global __ptext686
__ptext686:

;; *************** function _EX_INT_FallingEdge *****************
;; Defined at:
;;		line 414 in file "1.C"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		None
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 20/20
;;		Unchanged: FFFDF/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    4
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_INT_INITIAL
;;		_main
;; This function uses a non-reentrant model
;;
psect	text686
	file	"1.C"
	line	414
	global	__size_of_EX_INT_FallingEdge
	__size_of_EX_INT_FallingEdge	equ	__end_of_EX_INT_FallingEdge-_EX_INT_FallingEdge
	
_EX_INT_FallingEdge:	
	opt	stack 3
; Regs used in _EX_INT_FallingEdge: []
	line	415
	
l3715:	
;1.C: 415: INTEDG =0;
	bsf	status, 5	;RP0=1, select bank1
	bcf	(1038/8)^080h,(1038)&7
	line	416
;1.C: 416: FLAGs &= ~0x01;
	bcf	(_FLAGs)+(0/8),(0)&7
	line	417
	
l951:	
	return
	opt stack 0
GLOBAL	__end_of_EX_INT_FallingEdge
	__end_of_EX_INT_FallingEdge:
;; =============== function _EX_INT_FallingEdge ends ============

	signat	_EX_INT_FallingEdge,88
	global	_ISR
psect	text687,local,class=CODE,delta=2
global __ptext687
__ptext687:

;; *************** function _ISR *****************
;; Defined at:
;;		line 136 in file "1.C"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, fsr1l, fsr1h, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 20/0
;;		Unchanged: FFEDF/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0      10       0
;;      Totals:         0      10       0
;;Total ram usage:       10 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_EX_INT_RisingEdge
;;		i1_EX_INT_FallingEdge
;;		___wmul
;;		_led1_debug
;;		_KEYSCAN
;;		_KEY
;; This function is called by:
;;		Interrupt level 1
;; This function uses a non-reentrant model
;;
psect	text687
	file	"1.C"
	line	136
	global	__size_of_ISR
	__size_of_ISR	equ	__end_of_ISR-_ISR
	
_ISR:	
	opt	stack 1
; Regs used in _ISR: [allreg]
psect	intentry,class=CODE,delta=2
global __pintentry
__pintentry:
global interrupt_function
interrupt_function:
	global saved_w
	saved_w	set	btemp+0
	movwf	saved_w
	swapf	status,w
	bcf	status, 5	;RP0=0, select bank0
	movwf	(??_ISR+6)
	movf	fsr0,w
	movwf	(??_ISR+7)
	movf	pclath,w
	movwf	(??_ISR+8)
	movf	btemp+1,w
	movwf	(??_ISR+9)
	ljmp	_ISR
psect	text687
	line	138
	
i1l2967:	
;1.C: 138: if(INTE && INTF){
	btfss	(92/8),(92)&7
	goto	u139_21
	goto	u139_20
u139_21:
	goto	i1l3107
u139_20:
	
i1l2969:	
	btfss	(89/8),(89)&7
	goto	u140_21
	goto	u140_20
u140_21:
	goto	i1l3107
u140_20:
	line	139
	
i1l2971:	
;1.C: 139: INTF = 0;
	bcf	(89/8),(89)&7
	line	140
;1.C: 140: INTE = 0;
	bcf	(92/8),(92)&7
	line	141
;1.C: 141: TMR2ON =0;
	bcf	(146/8),(146)&7
	line	142
;1.C: 142: if((FLAGs&0x01) == 0){
	btfsc	(_FLAGs),(0)&7
	goto	u141_21
	goto	u141_20
u141_21:
	goto	i1l858
u141_20:
	line	143
	
i1l2973:	
;1.C: 143: Indata = 0;
	bsf	status, 5	;RP0=1, select bank1
	clrf	(_Indata)^080h
	clrf	(_Indata+1)^080h
	line	144
	
i1l2975:	
;1.C: 144: EX_INT_RisingEdge();
	fcall	_EX_INT_RisingEdge
	line	145
;1.C: 145: }else if((FLAGs&0x01) == 0x01){
	goto	i1l3103
	
i1l858:	
	btfss	(_FLAGs),(0)&7
	goto	u142_21
	goto	u142_20
u142_21:
	goto	i1l3103
u142_20:
	line	146
	
i1l2977:	
;1.C: 146: EX_INT_FallingEdge();
	fcall	i1_EX_INT_FallingEdge
	line	147
	
i1l2979:	
;1.C: 147: buff = Indata*53;
	movf	(_Indata+1)^080h,w
	movwf	(?___wmul+1)
	movf	(_Indata)^080h,w
	movwf	(?___wmul)
	movlw	035h
	movwf	0+(?___wmul)+02h
	clrf	1+(?___wmul)+02h
	fcall	___wmul
	movf	(1+(?___wmul)),w
	movwf	(_buff+1)
	movf	(0+(?___wmul)),w
	movwf	(_buff)
	line	148
	
i1l2981:	
;1.C: 148: Indata = 0;
	clrf	(_Indata)^080h
	clrf	(_Indata+1)^080h
	line	153
	
i1l2983:	
;1.C: 150: if( ((FLAGs&0x10) == 0) &&
;1.C: 151: ((FLAGs&0x20) == 0) &&
;1.C: 152: ((FLAGs&0x40) == 0)
;1.C: 153: ){
	btfsc	(_FLAGs),(4)&7
	goto	u143_21
	goto	u143_20
u143_21:
	goto	i1l3083
u143_20:
	
i1l2985:	
	btfsc	(_FLAGs),(5)&7
	goto	u144_21
	goto	u144_20
u144_21:
	goto	i1l3083
u144_20:
	
i1l2987:	
	btfsc	(_FLAGs),(6)&7
	goto	u145_21
	goto	u145_20
u145_21:
	goto	i1l3083
u145_20:
	line	154
	
i1l2989:	
;1.C: 154: if((FLAGs&0x08) == 0x08){
	btfss	(_FLAGs),(3)&7
	goto	u146_21
	goto	u146_20
u146_21:
	goto	i1l3083
u146_20:
	line	155
	
i1l2991:	
;1.C: 155: if(num < 24){
	movlw	(018h)
	bcf	status, 5	;RP0=0, select bank0
	subwf	(_num),w
	skipnc
	goto	u147_21
	goto	u147_20
u147_21:
	goto	i1l3007
u147_20:
	line	156
	
i1l2993:	
;1.C: 156: if((buff>200)&&(buff<600)){
	movlw	high(0C9h)
	subwf	(_buff+1),w
	movlw	low(0C9h)
	skipnz
	subwf	(_buff),w
	skipc
	goto	u148_21
	goto	u148_20
u148_21:
	goto	i1l3001
u148_20:
	
i1l2995:	
	movlw	high(0258h)
	subwf	(_buff+1),w
	movlw	low(0258h)
	skipnz
	subwf	(_buff),w
	skipnc
	goto	u149_21
	goto	u149_20
u149_21:
	goto	i1l3001
u149_20:
	line	157
	
i1l2997:	
;1.C: 157: remotekey = remotekey<<1;
	clrc
	bsf	status, 5	;RP0=1, select bank1
	rlf	(_remotekey)^080h,f
	rlf	(_remotekey+1)^080h,f
	rlf	(_remotekey+2)^080h,f
	rlf	(_remotekey+3)^080h,f
	line	158
	
i1l2999:	
;1.C: 158: remotekey |= 0x00000001;
	bsf	(_remotekey)^080h+(0/8),(0)&7
	line	160
	
i1l3001:	
;1.C: 159: }
;1.C: 160: if((buff>700)&&(buff<1800)){
	movlw	high(02BDh)
	subwf	(_buff+1),w
	movlw	low(02BDh)
	skipnz
	subwf	(_buff),w
	skipc
	goto	u150_21
	goto	u150_20
u150_21:
	goto	i1l865
u150_20:
	
i1l3003:	
	movlw	high(0708h)
	subwf	(_buff+1),w
	movlw	low(0708h)
	skipnz
	subwf	(_buff),w
	skipnc
	goto	u151_21
	goto	u151_20
u151_21:
	goto	i1l865
u151_20:
	line	161
	
i1l3005:	
;1.C: 161: remotekey = remotekey<<1;
	clrc
	bsf	status, 5	;RP0=1, select bank1
	rlf	(_remotekey)^080h,f
	rlf	(_remotekey+1)^080h,f
	rlf	(_remotekey+2)^080h,f
	rlf	(_remotekey+3)^080h,f
	line	162
	
i1l865:	
	line	163
;1.C: 162: }
;1.C: 163: num++;
	bcf	status, 5	;RP0=0, select bank0
	incf	(_num),f
	line	166
	
i1l3007:	
;1.C: 164: }
;1.C: 166: if(num >= 24){
	movlw	(018h)
	subwf	(_num),w
	skipc
	goto	u152_21
	goto	u152_20
u152_21:
	goto	i1l3083
u152_20:
	line	168
	
i1l3009:	
;1.C: 168: if(remotekey>0){
	bsf	status, 5	;RP0=1, select bank1
	movf	(_remotekey+3)^080h,w
	iorwf	(_remotekey+2)^080h,w
	iorwf	(_remotekey+1)^080h,w
	iorwf	(_remotekey)^080h,w
	skipnz
	goto	u153_21
	goto	u153_20
u153_21:
	goto	i1l867
u153_20:
	line	169
	
i1l3011:	
;1.C: 169: if(Match_remotekey == remotekey){
	movf	(_remotekey+3)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	xorwf	(_Match_remotekey+3),w
	skipz
	goto	u154_25
	bsf	status, 5	;RP0=1, select bank1
	movf	(_remotekey+2)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	xorwf	(_Match_remotekey+2),w
	skipz
	goto	u154_25
	bsf	status, 5	;RP0=1, select bank1
	movf	(_remotekey+1)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	xorwf	(_Match_remotekey+1),w
	skipz
	goto	u154_25
	bsf	status, 5	;RP0=1, select bank1
	movf	(_remotekey)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	xorwf	(_Match_remotekey),w
u154_25:
	skipz
	goto	u154_21
	goto	u154_20
u154_21:
	goto	i1l3017
u154_20:
	line	170
	
i1l3013:	
;1.C: 170: remotekey_Receive_num++;
	incf	(_remotekey_Receive_num),f
	line	171
	
i1l3015:	
;1.C: 171: match_slice = 0;
	clrf	(_match_slice)
	line	173
	
i1l3017:	
;1.C: 172: }
;1.C: 173: if(remotekey_Receive_num == 0) Match_remotekey = remotekey;
	movf	(_remotekey_Receive_num),f
	skipz
	goto	u155_21
	goto	u155_20
u155_21:
	goto	i1l867
u155_20:
	
i1l3019:	
	bsf	status, 5	;RP0=1, select bank1
	movf	(_remotekey+3)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	movwf	(_Match_remotekey+3)
	bsf	status, 5	;RP0=1, select bank1
	movf	(_remotekey+2)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	movwf	(_Match_remotekey+2)
	bsf	status, 5	;RP0=1, select bank1
	movf	(_remotekey+1)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	movwf	(_Match_remotekey+1)
	bsf	status, 5	;RP0=1, select bank1
	movf	(_remotekey)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	movwf	(_Match_remotekey)

	line	174
	
i1l867:	
	line	176
;1.C: 174: }
;1.C: 176: Ctrl_remotekey = remotekey;
	bsf	status, 5	;RP0=1, select bank1
	movf	(_remotekey+3)^080h,w
	movwf	(_Ctrl_remotekey+3)^080h
	movf	(_remotekey+2)^080h,w
	movwf	(_Ctrl_remotekey+2)^080h
	movf	(_remotekey+1)^080h,w
	movwf	(_Ctrl_remotekey+1)^080h
	movf	(_remotekey)^080h,w
	movwf	(_Ctrl_remotekey)^080h

	line	181
	
i1l3021:	
;1.C: 178: if( ((PRESSED&0x10) == 0) &&
;1.C: 179: ((PRESSED&0x20) == 0) &&
;1.C: 180: ((PRESSED&0x40) == 0)
;1.C: 181: ){
	btfsc	(_PRESSED),(4)&7
	goto	u156_21
	goto	u156_20
u156_21:
	goto	i1l870
u156_20:
	
i1l3023:	
	btfsc	(_PRESSED),(5)&7
	goto	u157_21
	goto	u157_20
u157_21:
	goto	i1l870
u157_20:
	
i1l3025:	
	btfsc	(_PRESSED),(6)&7
	goto	u158_21
	goto	u158_20
u158_21:
	goto	i1l870
u158_20:
	line	182
	
i1l3027:	
;1.C: 182: if((FLAGs&0x10) == 0){
	btfsc	(_FLAGs),(4)&7
	goto	u159_21
	goto	u159_20
u159_21:
	goto	i1l871
u159_20:
	line	183
	
i1l3029:	
;1.C: 183: for(buff=0;buff<CH1_remotekey_num;buff++){
	clrf	(_buff)
	clrf	(_buff+1)
	goto	i1l3043
	line	184
	
i1l3031:	
;1.C: 184: if(Ctrl_remotekey == CH1_remotekey[buff]){
	movf	(_buff),w
	movwf	(??_ISR+0)+0
	clrc
	rlf	(??_ISR+0)+0,f
	clrc
	rlf	(??_ISR+0)+0,w
	addlw	_CH1_remotekey&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	movwf	(??_ISR+1)+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_ISR+1)+0+1
	incf	fsr0,f
	movf	indf,w
	movwf	(??_ISR+1)+0+2
	incf	fsr0,f
	movf	indf,w
	movwf	(??_ISR+1)+0+3
	bsf	status, 5	;RP0=1, select bank1
	movf	(_Ctrl_remotekey+3)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	xorwf	3+(??_ISR+1)+0,w
	skipz
	goto	u160_25
	bsf	status, 5	;RP0=1, select bank1
	movf	(_Ctrl_remotekey+2)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	xorwf	2+(??_ISR+1)+0,w
	skipz
	goto	u160_25
	bsf	status, 5	;RP0=1, select bank1
	movf	(_Ctrl_remotekey+1)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	xorwf	1+(??_ISR+1)+0,w
	skipz
	goto	u160_25
	bsf	status, 5	;RP0=1, select bank1
	movf	(_Ctrl_remotekey)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	xorwf	0+(??_ISR+1)+0,w
u160_25:
	skipz
	goto	u160_21
	goto	u160_20
u160_21:
	goto	i1l3041
u160_20:
	line	185
	
i1l3033:	
;1.C: 185: FLAGs |= 0x10;
	bsf	(_FLAGs)+(4/8),(4)&7
	line	186
	
i1l3035:	
;1.C: 186: led1_debug();
	fcall	_led1_debug
	line	187
	
i1l3037:	
;1.C: 187: PA7 = ~PA7;
	movlw	1<<((47)&7)
	xorwf	((47)/8),f
	line	188
	
i1l3039:	
;1.C: 188: CH1_remotekey_Latest = buff;
	movf	(_buff),w
	bsf	status, 5	;RP0=1, select bank1
	movwf	(_CH1_remotekey_Latest)^080h
	line	183
	
i1l3041:	
	incf	(_buff),f
	skipnz
	incf	(_buff+1),f
	
i1l3043:	
	bcf	status, 5	;RP0=0, select bank0
	movf	(_CH1_remotekey_num),w
	movwf	(??_ISR+0)+0
	clrf	(??_ISR+0)+0+1
	movf	1+(??_ISR+0)+0,w
	subwf	(_buff+1),w
	skipz
	goto	u161_25
	movf	0+(??_ISR+0)+0,w
	subwf	(_buff),w
u161_25:
	skipc
	goto	u161_21
	goto	u161_20
u161_21:
	goto	i1l3031
u161_20:
	line	191
	
i1l871:	
	line	192
;1.C: 189: }
;1.C: 190: }
;1.C: 191: }
;1.C: 192: if((FLAGs&0x20) == 0){
	btfsc	(_FLAGs),(5)&7
	goto	u162_21
	goto	u162_20
u162_21:
	goto	i1l876
u162_20:
	line	193
	
i1l3045:	
;1.C: 193: for(buff=0;buff<CH2_remotekey_num;buff++){
	clrf	(_buff)
	clrf	(_buff+1)
	goto	i1l3059
	line	194
	
i1l3047:	
;1.C: 194: if(Ctrl_remotekey == CH2_remotekey[buff]){
	movf	(_buff),w
	movwf	(??_ISR+0)+0
	clrc
	rlf	(??_ISR+0)+0,f
	clrc
	rlf	(??_ISR+0)+0,w
	addlw	_CH2_remotekey&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	movwf	(??_ISR+1)+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_ISR+1)+0+1
	incf	fsr0,f
	movf	indf,w
	movwf	(??_ISR+1)+0+2
	incf	fsr0,f
	movf	indf,w
	movwf	(??_ISR+1)+0+3
	bsf	status, 5	;RP0=1, select bank1
	movf	(_Ctrl_remotekey+3)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	xorwf	3+(??_ISR+1)+0,w
	skipz
	goto	u163_25
	bsf	status, 5	;RP0=1, select bank1
	movf	(_Ctrl_remotekey+2)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	xorwf	2+(??_ISR+1)+0,w
	skipz
	goto	u163_25
	bsf	status, 5	;RP0=1, select bank1
	movf	(_Ctrl_remotekey+1)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	xorwf	1+(??_ISR+1)+0,w
	skipz
	goto	u163_25
	bsf	status, 5	;RP0=1, select bank1
	movf	(_Ctrl_remotekey)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	xorwf	0+(??_ISR+1)+0,w
u163_25:
	skipz
	goto	u163_21
	goto	u163_20
u163_21:
	goto	i1l3057
u163_20:
	line	195
	
i1l3049:	
;1.C: 195: FLAGs |= 0x20;
	bsf	(_FLAGs)+(5/8),(5)&7
	line	196
	
i1l3051:	
;1.C: 196: led1_debug();
	fcall	_led1_debug
	line	197
	
i1l3053:	
;1.C: 197: PA6 = ~PA6;
	movlw	1<<((46)&7)
	xorwf	((46)/8),f
	line	198
	
i1l3055:	
;1.C: 198: CH2_remotekey_Latest = buff;
	movf	(_buff),w
	bsf	status, 5	;RP0=1, select bank1
	movwf	(_CH2_remotekey_Latest)^080h
	line	193
	
i1l3057:	
	incf	(_buff),f
	skipnz
	incf	(_buff+1),f
	
i1l3059:	
	bcf	status, 5	;RP0=0, select bank0
	movf	(_CH2_remotekey_num),w
	movwf	(??_ISR+0)+0
	clrf	(??_ISR+0)+0+1
	movf	1+(??_ISR+0)+0,w
	subwf	(_buff+1),w
	skipz
	goto	u164_25
	movf	0+(??_ISR+0)+0,w
	subwf	(_buff),w
u164_25:
	skipc
	goto	u164_21
	goto	u164_20
u164_21:
	goto	i1l3047
u164_20:
	line	201
	
i1l876:	
	line	202
;1.C: 199: }
;1.C: 200: }
;1.C: 201: }
;1.C: 202: if((FLAGs&0x40) == 0){
	btfsc	(_FLAGs),(6)&7
	goto	u165_21
	goto	u165_20
u165_21:
	goto	i1l870
u165_20:
	line	203
	
i1l3061:	
;1.C: 203: for(buff=0;buff<CH3_remotekey_num;buff++){
	clrf	(_buff)
	clrf	(_buff+1)
	goto	i1l3075
	line	204
	
i1l3063:	
;1.C: 204: if(Ctrl_remotekey == CH3_remotekey[buff]){
	movf	(_buff),w
	movwf	(??_ISR+0)+0
	clrc
	rlf	(??_ISR+0)+0,f
	clrc
	rlf	(??_ISR+0)+0,w
	addlw	_CH3_remotekey&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	movwf	(??_ISR+1)+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_ISR+1)+0+1
	incf	fsr0,f
	movf	indf,w
	movwf	(??_ISR+1)+0+2
	incf	fsr0,f
	movf	indf,w
	movwf	(??_ISR+1)+0+3
	bsf	status, 5	;RP0=1, select bank1
	movf	(_Ctrl_remotekey+3)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	xorwf	3+(??_ISR+1)+0,w
	skipz
	goto	u166_25
	bsf	status, 5	;RP0=1, select bank1
	movf	(_Ctrl_remotekey+2)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	xorwf	2+(??_ISR+1)+0,w
	skipz
	goto	u166_25
	bsf	status, 5	;RP0=1, select bank1
	movf	(_Ctrl_remotekey+1)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	xorwf	1+(??_ISR+1)+0,w
	skipz
	goto	u166_25
	bsf	status, 5	;RP0=1, select bank1
	movf	(_Ctrl_remotekey)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	xorwf	0+(??_ISR+1)+0,w
u166_25:
	skipz
	goto	u166_21
	goto	u166_20
u166_21:
	goto	i1l3073
u166_20:
	line	205
	
i1l3065:	
;1.C: 205: FLAGs |= 0x40;
	bsf	(_FLAGs)+(6/8),(6)&7
	line	206
	
i1l3067:	
;1.C: 206: led1_debug();
	fcall	_led1_debug
	line	207
	
i1l3069:	
;1.C: 207: PA5 = ~PA5;
	movlw	1<<((45)&7)
	xorwf	((45)/8),f
	line	208
	
i1l3071:	
;1.C: 208: CH3_remotekey_Latest = buff;
	movf	(_buff),w
	bsf	status, 5	;RP0=1, select bank1
	movwf	(_CH3_remotekey_Latest)^080h
	line	203
	
i1l3073:	
	incf	(_buff),f
	skipnz
	incf	(_buff+1),f
	
i1l3075:	
	bcf	status, 5	;RP0=0, select bank0
	movf	(_CH3_remotekey_num),w
	movwf	(??_ISR+0)+0
	clrf	(??_ISR+0)+0+1
	movf	1+(??_ISR+0)+0,w
	subwf	(_buff+1),w
	skipz
	goto	u167_25
	movf	0+(??_ISR+0)+0,w
	subwf	(_buff),w
u167_25:
	skipc
	goto	u167_21
	goto	u167_20
u167_21:
	goto	i1l3063
u167_20:
	line	212
	
i1l870:	
	line	213
;1.C: 209: }
;1.C: 210: }
;1.C: 211: }
;1.C: 212: }
;1.C: 213: FLAGs &= ~0x08;
	bcf	(_FLAGs)+(3/8),(3)&7
	line	214
	
i1l3077:	
;1.C: 214: Indata = 0;
	bsf	status, 5	;RP0=1, select bank1
	clrf	(_Indata)^080h
	clrf	(_Indata+1)^080h
	line	215
;1.C: 215: num = 0;
	bcf	status, 5	;RP0=0, select bank0
	clrf	(_num)
	line	216
	
i1l3079:	
;1.C: 216: remotekey = 0;
	bsf	status, 5	;RP0=1, select bank1
	clrf	(_remotekey)^080h
	clrf	(_remotekey+1)^080h
	clrf	(_remotekey+2)^080h
	clrf	(_remotekey+3)^080h
	line	217
	
i1l3081:	
;1.C: 217: Ctrl_remotekey = 0;
	clrf	(_Ctrl_remotekey)^080h
	clrf	(_Ctrl_remotekey+1)^080h
	clrf	(_Ctrl_remotekey+2)^080h
	clrf	(_Ctrl_remotekey+3)^080h
	line	221
	
i1l3083:	
;1.C: 218: }
;1.C: 219: }
;1.C: 220: }
;1.C: 221: if((FLAGs&0x08) == 0){
	btfsc	(_FLAGs),(3)&7
	goto	u168_21
	goto	u168_20
u168_21:
	goto	i1l3103
u168_20:
	line	222
	
i1l3085:	
;1.C: 222: if(buff > 7000){
	movlw	high(01B59h)
	subwf	(_buff+1),w
	movlw	low(01B59h)
	skipnz
	subwf	(_buff),w
	skipc
	goto	u169_21
	goto	u169_20
u169_21:
	goto	i1l3103
u169_20:
	line	223
	
i1l3087:	
;1.C: 223: FLAGs |= 0x08;
	bsf	(_FLAGs)+(3/8),(3)&7
	line	224
	
i1l3089:	
;1.C: 224: num = 0;
	bcf	status, 5	;RP0=0, select bank0
	clrf	(_num)
	line	225
	
i1l3091:	
;1.C: 225: remotekey = 0;
	bsf	status, 5	;RP0=1, select bank1
	clrf	(_remotekey)^080h
	clrf	(_remotekey+1)^080h
	clrf	(_remotekey+2)^080h
	clrf	(_remotekey+3)^080h
	line	230
	
i1l3093:	
;1.C: 227: if( ((FLAGs&0x10) == 0x10) ||
;1.C: 228: ((FLAGs&0x20) == 0x20) ||
;1.C: 229: ((FLAGs&0x40) == 0x40)
;1.C: 230: ){
	btfsc	(_FLAGs),(4)&7
	goto	u170_21
	goto	u170_20
u170_21:
	goto	i1l3099
u170_20:
	
i1l3095:	
	btfsc	(_FLAGs),(5)&7
	goto	u171_21
	goto	u171_20
u171_21:
	goto	i1l3099
u171_20:
	
i1l3097:	
	btfss	(_FLAGs),(6)&7
	goto	u172_21
	goto	u172_20
u172_21:
	goto	i1l860
u172_20:
	line	231
	
i1l3099:	
;1.C: 231: remotekey_slice = 0;
	bcf	status, 5	;RP0=0, select bank0
	clrf	(_remotekey_slice)
	line	232
	
i1l3101:	
;1.C: 232: FLAGs &= ~0x08;
	bcf	(_FLAGs)+(3/8),(3)&7
	goto	i1l3103
	line	236
	
i1l860:	
	line	237
	
i1l3103:	
;1.C: 233: }
;1.C: 234: }
;1.C: 235: }
;1.C: 236: }
;1.C: 237: TMR2ON =1;
	bcf	status, 5	;RP0=0, select bank0
	bsf	(146/8),(146)&7
	line	238
	
i1l3105:	
;1.C: 238: INTE = 1;
	bsf	(92/8),(92)&7
	line	242
	
i1l3107:	
;1.C: 239: }
;1.C: 242: if(TMR2IE && TMR2IF){
	bsf	status, 5	;RP0=1, select bank1
	btfss	(1121/8)^080h,(1121)&7
	goto	u173_21
	goto	u173_20
u173_21:
	goto	i1l3163
u173_20:
	
i1l3109:	
	bcf	status, 5	;RP0=0, select bank0
	btfss	(97/8),(97)&7
	goto	u174_21
	goto	u174_20
u174_21:
	goto	i1l3163
u174_20:
	line	243
	
i1l3111:	
;1.C: 243: TMR2IF = 0;
	bcf	(97/8),(97)&7
	line	245
;1.C: 245: if((FLAGs&0x02) == 0x02){
	btfss	(_FLAGs),(1)&7
	goto	u175_21
	goto	u175_20
u175_21:
	goto	i1l892
u175_20:
	line	246
	
i1l3113:	
;1.C: 246: Indata++;
	bsf	status, 5	;RP0=1, select bank1
	incf	(_Indata)^080h,f
	skipnz
	incf	(_Indata+1)^080h,f
	line	247
;1.C: 247: }else{
	goto	i1l3163
	
i1l892:	
	line	256
;1.C: 256: if((FLAGs&0x80) == 0){
	btfsc	(_FLAGs),(7)&7
	goto	u176_21
	goto	u176_20
u176_21:
	goto	i1l3133
u176_20:
	line	257
	
i1l3115:	
;1.C: 257: if(PA2 == 1){
	btfss	(42/8),(42)&7
	goto	u177_21
	goto	u177_20
u177_21:
	goto	i1l3119
u177_20:
	line	258
	
i1l3117:	
;1.C: 258: HIndata++;
	bsf	status, 5	;RP0=1, select bank1
	incf	(_HIndata)^080h,f
	skipnz
	incf	(_HIndata+1)^080h,f
	line	259
;1.C: 259: }else{
	goto	i1l3133
	line	260
	
i1l3119:	
;1.C: 260: buff = HIndata*53;
	bsf	status, 5	;RP0=1, select bank1
	movf	(_HIndata+1)^080h,w
	movwf	(?___wmul+1)
	movf	(_HIndata)^080h,w
	movwf	(?___wmul)
	movlw	035h
	movwf	0+(?___wmul)+02h
	clrf	1+(?___wmul)+02h
	fcall	___wmul
	movf	(1+(?___wmul)),w
	movwf	(_buff+1)
	movf	(0+(?___wmul)),w
	movwf	(_buff)
	line	261
	
i1l3121:	
;1.C: 261: HIndata = 0;
	clrf	(_HIndata)^080h
	clrf	(_HIndata+1)^080h
	line	264
	
i1l3123:	
;1.C: 262: if( ((buff>200)&&(buff<600)) ||
;1.C: 263: ((buff>700)&&(buff<1800))
;1.C: 264: ){
	movlw	high(0C9h)
	subwf	(_buff+1),w
	movlw	low(0C9h)
	skipnz
	subwf	(_buff),w
	skipc
	goto	u178_21
	goto	u178_20
u178_21:
	goto	i1l3127
u178_20:
	
i1l3125:	
	movlw	high(0258h)
	subwf	(_buff+1),w
	movlw	low(0258h)
	skipnz
	subwf	(_buff),w
	skipc
	goto	u179_21
	goto	u179_20
u179_21:
	goto	i1l899
u179_20:
	
i1l3127:	
	movlw	high(02BDh)
	subwf	(_buff+1),w
	movlw	low(02BDh)
	skipnz
	subwf	(_buff),w
	skipc
	goto	u180_21
	goto	u180_20
u180_21:
	goto	i1l3131
u180_20:
	
i1l3129:	
	movlw	high(0708h)
	subwf	(_buff+1),w
	movlw	low(0708h)
	skipnz
	subwf	(_buff),w
	skipnc
	goto	u181_21
	goto	u181_20
u181_21:
	goto	i1l3131
u181_20:
	
i1l899:	
	line	265
;1.C: 265: FLAGs |= 0x80;
	bsf	(_FLAGs)+(7/8),(7)&7
	line	266
;1.C: 266: }else{
	goto	i1l3133
	line	267
	
i1l3131:	
;1.C: 267: i = 0;
	clrf	(_i)^080h
	line	271
	
i1l3133:	
;1.C: 268: }
;1.C: 269: }
;1.C: 270: }
;1.C: 271: if((FLAGs&0x80) == 0x80){
	btfss	(_FLAGs),(7)&7
	goto	u182_21
	goto	u182_20
u182_21:
	goto	i1l3157
u182_20:
	line	272
	
i1l3135:	
;1.C: 272: if(PA2 == 0){
	bcf	status, 5	;RP0=0, select bank0
	btfsc	(42/8),(42)&7
	goto	u183_21
	goto	u183_20
u183_21:
	goto	i1l3139
u183_20:
	line	273
	
i1l3137:	
;1.C: 273: LIndata++;
	bsf	status, 5	;RP0=1, select bank1
	incf	(_LIndata)^080h,f
	skipnz
	incf	(_LIndata+1)^080h,f
	line	274
;1.C: 274: }else{
	goto	i1l3157
	line	275
	
i1l3139:	
;1.C: 275: buff = LIndata*53;
	bsf	status, 5	;RP0=1, select bank1
	movf	(_LIndata+1)^080h,w
	movwf	(?___wmul+1)
	movf	(_LIndata)^080h,w
	movwf	(?___wmul)
	movlw	035h
	movwf	0+(?___wmul)+02h
	clrf	1+(?___wmul)+02h
	fcall	___wmul
	movf	(1+(?___wmul)),w
	movwf	(_buff+1)
	movf	(0+(?___wmul)),w
	movwf	(_buff)
	line	276
	
i1l3141:	
;1.C: 276: LIndata = 0;
	clrf	(_LIndata)^080h
	clrf	(_LIndata+1)^080h
	line	279
	
i1l3143:	
;1.C: 277: if( ((buff>200)&&(buff<600)) ||
;1.C: 278: ((buff>700)&&(buff<1800))
;1.C: 279: ){
	movlw	high(0C9h)
	subwf	(_buff+1),w
	movlw	low(0C9h)
	skipnz
	subwf	(_buff),w
	skipc
	goto	u184_21
	goto	u184_20
u184_21:
	goto	i1l3147
u184_20:
	
i1l3145:	
	movlw	high(0258h)
	subwf	(_buff+1),w
	movlw	low(0258h)
	skipnz
	subwf	(_buff),w
	skipc
	goto	u185_21
	goto	u185_20
u185_21:
	goto	i1l3151
u185_20:
	
i1l3147:	
	movlw	high(02BDh)
	subwf	(_buff+1),w
	movlw	low(02BDh)
	skipnz
	subwf	(_buff),w
	skipc
	goto	u186_21
	goto	u186_20
u186_21:
	goto	i1l3153
u186_20:
	
i1l3149:	
	movlw	high(0708h)
	subwf	(_buff+1),w
	movlw	low(0708h)
	skipnz
	subwf	(_buff),w
	skipnc
	goto	u187_21
	goto	u187_20
u187_21:
	goto	i1l3153
u187_20:
	line	280
	
i1l3151:	
;1.C: 280: i++;
	incf	(_i)^080h,f
	line	281
;1.C: 281: }else{
	goto	i1l3155
	line	282
	
i1l3153:	
;1.C: 282: i = 0;
	clrf	(_i)^080h
	line	284
	
i1l3155:	
;1.C: 283: }
;1.C: 284: FLAGs &= ~0x80;
	bcf	(_FLAGs)+(7/8),(7)&7
	line	287
	
i1l3157:	
;1.C: 285: }
;1.C: 286: }
;1.C: 287: if(i>3){
	movlw	(04h)
	bsf	status, 5	;RP0=1, select bank1
	subwf	(_i)^080h,w
	skipc
	goto	u188_21
	goto	u188_20
u188_21:
	goto	i1l3163
u188_20:
	line	288
	
i1l3159:	
;1.C: 288: FLAGs |= 0x02;
	bsf	(_FLAGs)+(1/8),(1)&7
	line	289
	
i1l3161:	
;1.C: 289: i = 0;
	clrf	(_i)^080h
	line	296
	
i1l3163:	
;1.C: 291: }
;1.C: 292: }
;1.C: 293: }
;1.C: 296: if(T0IE && T0IF){
	btfss	(93/8),(93)&7
	goto	u189_21
	goto	u189_20
u189_21:
	goto	i1l939
u189_20:
	
i1l3165:	
	btfss	(90/8),(90)&7
	goto	u190_21
	goto	u190_20
u190_21:
	goto	i1l939
u190_20:
	line	297
	
i1l3167:	
;1.C: 297: T0IF = 0;
	bcf	(90/8),(90)&7
	line	298
	
i1l3169:	
;1.C: 298: ms16_counter ++;
	bcf	status, 5	;RP0=0, select bank0
	incf	(_ms16_counter),f
	line	304
	
i1l3171:	
;1.C: 301: if( ((FLAGs&0x10) == 0x10) ||
;1.C: 302: ((FLAGs&0x20) == 0x20) ||
;1.C: 303: ((FLAGs&0x40) == 0x40)
;1.C: 304: ){
	btfsc	(_FLAGs),(4)&7
	goto	u191_21
	goto	u191_20
u191_21:
	goto	i1l3177
u191_20:
	
i1l3173:	
	btfsc	(_FLAGs),(5)&7
	goto	u192_21
	goto	u192_20
u192_21:
	goto	i1l3177
u192_20:
	
i1l3175:	
	btfss	(_FLAGs),(6)&7
	goto	u193_21
	goto	u193_20
u193_21:
	goto	i1l3191
u193_20:
	line	305
	
i1l3177:	
;1.C: 305: remotekey_slice++;
	incf	(_remotekey_slice),f
	line	306
	
i1l3179:	
;1.C: 306: if( remotekey_slice>(110/8)){
	movlw	(0Eh)
	subwf	(_remotekey_slice),w
	skipc
	goto	u194_21
	goto	u194_20
u194_21:
	goto	i1l3191
u194_20:
	line	307
	
i1l3181:	
;1.C: 307: remotekey_slice = 0;
	clrf	(_remotekey_slice)
	line	309
	
i1l3183:	
;1.C: 309: FLAGs &= ~0x02;
	bcf	(_FLAGs)+(1/8),(1)&7
	line	310
	
i1l3185:	
;1.C: 310: FLAGs &= ~0x10;
	bcf	(_FLAGs)+(4/8),(4)&7
	line	311
	
i1l3187:	
;1.C: 311: FLAGs &= ~0x20;
	bcf	(_FLAGs)+(5/8),(5)&7
	line	312
	
i1l3189:	
;1.C: 312: FLAGs &= ~0x40;
	bcf	(_FLAGs)+(6/8),(6)&7
	line	319
	
i1l3191:	
;1.C: 313: }
;1.C: 314: }
;1.C: 316: if( ((PRESSED&0x10) == 0x10) ||
;1.C: 317: ((PRESSED&0x20) == 0x20) ||
;1.C: 318: ((PRESSED&0x40) == 0x40)
;1.C: 319: ){
	btfsc	(_PRESSED),(4)&7
	goto	u195_21
	goto	u195_20
u195_21:
	goto	i1l3197
u195_20:
	
i1l3193:	
	btfsc	(_PRESSED),(5)&7
	goto	u196_21
	goto	u196_20
u196_21:
	goto	i1l3197
u196_20:
	
i1l3195:	
	btfss	(_PRESSED),(6)&7
	goto	u197_21
	goto	u197_20
u197_21:
	goto	i1l3203
u197_20:
	line	320
	
i1l3197:	
;1.C: 320: match_slice++;
	incf	(_match_slice),f
	line	321
	
i1l3199:	
;1.C: 321: if(match_slice>(110/8)){
	movlw	(0Eh)
	subwf	(_match_slice),w
	skipc
	goto	u198_21
	goto	u198_20
u198_21:
	goto	i1l3203
u198_20:
	line	322
	
i1l3201:	
;1.C: 322: match_slice = 0;
	clrf	(_match_slice)
	line	323
;1.C: 323: remotekey_Receive_num = 0;
	clrf	(_remotekey_Receive_num)
	line	328
	
i1l3203:	
;1.C: 324: }
;1.C: 325: }
;1.C: 328: if((FLAGs&0x02) == 0){
	btfsc	(_FLAGs),(1)&7
	goto	u199_21
	goto	u199_20
u199_21:
	goto	i1l922
u199_20:
	line	329
	
i1l3205:	
;1.C: 329: EE_Buff = ms16_counter%8;
	movf	(_ms16_counter),w
	bsf	status, 5	;RP0=1, select bank1
	movwf	(_EE_Buff)^080h
	
i1l3207:	
	movlw	(07h)
	andwf	(_EE_Buff)^080h,f
	line	330
	
i1l3209:	
;1.C: 330: if(EE_Buff == 1){
	decf	(_EE_Buff)^080h,w
	skipz
	goto	u200_21
	goto	u200_20
u200_21:
	goto	i1l3219
u200_20:
	line	331
	
i1l3211:	
;1.C: 331: PA3 = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	(43/8),(43)&7
	line	333
	
i1l3213:	
;1.C: 333: EX_INT_FallingEdge();
	fcall	i1_EX_INT_FallingEdge
	line	334
	
i1l3215:	
;1.C: 334: INTE =1;
	bsf	(92/8),(92)&7
	line	335
	
i1l3217:	
;1.C: 335: TMR2ON =1;
	bcf	status, 5	;RP0=0, select bank0
	bsf	(146/8),(146)&7
	line	337
	
i1l3219:	
;1.C: 336: }
;1.C: 337: if(EE_Buff == 4){
	bsf	status, 5	;RP0=1, select bank1
	movf	(_EE_Buff)^080h,w
	xorlw	04h
	skipz
	goto	u201_21
	goto	u201_20
u201_21:
	goto	i1l925
u201_20:
	line	338
	
i1l3221:	
;1.C: 338: PA3 = 1;
	bcf	status, 5	;RP0=0, select bank0
	bsf	(43/8),(43)&7
	line	339
;1.C: 339: TMR2ON =0;
	bcf	(146/8),(146)&7
	line	340
;1.C: 340: INTE =0;
	bcf	(92/8),(92)&7
	goto	i1l925
	line	342
	
i1l922:	
	line	343
;1.C: 343: PA3 = 0;
	bcf	(43/8),(43)&7
	line	344
;1.C: 344: INTE =1;
	bsf	(92/8),(92)&7
	line	345
;1.C: 345: TMR2ON =1;
	bsf	(146/8),(146)&7
	line	346
	
i1l925:	
	line	349
;1.C: 346: }
;1.C: 349: if(ms16_counter%2 == 0){
	bcf	status, 5	;RP0=0, select bank0
	btfsc	(_ms16_counter),(0)&7
	goto	u202_21
	goto	u202_20
u202_21:
	goto	i1l3227
u202_20:
	line	350
	
i1l3223:	
;1.C: 350: KEYSCAN();
	fcall	_KEYSCAN
	line	351
	
i1l3225:	
;1.C: 351: KEY();
	fcall	_KEY
	line	356
	
i1l3227:	
;1.C: 352: }
;1.C: 356: if(ms16_counter >= 120){
	movlw	(078h)
	subwf	(_ms16_counter),w
	skipc
	goto	u203_21
	goto	u203_20
u203_21:
	goto	i1l939
u203_20:
	line	357
	
i1l3229:	
;1.C: 357: ms16_counter = 0;
	clrf	(_ms16_counter)
	line	363
	
i1l3231:	
;1.C: 360: if( ((PRESSED&0x10) == 0x10) ||
;1.C: 361: ((PRESSED&0x20) == 0x20) ||
;1.C: 362: ((PRESSED&0x40) == 0x40)
;1.C: 363: ){
	btfsc	(_PRESSED),(4)&7
	goto	u204_21
	goto	u204_20
u204_21:
	goto	i1l3237
u204_20:
	
i1l3233:	
	btfsc	(_PRESSED),(5)&7
	goto	u205_21
	goto	u205_20
u205_21:
	goto	i1l3237
u205_20:
	
i1l3235:	
	btfss	(_PRESSED),(6)&7
	goto	u206_21
	goto	u206_20
u206_21:
	goto	i1l939
u206_20:
	line	364
	
i1l3237:	
;1.C: 364: if(KEY_Match_counter<4){
	movlw	(04h)
	subwf	(_KEY_Match_counter),w
	skipnc
	goto	u207_21
	goto	u207_20
u207_21:
	goto	i1l931
u207_20:
	line	365
	
i1l3239:	
;1.C: 365: KEY_Match_counter++;
	incf	(_KEY_Match_counter),f
	line	366
	
i1l931:	
	line	367
;1.C: 366: }
;1.C: 367: LONGPRESS_OverTime_Counter++;
	incf	(_LONGPRESS_OverTime_Counter),f
	line	368
	
i1l3241:	
;1.C: 368: if(LONGPRESS_OverTime_Counter > 15){
	movlw	(010h)
	subwf	(_LONGPRESS_OverTime_Counter),w
	skipc
	goto	u208_21
	goto	u208_20
u208_21:
	goto	i1l927
u208_20:
	line	369
	
i1l3243:	
;1.C: 369: LONGPRESS_OverTime_Counter = 0;
	clrf	(_LONGPRESS_OverTime_Counter)
	line	370
	
i1l3245:	
;1.C: 370: if((PRESSED&0x10) == 0x10){
	btfss	(_PRESSED),(4)&7
	goto	u209_21
	goto	u209_20
u209_21:
	goto	i1l3257
u209_20:
	line	371
	
i1l3247:	
;1.C: 371: CH1_remotekey[CH1_remotekey_Latest] = CH1_remotekey[CH1_remotekey_num-1];
	movf	(_CH1_remotekey_num),w
	movwf	(??_ISR+0)+0
	clrc
	rlf	(??_ISR+0)+0,f
	clrc
	rlf	(??_ISR+0)+0,w
	addlw	_CH1_remotekey+-4&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	movwf	(??_ISR+1)+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_ISR+1)+0+1
	incf	fsr0,f
	movf	indf,w
	movwf	(??_ISR+1)+0+2
	incf	fsr0,f
	movf	indf,w
	movwf	(??_ISR+1)+0+3
	bsf	status, 5	;RP0=1, select bank1
	movf	(_CH1_remotekey_Latest)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	movwf	(??_ISR+5)+0
	clrc
	rlf	(??_ISR+5)+0,f
	clrc
	rlf	(??_ISR+5)+0,w
	addlw	_CH1_remotekey&0ffh
	movwf	fsr0
	movf	0+(??_ISR+1)+0,w
	movwf	indf
	incf	fsr0,f
	movf	1+(??_ISR+1)+0,w
	movwf	indf
	incf	fsr0,f
	movf	2+(??_ISR+1)+0,w
	movwf	indf
	incf	fsr0,f
	movf	3+(??_ISR+1)+0,w
	movwf	indf
	line	372
;1.C: 372: CH1_remotekey[CH1_remotekey_num-1] = 0xFFFFFFFF;
	movf	(_CH1_remotekey_num),w
	movwf	(??_ISR+0)+0
	clrc
	rlf	(??_ISR+0)+0,f
	clrc
	rlf	(??_ISR+0)+0,w
	addlw	_CH1_remotekey+-4&0ffh
	movwf	fsr0
	movlw	0FFh
	movwf	indf
	incf	fsr0,f
	movlw	0FFh
	movwf	indf
	incf	fsr0,f
	movlw	0FFh
	movwf	indf
	incf	fsr0,f
	movlw	0FFh
	movwf	indf
	line	373
	
i1l3249:	
;1.C: 373: if(CH1_remotekey_num>0) CH1_remotekey_num--;
	movf	(_CH1_remotekey_num),w
	skipz
	goto	u210_20
	goto	i1l3253
u210_20:
	
i1l3251:	
	decf	(_CH1_remotekey_num),f
	line	374
	
i1l3253:	
;1.C: 374: PRESSED &= ~0x10;
	bcf	(_PRESSED)+(4/8),(4)&7
	line	375
	
i1l3255:	
;1.C: 375: PA7 = 1;
	bsf	(47/8),(47)&7
	line	377
	
i1l3257:	
;1.C: 376: }
;1.C: 377: if((PRESSED&0x20) == 0x20){
	btfss	(_PRESSED),(5)&7
	goto	u211_21
	goto	u211_20
u211_21:
	goto	i1l3269
u211_20:
	line	378
	
i1l3259:	
;1.C: 378: CH2_remotekey[CH2_remotekey_Latest] = CH2_remotekey[CH2_remotekey_num-1];
	movf	(_CH2_remotekey_num),w
	movwf	(??_ISR+0)+0
	clrc
	rlf	(??_ISR+0)+0,f
	clrc
	rlf	(??_ISR+0)+0,w
	addlw	_CH2_remotekey+-4&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	movwf	(??_ISR+1)+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_ISR+1)+0+1
	incf	fsr0,f
	movf	indf,w
	movwf	(??_ISR+1)+0+2
	incf	fsr0,f
	movf	indf,w
	movwf	(??_ISR+1)+0+3
	bsf	status, 5	;RP0=1, select bank1
	movf	(_CH2_remotekey_Latest)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	movwf	(??_ISR+5)+0
	clrc
	rlf	(??_ISR+5)+0,f
	clrc
	rlf	(??_ISR+5)+0,w
	addlw	_CH2_remotekey&0ffh
	movwf	fsr0
	movf	0+(??_ISR+1)+0,w
	movwf	indf
	incf	fsr0,f
	movf	1+(??_ISR+1)+0,w
	movwf	indf
	incf	fsr0,f
	movf	2+(??_ISR+1)+0,w
	movwf	indf
	incf	fsr0,f
	movf	3+(??_ISR+1)+0,w
	movwf	indf
	line	379
;1.C: 379: CH2_remotekey[CH2_remotekey_num-1] = 0xFFFFFFFF;
	movf	(_CH2_remotekey_num),w
	movwf	(??_ISR+0)+0
	clrc
	rlf	(??_ISR+0)+0,f
	clrc
	rlf	(??_ISR+0)+0,w
	addlw	_CH2_remotekey+-4&0ffh
	movwf	fsr0
	movlw	0FFh
	movwf	indf
	incf	fsr0,f
	movlw	0FFh
	movwf	indf
	incf	fsr0,f
	movlw	0FFh
	movwf	indf
	incf	fsr0,f
	movlw	0FFh
	movwf	indf
	line	380
	
i1l3261:	
;1.C: 380: if(CH2_remotekey_num>0) CH2_remotekey_num--;
	movf	(_CH2_remotekey_num),w
	skipz
	goto	u212_20
	goto	i1l3265
u212_20:
	
i1l3263:	
	decf	(_CH2_remotekey_num),f
	line	381
	
i1l3265:	
;1.C: 381: PRESSED &= ~0x20;
	bcf	(_PRESSED)+(5/8),(5)&7
	line	382
	
i1l3267:	
;1.C: 382: PA6 = 1;
	bsf	(46/8),(46)&7
	line	384
	
i1l3269:	
;1.C: 383: }
;1.C: 384: if((PRESSED&0x40) == 0x40){
	btfss	(_PRESSED),(6)&7
	goto	u213_21
	goto	u213_20
u213_21:
	goto	i1l3281
u213_20:
	line	385
	
i1l3271:	
;1.C: 385: CH3_remotekey[CH3_remotekey_Latest] = CH3_remotekey[CH3_remotekey_num-1];
	movf	(_CH3_remotekey_num),w
	movwf	(??_ISR+0)+0
	clrc
	rlf	(??_ISR+0)+0,f
	clrc
	rlf	(??_ISR+0)+0,w
	addlw	_CH3_remotekey+-4&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	movwf	(??_ISR+1)+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_ISR+1)+0+1
	incf	fsr0,f
	movf	indf,w
	movwf	(??_ISR+1)+0+2
	incf	fsr0,f
	movf	indf,w
	movwf	(??_ISR+1)+0+3
	bsf	status, 5	;RP0=1, select bank1
	movf	(_CH3_remotekey_Latest)^080h,w
	bcf	status, 5	;RP0=0, select bank0
	movwf	(??_ISR+5)+0
	clrc
	rlf	(??_ISR+5)+0,f
	clrc
	rlf	(??_ISR+5)+0,w
	addlw	_CH3_remotekey&0ffh
	movwf	fsr0
	movf	0+(??_ISR+1)+0,w
	movwf	indf
	incf	fsr0,f
	movf	1+(??_ISR+1)+0,w
	movwf	indf
	incf	fsr0,f
	movf	2+(??_ISR+1)+0,w
	movwf	indf
	incf	fsr0,f
	movf	3+(??_ISR+1)+0,w
	movwf	indf
	line	386
;1.C: 386: CH3_remotekey[CH3_remotekey_num-1] = 0xFFFFFFFF;
	movf	(_CH3_remotekey_num),w
	movwf	(??_ISR+0)+0
	clrc
	rlf	(??_ISR+0)+0,f
	clrc
	rlf	(??_ISR+0)+0,w
	addlw	_CH3_remotekey+-4&0ffh
	movwf	fsr0
	movlw	0FFh
	movwf	indf
	incf	fsr0,f
	movlw	0FFh
	movwf	indf
	incf	fsr0,f
	movlw	0FFh
	movwf	indf
	incf	fsr0,f
	movlw	0FFh
	movwf	indf
	line	387
	
i1l3273:	
;1.C: 387: if(CH3_remotekey_num>0) CH3_remotekey_num--;
	movf	(_CH3_remotekey_num),w
	skipz
	goto	u214_20
	goto	i1l3277
u214_20:
	
i1l3275:	
	decf	(_CH3_remotekey_num),f
	line	388
	
i1l3277:	
;1.C: 388: PRESSED &= ~0x40;
	bcf	(_PRESSED)+(6/8),(6)&7
	line	389
	
i1l3279:	
;1.C: 389: PA5 = 1;
	bsf	(45/8),(45)&7
	line	391
	
i1l3281:	
;1.C: 390: }
;1.C: 391: PC0 = 1;
	bsf	(56/8),(56)&7
	goto	i1l939
	line	394
	
i1l927:	
	line	396
	
i1l939:	
	bcf	status, 5	;RP0=0, select bank0
	movf	(??_ISR+9),w
	movwf	btemp+1
	movf	(??_ISR+8),w
	movwf	pclath
	movf	(??_ISR+7),w
	movwf	fsr0
	swapf	(??_ISR+6)^00h,w
	movwf	status
	swapf	saved_w,f
	swapf	saved_w,w
	retfie
	opt stack 0
GLOBAL	__end_of_ISR
	__end_of_ISR:
;; =============== function _ISR ends ============

	signat	_ISR,88
	global	_KEY
psect	text688,local,class=CODE,delta=2
global __ptext688
__ptext688:

;; *************** function _KEY *****************
;; Defined at:
;;		line 666 in file "1.C"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 20/0
;;		Unchanged: FFEDF/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          2       0       0
;;      Totals:         2       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_CH1_EEPROM_Write
;;		_CH2_EEPROM_Write
;;		_CH3_EEPROM_Write
;;		_led1_debug
;; This function is called by:
;;		_ISR
;; This function uses a non-reentrant model
;;
psect	text688
	file	"1.C"
	line	666
	global	__size_of_KEY
	__size_of_KEY	equ	__end_of_KEY-_KEY
	
_KEY:	
	opt	stack 1
; Regs used in _KEY: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	670
	
i1l3425:	
;1.C: 667: if( ((PRESSED&0x10) == 0x10) ||
;1.C: 668: ((PRESSED&0x20) == 0x20) ||
;1.C: 669: ((PRESSED&0x40) == 0x40)
;1.C: 670: ){
	btfsc	(_PRESSED),(4)&7
	goto	u238_21
	goto	u238_20
u238_21:
	goto	i1l3537
u238_20:
	
i1l3427:	
	btfsc	(_PRESSED),(5)&7
	goto	u239_21
	goto	u239_20
u239_21:
	goto	i1l3537
u239_20:
	
i1l3429:	
	btfss	(_PRESSED),(6)&7
	goto	u240_21
	goto	u240_20
u240_21:
	goto	i1l1016
u240_20:
	goto	i1l3537
	line	673
	
i1l3431:	
;1.C: 673: Match_remotekey = 0xFFFFFFFF;
	movlw	0FFh
	movwf	(_Match_remotekey+3)
	movlw	0FFh
	movwf	(_Match_remotekey+2)
	movlw	0FFh
	movwf	(_Match_remotekey+1)
	movlw	0FFh
	movwf	(_Match_remotekey)

	line	674
;1.C: 674: break;
	goto	i1l1016
	line	675
;1.C: 675: case 1:
	
i1l1022:	
	line	676
;1.C: 676: PC0 = 0;
	bcf	(56/8),(56)&7
	line	677
;1.C: 677: if((PRESSED&0x10) == 0x10) PA7 = 0;
	btfss	(_PRESSED),(4)&7
	goto	u241_21
	goto	u241_20
u241_21:
	goto	i1l1023
u241_20:
	
i1l3433:	
	bcf	(47/8),(47)&7
	
i1l1023:	
	line	678
;1.C: 678: if((PRESSED&0x20) == 0x20) PA6 = 0;
	btfss	(_PRESSED),(5)&7
	goto	u242_21
	goto	u242_20
u242_21:
	goto	i1l1024
u242_20:
	
i1l3435:	
	bcf	(46/8),(46)&7
	
i1l1024:	
	line	679
;1.C: 679: if((PRESSED&0x40) == 0x40) PA5 = 0;
	btfss	(_PRESSED),(6)&7
	goto	u243_21
	goto	u243_20
u243_21:
	goto	i1l1016
u243_20:
	
i1l3437:	
	bcf	(45/8),(45)&7
	goto	i1l1016
	line	681
;1.C: 681: case 2:
	
i1l1026:	
	line	682
;1.C: 682: PC0 = 1;
	bsf	(56/8),(56)&7
	line	683
;1.C: 683: if((PRESSED&0x10) == 0x10) PA7 = 1;
	btfss	(_PRESSED),(4)&7
	goto	u244_21
	goto	u244_20
u244_21:
	goto	i1l1027
u244_20:
	
i1l3439:	
	bsf	(47/8),(47)&7
	
i1l1027:	
	line	684
;1.C: 684: if((PRESSED&0x20) == 0x20) PA6 = 1;
	btfss	(_PRESSED),(5)&7
	goto	u245_21
	goto	u245_20
u245_21:
	goto	i1l1028
u245_20:
	
i1l3441:	
	bsf	(46/8),(46)&7
	
i1l1028:	
	line	685
;1.C: 685: if((PRESSED&0x40) == 0x40) PA5 = 1;
	btfss	(_PRESSED),(6)&7
	goto	u246_21
	goto	u246_20
u246_21:
	goto	i1l1016
u246_20:
	
i1l3443:	
	bsf	(45/8),(45)&7
	goto	i1l1016
	line	687
;1.C: 687: case 3:
	
i1l1030:	
	line	688
;1.C: 688: KEY_Match_counter = 1;
	clrf	(_KEY_Match_counter)
	incf	(_KEY_Match_counter),f
	line	689
	
i1l3445:	
;1.C: 689: if(remotekey_Receive_num >= 3){
	movlw	(03h)
	subwf	(_remotekey_Receive_num),w
	skipc
	goto	u247_21
	goto	u247_20
u247_21:
	goto	i1l1016
u247_20:
	line	690
	
i1l3447:	
;1.C: 690: if((PRESSED&0x10) == 0x10){
	btfss	(_PRESSED),(4)&7
	goto	u248_21
	goto	u248_20
u248_21:
	goto	i1l3475
u248_20:
	line	695
	
i1l3449:	
;1.C: 691: if( (Match_remotekey != CH1_remotekey[0]) &&
;1.C: 692: (Match_remotekey != CH1_remotekey[1]) &&
;1.C: 693: (Match_remotekey != CH1_remotekey[2]) &&
;1.C: 694: (Match_remotekey != CH1_remotekey[3])
;1.C: 695: ){
	movf	(_Match_remotekey+3),w
	xorwf	(_CH1_remotekey+3),w
	skipz
	goto	u249_25
	movf	(_Match_remotekey+2),w
	xorwf	(_CH1_remotekey+2),w
	skipz
	goto	u249_25
	movf	(_Match_remotekey+1),w
	xorwf	(_CH1_remotekey+1),w
	skipz
	goto	u249_25
	movf	(_Match_remotekey),w
	xorwf	(_CH1_remotekey),w
u249_25:
	skipnz
	goto	u249_21
	goto	u249_20
u249_21:
	goto	i1l3465
u249_20:
	
i1l3451:	
	movf	(_Match_remotekey+3),w
	xorwf	3+(_CH1_remotekey)+04h,w
	skipz
	goto	u250_25
	movf	(_Match_remotekey+2),w
	xorwf	2+(_CH1_remotekey)+04h,w
	skipz
	goto	u250_25
	movf	(_Match_remotekey+1),w
	xorwf	1+(_CH1_remotekey)+04h,w
	skipz
	goto	u250_25
	movf	(_Match_remotekey),w
	xorwf	0+(_CH1_remotekey)+04h,w
u250_25:
	skipnz
	goto	u250_21
	goto	u250_20
u250_21:
	goto	i1l3465
u250_20:
	
i1l3453:	
	movf	(_Match_remotekey+3),w
	xorwf	3+(_CH1_remotekey)+08h,w
	skipz
	goto	u251_25
	movf	(_Match_remotekey+2),w
	xorwf	2+(_CH1_remotekey)+08h,w
	skipz
	goto	u251_25
	movf	(_Match_remotekey+1),w
	xorwf	1+(_CH1_remotekey)+08h,w
	skipz
	goto	u251_25
	movf	(_Match_remotekey),w
	xorwf	0+(_CH1_remotekey)+08h,w
u251_25:
	skipnz
	goto	u251_21
	goto	u251_20
u251_21:
	goto	i1l3465
u251_20:
	
i1l3455:	
	movf	(_Match_remotekey+3),w
	xorwf	3+(_CH1_remotekey)+0Ch,w
	skipz
	goto	u252_25
	movf	(_Match_remotekey+2),w
	xorwf	2+(_CH1_remotekey)+0Ch,w
	skipz
	goto	u252_25
	movf	(_Match_remotekey+1),w
	xorwf	1+(_CH1_remotekey)+0Ch,w
	skipz
	goto	u252_25
	movf	(_Match_remotekey),w
	xorwf	0+(_CH1_remotekey)+0Ch,w
u252_25:
	skipnz
	goto	u252_21
	goto	u252_20
u252_21:
	goto	i1l3465
u252_20:
	line	696
	
i1l3457:	
;1.C: 696: if(CH1_remotekey_num < 4){
	movlw	(04h)
	subwf	(_CH1_remotekey_num),w
	skipnc
	goto	u253_21
	goto	u253_20
u253_21:
	goto	i1l3463
u253_20:
	line	697
	
i1l3459:	
;1.C: 697: CH1_remotekey[CH1_remotekey_num] = Match_remotekey;
	movf	(_CH1_remotekey_num),w
	movwf	(??_KEY+0)+0
	clrc
	rlf	(??_KEY+0)+0,f
	clrc
	rlf	(??_KEY+0)+0,w
	addlw	_CH1_remotekey&0ffh
	movwf	fsr0
	movf	(_Match_remotekey),w
	bcf	status, 7	;select IRP bank0
	movwf	indf
	incf	fsr0,f
	movf	(_Match_remotekey+1),w
	movwf	indf
	incf	fsr0,f
	movf	(_Match_remotekey+2),w
	movwf	indf
	incf	fsr0,f
	movf	(_Match_remotekey+3),w
	movwf	indf
	line	698
	
i1l3461:	
;1.C: 698: CH1_remotekey_num++;
	incf	(_CH1_remotekey_num),f
	line	699
;1.C: 699: }else{
	goto	i1l3465
	line	700
	
i1l3463:	
;1.C: 700: CH1_remotekey[CH1_remotekey_Latest] = Match_remotekey;
	bsf	status, 5	;RP0=1, select bank1
	movf	(_CH1_remotekey_Latest)^080h,w
	movwf	(??_KEY+0)+0
	clrc
	rlf	(??_KEY+0)+0,f
	clrc
	rlf	(??_KEY+0)+0,w
	addlw	_CH1_remotekey&0ffh
	movwf	fsr0
	bcf	status, 5	;RP0=0, select bank0
	movf	(_Match_remotekey),w
	bcf	status, 7	;select IRP bank0
	movwf	indf
	incf	fsr0,f
	movf	(_Match_remotekey+1),w
	movwf	indf
	incf	fsr0,f
	movf	(_Match_remotekey+2),w
	movwf	indf
	incf	fsr0,f
	movf	(_Match_remotekey+3),w
	movwf	indf
	line	703
	
i1l3465:	
;1.C: 701: }
;1.C: 702: }
;1.C: 703: if(CH1_remotekey_num > 4) CH1_remotekey_num = 4;
	movlw	(05h)
	subwf	(_CH1_remotekey_num),w
	skipc
	goto	u254_21
	goto	u254_20
u254_21:
	goto	i1l3469
u254_20:
	
i1l3467:	
	movlw	(04h)
	movwf	(_CH1_remotekey_num)
	line	704
	
i1l3469:	
;1.C: 704: PRESSED &= ~0x10;
	bcf	(_PRESSED)+(4/8),(4)&7
	line	705
	
i1l3471:	
;1.C: 705: CH1_EEPROM_Write();
	fcall	_CH1_EEPROM_Write
	line	706
	
i1l3473:	
;1.C: 706: PA7 = 1;
	bcf	status, 5	;RP0=0, select bank0
	bsf	(47/8),(47)&7
	line	708
	
i1l3475:	
;1.C: 707: }
;1.C: 708: if((PRESSED&0x20) == 0x20){
	btfss	(_PRESSED),(5)&7
	goto	u255_21
	goto	u255_20
u255_21:
	goto	i1l3503
u255_20:
	line	713
	
i1l3477:	
;1.C: 709: if( (Match_remotekey != CH2_remotekey[0]) &&
;1.C: 710: (Match_remotekey != CH2_remotekey[1]) &&
;1.C: 711: (Match_remotekey != CH2_remotekey[2]) &&
;1.C: 712: (Match_remotekey != CH2_remotekey[3])
;1.C: 713: ){
	movf	(_Match_remotekey+3),w
	xorwf	(_CH2_remotekey+3),w
	skipz
	goto	u256_25
	movf	(_Match_remotekey+2),w
	xorwf	(_CH2_remotekey+2),w
	skipz
	goto	u256_25
	movf	(_Match_remotekey+1),w
	xorwf	(_CH2_remotekey+1),w
	skipz
	goto	u256_25
	movf	(_Match_remotekey),w
	xorwf	(_CH2_remotekey),w
u256_25:
	skipnz
	goto	u256_21
	goto	u256_20
u256_21:
	goto	i1l3493
u256_20:
	
i1l3479:	
	movf	(_Match_remotekey+3),w
	xorwf	3+(_CH2_remotekey)+04h,w
	skipz
	goto	u257_25
	movf	(_Match_remotekey+2),w
	xorwf	2+(_CH2_remotekey)+04h,w
	skipz
	goto	u257_25
	movf	(_Match_remotekey+1),w
	xorwf	1+(_CH2_remotekey)+04h,w
	skipz
	goto	u257_25
	movf	(_Match_remotekey),w
	xorwf	0+(_CH2_remotekey)+04h,w
u257_25:
	skipnz
	goto	u257_21
	goto	u257_20
u257_21:
	goto	i1l3493
u257_20:
	
i1l3481:	
	movf	(_Match_remotekey+3),w
	xorwf	3+(_CH2_remotekey)+08h,w
	skipz
	goto	u258_25
	movf	(_Match_remotekey+2),w
	xorwf	2+(_CH2_remotekey)+08h,w
	skipz
	goto	u258_25
	movf	(_Match_remotekey+1),w
	xorwf	1+(_CH2_remotekey)+08h,w
	skipz
	goto	u258_25
	movf	(_Match_remotekey),w
	xorwf	0+(_CH2_remotekey)+08h,w
u258_25:
	skipnz
	goto	u258_21
	goto	u258_20
u258_21:
	goto	i1l3493
u258_20:
	
i1l3483:	
	movf	(_Match_remotekey+3),w
	xorwf	3+(_CH2_remotekey)+0Ch,w
	skipz
	goto	u259_25
	movf	(_Match_remotekey+2),w
	xorwf	2+(_CH2_remotekey)+0Ch,w
	skipz
	goto	u259_25
	movf	(_Match_remotekey+1),w
	xorwf	1+(_CH2_remotekey)+0Ch,w
	skipz
	goto	u259_25
	movf	(_Match_remotekey),w
	xorwf	0+(_CH2_remotekey)+0Ch,w
u259_25:
	skipnz
	goto	u259_21
	goto	u259_20
u259_21:
	goto	i1l3493
u259_20:
	line	714
	
i1l3485:	
;1.C: 714: if(CH2_remotekey_num < 4){
	movlw	(04h)
	subwf	(_CH2_remotekey_num),w
	skipnc
	goto	u260_21
	goto	u260_20
u260_21:
	goto	i1l3491
u260_20:
	line	715
	
i1l3487:	
;1.C: 715: CH2_remotekey[CH2_remotekey_num] = Match_remotekey;
	movf	(_CH2_remotekey_num),w
	movwf	(??_KEY+0)+0
	clrc
	rlf	(??_KEY+0)+0,f
	clrc
	rlf	(??_KEY+0)+0,w
	addlw	_CH2_remotekey&0ffh
	movwf	fsr0
	movf	(_Match_remotekey),w
	bcf	status, 7	;select IRP bank0
	movwf	indf
	incf	fsr0,f
	movf	(_Match_remotekey+1),w
	movwf	indf
	incf	fsr0,f
	movf	(_Match_remotekey+2),w
	movwf	indf
	incf	fsr0,f
	movf	(_Match_remotekey+3),w
	movwf	indf
	line	716
	
i1l3489:	
;1.C: 716: CH2_remotekey_num++;
	incf	(_CH2_remotekey_num),f
	line	717
;1.C: 717: }else{
	goto	i1l3493
	line	718
	
i1l3491:	
;1.C: 718: CH2_remotekey[CH2_remotekey_Latest] = Match_remotekey;
	bsf	status, 5	;RP0=1, select bank1
	movf	(_CH2_remotekey_Latest)^080h,w
	movwf	(??_KEY+0)+0
	clrc
	rlf	(??_KEY+0)+0,f
	clrc
	rlf	(??_KEY+0)+0,w
	addlw	_CH2_remotekey&0ffh
	movwf	fsr0
	bcf	status, 5	;RP0=0, select bank0
	movf	(_Match_remotekey),w
	bcf	status, 7	;select IRP bank0
	movwf	indf
	incf	fsr0,f
	movf	(_Match_remotekey+1),w
	movwf	indf
	incf	fsr0,f
	movf	(_Match_remotekey+2),w
	movwf	indf
	incf	fsr0,f
	movf	(_Match_remotekey+3),w
	movwf	indf
	line	721
	
i1l3493:	
;1.C: 719: }
;1.C: 720: }
;1.C: 721: if(CH2_remotekey_num > 4) CH2_remotekey_num = 4;
	movlw	(05h)
	subwf	(_CH2_remotekey_num),w
	skipc
	goto	u261_21
	goto	u261_20
u261_21:
	goto	i1l3497
u261_20:
	
i1l3495:	
	movlw	(04h)
	movwf	(_CH2_remotekey_num)
	line	722
	
i1l3497:	
;1.C: 722: PRESSED &= ~0x20;
	bcf	(_PRESSED)+(5/8),(5)&7
	line	723
	
i1l3499:	
;1.C: 723: CH2_EEPROM_Write();
	fcall	_CH2_EEPROM_Write
	line	724
	
i1l3501:	
;1.C: 724: PA6 = 1;
	bcf	status, 5	;RP0=0, select bank0
	bsf	(46/8),(46)&7
	line	726
	
i1l3503:	
;1.C: 725: }
;1.C: 726: if((PRESSED&0x40) == 0x40){
	btfss	(_PRESSED),(6)&7
	goto	u262_21
	goto	u262_20
u262_21:
	goto	i1l3531
u262_20:
	line	731
	
i1l3505:	
;1.C: 727: if( (Match_remotekey != CH3_remotekey[0]) &&
;1.C: 728: (Match_remotekey != CH3_remotekey[1]) &&
;1.C: 729: (Match_remotekey != CH3_remotekey[2]) &&
;1.C: 730: (Match_remotekey != CH3_remotekey[3])
;1.C: 731: ){
	movf	(_Match_remotekey+3),w
	xorwf	(_CH3_remotekey+3),w
	skipz
	goto	u263_25
	movf	(_Match_remotekey+2),w
	xorwf	(_CH3_remotekey+2),w
	skipz
	goto	u263_25
	movf	(_Match_remotekey+1),w
	xorwf	(_CH3_remotekey+1),w
	skipz
	goto	u263_25
	movf	(_Match_remotekey),w
	xorwf	(_CH3_remotekey),w
u263_25:
	skipnz
	goto	u263_21
	goto	u263_20
u263_21:
	goto	i1l3521
u263_20:
	
i1l3507:	
	movf	(_Match_remotekey+3),w
	xorwf	3+(_CH3_remotekey)+04h,w
	skipz
	goto	u264_25
	movf	(_Match_remotekey+2),w
	xorwf	2+(_CH3_remotekey)+04h,w
	skipz
	goto	u264_25
	movf	(_Match_remotekey+1),w
	xorwf	1+(_CH3_remotekey)+04h,w
	skipz
	goto	u264_25
	movf	(_Match_remotekey),w
	xorwf	0+(_CH3_remotekey)+04h,w
u264_25:
	skipnz
	goto	u264_21
	goto	u264_20
u264_21:
	goto	i1l3521
u264_20:
	
i1l3509:	
	movf	(_Match_remotekey+3),w
	xorwf	3+(_CH3_remotekey)+08h,w
	skipz
	goto	u265_25
	movf	(_Match_remotekey+2),w
	xorwf	2+(_CH3_remotekey)+08h,w
	skipz
	goto	u265_25
	movf	(_Match_remotekey+1),w
	xorwf	1+(_CH3_remotekey)+08h,w
	skipz
	goto	u265_25
	movf	(_Match_remotekey),w
	xorwf	0+(_CH3_remotekey)+08h,w
u265_25:
	skipnz
	goto	u265_21
	goto	u265_20
u265_21:
	goto	i1l3521
u265_20:
	
i1l3511:	
	movf	(_Match_remotekey+3),w
	xorwf	3+(_CH3_remotekey)+0Ch,w
	skipz
	goto	u266_25
	movf	(_Match_remotekey+2),w
	xorwf	2+(_CH3_remotekey)+0Ch,w
	skipz
	goto	u266_25
	movf	(_Match_remotekey+1),w
	xorwf	1+(_CH3_remotekey)+0Ch,w
	skipz
	goto	u266_25
	movf	(_Match_remotekey),w
	xorwf	0+(_CH3_remotekey)+0Ch,w
u266_25:
	skipnz
	goto	u266_21
	goto	u266_20
u266_21:
	goto	i1l3521
u266_20:
	line	732
	
i1l3513:	
;1.C: 732: if(CH3_remotekey_num < 4){
	movlw	(04h)
	subwf	(_CH3_remotekey_num),w
	skipnc
	goto	u267_21
	goto	u267_20
u267_21:
	goto	i1l3519
u267_20:
	line	733
	
i1l3515:	
;1.C: 733: CH3_remotekey[CH3_remotekey_num] = Match_remotekey;
	movf	(_CH3_remotekey_num),w
	movwf	(??_KEY+0)+0
	clrc
	rlf	(??_KEY+0)+0,f
	clrc
	rlf	(??_KEY+0)+0,w
	addlw	_CH3_remotekey&0ffh
	movwf	fsr0
	movf	(_Match_remotekey),w
	bcf	status, 7	;select IRP bank0
	movwf	indf
	incf	fsr0,f
	movf	(_Match_remotekey+1),w
	movwf	indf
	incf	fsr0,f
	movf	(_Match_remotekey+2),w
	movwf	indf
	incf	fsr0,f
	movf	(_Match_remotekey+3),w
	movwf	indf
	line	734
	
i1l3517:	
;1.C: 734: CH3_remotekey_num++;
	incf	(_CH3_remotekey_num),f
	line	735
;1.C: 735: }else{
	goto	i1l3521
	line	736
	
i1l3519:	
;1.C: 736: CH3_remotekey[CH3_remotekey_Latest] = Match_remotekey;
	bsf	status, 5	;RP0=1, select bank1
	movf	(_CH3_remotekey_Latest)^080h,w
	movwf	(??_KEY+0)+0
	clrc
	rlf	(??_KEY+0)+0,f
	clrc
	rlf	(??_KEY+0)+0,w
	addlw	_CH3_remotekey&0ffh
	movwf	fsr0
	bcf	status, 5	;RP0=0, select bank0
	movf	(_Match_remotekey),w
	bcf	status, 7	;select IRP bank0
	movwf	indf
	incf	fsr0,f
	movf	(_Match_remotekey+1),w
	movwf	indf
	incf	fsr0,f
	movf	(_Match_remotekey+2),w
	movwf	indf
	incf	fsr0,f
	movf	(_Match_remotekey+3),w
	movwf	indf
	line	739
	
i1l3521:	
;1.C: 737: }
;1.C: 738: }
;1.C: 739: if(CH3_remotekey_num > 4) CH3_remotekey_num = 4;
	movlw	(05h)
	subwf	(_CH3_remotekey_num),w
	skipc
	goto	u268_21
	goto	u268_20
u268_21:
	goto	i1l3525
u268_20:
	
i1l3523:	
	movlw	(04h)
	movwf	(_CH3_remotekey_num)
	line	740
	
i1l3525:	
;1.C: 740: PRESSED &= ~0x40;
	bcf	(_PRESSED)+(6/8),(6)&7
	line	741
	
i1l3527:	
;1.C: 741: CH3_EEPROM_Write();
	fcall	_CH3_EEPROM_Write
	line	742
	
i1l3529:	
;1.C: 742: PA5 = 1;
	bcf	status, 5	;RP0=0, select bank0
	bsf	(45/8),(45)&7
	line	744
	
i1l3531:	
;1.C: 743: }
;1.C: 744: KEY_Match_counter = 0;
	clrf	(_KEY_Match_counter)
	line	745
	
i1l3533:	
;1.C: 745: PC0 = 1;
	bsf	(56/8),(56)&7
	goto	i1l1016
	line	671
	
i1l3537:	
	movf	(_KEY_Match_counter),w
	; Switch size 1, requested type "space"
; Number of cases is 4, Range of values is 0 to 3
; switch strategies available:
; Name         Instructions Cycles
; direct_byte           10     6 (fixed)
; simple_byte           13     7 (average)
; jumptable            260     6 (fixed)
; rangetable             8     6 (fixed)
; spacedrange           14     9 (fixed)
; locatedrange           4     3 (fixed)
;	Chosen strategy is direct_byte

	movwf fsr
	movlw	4
	subwf	fsr,w
skipnc
goto i1l1016
movlw high(i1S3877)
movwf pclath
	movlw low(i1S3877)
	addwf fsr,w
	movwf pc
psect	swtext1,local,class=CONST,delta=2
global __pswtext1
__pswtext1:
i1S3877:
	ljmp	i1l3431
	ljmp	i1l1022
	ljmp	i1l1026
	ljmp	i1l1030
psect	text688

	line	749
	
i1l1016:	
	line	755
;1.C: 749: }
;1.C: 752: if( ((PRESSED&0x10) == 0) &&
;1.C: 753: ((PRESSED&0x20) == 0) &&
;1.C: 754: ((PRESSED&0x40) == 0)
;1.C: 755: ){
	btfsc	(_PRESSED),(4)&7
	goto	u269_21
	goto	u269_20
u269_21:
	goto	i1l1054
u269_20:
	
i1l3539:	
	btfsc	(_PRESSED),(5)&7
	goto	u270_21
	goto	u270_20
u270_21:
	goto	i1l1054
u270_20:
	
i1l3541:	
	btfsc	(_PRESSED),(6)&7
	goto	u271_21
	goto	u271_20
u271_21:
	goto	i1l1054
u271_20:
	line	756
	
i1l3543:	
;1.C: 756: if((PRESSED&0x0F) > 0){
	movf	(_PRESSED),w
	andlw	0Fh
	btfsc	status,2
	goto	u272_21
	goto	u272_20
u272_21:
	goto	i1l3563
u272_20:
	goto	i1l3561
	line	759
	
i1l3547:	
;1.C: 759: PA7 = ~PA7;
	movlw	1<<((47)&7)
	xorwf	((47)/8),f
	line	760
	
i1l3549:	
;1.C: 760: led1_debug();
	fcall	_led1_debug
	line	761
;1.C: 761: break;
	goto	i1l3563
	line	763
	
i1l3551:	
;1.C: 763: PA6 = ~PA6;
	movlw	1<<((46)&7)
	xorwf	((46)/8),f
	goto	i1l3549
	line	767
	
i1l3555:	
;1.C: 767: PA5 = ~PA5;
	movlw	1<<((45)&7)
	xorwf	((45)/8),f
	goto	i1l3549
	line	757
	
i1l3561:	
	movf	(_PRESSED),w
	andlw	0Fh
	movwf	(??_KEY+0)+0
	clrf	(??_KEY+0)+0+1
	; Switch on 2 bytes has been partitioned into a top level switch of size 1, and 1 sub-switches
; Switch size 1, requested type "space"
; Number of cases is 1, Range of values is 0 to 0
; switch strategies available:
; Name         Instructions Cycles
; simple_byte            4     3 (average)
; direct_byte            7     6 (fixed)
; jumptable            260     6 (fixed)
; rangetable             5     6 (fixed)
; spacedrange            8     9 (fixed)
; locatedrange           1     3 (fixed)
;	Chosen strategy is simple_byte

	movf 1+(??_KEY+0)+0,w
	opt asmopt_off
	xorlw	0^0	; case 0
	skipnz
	goto	i1l3879
	goto	i1l3563
	opt asmopt_on
	
i1l3879:	
; Switch size 1, requested type "space"
; Number of cases is 3, Range of values is 1 to 4
; switch strategies available:
; Name         Instructions Cycles
; simple_byte           10     6 (average)
; direct_byte           13     9 (fixed)
; jumptable            263     9 (fixed)
;	Chosen strategy is simple_byte

	movf 0+(??_KEY+0)+0,w
	opt asmopt_off
	xorlw	1^0	; case 1
	skipnz
	goto	i1l3547
	xorlw	2^1	; case 2
	skipnz
	goto	i1l3551
	xorlw	4^2	; case 4
	skipnz
	goto	i1l3555
	goto	i1l3563
	opt asmopt_on

	line	772
	
i1l3563:	
;1.C: 771: }
;1.C: 772: PRESSED &= 0xF0;
	movlw	(0F0h)
	andwf	(_PRESSED),f
	line	775
	
i1l1054:	
	return
	opt stack 0
GLOBAL	__end_of_KEY
	__end_of_KEY:
;; =============== function _KEY ends ============

	signat	_KEY,88
	global	_CH3_EEPROM_Write
psect	text689,local,class=CODE,delta=2
global __ptext689
__ptext689:

;; *************** function _CH3_EEPROM_Write *****************
;; Defined at:
;;		line 536 in file "1.C"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 20/20
;;		Unchanged: FFFDF/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_IAPWrite
;; This function is called by:
;;		_KEY
;; This function uses a non-reentrant model
;;
psect	text689
	file	"1.C"
	line	536
	global	__size_of_CH3_EEPROM_Write
	__size_of_CH3_EEPROM_Write	equ	__end_of_CH3_EEPROM_Write-_CH3_EEPROM_Write
	
_CH3_EEPROM_Write:	
	opt	stack 1
; Regs used in _CH3_EEPROM_Write: [wreg+status,2+status,0+pclath+cstack]
	line	537
	
i1l3597:	
;1.C: 537: IAPWrite(0x08,((CH3_remotekey[0]&0x000000FF)>>0));
	movf	(_CH3_remotekey),w
	movwf	(?_IAPWrite)
	movlw	(08h)
	fcall	_IAPWrite
	line	538
;1.C: 538: IAPWrite(0x09,((CH3_remotekey[0]&0x0000FF00)>>8));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+(((_CH3_remotekey))+1),w
	movwf	(?_IAPWrite)
	movlw	(09h)
	fcall	_IAPWrite
	line	539
;1.C: 539: IAPWrite(0x0A,((CH3_remotekey[0]&0x00FF0000)>>16));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+(((_CH3_remotekey))+2),w
	movwf	(?_IAPWrite)
	movlw	(0Ah)
	fcall	_IAPWrite
	line	541
;1.C: 541: IAPWrite(0x14,((CH3_remotekey[1]&0x000000FF)>>0));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+(_CH3_remotekey)+04h,w
	movwf	(?_IAPWrite)
	movlw	(014h)
	fcall	_IAPWrite
	line	542
;1.C: 542: IAPWrite(0x15,((CH3_remotekey[1]&0x0000FF00)>>8));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+((0+(_CH3_remotekey)+04h)+1),w
	movwf	(?_IAPWrite)
	movlw	(015h)
	fcall	_IAPWrite
	line	543
;1.C: 543: IAPWrite(0x16,((CH3_remotekey[1]&0x00FF0000)>>16));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+((0+(_CH3_remotekey)+04h)+2),w
	movwf	(?_IAPWrite)
	movlw	(016h)
	fcall	_IAPWrite
	line	545
;1.C: 545: IAPWrite(0x20,((CH3_remotekey[2]&0x000000FF)>>0));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+(_CH3_remotekey)+08h,w
	movwf	(?_IAPWrite)
	movlw	(020h)
	fcall	_IAPWrite
	line	546
;1.C: 546: IAPWrite(0x21,((CH3_remotekey[2]&0x0000FF00)>>8));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+((0+(_CH3_remotekey)+08h)+1),w
	movwf	(?_IAPWrite)
	movlw	(021h)
	fcall	_IAPWrite
	line	547
;1.C: 547: IAPWrite(0x22,((CH3_remotekey[2]&0x00FF0000)>>16));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+((0+(_CH3_remotekey)+08h)+2),w
	movwf	(?_IAPWrite)
	movlw	(022h)
	fcall	_IAPWrite
	line	549
;1.C: 549: IAPWrite(0x2C,((CH3_remotekey[3]&0x000000FF)>>0));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+(_CH3_remotekey)+0Ch,w
	movwf	(?_IAPWrite)
	movlw	(02Ch)
	fcall	_IAPWrite
	line	550
;1.C: 550: IAPWrite(0x2D,((CH3_remotekey[3]&0x0000FF00)>>8));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+((0+(_CH3_remotekey)+0Ch)+1),w
	movwf	(?_IAPWrite)
	movlw	(02Dh)
	fcall	_IAPWrite
	line	551
;1.C: 551: IAPWrite(0x2E,((CH3_remotekey[3]&0x00FF0000)>>16));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+((0+(_CH3_remotekey)+0Ch)+2),w
	movwf	(?_IAPWrite)
	movlw	(02Eh)
	fcall	_IAPWrite
	line	553
;1.C: 553: IAPWrite(0x32,CH3_remotekey_num);
	bcf	status, 5	;RP0=0, select bank0
	movf	(_CH3_remotekey_num),w
	movwf	(?_IAPWrite)
	movlw	(032h)
	fcall	_IAPWrite
	line	554
	
i1l984:	
	return
	opt stack 0
GLOBAL	__end_of_CH3_EEPROM_Write
	__end_of_CH3_EEPROM_Write:
;; =============== function _CH3_EEPROM_Write ends ============

	signat	_CH3_EEPROM_Write,88
	global	_CH2_EEPROM_Write
psect	text690,local,class=CODE,delta=2
global __ptext690
__ptext690:

;; *************** function _CH2_EEPROM_Write *****************
;; Defined at:
;;		line 517 in file "1.C"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 20/20
;;		Unchanged: FFFDF/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_IAPWrite
;; This function is called by:
;;		_KEY
;; This function uses a non-reentrant model
;;
psect	text690
	file	"1.C"
	line	517
	global	__size_of_CH2_EEPROM_Write
	__size_of_CH2_EEPROM_Write	equ	__end_of_CH2_EEPROM_Write-_CH2_EEPROM_Write
	
_CH2_EEPROM_Write:	
	opt	stack 1
; Regs used in _CH2_EEPROM_Write: [wreg+status,2+status,0+pclath+cstack]
	line	518
	
i1l3595:	
;1.C: 518: IAPWrite(0x04,((CH2_remotekey[0]&0x000000FF)>>0));
	movf	(_CH2_remotekey),w
	movwf	(?_IAPWrite)
	movlw	(04h)
	fcall	_IAPWrite
	line	519
;1.C: 519: IAPWrite(0x05,((CH2_remotekey[0]&0x0000FF00)>>8));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+(((_CH2_remotekey))+1),w
	movwf	(?_IAPWrite)
	movlw	(05h)
	fcall	_IAPWrite
	line	520
;1.C: 520: IAPWrite(0x06,((CH2_remotekey[0]&0x00FF0000)>>16));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+(((_CH2_remotekey))+2),w
	movwf	(?_IAPWrite)
	movlw	(06h)
	fcall	_IAPWrite
	line	522
;1.C: 522: IAPWrite(0x10,((CH2_remotekey[1]&0x000000FF)>>0));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+(_CH2_remotekey)+04h,w
	movwf	(?_IAPWrite)
	movlw	(010h)
	fcall	_IAPWrite
	line	523
;1.C: 523: IAPWrite(0x11,((CH2_remotekey[1]&0x0000FF00)>>8));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+((0+(_CH2_remotekey)+04h)+1),w
	movwf	(?_IAPWrite)
	movlw	(011h)
	fcall	_IAPWrite
	line	524
;1.C: 524: IAPWrite(0x12,((CH2_remotekey[1]&0x00FF0000)>>16));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+((0+(_CH2_remotekey)+04h)+2),w
	movwf	(?_IAPWrite)
	movlw	(012h)
	fcall	_IAPWrite
	line	526
;1.C: 526: IAPWrite(0x1C,((CH2_remotekey[2]&0x000000FF)>>0));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+(_CH2_remotekey)+08h,w
	movwf	(?_IAPWrite)
	movlw	(01Ch)
	fcall	_IAPWrite
	line	527
;1.C: 527: IAPWrite(0x1D,((CH2_remotekey[2]&0x0000FF00)>>8));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+((0+(_CH2_remotekey)+08h)+1),w
	movwf	(?_IAPWrite)
	movlw	(01Dh)
	fcall	_IAPWrite
	line	528
;1.C: 528: IAPWrite(0x1E,((CH2_remotekey[2]&0x00FF0000)>>16));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+((0+(_CH2_remotekey)+08h)+2),w
	movwf	(?_IAPWrite)
	movlw	(01Eh)
	fcall	_IAPWrite
	line	530
;1.C: 530: IAPWrite(0x28,((CH2_remotekey[3]&0x000000FF)>>0));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+(_CH2_remotekey)+0Ch,w
	movwf	(?_IAPWrite)
	movlw	(028h)
	fcall	_IAPWrite
	line	531
;1.C: 531: IAPWrite(0x29,((CH2_remotekey[3]&0x0000FF00)>>8));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+((0+(_CH2_remotekey)+0Ch)+1),w
	movwf	(?_IAPWrite)
	movlw	(029h)
	fcall	_IAPWrite
	line	532
;1.C: 532: IAPWrite(0x2A,((CH2_remotekey[3]&0x00FF0000)>>16));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+((0+(_CH2_remotekey)+0Ch)+2),w
	movwf	(?_IAPWrite)
	movlw	(02Ah)
	fcall	_IAPWrite
	line	534
;1.C: 534: IAPWrite(0x31,CH2_remotekey_num);
	bcf	status, 5	;RP0=0, select bank0
	movf	(_CH2_remotekey_num),w
	movwf	(?_IAPWrite)
	movlw	(031h)
	fcall	_IAPWrite
	line	535
	
i1l981:	
	return
	opt stack 0
GLOBAL	__end_of_CH2_EEPROM_Write
	__end_of_CH2_EEPROM_Write:
;; =============== function _CH2_EEPROM_Write ends ============

	signat	_CH2_EEPROM_Write,88
	global	_CH1_EEPROM_Write
psect	text691,local,class=CODE,delta=2
global __ptext691
__ptext691:

;; *************** function _CH1_EEPROM_Write *****************
;; Defined at:
;;		line 498 in file "1.C"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 20/20
;;		Unchanged: FFFDF/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_IAPWrite
;; This function is called by:
;;		_KEY
;; This function uses a non-reentrant model
;;
psect	text691
	file	"1.C"
	line	498
	global	__size_of_CH1_EEPROM_Write
	__size_of_CH1_EEPROM_Write	equ	__end_of_CH1_EEPROM_Write-_CH1_EEPROM_Write
	
_CH1_EEPROM_Write:	
	opt	stack 1
; Regs used in _CH1_EEPROM_Write: [wreg+status,2+status,0+pclath+cstack]
	line	499
	
i1l3593:	
;1.C: 499: IAPWrite(0x00,((CH1_remotekey[0]&0x000000FF)>>0));
	movf	(_CH1_remotekey),w
	movwf	(?_IAPWrite)
	movlw	(0)
	fcall	_IAPWrite
	line	500
;1.C: 500: IAPWrite(0x01,((CH1_remotekey[0]&0x0000FF00)>>8));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+(((_CH1_remotekey))+1),w
	movwf	(?_IAPWrite)
	movlw	(01h)
	fcall	_IAPWrite
	line	501
;1.C: 501: IAPWrite(0x02,((CH1_remotekey[0]&0x00FF0000)>>16));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+(((_CH1_remotekey))+2),w
	movwf	(?_IAPWrite)
	movlw	(02h)
	fcall	_IAPWrite
	line	503
;1.C: 503: IAPWrite(0x0C,((CH1_remotekey[1]&0x000000FF)>>0));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+(_CH1_remotekey)+04h,w
	movwf	(?_IAPWrite)
	movlw	(0Ch)
	fcall	_IAPWrite
	line	504
;1.C: 504: IAPWrite(0x0D,((CH1_remotekey[1]&0x0000FF00)>>8));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+((0+(_CH1_remotekey)+04h)+1),w
	movwf	(?_IAPWrite)
	movlw	(0Dh)
	fcall	_IAPWrite
	line	505
;1.C: 505: IAPWrite(0x0E,((CH1_remotekey[1]&0x00FF0000)>>16));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+((0+(_CH1_remotekey)+04h)+2),w
	movwf	(?_IAPWrite)
	movlw	(0Eh)
	fcall	_IAPWrite
	line	507
;1.C: 507: IAPWrite(0x18,((CH1_remotekey[2]&0x000000FF)>>0));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+(_CH1_remotekey)+08h,w
	movwf	(?_IAPWrite)
	movlw	(018h)
	fcall	_IAPWrite
	line	508
;1.C: 508: IAPWrite(0x19,((CH1_remotekey[2]&0x0000FF00)>>8));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+((0+(_CH1_remotekey)+08h)+1),w
	movwf	(?_IAPWrite)
	movlw	(019h)
	fcall	_IAPWrite
	line	509
;1.C: 509: IAPWrite(0x1A,((CH1_remotekey[2]&0x00FF0000)>>16));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+((0+(_CH1_remotekey)+08h)+2),w
	movwf	(?_IAPWrite)
	movlw	(01Ah)
	fcall	_IAPWrite
	line	511
;1.C: 511: IAPWrite(0x24,((CH1_remotekey[3]&0x000000FF)>>0));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+(_CH1_remotekey)+0Ch,w
	movwf	(?_IAPWrite)
	movlw	(024h)
	fcall	_IAPWrite
	line	512
;1.C: 512: IAPWrite(0x25,((CH1_remotekey[3]&0x0000FF00)>>8));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+((0+(_CH1_remotekey)+0Ch)+1),w
	movwf	(?_IAPWrite)
	movlw	(025h)
	fcall	_IAPWrite
	line	513
;1.C: 513: IAPWrite(0x26,((CH1_remotekey[3]&0x00FF0000)>>16));
	bcf	status, 5	;RP0=0, select bank0
	movf	0+((0+(_CH1_remotekey)+0Ch)+2),w
	movwf	(?_IAPWrite)
	movlw	(026h)
	fcall	_IAPWrite
	line	515
;1.C: 515: IAPWrite(0x30,CH1_remotekey_num);
	bcf	status, 5	;RP0=0, select bank0
	movf	(_CH1_remotekey_num),w
	movwf	(?_IAPWrite)
	movlw	(030h)
	fcall	_IAPWrite
	line	516
	
i1l978:	
	return
	opt stack 0
GLOBAL	__end_of_CH1_EEPROM_Write
	__end_of_CH1_EEPROM_Write:
;; =============== function _CH1_EEPROM_Write ends ============

	signat	_CH1_EEPROM_Write,88
	global	i1_EX_INT_FallingEdge
psect	text692,local,class=CODE,delta=2
global __ptext692
__ptext692:

;; *************** function i1_EX_INT_FallingEdge *****************
;; Defined at:
;;		line 414 in file "1.C"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		None
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 20/20
;;		Unchanged: FFFDF/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_ISR
;; This function uses a non-reentrant model
;;
psect	text692
	file	"1.C"
	line	414
	global	__size_ofi1_EX_INT_FallingEdge
	__size_ofi1_EX_INT_FallingEdge	equ	__end_ofi1_EX_INT_FallingEdge-i1_EX_INT_FallingEdge
	
i1_EX_INT_FallingEdge:	
	opt	stack 3
; Regs used in i1_EX_INT_FallingEdge: []
	line	415
	
i1l3615:	
;1.C: 415: INTEDG =0;
	bsf	status, 5	;RP0=1, select bank1
	bcf	(1038/8)^080h,(1038)&7
	line	416
;1.C: 416: FLAGs &= ~0x01;
	bcf	(_FLAGs)+(0/8),(0)&7
	line	417
	
i1l951:	
	return
	opt stack 0
GLOBAL	__end_ofi1_EX_INT_FallingEdge
	__end_ofi1_EX_INT_FallingEdge:
;; =============== function i1_EX_INT_FallingEdge ends ============

	signat	i1_EX_INT_FallingEdge,88
	global	___wmul
psect	text693,local,class=CODE,delta=2
global __ptext693
__ptext693:

;; *************** function ___wmul *****************
;; Defined at:
;;		line 3 in file "f:\program files (x86)\fmd\fmdide\data\sources\wmul.c"
;; Parameters:    Size  Location     Type
;;  multiplier      2    0[COMMON] unsigned int 
;;  multiplicand    2    2[COMMON] unsigned int 
;; Auto vars:     Size  Location     Type
;;  product         2    4[COMMON] unsigned int 
;; Return value:  Size  Location     Type
;;                  2    0[COMMON] unsigned int 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 20/20
;;		On exit  : 20/20
;;		Unchanged: FFFDF/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         4       0       0
;;      Locals:         2       0       0
;;      Temps:          0       0       0
;;      Totals:         6       0       0
;;Total ram usage:        6 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_ISR
;; This function uses a non-reentrant model
;;
psect	text693
	file	"f:\program files (x86)\fmd\fmdide\data\sources\wmul.c"
	line	3
	global	__size_of___wmul
	__size_of___wmul	equ	__end_of___wmul-___wmul
	
___wmul:	
	opt	stack 3
; Regs used in ___wmul: [wreg+status,2+status,0]
	line	4
	
i1l3599:	
	clrf	(___wmul@product)
	clrf	(___wmul@product+1)
	line	7
	
i1l3601:	
	btfss	(___wmul@multiplier),(0)&7
	goto	u275_21
	goto	u275_20
u275_21:
	goto	i1l3605
u275_20:
	line	8
	
i1l3603:	
	movf	(___wmul@multiplicand),w
	addwf	(___wmul@product),f
	skipnc
	incf	(___wmul@product+1),f
	movf	(___wmul@multiplicand+1),w
	addwf	(___wmul@product+1),f
	line	9
	
i1l3605:	
	clrc
	rlf	(___wmul@multiplicand),f
	rlf	(___wmul@multiplicand+1),f
	line	10
	
i1l3607:	
	clrc
	rrf	(___wmul@multiplier+1),f
	rrf	(___wmul@multiplier),f
	line	11
	
i1l3609:	
	movf	((___wmul@multiplier+1)),w
	iorwf	((___wmul@multiplier)),w
	skipz
	goto	u276_21
	goto	u276_20
u276_21:
	goto	i1l3601
u276_20:
	line	12
	
i1l3611:	
	movf	(___wmul@product+1),w
	movwf	(?___wmul+1)
	movf	(___wmul@product),w
	movwf	(?___wmul)
	line	13
	
i1l1732:	
	return
	opt stack 0
GLOBAL	__end_of___wmul
	__end_of___wmul:
;; =============== function ___wmul ends ============

	signat	___wmul,8314
	global	_IAPWrite
psect	text694,local,class=CODE,delta=2
global __ptext694
__ptext694:

;; *************** function _IAPWrite *****************
;; Defined at:
;;		line 487 in file "1.C"
;; Parameters:    Size  Location     Type
;;  EEAddr          1    wreg     unsigned char 
;;  Data            1    0[COMMON] unsigned char 
;; Auto vars:     Size  Location     Type
;;  EEAddr          1    1[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 20/20
;;		Unchanged: FFFDF/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         1       0       0
;;      Locals:         1       0       0
;;      Temps:          0       0       0
;;      Totals:         2       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_CH1_EEPROM_Write
;;		_CH2_EEPROM_Write
;;		_CH3_EEPROM_Write
;; This function uses a non-reentrant model
;;
psect	text694
	file	"1.C"
	line	487
	global	__size_of_IAPWrite
	__size_of_IAPWrite	equ	__end_of_IAPWrite-_IAPWrite
	
_IAPWrite:	
	opt	stack 1
; Regs used in _IAPWrite: [wreg+status,2+status,0]
;IAPWrite@EEAddr stored from wreg
	movwf	(IAPWrite@EEAddr)
	line	488
	
i1l3583:	
;1.C: 488: GIE = 0;
	bcf	(95/8),(95)&7
	line	489
;1.C: 489: while(GIE);
	
i1l969:	
	btfsc	(95/8),(95)&7
	goto	u273_21
	goto	u273_20
u273_21:
	goto	i1l969
u273_20:
	line	490
	
i1l3585:	
;1.C: 490: EEADR = EEAddr;
	movf	(IAPWrite@EEAddr),w
	bsf	status, 5	;RP0=1, select bank1
	movwf	(155)^080h	;volatile
	line	491
;1.C: 491: EEDAT = Data;
	movf	(IAPWrite@Data),w
	movwf	(154)^080h	;volatile
	line	492
	
i1l3587:	
;1.C: 492: EEIF = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	(103/8),(103)&7
	line	493
	
i1l3589:	
;1.C: 493: EECON1 |= 0x34;
	movlw	(034h)
	bsf	status, 5	;RP0=1, select bank1
	iorwf	(156)^080h,f	;volatile
	line	494
	
i1l3591:	
;1.C: 494: WR = 1;
	bsf	(1256/8)^080h,(1256)&7
	line	495
;1.C: 495: while(WR);
	
i1l972:	
	btfsc	(1256/8)^080h,(1256)&7
	goto	u274_21
	goto	u274_20
u274_21:
	goto	i1l972
u274_20:
	
i1l974:	
	line	496
;1.C: 496: GIE = 1;
	bsf	(95/8),(95)&7
	line	497
	
i1l975:	
	return
	opt stack 0
GLOBAL	__end_of_IAPWrite
	__end_of_IAPWrite:
;; =============== function _IAPWrite ends ============

	signat	_IAPWrite,8312
	global	_KEYSCAN
psect	text695,local,class=CODE,delta=2
global __ptext695
__ptext695:

;; *************** function _KEYSCAN *****************
;; Defined at:
;;		line 583 in file "1.C"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 20/0
;;		Unchanged: FFFDF/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_ISR
;; This function uses a non-reentrant model
;;
psect	text695
	file	"1.C"
	line	583
	global	__size_of_KEYSCAN
	__size_of_KEYSCAN	equ	__end_of_KEYSCAN-_KEYSCAN
	
_KEYSCAN:	
	opt	stack 3
; Regs used in _KEYSCAN: [wreg+status,2+status,0]
	line	584
	
i1l3285:	
;1.C: 584: if(PRESSED == 0){
	movf	(_PRESSED),f
	skipz
	goto	u215_21
	goto	u215_20
u215_21:
	goto	i1l1013
u215_20:
	line	585
	
i1l3287:	
;1.C: 585: if(PC5 == 0){
	btfsc	(61/8),(61)&7
	goto	u216_21
	goto	u216_20
u216_21:
	goto	i1l3327
u216_20:
	line	586
	
i1l3289:	
;1.C: 586: if(KEY1_LongPress < 125) PRESS_FLAG |= 0x01;
	movlw	(07Dh)
	subwf	(_KEY1_LongPress),w
	skipnc
	goto	u217_21
	goto	u217_20
u217_21:
	goto	i1l3293
u217_20:
	
i1l3291:	
	bsf	(_PRESS_FLAG)+(0/8),(0)&7
	line	587
	
i1l3293:	
;1.C: 587: if(KEY1_LongPress < 254) KEY1_LongPress++;
	movlw	(0FEh)
	subwf	(_KEY1_LongPress),w
	skipnc
	goto	u218_21
	goto	u218_20
u218_21:
	goto	i1l3297
u218_20:
	
i1l3295:	
	incf	(_KEY1_LongPress),f
	line	588
	
i1l3297:	
;1.C: 588: if((KEY1_LongPress > 125) && (KEY1_LongPress < 250)){
	movlw	(07Eh)
	subwf	(_KEY1_LongPress),w
	skipc
	goto	u219_21
	goto	u219_20
u219_21:
	goto	i1l3309
u219_20:
	
i1l3299:	
	movlw	(0FAh)
	subwf	(_KEY1_LongPress),w
	skipnc
	goto	u220_21
	goto	u220_20
u220_21:
	goto	i1l3309
u220_20:
	line	589
	
i1l3301:	
;1.C: 589: PRESS_FLAG |= 0x10;
	bsf	(_PRESS_FLAG)+(4/8),(4)&7
	line	590
	
i1l3303:	
;1.C: 590: match_slice = 0;
	clrf	(_match_slice)
	line	591
	
i1l3305:	
;1.C: 591: PC0 = 0;
	bcf	(56/8),(56)&7
	line	592
	
i1l3307:	
;1.C: 592: PA7 = 0;
	bcf	(47/8),(47)&7
	line	593
;1.C: 593: LONGPRESS_OverTime_Counter = 0;
	clrf	(_LONGPRESS_OverTime_Counter)
	line	595
	
i1l3309:	
;1.C: 594: }
;1.C: 595: if(KEY1_LongPress > 250){
	movlw	(0FBh)
	subwf	(_KEY1_LongPress),w
	skipc
	goto	u221_21
	goto	u221_20
u221_21:
	goto	i1l3329
u221_20:
	line	596
	
i1l3311:	
;1.C: 596: CH1_remotekey[0] = 0xFFFFFFFF;
	movlw	0FFh
	movwf	(_CH1_remotekey+3)
	movlw	0FFh
	movwf	(_CH1_remotekey+2)
	movlw	0FFh
	movwf	(_CH1_remotekey+1)
	movlw	0FFh
	movwf	(_CH1_remotekey)

	line	597
;1.C: 597: CH1_remotekey[1] = 0xFFFFFFFF;
	movlw	0FFh
	movwf	3+(_CH1_remotekey)+04h
	movlw	0FFh
	movwf	2+(_CH1_remotekey)+04h
	movlw	0FFh
	movwf	1+(_CH1_remotekey)+04h
	movlw	0FFh
	movwf	0+(_CH1_remotekey)+04h

	line	598
;1.C: 598: CH1_remotekey[2] = 0xFFFFFFFF;
	movlw	0FFh
	movwf	3+(_CH1_remotekey)+08h
	movlw	0FFh
	movwf	2+(_CH1_remotekey)+08h
	movlw	0FFh
	movwf	1+(_CH1_remotekey)+08h
	movlw	0FFh
	movwf	0+(_CH1_remotekey)+08h

	line	599
;1.C: 599: CH1_remotekey[3] = 0xFFFFFFFF;
	movlw	0FFh
	movwf	3+(_CH1_remotekey)+0Ch
	movlw	0FFh
	movwf	2+(_CH1_remotekey)+0Ch
	movlw	0FFh
	movwf	1+(_CH1_remotekey)+0Ch
	movlw	0FFh
	movwf	0+(_CH1_remotekey)+0Ch

	line	600
	
i1l3313:	
;1.C: 600: CH1_remotekey_num = 0;
	clrf	(_CH1_remotekey_num)
	line	601
	
i1l3315:	
;1.C: 601: CH1_remotekey_Latest = 0;
	bsf	status, 5	;RP0=1, select bank1
	clrf	(_CH1_remotekey_Latest)^080h
	line	602
	
i1l3317:	
;1.C: 602: PRESS_FLAG &= ~0x10;
	bcf	status, 5	;RP0=0, select bank0
	bcf	(_PRESS_FLAG)+(4/8),(4)&7
	line	603
	
i1l3319:	
;1.C: 603: PRESS_FLAG &= ~0x01;
	bcf	(_PRESS_FLAG)+(0/8),(0)&7
	line	604
	
i1l3321:	
;1.C: 604: PC0 = 1;
	bsf	(56/8),(56)&7
	line	605
	
i1l3323:	
;1.C: 605: PA7 = 1;
	bsf	(47/8),(47)&7
	line	606
	
i1l3325:	
;1.C: 606: KEY_Match_counter = 0;
	clrf	(_KEY_Match_counter)
	goto	i1l3329
	line	608
	
i1l3327:	
	clrf	(_KEY1_LongPress)
	line	610
	
i1l3329:	
;1.C: 610: if(PA4 == 0){
	btfsc	(44/8),(44)&7
	goto	u222_21
	goto	u222_20
u222_21:
	goto	i1l3369
u222_20:
	line	611
	
i1l3331:	
;1.C: 611: if(KEY2_LongPress < 125) PRESS_FLAG |= 0x02;
	movlw	(07Dh)
	subwf	(_KEY2_LongPress),w
	skipnc
	goto	u223_21
	goto	u223_20
u223_21:
	goto	i1l3335
u223_20:
	
i1l3333:	
	bsf	(_PRESS_FLAG)+(1/8),(1)&7
	line	612
	
i1l3335:	
;1.C: 612: if(KEY2_LongPress < 254) KEY2_LongPress++;
	movlw	(0FEh)
	subwf	(_KEY2_LongPress),w
	skipnc
	goto	u224_21
	goto	u224_20
u224_21:
	goto	i1l3339
u224_20:
	
i1l3337:	
	incf	(_KEY2_LongPress),f
	line	613
	
i1l3339:	
;1.C: 613: if((KEY2_LongPress > 125) && (KEY2_LongPress < 250)){
	movlw	(07Eh)
	subwf	(_KEY2_LongPress),w
	skipc
	goto	u225_21
	goto	u225_20
u225_21:
	goto	i1l3351
u225_20:
	
i1l3341:	
	movlw	(0FAh)
	subwf	(_KEY2_LongPress),w
	skipnc
	goto	u226_21
	goto	u226_20
u226_21:
	goto	i1l3351
u226_20:
	line	614
	
i1l3343:	
;1.C: 614: PRESS_FLAG |= 0x20;
	bsf	(_PRESS_FLAG)+(5/8),(5)&7
	line	615
	
i1l3345:	
;1.C: 615: match_slice = 0;
	clrf	(_match_slice)
	line	616
	
i1l3347:	
;1.C: 616: PC0 = 0;
	bcf	(56/8),(56)&7
	line	617
	
i1l3349:	
;1.C: 617: PA6 = 0;
	bcf	(46/8),(46)&7
	line	618
;1.C: 618: LONGPRESS_OverTime_Counter = 0;
	clrf	(_LONGPRESS_OverTime_Counter)
	line	620
	
i1l3351:	
;1.C: 619: }
;1.C: 620: if(KEY2_LongPress > 250){
	movlw	(0FBh)
	subwf	(_KEY2_LongPress),w
	skipc
	goto	u227_21
	goto	u227_20
u227_21:
	goto	i1l3371
u227_20:
	line	621
	
i1l3353:	
;1.C: 621: CH2_remotekey[0] = 0xFFFFFFFF;
	movlw	0FFh
	movwf	(_CH2_remotekey+3)
	movlw	0FFh
	movwf	(_CH2_remotekey+2)
	movlw	0FFh
	movwf	(_CH2_remotekey+1)
	movlw	0FFh
	movwf	(_CH2_remotekey)

	line	622
;1.C: 622: CH2_remotekey[1] = 0xFFFFFFFF;
	movlw	0FFh
	movwf	3+(_CH2_remotekey)+04h
	movlw	0FFh
	movwf	2+(_CH2_remotekey)+04h
	movlw	0FFh
	movwf	1+(_CH2_remotekey)+04h
	movlw	0FFh
	movwf	0+(_CH2_remotekey)+04h

	line	623
;1.C: 623: CH2_remotekey[2] = 0xFFFFFFFF;
	movlw	0FFh
	movwf	3+(_CH2_remotekey)+08h
	movlw	0FFh
	movwf	2+(_CH2_remotekey)+08h
	movlw	0FFh
	movwf	1+(_CH2_remotekey)+08h
	movlw	0FFh
	movwf	0+(_CH2_remotekey)+08h

	line	624
;1.C: 624: CH2_remotekey[3] = 0xFFFFFFFF;
	movlw	0FFh
	movwf	3+(_CH2_remotekey)+0Ch
	movlw	0FFh
	movwf	2+(_CH2_remotekey)+0Ch
	movlw	0FFh
	movwf	1+(_CH2_remotekey)+0Ch
	movlw	0FFh
	movwf	0+(_CH2_remotekey)+0Ch

	line	625
	
i1l3355:	
;1.C: 625: CH2_remotekey_num = 0;
	clrf	(_CH2_remotekey_num)
	line	626
	
i1l3357:	
;1.C: 626: CH2_remotekey_Latest = 0;
	bsf	status, 5	;RP0=1, select bank1
	clrf	(_CH2_remotekey_Latest)^080h
	line	627
	
i1l3359:	
;1.C: 627: PRESS_FLAG &= ~0x20;
	bcf	status, 5	;RP0=0, select bank0
	bcf	(_PRESS_FLAG)+(5/8),(5)&7
	line	628
	
i1l3361:	
;1.C: 628: PRESS_FLAG &= ~0x02;
	bcf	(_PRESS_FLAG)+(1/8),(1)&7
	line	629
	
i1l3363:	
;1.C: 629: PC0 = 1;
	bsf	(56/8),(56)&7
	line	630
	
i1l3365:	
;1.C: 630: PA6 = 1;
	bsf	(46/8),(46)&7
	line	631
	
i1l3367:	
;1.C: 631: KEY_Match_counter = 0;
	clrf	(_KEY_Match_counter)
	goto	i1l3371
	line	633
	
i1l3369:	
	clrf	(_KEY2_LongPress)
	line	635
	
i1l3371:	
;1.C: 635: if(PC4 == 0){
	btfsc	(60/8),(60)&7
	goto	u228_21
	goto	u228_20
u228_21:
	goto	i1l3411
u228_20:
	line	636
	
i1l3373:	
;1.C: 636: if(KEY3_LongPress < 125) PRESS_FLAG |= 0x04;
	movlw	(07Dh)
	subwf	(_KEY3_LongPress),w
	skipnc
	goto	u229_21
	goto	u229_20
u229_21:
	goto	i1l3377
u229_20:
	
i1l3375:	
	bsf	(_PRESS_FLAG)+(2/8),(2)&7
	line	637
	
i1l3377:	
;1.C: 637: if(KEY3_LongPress < 254) KEY3_LongPress++;
	movlw	(0FEh)
	subwf	(_KEY3_LongPress),w
	skipnc
	goto	u230_21
	goto	u230_20
u230_21:
	goto	i1l3381
u230_20:
	
i1l3379:	
	incf	(_KEY3_LongPress),f
	line	638
	
i1l3381:	
;1.C: 638: if((KEY3_LongPress > 125) && (KEY3_LongPress < 250)){
	movlw	(07Eh)
	subwf	(_KEY3_LongPress),w
	skipc
	goto	u231_21
	goto	u231_20
u231_21:
	goto	i1l3393
u231_20:
	
i1l3383:	
	movlw	(0FAh)
	subwf	(_KEY3_LongPress),w
	skipnc
	goto	u232_21
	goto	u232_20
u232_21:
	goto	i1l3393
u232_20:
	line	639
	
i1l3385:	
;1.C: 639: PRESS_FLAG |= 0x40;
	bsf	(_PRESS_FLAG)+(6/8),(6)&7
	line	640
	
i1l3387:	
;1.C: 640: match_slice = 0;
	clrf	(_match_slice)
	line	641
	
i1l3389:	
;1.C: 641: PC0 = 0;
	bcf	(56/8),(56)&7
	line	642
	
i1l3391:	
;1.C: 642: PA5 = 0;
	bcf	(45/8),(45)&7
	line	643
;1.C: 643: LONGPRESS_OverTime_Counter = 0;
	clrf	(_LONGPRESS_OverTime_Counter)
	line	645
	
i1l3393:	
;1.C: 644: }
;1.C: 645: if(KEY3_LongPress > 250){
	movlw	(0FBh)
	subwf	(_KEY3_LongPress),w
	skipc
	goto	u233_21
	goto	u233_20
u233_21:
	goto	i1l3413
u233_20:
	line	646
	
i1l3395:	
;1.C: 646: CH3_remotekey[0] = 0xFFFFFFFF;
	movlw	0FFh
	movwf	(_CH3_remotekey+3)
	movlw	0FFh
	movwf	(_CH3_remotekey+2)
	movlw	0FFh
	movwf	(_CH3_remotekey+1)
	movlw	0FFh
	movwf	(_CH3_remotekey)

	line	647
;1.C: 647: CH3_remotekey[1] = 0xFFFFFFFF;
	movlw	0FFh
	movwf	3+(_CH3_remotekey)+04h
	movlw	0FFh
	movwf	2+(_CH3_remotekey)+04h
	movlw	0FFh
	movwf	1+(_CH3_remotekey)+04h
	movlw	0FFh
	movwf	0+(_CH3_remotekey)+04h

	line	648
;1.C: 648: CH3_remotekey[2] = 0xFFFFFFFF;
	movlw	0FFh
	movwf	3+(_CH3_remotekey)+08h
	movlw	0FFh
	movwf	2+(_CH3_remotekey)+08h
	movlw	0FFh
	movwf	1+(_CH3_remotekey)+08h
	movlw	0FFh
	movwf	0+(_CH3_remotekey)+08h

	line	649
;1.C: 649: CH3_remotekey[3] = 0xFFFFFFFF;
	movlw	0FFh
	movwf	3+(_CH3_remotekey)+0Ch
	movlw	0FFh
	movwf	2+(_CH3_remotekey)+0Ch
	movlw	0FFh
	movwf	1+(_CH3_remotekey)+0Ch
	movlw	0FFh
	movwf	0+(_CH3_remotekey)+0Ch

	line	650
	
i1l3397:	
;1.C: 650: CH3_remotekey_num = 0;
	clrf	(_CH3_remotekey_num)
	line	651
	
i1l3399:	
;1.C: 651: CH3_remotekey_Latest = 0;
	bsf	status, 5	;RP0=1, select bank1
	clrf	(_CH3_remotekey_Latest)^080h
	line	652
	
i1l3401:	
;1.C: 652: PRESS_FLAG &= ~0x40;
	bcf	status, 5	;RP0=0, select bank0
	bcf	(_PRESS_FLAG)+(6/8),(6)&7
	line	653
	
i1l3403:	
;1.C: 653: PRESS_FLAG &= ~0x04;
	bcf	(_PRESS_FLAG)+(2/8),(2)&7
	line	654
	
i1l3405:	
;1.C: 654: PC0 = 1;
	bsf	(56/8),(56)&7
	line	655
	
i1l3407:	
;1.C: 655: PA5 = 1;
	bsf	(45/8),(45)&7
	line	656
	
i1l3409:	
;1.C: 656: KEY_Match_counter = 0;
	clrf	(_KEY_Match_counter)
	goto	i1l3413
	line	658
	
i1l3411:	
	clrf	(_KEY3_LongPress)
	line	660
	
i1l3413:	
;1.C: 660: if((PRESS_FLAG>0)&&(PC5==1)&&(PA4==1)&&(PC4==1)){
	movf	(_PRESS_FLAG),w
	skipz
	goto	u234_20
	goto	i1l1013
u234_20:
	
i1l3415:	
	btfss	(61/8),(61)&7
	goto	u235_21
	goto	u235_20
u235_21:
	goto	i1l1013
u235_20:
	
i1l3417:	
	btfss	(44/8),(44)&7
	goto	u236_21
	goto	u236_20
u236_21:
	goto	i1l1013
u236_20:
	
i1l3419:	
	btfss	(60/8),(60)&7
	goto	u237_21
	goto	u237_20
u237_21:
	goto	i1l1013
u237_20:
	line	661
	
i1l3421:	
;1.C: 661: PRESSED = PRESS_FLAG;
	movf	(_PRESS_FLAG),w
	movwf	(_PRESSED)
	line	662
	
i1l3423:	
;1.C: 662: PRESS_FLAG = 0;
	clrf	(_PRESS_FLAG)
	line	665
	
i1l1013:	
	return
	opt stack 0
GLOBAL	__end_of_KEYSCAN
	__end_of_KEYSCAN:
;; =============== function _KEYSCAN ends ============

	signat	_KEYSCAN,88
	global	_led1_debug
psect	text696,local,class=CODE,delta=2
global __ptext696
__ptext696:

;; *************** function _led1_debug *****************
;; Defined at:
;;		line 397 in file "1.C"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		None
;; Tracked objects:
;;		On entry : 20/0
;;		On exit  : 20/0
;;		Unchanged: FFFFFFDF/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_ISR
;;		_KEY
;; This function uses a non-reentrant model
;;
psect	text696
	file	"1.C"
	line	397
	global	__size_of_led1_debug
	__size_of_led1_debug	equ	__end_of_led1_debug-_led1_debug
	
_led1_debug:	
	opt	stack 2
; Regs used in _led1_debug: []
	line	401
	
i1l942:	
	return
	opt stack 0
GLOBAL	__end_of_led1_debug
	__end_of_led1_debug:
;; =============== function _led1_debug ends ============

	signat	_led1_debug,88
	global	_EX_INT_RisingEdge
psect	text697,local,class=CODE,delta=2
global __ptext697
__ptext697:

;; *************** function _EX_INT_RisingEdge *****************
;; Defined at:
;;		line 410 in file "1.C"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		None
;; Tracked objects:
;;		On entry : 20/20
;;		On exit  : 20/20
;;		Unchanged: FFFDF/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_ISR
;; This function uses a non-reentrant model
;;
psect	text697
	file	"1.C"
	line	410
	global	__size_of_EX_INT_RisingEdge
	__size_of_EX_INT_RisingEdge	equ	__end_of_EX_INT_RisingEdge-_EX_INT_RisingEdge
	
_EX_INT_RisingEdge:	
	opt	stack 3
; Regs used in _EX_INT_RisingEdge: []
	line	411
	
i1l3283:	
;1.C: 411: INTEDG =1;
	bsf	(1038/8)^080h,(1038)&7
	line	412
;1.C: 412: FLAGs |= 0x01;
	bsf	(_FLAGs)+(0/8),(0)&7
	line	413
	
i1l948:	
	return
	opt stack 0
GLOBAL	__end_of_EX_INT_RisingEdge
	__end_of_EX_INT_RisingEdge:
;; =============== function _EX_INT_RisingEdge ends ============

	signat	_EX_INT_RisingEdge,88
psect	text698,local,class=CODE,delta=2
global __ptext698
__ptext698:
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
