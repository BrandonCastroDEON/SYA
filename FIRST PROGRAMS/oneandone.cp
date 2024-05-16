#line 1 "C:/Users/USER/Downloads/Simultaneo y alternancia/oneandone.c"
bit Flag01;
bit Flag02;
bit OF;
unsigned short int AR1;
unsigned short int AR2;

void main(){

 ANSELA = 0;
 ANSELC = 0;
 ANSELE = 0;

 TRISC = 0x03;
 TRISE = 0x00;
 TRISA = 0x00;

 PORTA = 0x00;
 PORTE = 0x00;
 PORTC = 0x00;

 LATC = 0x00;
 LATE = 0x00;
 LATA = 0x00;

 AR1 = 1;
 AR2 = 0;


 if(AR1 >= 255){

 OF = 1;
 AR1 = 1;
 AR2 = 0;

 }

 else if(AR2 >= 255){

 OF = 1;
 AR1 = 1;
 AR2 = 0;

 }
 else{

 OF = 0;

 }

 if(RC0_bit == 0){

 Flag01 = 1;
 RA4_bit = 1;

 }
 else{

 Flag01 = 0;

 }

 Delay_ms(100);

 while(1){

 if(Flag01 == 1){

 LATE = 0x02;
 AR2 = AR2 + 1;
 Delay_ms(100);

 }
 else if(Flag01 == 1 && AR1 < AR2){

 LATE = 0x01;
 AR1 = AR1 + 1;
 Delay_ms(100);

 }
 else{

 LATE = 0x00;
 RA4_bit = 1;

 }

 }

}
