#line 1 "C:/Users/USER/Downloads/Simultaneo y alternancia/two.c"
#line 16 "C:/Users/USER/Downloads/Simultaneo y alternancia/two.c"
bit flag01;
bit flag02;
long int AR1 = 0;
long int AR2 = 0;
unsigned int AR3 = 0;
unsigned int AR4 = 0;
long int stop = 0;
char multi;
char flags;





void InitMCU();
void InitInterrupt();
void blink();
void watchdog();
void MUX();





void interrupt(){

 if (TMR0IF_bit){
 TMR0H = 0xFF;
 TMR0L = 0xF7;
 if( LATA.F5 ){
 if( flags.f1 ){
  LATA.F4  = 0;
 AR1 = AR1 + 1;
  flags.f1  =  0 ;
 }
 }
 if( LATE.F0 ){
 if( flags.f1 ){
  LATA.F4  = 0;
 AR2 = AR2 + 1;
  flags.f1  =  0 ;
 }
 }
 TMR0IF_bit = 0;
 }
#line 68 "C:/Users/USER/Downloads/Simultaneo y alternancia/two.c"
}





void main() {

 InitMCU();
 InitInterrupt();

 AR1 = 0;
 AR2 = 0;

 if(stop >= 80){
  LATE.F0  = ~ LATE.F0 ;
 }


 while(1){
 watchdog();


 if(flag01 == 1){
 MUX();


 switch(multi){
 case 0:
  LATA.F5  = ~ LATA.F5 ;
 break;
 case 1:
  LATE.F0  = ~ LATE.F0 ;
 break;
 }
#line 109 "C:/Users/USER/Downloads/Simultaneo y alternancia/two.c"
 }
 else{

  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 0;
  LATE.F2  = 0;
 }
 }

}





void watchdog(){

 while(1){

 if(1 ==  PORTC.F0 )continue;

 if(0 ==  PORTC.F0 ){
 flag01 = 1;
 }
 break;
 }
}





void MUX(){

 if(AR2 > AR1){
 multi = 0;
 }
 else{
 multi = 1;
 }

}





void blink(){

 while(flag01 == 1){
 char i;

 for(i = 0; i < 4; i++){
  LATA.F4  = ~ LATA.F4 ;
 Delay_ms(50);
 }
 break;
 }

}





void InitInterrupt(){

 PIE0 = 0x10;
 IOCCF = 0x00;
 IOCCN = 0x00;
 IOCCP = 0x00;
 T0CON0 = 0x90;
 T0CON1 = 0x46;
 TMR0H = 0xFF;
 TMR0L = 0xF7;
 INTCON = 0xC0;
 TMR0IE_bit = 1;

}





void InitMCU(){

 ADCON1 = 0x0F;

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
#line 219 "C:/Users/USER/Downloads/Simultaneo y alternancia/two.c"
  flags.f0  =  1 ;
  flags.f1  =  1 ;
 flag01 = 0;
 flag02 = 0;

}
