bit Flag01; // Bandera 1
bit Flag02; // Bandera 2
bit OF; // Bandera de Overflow
unsigned short int AR1; // Registro actuador 1 0-255
unsigned short int AR2; // Registro actuador 2 0-255

void main(){

     ANSELA = 0; // Ponemos en modo digital al puerto A
     ANSELC = 0; // Ponemos en modo digital al puerto C
     ANSELE = 0; // Ponemos en modo digital al puerto E
     
     TRISC = 0x03; // Ponemos en modo entrada al pin C0 y C1, los demas quedan en salida
     TRISE = 0x00; // Ponemos en modo salida al puerto E
     TRISA = 0x00; // Ponemos en modo salida al puerto A
     
     PORTA = 0x00; // Ponemos en ceros al puerto A
     PORTE = 0x00; // Ponemos en ceros al puerto E
     PORTC = 0x00; // Ponemos en ceros al puerto C
     
     LATC = 0x00; // Ponemos en ceros el registro del puerto C
     LATE = 0x00; // Ponemos en ceros el registro del puerto E
     LATA = 0x00; // Ponemos en ceros el registro del puerto A
     
     AR1 = 1; // Reseteamos en cero el registro del actuador 1
     AR2 = 0; // Reseteamos en cero el registro del actuador 2
     
     // El registro del actuador 1 es mayor o igual a 255?
     if(AR1 >= 255){
          // Si
          OF = 1; // Ponemos la bandera de overflow en 1
          AR1 = 1; // Reseteamos el registro del actuador 1 en cero
          AR2 = 0; // Reseteamos el registro del actuador 2 en cero
     
     }
     // El registro del actuador 2 es mayor o igual a 255?
     else if(AR2 >= 255){
          // Si
          OF = 1; // Ponemos la bandera de overflow en 1
          AR1 = 1; // Reseteamos el registro del actuador 1 en cero
          AR2 = 0; // Reseteamos el registro del actuador 2 en cero
     
     }
     else{
          // No
          OF = 0; // Ponemos la bandera de overflow en 0
     
     }
     // Mientras que el pin cero en el puerto C esté en 0
     if(RC0_bit == 0){
          // Ponemos la bandera 1 en uno
          Flag01 = 1;
          RA4_bit = 1;
     
     }
     else{
     
          Flag01 = 0;
     
     }
     // Delay para corroborar el estado del pin
     Delay_ms(100);
     
     while(1){
          // La bandera 1 y el registro del actuador 1 es mayor al regist
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