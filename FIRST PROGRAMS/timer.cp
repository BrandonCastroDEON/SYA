#line 1 "C:/Users/USER/Downloads/Simultaneo y alternancia/timer.c"
#line 16 "C:/Users/USER/Downloads/Simultaneo y alternancia/timer.c"
bit flag_switch;
bit flag_A1;
bit flag_A2;
bit flag01;
bit flag02;
bit estado;
long int AR1;
long int AR1P;
long int AR2;
long int AR2P;
unsigned int AR3 = 0;
unsigned int AR4 = 0;
int cuenta = 0;
long int stop = 0;
char multi;
char flags;

void InitMCU();
void InitInterrupt();

void interrupt(){

 if(PIR0.TMR0IF){
 TMR0H = 0xE1;
 TMR0L = 0x7A;

 if( PORTC.F0 ){
 cuenta++;
 if(cuenta >= 50){
 flag01 = 1;
 cuenta = 0;
 }
 }
 PIR0.TMR0IF = 0;
 }

}

void main() {

 InitMCU();
 InitInterrupt();
 flag01 = 0;
 cuenta = 0;

 while(1){
 estado = 0;
 if(flag01){
 estado++;
 estado = estado << 1;
 if((estado == 0xf0000) && ( PORTC.F0  == 1)){
 flag02 = 1;
  LATA.F4  = ~ LATA.F4 ;
 }
 else{
 flag02 = 0;
 }
 }
 if(flag02){
  LATA.F5  = ~ LATA.F5 ;
  LATE.F0  = ~ LATE.F0 ;
  LATE.F1  = ~ LATE.F1 ;
  LATE.F2  = ~ LATE.F2 ;
 }
 else{
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 0;
  LATE.F2  = 0;
 }
 }

}

void InitInterrupt(){

 T0CON0 = 0x90;
 T0CON1 = 0x46;
 PIE0.TMR0IE = 1;
 TMR0H = 0xE1;
 TMR0L = 0x7A;

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
 PORTA = 0x00;
 PORTE = 0x00;

 LATC = 0x00;
 LATE = 0x00;
 LATA = 0x00;
}
