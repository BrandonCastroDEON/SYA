#define LED PORTA.RA4
#define A1 PORTE.RE0
#define A2 PORTE.RE1

bit flag01;
bit flag02;
int i=0;
short unsigned int AR1 = 0;
short unsigned int AR2 = 1;

void InitPIC();
void watch();

void InitPIC() {

     ADCON1 = 0x0F;
     
     ANSELC = 0; // Ponemos los pines del puerto C en modo digital
     ANSELE = 0; // Ponemos los pines del puerto E en modo digital
     ANSELA = 0; // Ponemos los pines del puerto A en modo digital
     
     TRISC = 0x03; // Indicamos que C0 y C1 en el puerto C quedan en modo entrada, los demas en modo salida
     TRISE = 0x00; // Indicamos que el puerto E queda en modo salida
     TRISA = 0x00; // Indicamos que el puerto A queda en modo salida
     
     PORTC = 0x00; // Ponemos al puerto C en ceros
     PORTE = 0x00; // Ponemos al puerto E en ceros
     PORTA = 0x10; // Ponemos al puerto A en ceros
     
     LATC = 0x00; // Establecemos en cero el registro del puerto C
     LATE = 0x00; // Establecemos en cero el registro del puerto E
     LATA = 0x10; // Establecemos en cero el registro del puerto A
     flag01 = 0;
     
}

void watch(){

     /*while(RC0_bit){
          flag01 = 1;
          if(RC0_bit == 0){
               flag01 = 0;
               break;
          }continue;
     }*/

     if(RC0_bit){
          flag01 = 1;
     }

}

void main(){

     InitPIC();
     watch();
     
     if(flag01){
          A1 = 1;
     }
     
     while(A1==1){
          AR1 = AR1 + 1;
          break;
     }
     
     if(AR1 <= 5){
            LED = 0;
            Delay_ms(100);
            LED = 1;
            Delay_ms(100);
     }
     else{
          LED = 0;
     }
     
     /*if(flag01 && AR1 < AR2){
          RE0_bit = 1;
          AR1++;
          
          RA4_bit = 0;
          Delay_ms(100);
          RA4_bit = 1;
          Delay_ms(100);   
     }
     else if(flag01 && AR1 > AR2){
          RE1_bit = 1;
          AR2++;
          
          RA4_bit = 0;
          Delay_ms(200);
          RA4_bit = 1;
          Delay_ms(200);
     }*/
}