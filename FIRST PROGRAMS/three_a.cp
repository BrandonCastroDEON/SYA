#line 1 "C:/Users/USER/Downloads/Simultaneo y alternancia/three_a.c"
#line 16 "C:/Users/USER/Downloads/Simultaneo y alternancia/three_a.c"
bit flag_switch;
bit flag_A1;
bit flag_A2;
bit flag02;
long int AR1;
long int AR1P;
long int AR2;
long int AR2P;
unsigned int AR3 = 0;
unsigned int AR4 = 0;
long int stop = 0;
char multi;
char flags;





void InitMCU();
void InitInterrupt();
void blink();
void watchdog();
void SM();
void RMUX();





void main() {

 InitMCU();
 InitInterrupt();
  flags.f0  =  1 ;

 while(1){
 watchdog();


 if((flag_switch == 1) && ( PORTC.F0  == 0)){

 if(AR1P > AR2P){
  LATE.F0  = 1;
 AR2 = AR2P + 1;
 }

 else if(AR1P < AR2P){
  LATA.F5  = 1;
 AR1 = AR1P + 1;
 }

 if(AR1P == AR1){
  LATA.F4  = ~ LATA.F4 ;
 }
 }

 else{
  LATA.F5  = 0;
  LATE.F0  = 0;
 AR1P = AR1;
 AR2P = AR2;
 AR1 = 0;
 AR2 = 0;
 }
 }

}





void RMUX(){

 while(1){

 if(AR1 > AR1P){
 flag_A1 = 1;
 AR1P = 0;
 }
 if(AR2 > AR2P){
 flag_A2 = 1;
 AR2P = 0;
 }
 break;
 }

}





void SM(){

 if( LATA.F5 ){

 if( flags.f0 ){
 AR1++;
  LATE.F1  = ~ LATE.F1 ;
  flags.f0  =  0 ;
 }
 }

 if( LATE.F0 ){

 if( flags.f0 ){
 AR2++;
  LATE.F2  = ~ LATE.F2 ;
  flags.f0  =  0 ;
 }
 }

}





void blink(){

 while(flag_switch){
 char i;

 for(i = 0; i < 4; i++){
  LATA.F4  = ~ LATA.F4 ;
 Delay_ms(50);
 }
 break;
 }

}





void watchdog(){

 while(1){

 if(1 ==  PORTC.F0 )continue;

 if(0 ==  PORTC.F0 ){
 Delay_ms(50);
 flag_switch = 1;

 }
 break;
 }
}





void InitInterrupt(){

 PIE0 = 0x10;
 IOCCF = 0x00;
 IOCCN = 0x00;
 IOCCP = 0x00;
#line 182 "C:/Users/USER/Downloads/Simultaneo y alternancia/three_a.c"
 INTCON = 0xC0;


}





void InitMCU(){

 ADCON1 = 0x0F;

 ANSELC = 0;
 ANSELE = 0;
 ANSELA = 0;

 TRISC = 0x03;
 TRISE = 0x00;
 TRISA = 0x00;

 PORTC = 0x00;
 PORTA = 0x10;
 PORTE = 0x00;

 LATC = 0x00;
 LATE = 0x00;
 LATA = 0x10;
#line 216 "C:/Users/USER/Downloads/Simultaneo y alternancia/three_a.c"
  flags.f1  =  1 ;
 flag_switch = 0;

}
