#line 1 "C:/Users/ADMIN/Desktop/tiny202/Attiny 85/sensor.c"






unsigned int uiCnt;
void PWM_Enable()
{
 PINB1_bit = 1;
 OCR0B = 130;
}
void PWM_Disable()
{
 PINB1_bit = 0;
 OCR0B = 0;
}
#line 63 "C:/Users/ADMIN/Desktop/tiny202/Attiny 85/sensor.c"
void InitTimer1(){
 SREG_I_bit = 1;
 OCR1A = 250;


 TCCR1 = 0x87;
 OCIE1A_bit = 1;
}

void Timer1Overflow_ISR() org IVT_ADDR_TIMER1_COMPA
{
 uiCnt++;
 PWM_Disable();
 if((uiCnt>= 10 ) && (uiCnt<= 20 ))
 {
 PWM_Enable();

 }
 else if((uiCnt>= 20 ) && (uiCnt<= 30 ))
 {
 PWM_Disable();
 PINB2_bit = 0;
 }
 else if((uiCnt>= 30 ) && (uiCnt<= 40 ))
 {
 PWM_Enable();

 }
 else if((uiCnt>= 40 ) && (uiCnt<= 500 ))
 {
 PWM_Disable();

 if(uiCnt >=  500 )
 uiCnt = 0;
 }
#line 102 "C:/Users/ADMIN/Desktop/tiny202/Attiny 85/sensor.c"
}


void PWM_config()
{
#line 123 "C:/Users/ADMIN/Desktop/tiny202/Attiny 85/sensor.c"
 TCCR0A=0x13;
 TCCR0B=0x01;

 GTCCR = 0x50;

}



void main()
{
 PORTB4_bit = 1;
 DDB4_bit = 1;
 PORTB0_bit = 1;
 DDB0_bit = 1;
 PORTB1_bit = 1;
 DDB1_bit = 1;
 PORTB2_bit = 0;
 DDB2_bit = 0;
 uiCnt = 0;
 PINB0_bit = 0;
 PINB1_bit = 0;
 PINB2_bit = 0;

 PWM_config();
 PWM_Disable();
 InitTimer1();

 while(1)
 {
 if(!PINB2_bit)
 {
 PINB0_bit = 1;
 }
 else
 {
 PINB0_bit = 0;
 }

 Delay_ms (100);




 }
}
