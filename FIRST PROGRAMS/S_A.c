bit Flag01; // Primera bandera del sensor 1
bit Flag02; // Segunda bandera del sensor 2
unsigned int AR1 = 1; // Registro del actuador 1
unsigned int AR2 = 0; // Registro del actuador 2

void main() {    

     ADCON1 = 0x0F; // Desactivamos los niveles TTL del PIC
     
     ANSELC = 0; // Ponemos los pines del puerto C en modo digital
     ANSELE = 0; // Ponemos los pines del puerto E en modo digital
     ANSELA = 0; // Ponemos los pines del puerto A en modo digital
     
     TRISC = 0x03; // Indicamos que C0 y C1 en el puerto C quedan en modo entrada, los demas en modo salida
     TRISE = 0x00; // Indicamos que el puerto E queda en modo salida
     TRISA = 0x00; // Indicamos que el puerto A queda en modo salida
     
     PORTC = 0x00; // Ponemos al puerto C en ceros
     PORTE = 0x00; // Ponemos al puerto E en ceros
     PORTA = 0x00; // Ponemos al puerto A en ceros
                                                                    
     LATC = 0x00; // Establecemos en cero el registro del puerto C
     LATE = 0x00; // Establecemos en cero el registro del puerto E
     LATA = 0x00; // Establecemos en cero el registro del puerto A
     
     AR1 = 0; // Reiniciamos los registros del actuador 1 en cero
     AR2 = 0; // Reiniciamos los registros del actuador 2 en cero
     
     do{
     
        // El Sensor 1 detectó cambio a linea alta (suponiendo que la linea este en nivel alto)
        if(RC0_bit == 0){
             Flag01 = 1; // Ponemos en 1 la bandera si el sensor 1 fue activado
             //RA4_bit = 1; // LED de Debug
        }
        // El Sensor 1 detectó cambio a linea baja (suponiendo que la linea este en nivel alto)
        else if(RC0_bit == 1){
             Flag01 = 0; // Ponemos en 0 la bandera si el sensor 1 fue desactivado
             //RA4_bit = 1; // LED de Debug
        }
        
        // El Sensor 2 detectó cambio a linea alta (suponiendo que la linea este en nivel alto)
        if(RC1_bit == 0){
             Flag02 = 1; // Ponemos en 1 la bandera si el sensor 2 fue activado
             //RA4_bit = 1; // LED de Debug
        }
        // El Sensor 2 detectó cambio a linea baja (suponiendo que la linea este en nivel alto)
        else if(RC1_bit == 1){
             Flag02 = 0; // Ponemos en 0 la bandera si el sensor 2 fue desactivado
             //RA4_bit = 1; // LED de Debug
        }
        
        /*if(AR1 > AR2){
             RA4_bit = 1; // LED de Debug
        }*/
        
        Delay_ms(100); // Delay de 100 ms para que el cambio en la bandera sea hecho
        
        // Si detectamos que la bandera del Sensor 1 esta activada y tenemos una transicion a cero
        if(Flag01 = 1 && RC0_bit == 0){
        
             // Si el contador del registro BR1 es mayor a BR2 entonces
             if(AR1 > AR2){
             
                  // Encendemos el actuador 02
                  LATE = 0x02;
                  AR2 = AR2 + 1; // Incrementamos en 1 el contador del actuador 2
                  //RA4_bit = 1; // LED de Debug
                  Flag01 = 0;
                  Delay_ms(100);
                  
             }
             
             else{
             
                  // Si no, encendemos el actuador 01
                  LATE = 0x01;
                  AR1 = AR1 + 1; // Incrementamos en 1 el contador del actuador 1
                  RA4_bit = 1; // LED de Debug
                  Flag01 = 0;
                  Delay_ms(100);
                  
             }
             
             // Si detectamos que la bandera del Sensor 2 esta activada y tenemos una transicion a cero 
             if(Flag02 = 1 && RC1_bit == 0){
             
                  // Encendemos todos los actuadores
                  LATE = 0x03;
                  //RA4_bit = 1; // LED de Debug
                  AR1 = AR1 + 1; // Incrementamos en 1 el contador del actuador 1
                  AR2 = AR2 + 1; // Incrementamos en 1 el contador del actuador 2
                  
             }
             // Si detectamos que la bandera del Sensor 2 esta desactivada y tenemos una transicion a uno                                                    
             else if(Flag02 = 0 && RC1_bit == 1){
                  // Si el registro del actuador 1 es mayor que el registro del actuador 2 entonces
                  if(AR1 > AR2){
                       // El actuador 2 es encendido
                       LATE = 0x02;
                       //RA4_bit = 1; // LED de Debug
                       AR2 = AR2 + 1; // Se le suma 1 al contador del registro del actuador 2
                       
                  }
                  // Si no
                  else{
                       // El actuador 1 es encendido
                       LATE = 0x01;
                       //RA4_bit = 1; // LED de Debug
                       AR1 = AR1 + 1; // Se le suma 1 al contador del registro del actuador 1
                  
                  }
                  
             }
             
        }
        // Si detectamos que la bandera del Sensor 1 esta desactivada y tenemos una transicion a uno
        else if (Flag01 = 0 && RC0_bit == 1){
             // Apagamos todos los actuadores
             LATE =  0x00;
             Flag01 = 0;
             //RA4_bit = 1; // LED de Debug
             
        }
       
     } while(1);
     
}