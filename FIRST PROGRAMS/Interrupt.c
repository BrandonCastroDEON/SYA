#define LPLACA LATA.F4 // LED de la placa en A4
#define ACT1 LATA.F5 // Actuador 1 en A5
#define ACT2 LATE.F0 // Actuador 2 en R0
#define ACT3 LATE.F1 // Actuador 3 en R1
#define ACT4 LATE.F2 // Actuador 4 en R2
#define LATCH PORTC.F0 // Pastilla en C0

char toggle = 1;
unsigned int PORTC_READ;

void interrupt(){

PORTC;
IOCCF = 0x00;
PORTC_READ = PORTC;

     if(PIR0.IOCIF == 1){
     if(PORTC_READ == 0x01){
     LPLACA = 0;
     }
     IOCCF = 0x00;
     }
}

void main() {
     
     ADCON1 = 0x0F;

     ANSELC = 0;
     ANSELA = 0;

     TRISC = 0x01; // C0 y C1 quedan como entradas, los demas en salidas
     TRISA = 0x00; // Puerto A como salida
     
     PORTC = 0x00; // Dejamos C0 en linea alta
     PORTA = 0x10; // Dejamos A4 en linea alta y los demas en linea baja
     
     LATC = 0x00; // Dejamos el registro de C0 en linea alta
     LATA = 0x10; // Dejamos el registro de A4 en linea alta
     
     INTCON.IPEN = 0;
     INTCON.PEIE = 1;
     
     PIR0.IOCIF = 0;
     PIE0.IOCIE = 0;
     
     IOCCF = 0x00;
     IOCCP = 0xFF;
     IOCCN = 0xFF;
     INTCON.GIE = 1;
     
     WPUC = 0xFF;
     
     while(1){
          Delay_ms(10);
     }     

}