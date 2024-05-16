#line 1 "C:/Users/USER/Downloads/Simultaneo y alternancia/test.c"







long int cuenta = 0;

void InitInterrupt();

void interrupt(){


 if (PIR0.TMR0IF){
 TMR0L = 0x3B;
 TMR0H = 0xF6;
 cuenta++;
 if( PORTC.F0 ){
 if(cuenta >= 100){
  LATA.F5  = ~ LATA.F5 ;
 }
 cuenta = 0;
 }
 PIR0.TMR0IF = 0;
 }

}

void main() {

 ANSELC = 0;
 ANSELE = 0;
 ANSELA = 0;

 TRISC = 0x03;
 TRISE = 0x00;
 TRISA = 0x00;

 PORTC = 0x01;
 PORTA = 0x10;
 PORTE = 0x00;

 LATC = 0x01;
 LATE = 0x00;
 LATA = 0x10;

 InitInterrupt();

}

void InitInterrupt(){

 INTCON = 0xC0;

 T0CON0 = 0x90;
 T0CON1 = 0x46;
 PIE0 = 0x20;
 TMR0L = 0x3B;
 TMR0H = 0xF6;

}
