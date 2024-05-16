#line 1 "C:/Users/USER/Downloads/Simultaneo y alternancia/one.c"










bit Flag01;
bit Flag02;
unsigned short int AR1 = 0;
unsigned short int AR2 = 0;
unsigned int RC0_READ;
unsigned int Reg01 = 0;
int i = 0;
int k = 0;
int cuenta = 0;
char flags;

void InitMCU();
void InitInterrupt();
void interrupt();
void blink();

void blink(){
 char i;
 for(i=0;i<4;i++){
  PORTA.RA4  = ~ PORTA.RA4 ;
 Delay_ms(80);
 }
}

void interrupt(){
 char tmp;
 PORTC;
 IOCIF_bit = 0;
 RC0_READ = PORTC;
 RC0_READ = RC0_READ >> 7;

  PORTA.RA5  = 1;
#line 56 "C:/Users/USER/Downloads/Simultaneo y alternancia/one.c"
}

void InitMCU(){

 ADCON1 = 0x0F;

 ANSELC = 0;
 ANSELE = 0;
 ANSELA = 0;

 TRISC = 0x03;
 TRISE = 0x00;
 TRISA = 0x00;

 PORTC = 0x00;
 PORTE = 0x00;
 PORTA = 0x10;

 LATC = 0x00;
 LATE = 0x00;
 LATA = 0x10;

  flags.f0  =  1 ;

}

void InitInterrupt(){
 PIE0.IOCIE = 1;
 PIR0.IOCIF = 0;
 IOCCP0_bit = 0;
 IOCCF0_bit = 0;
 GIE_bit = 1;
}

void main() {

 InitMCU();
 InitInterrupt();

 blink();

 do{
 Delay_ms(10);
 }while(1);
#line 109 "C:/Users/USER/Downloads/Simultaneo y alternancia/one.c"
}
