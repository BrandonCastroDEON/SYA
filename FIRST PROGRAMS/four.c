#define LPLACA LATA.F4 // LED de la placa en A4
#define ACT1 LATA.F5 // Actuador 1 en A5
#define ACT2 LATE.F0 // Actuador 2 en R0
#define ACT3 LATE.F1 // Actuador 3 en R1
#define ACT4 LATE.F2 // Actuador 4 en R2
#define LATCH PORTC.F0 // Pastilla en C0
#define TRUE 1
#define FALSE 0
#define bool_once flags.f0
#define bool_interrupt flags.f1

//******************************************************************************
// Declaracion de variables
//******************************************************************************

bit flag_switch; // Bandera de pastilla 1
bit flag_A1;
bit flag_A2;
bit flag02; // Bandera de pastilla 2
long int AR1; // Registro del actuador 1
long int AR1P;
long int AR2; // Registro del actuador 2
long int AR2P;
unsigned int AR3 = 0; // Registro del actuador 3
unsigned int AR4 = 0; // Registro del actuador 4
long int stop = 0;
char multi; // Bandera para el MUX
char flags; // Banderas de control para el barrido del MUX

//******************************************************************************
// Declaracion de prototipos
//******************************************************************************

void InitMCU(); // Setup MCU
void InitInterrupt(); // Setup interrupciones
void blink(); // Debug
void watchdog(); // Funcion observadora
void SM(); // Maquina de estados (WIP)
void RMUX(); // Registro del multiplexor (WIP)

//******************************************************************************
// Programa principal
//******************************************************************************

void main() {

     InitMCU(); // Inicio MCU (seteo de pines y registros de bits)
     InitInterrupt();            
     bool_once = TRUE; // Seteo del estado de la variable de ejecucion de una sola vez
     
     while(1){
          watchdog(); // Inicio de la funcion observadora
          Delay_ms(20);
          //RMUX();
          // Bandera de switch y switch en valor de 0?
          if((flag_switch == 1) && (LATCH == 0)){
               // Si y el registro historico del actuador 1 es mayor al actuador 2?
               if(AR1P > AR2P){
                    ACT2 = 1; // Si, entonces enciende actuador 2
                    AR2 = AR2P + 1; // Se suma el registro historico mas 1 al registro actual
               }
               // Si y el registro historico del actuador 2 es mayor al actuador 1?
               else if(AR1P < AR2P){
                    ACT1 = 1; // Si, entonces enciende actuador 1
                    AR1 = AR1P + 1; // Se suma el registro historico mas 1 al registro actual
               }
               // Si, y si tenemos que el registro historico es igual al registro actual
               if(AR1P == AR1){
                    LPLACA = ~LPLACA; // Cambia de estado al LED de la placa
               }
          }
          // Si no
          else{
               ACT1 = 0;   // Apagamos todos los actuadores
               ACT2 = 0;
               AR1P = AR1; // Registramos el valor del registro actual en el registro historico
               AR2P = AR2;
               AR1 = 0;    // Reiniciamos los registros actuales de los actuadores
               AR2 = 0;
          }
     }

}

//******************************************************************************
// Registro del MUX (WIP)
//******************************************************************************

void RMUX(){
     // Loop infinito
     while(1){
     // Si el registro actual es mayor al registro historico
     if(AR1 > AR1P){
          flag_A1 = 1; // Ponemos una bandera para el actuador 1
          AR1P = 0; // Reiniciamos el registro historico del actuador 1
     }               
     if(AR2 > AR2P){
          flag_A2 = 1; // Ponemos una bandera para el actuador 2
          AR2P = 0; // Reiniciamos el registro historico del actuador 2
     }
     break; // Rompemos una vez ya se haya completado
     }

}

//******************************************************************************
// Maquina de estados (WIP)
//******************************************************************************

void SM(){
     // Si tenemos que el actuador 1 esta encendido
     if(ACT1){
          // Ejecutamos una sola vez
          if(bool_once){
               AR1++; // Aumentamos el registro del actuador 1
               ACT3 = ~ACT3; // Cambiamos de estado el actuador 3
               bool_once = FALSE; // Terminamos la ejecucion
          }
     }
     // Si tenemos que el actuador 2 esta encendido
     if(ACT2){
          // Ejecutamos una sola vez
          if(bool_once){
               AR2++; // Aumentamos el registro del actuador 2
               ACT4 = ~ACT4; // Cambiamos de estado el actuador 4
               bool_once = FALSE; // Terminamos la ejecucion
          }
     }

}

//******************************************************************************
// Rutina de parpadeo
//******************************************************************************

void blink(){
     // Ejecucion solo mientras la bandera este en 1
     while(flag_switch){
          char i;
          // Parpadeo de 4 cambios de estado a 50ms
          for(i = 0; i < 4; i++){
               LPLACA = ~LPLACA; // Cambio de estado del LED de la placa
               Delay_ms(50);
          }
          break;
     }

}

//******************************************************************************
// Rutina de verificacion del estado de la pastilla
//******************************************************************************

void watchdog(){
     // Ejecucion siempre 
     while(1){
          // Si tenemos que es 1 seguimos al siguiente estado (Logica Inversa)
          if(1 == LATCH)continue;
          // Si tenemos que es 0
          if(0 == LATCH){
               Delay_ms(50);
               flag_switch = 1; // Ponemos la bandera en 1
               //LPLACA = ~LPLACA; 
          }
          break; // Rompemos el ciclo una vez se detecte que est� en 1
     }     
}

//******************************************************************************
// Configuracion de bits para interrupcion IOC
//******************************************************************************

void InitInterrupt(){

     PIE0 = 0x10; // Registro Peripheral Interrupt Enable (Bit 4 IOCIE)
     IOCCF = 0x00; // Seteo en 0 el registro del Interrupt on Change on PORTC Flag
     IOCCN = 0x00; // Seteo en 0 el registro del Interrupt on Change on PORTC Flag
     IOCCP = 0x00; // Seteo en 0 el registro del Interrupt on Change on PORTC Flag
     /*T0CON0 = 0x90; // Enable del Timer 0
     T0CON1 = 0x46; // Enable Timer 0 16 bits
     TMR0H = 0xFF; 
     TMR0L = 0xF7;*/
     INTCON = 0xC0; // Registro INTCON (Bit 7 y 6; GIE y PIE)
     //TMR0IE_bit = 1;

}

//******************************************************************************
// Configuracion general del MCU
//******************************************************************************

void InitMCU(){
     
     ADCON1 = 0x0F; // Desactivamos los valores TTL para el PIC
     
     ANSELC = 0; // Puerto A en digital
     ANSELE = 0; // Puerto E en digital
     ANSELA = 0; // Puerto A en digital
     
     TRISC = 0x03; // C0 y C1 quedan como entradas, los demas en salidas
     TRISE = 0x00; // Puerto E como salida
     TRISA = 0x00; // Puerto A como salida
     
     PORTC = 0x00; // Dejamos C0 en linea alta
     PORTA = 0x10; // Dejamos A4 en linea alta y los demas en linea baja
     PORTE = 0x00; // Puerto E en linea baja
     
     LATC = 0x00; // Dejamos el registro de C0 en linea alta
     LATE = 0x00; // Dejamos el registro del puerto E en linea baja 
     LATA = 0x10; // Dejamos el registro de A4 en linea alta
     
     /*AR1 = 0; // Seteo del registro del actuador 1
     AR2 = 0; // Seteo del registro del actuador 2
     AR3 = 0; // Seteo del registro del actuador 3
     AR4 = 0; // Seteo del registro del actuador 4*/
     
     bool_interrupt = TRUE;
     flag_switch = 0; // Seteo de la bandera 1 en 0
     
}