
_PWM_Enable:

;sensor.c,8 :: 		void PWM_Enable()
;sensor.c,10 :: 		PINB1_bit = 1;
	IN         R27, PINB1_bit+0
	SBR        R27, BitMask(PINB1_bit+0)
	OUT        PINB1_bit+0, R27
;sensor.c,11 :: 		OCR0B = 130;
	LDI        R27, 130
	OUT        OCR0B+0, R27
;sensor.c,12 :: 		}
L_end_PWM_Enable:
	RET
; end of _PWM_Enable

_PWM_Disable:

;sensor.c,13 :: 		void PWM_Disable()
;sensor.c,15 :: 		PINB1_bit = 0;
	IN         R27, PINB1_bit+0
	CBR        R27, BitMask(PINB1_bit+0)
	OUT        PINB1_bit+0, R27
;sensor.c,16 :: 		OCR0B = 0;
	LDI        R27, 0
	OUT        OCR0B+0, R27
;sensor.c,17 :: 		}
L_end_PWM_Disable:
	RET
; end of _PWM_Disable

_InitTimer1:

;sensor.c,63 :: 		void InitTimer1(){
;sensor.c,64 :: 		SREG_I_bit = 1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;sensor.c,65 :: 		OCR1A = 250;
	LDI        R27, 250
	OUT        OCR1A+0, R27
;sensor.c,68 :: 		TCCR1 = 0x87;
	LDI        R27, 135
	OUT        TCCR1+0, R27
;sensor.c,69 :: 		OCIE1A_bit = 1;
	IN         R27, OCIE1A_bit+0
	SBR        R27, BitMask(OCIE1A_bit+0)
	OUT        OCIE1A_bit+0, R27
;sensor.c,70 :: 		}
L_end_InitTimer1:
	RET
; end of _InitTimer1

_Timer1Overflow_ISR:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;sensor.c,72 :: 		void Timer1Overflow_ISR() org IVT_ADDR_TIMER1_COMPA
;sensor.c,74 :: 		uiCnt++;
	LDS        R16, _uiCnt+0
	LDS        R17, _uiCnt+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _uiCnt+0, R16
	STS        _uiCnt+1, R17
;sensor.c,75 :: 		PWM_Disable();
	CALL       _PWM_Disable+0
;sensor.c,76 :: 		if((uiCnt>=PWM_1_Enable) &&  (uiCnt<=PWM_1_Disable))
	LDS        R16, _uiCnt+0
	LDS        R17, _uiCnt+1
	CPI        R17, 0
	BRNE       L__Timer1Overflow_ISR38
	CPI        R16, 10
L__Timer1Overflow_ISR38:
	BRSH       L__Timer1Overflow_ISR39
	JMP        L__Timer1Overflow_ISR27
L__Timer1Overflow_ISR39:
	LDS        R18, _uiCnt+0
	LDS        R19, _uiCnt+1
	LDI        R16, 20
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRSH       L__Timer1Overflow_ISR40
	JMP        L__Timer1Overflow_ISR26
L__Timer1Overflow_ISR40:
L__Timer1Overflow_ISR25:
;sensor.c,78 :: 		PWM_Enable();
	CALL       _PWM_Enable+0
;sensor.c,80 :: 		}
	JMP        L_Timer1Overflow_ISR3
;sensor.c,76 :: 		if((uiCnt>=PWM_1_Enable) &&  (uiCnt<=PWM_1_Disable))
L__Timer1Overflow_ISR27:
L__Timer1Overflow_ISR26:
;sensor.c,81 :: 		else if((uiCnt>=PWM_1_Disable) &&  (uiCnt<=PWM_2_Enable))
	LDS        R16, _uiCnt+0
	LDS        R17, _uiCnt+1
	CPI        R17, 0
	BRNE       L__Timer1Overflow_ISR41
	CPI        R16, 20
L__Timer1Overflow_ISR41:
	BRSH       L__Timer1Overflow_ISR42
	JMP        L__Timer1Overflow_ISR29
L__Timer1Overflow_ISR42:
	LDS        R18, _uiCnt+0
	LDS        R19, _uiCnt+1
	LDI        R16, 30
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRSH       L__Timer1Overflow_ISR43
	JMP        L__Timer1Overflow_ISR28
L__Timer1Overflow_ISR43:
L__Timer1Overflow_ISR24:
;sensor.c,83 :: 		PWM_Disable();
	CALL       _PWM_Disable+0
;sensor.c,84 :: 		PINB2_bit = 0;
	IN         R27, PINB2_bit+0
	CBR        R27, BitMask(PINB2_bit+0)
	OUT        PINB2_bit+0, R27
;sensor.c,85 :: 		}
	JMP        L_Timer1Overflow_ISR7
;sensor.c,81 :: 		else if((uiCnt>=PWM_1_Disable) &&  (uiCnt<=PWM_2_Enable))
L__Timer1Overflow_ISR29:
L__Timer1Overflow_ISR28:
;sensor.c,86 :: 		else if((uiCnt>=PWM_2_Enable) &&  (uiCnt<=PWM_2_Disable))
	LDS        R16, _uiCnt+0
	LDS        R17, _uiCnt+1
	CPI        R17, 0
	BRNE       L__Timer1Overflow_ISR44
	CPI        R16, 30
L__Timer1Overflow_ISR44:
	BRSH       L__Timer1Overflow_ISR45
	JMP        L__Timer1Overflow_ISR31
L__Timer1Overflow_ISR45:
	LDS        R18, _uiCnt+0
	LDS        R19, _uiCnt+1
	LDI        R16, 40
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRSH       L__Timer1Overflow_ISR46
	JMP        L__Timer1Overflow_ISR30
L__Timer1Overflow_ISR46:
L__Timer1Overflow_ISR23:
;sensor.c,88 :: 		PWM_Enable();
	CALL       _PWM_Enable+0
;sensor.c,90 :: 		}
	JMP        L_Timer1Overflow_ISR11
;sensor.c,86 :: 		else if((uiCnt>=PWM_2_Enable) &&  (uiCnt<=PWM_2_Disable))
L__Timer1Overflow_ISR31:
L__Timer1Overflow_ISR30:
;sensor.c,91 :: 		else if((uiCnt>=PWM_2_Disable) &&  (uiCnt<=PWM_2_Stop))
	LDS        R16, _uiCnt+0
	LDS        R17, _uiCnt+1
	CPI        R17, 0
	BRNE       L__Timer1Overflow_ISR47
	CPI        R16, 40
L__Timer1Overflow_ISR47:
	BRSH       L__Timer1Overflow_ISR48
	JMP        L__Timer1Overflow_ISR33
L__Timer1Overflow_ISR48:
	LDS        R18, _uiCnt+0
	LDS        R19, _uiCnt+1
	LDI        R16, 244
	LDI        R17, 1
	CP         R16, R18
	CPC        R17, R19
	BRSH       L__Timer1Overflow_ISR49
	JMP        L__Timer1Overflow_ISR32
L__Timer1Overflow_ISR49:
L__Timer1Overflow_ISR22:
;sensor.c,93 :: 		PWM_Disable();
	CALL       _PWM_Disable+0
;sensor.c,95 :: 		if(uiCnt >= PWM_2_Stop)
	LDS        R16, _uiCnt+0
	LDS        R17, _uiCnt+1
	CPI        R17, 1
	BRNE       L__Timer1Overflow_ISR50
	CPI        R16, 244
L__Timer1Overflow_ISR50:
	BRSH       L__Timer1Overflow_ISR51
	JMP        L_Timer1Overflow_ISR15
L__Timer1Overflow_ISR51:
;sensor.c,96 :: 		uiCnt = 0;
	LDI        R27, 0
	STS        _uiCnt+0, R27
	STS        _uiCnt+1, R27
L_Timer1Overflow_ISR15:
;sensor.c,91 :: 		else if((uiCnt>=PWM_2_Disable) &&  (uiCnt<=PWM_2_Stop))
L__Timer1Overflow_ISR33:
L__Timer1Overflow_ISR32:
;sensor.c,97 :: 		}
L_Timer1Overflow_ISR11:
L_Timer1Overflow_ISR7:
L_Timer1Overflow_ISR3:
;sensor.c,102 :: 		}
L_end_Timer1Overflow_ISR:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _Timer1Overflow_ISR

_PWM_config:

;sensor.c,105 :: 		void PWM_config()
;sensor.c,123 :: 		TCCR0A=0x13;
	LDI        R27, 19
	OUT        TCCR0A+0, R27
;sensor.c,124 :: 		TCCR0B=0x01;
	LDI        R27, 1
	OUT        TCCR0B+0, R27
;sensor.c,126 :: 		GTCCR = 0x50;
	LDI        R27, 80
	OUT        GTCCR+0, R27
;sensor.c,128 :: 		}
L_end_PWM_config:
	RET
; end of _PWM_config

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;sensor.c,132 :: 		void main()
;sensor.c,134 :: 		PORTB4_bit = 1;
	IN         R27, PORTB4_bit+0
	SBR        R27, BitMask(PORTB4_bit+0)
	OUT        PORTB4_bit+0, R27
;sensor.c,135 :: 		DDB4_bit = 1;
	IN         R27, DDB4_bit+0
	SBR        R27, BitMask(DDB4_bit+0)
	OUT        DDB4_bit+0, R27
;sensor.c,136 :: 		PORTB0_bit = 1;
	IN         R27, PORTB0_bit+0
	SBR        R27, BitMask(PORTB0_bit+0)
	OUT        PORTB0_bit+0, R27
;sensor.c,137 :: 		DDB0_bit = 1;               // Set PORTB pin 0 as input
	IN         R27, DDB0_bit+0
	SBR        R27, BitMask(DDB0_bit+0)
	OUT        DDB0_bit+0, R27
;sensor.c,138 :: 		PORTB1_bit = 1;
	IN         R27, PORTB1_bit+0
	SBR        R27, BitMask(PORTB1_bit+0)
	OUT        PORTB1_bit+0, R27
;sensor.c,139 :: 		DDB1_bit = 1;                  // Set PORTB pin 1 as input
	IN         R27, DDB1_bit+0
	SBR        R27, BitMask(DDB1_bit+0)
	OUT        DDB1_bit+0, R27
;sensor.c,140 :: 		PORTB2_bit = 0;
	IN         R27, PORTB2_bit+0
	CBR        R27, BitMask(PORTB2_bit+0)
	OUT        PORTB2_bit+0, R27
;sensor.c,141 :: 		DDB2_bit = 0;
	IN         R27, DDB2_bit+0
	CBR        R27, BitMask(DDB2_bit+0)
	OUT        DDB2_bit+0, R27
;sensor.c,142 :: 		uiCnt = 0;
	LDI        R27, 0
	STS        _uiCnt+0, R27
	STS        _uiCnt+1, R27
;sensor.c,143 :: 		PINB0_bit = 0;
	IN         R27, PINB0_bit+0
	CBR        R27, BitMask(PINB0_bit+0)
	OUT        PINB0_bit+0, R27
;sensor.c,144 :: 		PINB1_bit = 0;
	IN         R27, PINB1_bit+0
	CBR        R27, BitMask(PINB1_bit+0)
	OUT        PINB1_bit+0, R27
;sensor.c,145 :: 		PINB2_bit = 0;
	IN         R27, PINB2_bit+0
	CBR        R27, BitMask(PINB2_bit+0)
	OUT        PINB2_bit+0, R27
;sensor.c,147 :: 		PWM_config();
	CALL       _PWM_config+0
;sensor.c,148 :: 		PWM_Disable();
	CALL       _PWM_Disable+0
;sensor.c,149 :: 		InitTimer1();
	CALL       _InitTimer1+0
;sensor.c,151 :: 		while(1)
L_main16:
;sensor.c,153 :: 		if(!PINB2_bit)
	IN         R27, PINB2_bit+0
	SBRC       R27, BitPos(PINB2_bit+0)
	JMP        L_main18
;sensor.c,155 :: 		PINB0_bit = 1;
	IN         R27, PINB0_bit+0
	SBR        R27, BitMask(PINB0_bit+0)
	OUT        PINB0_bit+0, R27
;sensor.c,156 :: 		}
	JMP        L_main19
L_main18:
;sensor.c,159 :: 		PINB0_bit = 0;
	IN         R27, PINB0_bit+0
	CBR        R27, BitMask(PINB0_bit+0)
	OUT        PINB0_bit+0, R27
;sensor.c,160 :: 		}
L_main19:
;sensor.c,162 :: 		Delay_ms (100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_main20:
	DEC        R16
	BRNE       L_main20
	DEC        R17
	BRNE       L_main20
	DEC        R18
	BRNE       L_main20
;sensor.c,167 :: 		}
	JMP        L_main16
;sensor.c,168 :: 		}
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
