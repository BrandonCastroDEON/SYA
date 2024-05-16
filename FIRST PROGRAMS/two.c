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

bit flag01; // Bandera de pastilla 1
bit flag02; // Bandera de pastilla 2
long int AR1 = 0; // Registro del actuador 1
long int AR2 = 0; // Registro del actuador 2
unsigned int AR3 = 0; // Registro del actuador 3
unsigned int AR4 = 0; // Registro del actuador 4
long int stop = 0;
char multi; // Bandera para el MUX
char flags; // Banderas de control para el barrido del MUX

//******************************************************************************
// Declaracion de prototipos
//******************************************************************************

void InitMCU();
void InitInterrupt();
void blink();
void watchdog();
void MUX();

//******************************************************************************
// Secuencia de Interrupcion IOC (WIP)
//******************************************************************************

void interrupt(){

     if (TMR0IF_bit){
     TMR0H = 0xFF;
     TMR0L = 0xF7;  
          if(ACT1){
                    if(bool_interrupt){
                         LPLACA = 0;
                         AR1 = AR1 + 1;
                         bool_interrupt = FALSE;
                    }
          }
          if(ACT2){
                    if(bool_interrupt){
                         LPLACA = 0;
                         AR2 = AR2 + 1;
                         bool_interrupt = FALSE;
                    }
          }
     TMR0IF_bit = 0;
     }

     /*// Si el bit 4 (IOCIF) del registro PIR0 (Peripheral Interrupt Request) se detecta 
     if(PIR0.IOCIF){
          LPLACA = 0; // Apagar LED de la placa
          IOCCF = 0x00; // Se limpia el registro del Interrupt on Change on PortC Flag
     }*/

}

//******************************************************************************
// Programa principal
//******************************************************************************

void main() {

     InitMCU(); // Iniciamos la configuracion del MCU
     InitInterrupt(); // Iniciamos la configuracion del interrupt
     
     AR1 = 0;
     AR2 = 0;
     
     if(stop >= 80){
     ACT2 = ~ACT2;
     }
     
     // Ejecucion siempre
     while(1){
          watchdog(); // Iniciamos la rutina de polling para el estado de la bandera
          //blink();
          // Si detectamos la bandera de la pastilla
          if(flag01 == 1){ 
               MUX(); // Iniciamos la rutina del chequeo para el registro
               //LPLACA = 0; 
               // Switch para iniciar los actuadores segun el registro (tal vez cambiar a if)
               switch(multi){
                             case 0:
                                  ACT1 = ~ACT1;
                                  break;
                             case 1:
                                  ACT2 = ~ACT2;
                                  break;
               }
               /*if(bool_once){
                    ACT1 = ~ACT1;
                    AR1++;
                    bool_once = FALSE;
               }*/
               //blink(); // Mientras este activada la pastilla tenemos parpadeo
          }
          else{
               // Se apagan todos los actuadores
               ACT1 = 0;
               ACT2 = 0;
               ACT3 = 0;
               ACT4 = 0;
          }
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
               flag01 = 1; // Ponemos la bandera en 1 
          }
          break; // Rompemos el ciclo una vez se detecte que está en 1
     }     
}

//******************************************************************************
// Maquina de estados de los valores de registros
//******************************************************************************

void MUX(){
     // Ejecucion solo mientras la bandera sea 1
     if(AR2 > AR1){
          multi = 0;  
     }
     else{
          multi = 1;
     }

}

//******************************************************************************
// Rutina de parpadeo
//******************************************************************************

void blink(){
     // Ejecucion solo mientras la bandera este en 1
     while(flag01 == 1){
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
// Configuracion de bits para interrupcion IOC
//******************************************************************************

void InitInterrupt(){

     PIE0 = 0x10; // Registro Peripheral Interrupt Enable (Bit 4 IOCIE)
     IOCCF = 0x00; // Seteo en 0 el registro del Interrupt on Change on PORTC Flag
     IOCCN = 0x00; // Seteo en 0 el registro del Interrupt on Change on PORTC Flag
     IOCCP = 0x00; // Seteo en 0 el registro del Interrupt on Change on PORTC Flag
     T0CON0 = 0x90;
     T0CON1 = 0x46;
     TMR0H = 0xFF;
     TMR0L = 0xF7;
     INTCON = 0xC0; // Registro INTCON (Bit 7 y 6; GIE y PIE)
     TMR0IE_bit = 1;

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
     
     PORTC = 0x01; // Dejamos C0 en linea alta
     PORTA = 0x10; // Dejamos A4 en linea alta y los demas en linea baja
     PORTE = 0x00; // Puerto E en linea baja
     
     LATC = 0x01; // Dejamos el registro de C0 en linea alta
     LATE = 0x00; // Dejamos el registro del puerto E en linea baja 
     LATA = 0x10; // Dejamos el registro de A4 en linea alta
     
     /*AR1 = 0; // Seteo del registro del actuador 1
     AR2 = 0; // Seteo del registro del actuador 2
     AR3 = 0; // Seteo del registro del actuador 3
     AR4 = 0; // Seteo del registro del actuador 4*/
     
     bool_once = TRUE; // Seteo del estado de la variable de ejecucion de una sola vez
     bool_interrupt = TRUE;
     flag01 = 0; // Seteo de la bandera 1 en 0
     flag02 = 0;
     
}

// Magic. Do not touch.