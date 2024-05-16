#line 1 "C:/Users/USER/Downloads/Simultaneo y alternancia/Interrupt.c"







char toggle = 1;
unsigned int PORTC_READ;

void interrupt(){

PORTC;
IOCCF = 0x00;
PORTC_READ = PORTC;

 if(PIR0.IOCIF == 1){
 if(PORTC_READ == 0x01){
  LATA.F4  = 0;
 }
 IOCCF = 0x00;
 }
}

void main() {

 ADCON1 = 0x0F;

 ANSELC = 0;
 ANSELA = 0;

 TRISC = 0x01;
 TRISA = 0x00;

 PORTC = 0x00;
 PORTA = 0x10;

 LATC = 0x00;
 LATA = 0x10;

 INTCON.IPEN = 0;
 INTCON.PEIE = 1;

 PIR0.IOCIF = 0;
 PIE0.IOCIE = 0;

 IOCCF = 0x00;
 IOCCP = 0xFF;
 IOCCN = 0xFF;
 INTCON.GIE = 1;

 WPUC = 0xFF;

 while(1){
 Delay_ms(10);
 }

}
