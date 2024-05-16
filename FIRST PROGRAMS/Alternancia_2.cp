#line 1 "C:/Users/USER/Downloads/Simultaneo y alternancia/Alternancia_2.c"
bit Flag01;
bit Flag02;
int AR1 = 0;
int AR2 = 0;

void main() {
 ADCON1 = 0x0F;

 TRISC = 0x03;
 TRISE = 0x00;

 PORTC = 0x00;
 PORTE = 0x00;

 LATC = 0x00;
 LATE = 0x00;

 do{

 if(RC0_bit == 1){
 Flag01 = 1;
 }


 if(Button(&PORTC, 1, 1, 1)){
 Flag02 = 1;
 }


 if(Flag01 && Button(&PORTC, 0, 1, 0)){

 if(AR1 > AR2){

 LATE = 0x02;
 }
 else{

 LATE = 0x01;
 }


 if(Flag02 && Button(&PORTC, 1, 1, 0)){

 LATE = 0x03;
 }
 }
 else{
 LATE = 0x00;
 }

 } while(1);

}
