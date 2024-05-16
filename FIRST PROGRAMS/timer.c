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
bit flag01;
bit flag02; // Bandera de pastilla 2
bit estado;
long int AR1; // Registro del actuador 1
long int AR1P;
long int AR2; // Registro del actuador 2
long int AR2P;
unsigned int AR3 = 0; // Registro del actuador 3
unsigned int AR4 = 0; // Registro del actuador 4
int cuenta = 0;
long int stop = 0;
char multi; // Bandera para el MUX
char flags; // Banderas de control para el barrido del MUX

void InitMCU();
void InitInterrupt();

void interrupt(){

     if(PIR0.TMR0IF){  
          TMR0H = 0xE1;
          TMR0L = 0x7A;
          
          if(LATCH){
               cuenta++;
               if(cuenta >= 50){
                    flag01 = 1;
                    cuenta = 0; 
               }
          }
          PIR0.TMR0IF = 0;
     }

}

void main() {

     InitMCU();
     InitInterrupt();
     flag01 = 0;                 
     cuenta = 0;
     
     while(1){
          estado = 0;   
          if(flag01){
               estado++;
               estado = estado << 1;
               if((estado == 0xf0000) && (LATCH == 1)){
                    flag02 = 1;
                    LPLACA = ~LPLACA;
               }
               else{
                    flag02 = 0;
               }
          }
          if(flag02){
               ACT1 = ~ACT1;
               ACT2 = ~ACT2;
               ACT3 = ~ACT3;
               ACT4 = ~ACT4;
          }
          else{             
               ACT1 = 0;
               ACT2 = 0;
               ACT3 = 0;
               ACT4 = 0;
          }
     }

}

void InitInterrupt(){

     T0CON0 = 0x90;
     T0CON1 = 0x46;     
     PIE0.TMR0IE = 1;
     TMR0H = 0xE1;
     TMR0L = 0x7A;      

     INTCON = 0xC0;

}

void InitMCU(){
     
     ADCON1 = 0x0F; // Desactivamos los valores TTL para el PIC
     
     ANSELC = 0; // Puerto A en digital
     ANSELE = 0; // Puerto E en digital
     ANSELA = 0; // Puerto A en digital
     
     TRISC = 0x03; // C0 y C1 quedan como entradas, los demas en salidas
     TRISE = 0x00; // Puerto E como salida
     TRISA = 0x00; // Puerto A como salida
     
     PORTC = 0x00; // Dejamos C0 en linea alta
     PORTA = 0x00; // Dejamos A4 en linea alta y los demas en linea baja
     PORTE = 0x00; // Puerto E en linea baja
     
     LATC = 0x00; // Dejamos el registro de C0 en linea alta
     LATE = 0x00; // Dejamos el registro del puerto E en linea baja 
     LATA = 0x00; // Dejamos el registro de A4 en linea alta
}