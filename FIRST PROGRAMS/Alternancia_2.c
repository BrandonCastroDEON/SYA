bit Flag01; // Primera bandera del sensor 1
bit Flag02; // Segunda bandera del sensor 2
int AR1 = 0; // Registro de la bomba 1
int AR2 = 0; // Registro de la bomba 2

void main() {
     ADCON1 = 0x0F; // Ponemos los pines en modo digital
     
     TRISC = 0x03; // Indicamos que C0 y C1 en el puerto C quedan en modo entrada, los demas en modo salida
     TRISE = 0x00; // Indicamos que el puerto E queda en modo salida
     
     PORTC = 0x00; // Ponemos al puerto C en ceros
     PORTE = 0x00; // Ponemos al puerto E en ceros
     
     LATC = 0x00; // Establecemos en cero el registro del puerto C
     LATE = 0x00; // Establecemos en cero el registro del puerto E
     
     do{
        // El Sensor 1 detectó cambio a linea alta (suponiendo que la linea este en nivel bajo)
        if(RC0_bit == 1){
             Flag01 = 1; //Ponemos en 1 la bandera de que el sensor 1 fue activado
        }
        
        // El Sensor 2 detectó cambio a linea alta (suponiendo que la linea este en nivel bajo)
        if(Button(&PORTC, 1, 1, 1)){
             Flag02 = 1; // Ponemos en 1 la bandera de que el sensor 2 fue activado
        }
        
        // Si detectamos que la bandera del Sensor 1 esta activada y tenemos una transicion a cero
        if(Flag01 && Button(&PORTC, 0, 1, 0)){
             // Si el contador del registro BR1 es mayor a BR2 entonces
             if(AR1 > AR2){
                  // Encendemos el actuador 02
                  LATE = 0x02;
             }
             else{
                  // Si no, encendemos el actuador 01
                  LATE = 0x01;
             }
             
             // Si detectamos que la bandera del Sensor 2 esta activada y tenemos una transicion a cero 
             if(Flag02 && Button(&PORTC, 1, 1, 0)){
                  // Encendemos todos los actuadores
                  LATE = 0x03;
             }
        }
        else{
              LATE = 0x00; // Apagamos todos los actuadores 
        }
             
     } while(1);
     
}                                     