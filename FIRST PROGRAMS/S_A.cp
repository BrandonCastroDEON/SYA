#line 1 "C:/Users/USER/Downloads/Simultaneo y alternancia/S_A.c"
bit Flag01;
bit Flag02;
unsigned int AR1 = 1;
unsigned int AR2 = 0;

void main() {

 ADCON1 = 0x0F;

 ANSELC = 0;
 ANSELE = 0;
 ANSELA = 0;

 TRISC = 0x03;
 TRISE = 0x00;
 TRISA = 0x00;

 PORTC = 0x00;
 PORTE = 0x00;
 PORTA = 0x00;

 LATC = 0x00;
 LATE = 0x00;
 LATA = 0x00;

 AR1 = 0;
 AR2 = 0;

 do{


 if(RC0_bit == 0){
 Flag01 = 1;

 }

 else if(RC0_bit == 1){
 Flag01 = 0;

 }


 if(RC1_bit == 0){
 Flag02 = 1;

 }

 else if(RC1_bit == 1){
 Flag02 = 0;

 }
#line 57 "C:/Users/USER/Downloads/Simultaneo y alternancia/S_A.c"
 Delay_ms(100);


 if(Flag01 = 1 && RC0_bit == 0){


 if(AR1 > AR2){


 LATE = 0x02;
 AR2 = AR2 + 1;

 Flag01 = 0;
 Delay_ms(100);

 }

 else{


 LATE = 0x01;
 AR1 = AR1 + 1;
 RA4_bit = 1;
 Flag01 = 0;
 Delay_ms(100);

 }


 if(Flag02 = 1 && RC1_bit == 0){


 LATE = 0x03;

 AR1 = AR1 + 1;
 AR2 = AR2 + 1;

 }

 else if(Flag02 = 0 && RC1_bit == 1){

 if(AR1 > AR2){

 LATE = 0x02;

 AR2 = AR2 + 1;

 }

 else{

 LATE = 0x01;

 AR1 = AR1 + 1;

 }

 }

 }

 else if (Flag01 = 0 && RC0_bit == 1){

 LATE = 0x00;
 Flag01 = 0;


 }

 } while(1);

}
