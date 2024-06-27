
//Timer0 Prescaler = 0; Preload = 211; Actual Interrupt Time = 26.375 us

//Place/Copy this part in declaration section
/*void InitTimer0(){
  SREG_I_bit = 1;
  OCR0A = 211;
  TCCR0A = 0x82;
  TCCR0B |= 0x81;
  OCIE0A_bit = 1;
}

void Timer0Overflow_ISR() org IVT_ADDR_TIMER0_COMPA {
  //Enter your code here
  //PINB2_bit = ~PINB2_bit;
}

void main()
{
  DDB0_bit = 1;                   // Set PORTB pin 0 as input
  DDB1_bit = 0;                   // Set PORTB pin 1 as input
  DDB2_bit = 1;
  DDB3_bit = 0;
  DDB4_bit = 0;
 // InitTimer0();
  while(1)
  {
  if(PINB1_bit)
  PINB0_bit = 1;
  else
  PINB0_bit = 0;

  }
}
*/
/*******************************************************************************************
unsigned int Acc;
unsigned int Note = 857; // Middle C

ISR(TIMER0_COMPA_vect) {
  Acc = Acc + Note;
  OCR1B = (Acc >> 8) & 0x80;
}
void setup() {
  // Enable 64 MHz PLL and use as source for Timer1
  PLLCSR = 1<<PCKE | 1<<PLLE;

  // Set up Timer/Counter1 for PWM output
  TIMSK = 0;                     // Timer interrupts OFF
  TCCR1 = 1<<CS10;               // 1:1 prescale
  GTCCR = 1<<PWM1B | 2<<COM1B0;  // PWM B, clear on match

 // pinMode(4, OUTPUT);            // Enable PWM output pin
 PINB4_bit = 1;

  // Set up Timer/Counter0 for 20kHz interrupt to output samples.
  TCCR0A = 3<<WGM00;             // Fast PWM
  TCCR0B = 1<<WGM02 | 2<<CS00;   // 1/8 prescale
  TIMSK = 1<<OCIE0A;             // Enable compare match, disable overflow
  OCR0A = 49;                    // Divide by 400
}

void main()
{
 DDB4_bit = 0;
setup();
 while(1)
 {

 }
}   */