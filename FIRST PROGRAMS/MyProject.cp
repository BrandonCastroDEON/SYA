#line 1 "C:/Users/USER/Downloads/Simultaneo y alternancia/MyProject.c"




bit flag01;
bit flag02;
int i=0;
short unsigned int AR1 = 0;
short unsigned int AR2 = 1;

void InitPIC();
void watch();

void InitPIC() {

 ADCON1 = 0x0F;

 ANSELC = 0;
 ANSELE = 0;
 ANSELA = 0;

 TRISC = 0x03;
 TRISE = 0x00;
 TRISA = 0x00;

 PORTC = 0x00;
 PORTE = 0x00;
 PORTA = 0x10;

 LATC = 0x00;
 LATE = 0x00;
 LATA = 0x10;
 flag01 = 0;

}

void watch(){
#line 47 "C:/Users/USER/Downloads/Simultaneo y alternancia/MyProject.c"
 if(RC0_bit){
 flag01 = 1;
 }

}

void main(){

 InitPIC();
 watch();

 if(flag01){
  PORTE.RE0  = 1;
 }

 while( PORTE.RE0 ==1){
 AR1 = AR1 + 1;
 break;
 }

 if(AR1 <= 5){
  PORTA.RA4  = 0;
 Delay_ms(100);
  PORTA.RA4  = 1;
 Delay_ms(100);
 }
 else{
  PORTA.RA4  = 0;
 }
#line 95 "C:/Users/USER/Downloads/Simultaneo y alternancia/MyProject.c"
}
