#define LPLACA LATA.F4 // LED de la placa en A4
#define ACT1 LATA.F5 // Actuador 1 en A5
#define ACT2 LATE.F0 // Actuador 2 en R0
#define ACT3 LATE.F1 // Actuador 3 en R1
#define ACT4 LATE.F2 // Actuador 4 en R2
#define LATCH PORTC.F0 // Pastilla en C0

long int cuenta = 0;

void InitInterrupt();

void interrupt(){

     // Interrupción TMR0
     if (PIR0.TMR0IF){
          TMR0L = 0x3B;                              // Se carga la cuenta inicial en 65285 para 1ms.
          TMR0H = 0xF6;                              // ''  
          cuenta++;
          if(LATCH){ 
          if(cuenta >= 100){
               ACT1 = ~ACT1;
          }
          cuenta = 0;
          }
          PIR0.TMR0IF = 0;                           // Reinicio de la bandera del bit de interrupción.
     }

}

void main() {

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

     InitInterrupt();

}

void InitInterrupt(){

     INTCON = 0xC0;
     // TMR0 16bits
     T0CON0 = 0x90;                                        // Timer0 Enable - Timer de 16 bits
     T0CON1 = 0x46;                                        // Clock Source Fosc/4 - Prescaler 64
     PIE0 = 0x20;                                          // TMR0 Enable Interrupt
     TMR0L = 0x3B;                                         // La cuenta inicia en 65285 para 1ms, Prescaler 64
     TMR0H = 0xF6;                                         // ''

}