//Timer0 Prescaler = 64; Preload = 125; Actual Interrupt Time = 1 ms
#define PWM_1_Enable     10
#define PWM_1_Disable    20
#define PWM_2_Enable     30
#define PWM_2_Disable    40
#define PWM_2_Stop       500
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

//Place/Copy this part in declaration section
/*void InitTimer0(){
  SREG_I_bit = 1;
  OCR0A = 125;
  TCCR0A = 0x82;
  TCCR0B |= 0x83;
  OCIE0A_bit = 1;
}

void Timer0Overflow_ISR() org IVT_ADDR_TIMER0_COMPA
{
  uiCnt++;
  if((uiCnt>=PWM_1_Enable) &&  (uiCnt<=PWM_1_Disable))
  {
      PWM1A_Enable(_PWM1_NON_INVERTED);
      PINB2_bit = 1;
  }
  else if((uiCnt>=PWM_1_Disable) &&  (uiCnt<=PWM_2_Enable))
  {
      PWM1A_Disable();
      PINB2_bit = 0;
  }
  else if((uiCnt>=PWM_2_Enable) &&  (uiCnt<=PWM_2_Disable))
  {
      PWM1A_Enable(_PWM1_NON_INVERTED);
      PINB2_bit = 1;
  }
  else if((uiCnt>=PWM_2_Disable) &&  (uiCnt<=PWM_2_Stop))
  {
      PWM1A_Disable();
      PINB2_bit = 0;
      if(uiCnt >= PWM_2_Stop)
      uiCnt = 0;
  }
  /*else
  {
      PINB2_bit = 0;
      uiCnt = 0;
  }*/

//}*/

//Timer1 Prescaler = 32; Preload = 250; Actual Interrupt Time = 1 ms

void InitTimer1(){
  SREG_I_bit = 1;
  OCR1A = 250;
 // TCCR1 = 0x86;
  //TCCR1 = 0x87;
  TCCR1 = 0x87;
  OCIE1A_bit = 1;
}

void Timer1Overflow_ISR() org IVT_ADDR_TIMER1_COMPA 
{
  uiCnt++;
  PWM_Disable();
  if((uiCnt>=PWM_1_Enable) &&  (uiCnt<=PWM_1_Disable))
  {
      PWM_Enable();
      //PINB2_bit = 0;
  }
  else if((uiCnt>=PWM_1_Disable) &&  (uiCnt<=PWM_2_Enable))
  {
      PWM_Disable();
      PINB2_bit = 0;
  }
  else if((uiCnt>=PWM_2_Enable) &&  (uiCnt<=PWM_2_Disable))
  {
      PWM_Enable();
      //PINB2_bit = 1;
  }
  else if((uiCnt>=PWM_2_Disable) &&  (uiCnt<=PWM_2_Stop))
  {
      PWM_Disable();
      //PINB2_bit = 0;
      if(uiCnt >= PWM_2_Stop)
      uiCnt = 0;
  }
  /*else
  {
       PWM_Disable();
  }*/
}


void PWM_config()
{
  //TCCR0A=0x00;             //Normal mode

  //TCNT0=0x00;
  //OCR0B=133;            //Generating PWM of 98% duty cycle from OC0B
  /********************************************************************/
  /*TIMSK = 0;                     // Timer interrupts OFF
  GTCCR = 0x70;
 //PINB1_bit = 1;
 TCCR0A=0x37;
  TCCR0B=0x01;*/
  //TIFR = 0x24;
  //TIMSK = 0x24;
  //OCR0B = 133;
  /************************************************************************/
  //TCCR0A=0xA3;
  //TCCR0A=0x03;
  TCCR0A=0x13;
  TCCR0B=0x01;
  //TCCR1 = 0x01;
  GTCCR = 0x50;
 //GTCCR = 0x10;
}



void main()
{
 PORTB4_bit = 1;
 DDB4_bit = 1;
 PORTB0_bit = 1;
  DDB0_bit = 1;               // Set PORTB pin 0 as input
  PORTB1_bit = 1;
  DDB1_bit = 1;                  // Set PORTB pin 1 as input
  PORTB2_bit = 0;
  DDB2_bit = 0;
  uiCnt = 0;
  PINB0_bit = 0;
  PINB1_bit = 0;
  PINB2_bit = 0;
  //PINB1_bit = 1;
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