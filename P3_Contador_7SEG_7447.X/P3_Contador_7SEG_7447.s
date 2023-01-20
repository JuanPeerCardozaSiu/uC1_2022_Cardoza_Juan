;Nombre: PRACTICA3
;Autor: Juan Peer Cardoza Siu
;Fecha: 15 de enero del 2023
;IDE: MPLAB X IDE
;Version: v6.00
;Descripcion: Si el boton no esta presionado los display muestran muestran los numeros del 0 al 99 en forma ascendente.
;Si el boton esta presionado se muestran los numeros del 99 al 0 de forma descendente. Los display son controlados por 
;dos decodificadores BCD 74LS47.
    
PROCESSOR 18F57Q84
#include "CONFIG_BITS.inc" /*config statements should precede project file includes.*/
#include <xc.inc>
#include "LIBRERIA_RETARDOS.inc"

PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main
    
PSECT CODE
    
Main:
    CALL Config_OSC,1
    CALL Config_Port,1
    
Loop:
    BTFSC   PORTA,3,0    ;PORTA<3> = 0    Button press?
    GOTO    Ascendente_Decenas

Descendente_Decenas:
    MOVLW   9
    MOVWF   LATD,1
Descendente_Unidades:
    MOVLW   9
    MOVWF   LATB,1
    CALL    Delay_1s
Loop_Descendente:
    BTFSC   PORTA,3,0
    GOTO    Loop_Ascendente
    DECF    LATB,1,1
    CALL    Delay_1s
    MOVLW   0
    CPFSEQ  LATB,1
    GOTO    Loop_Descendente
    DECF    LATD,1
    MOVLW   -1
    CPFSEQ  LATD,1
    GOTO    Descendente_Unidades
    GOTO    Descendente_Decenas
    
Ascendente_Decenas:
    MOVLW   0
    MOVWF   LATD,1
Ascendente_Unidades:
    MOVLW   0
    MOVWF   LATB,1
    CALL    Delay_1s
Loop_Ascendente:
    BTFSS   PORTA,3,0
    GOTO    Loop_Descendente
    INCF    LATB,1,1
    CALL    Delay_1s
    MOVLW   9
    CPFSEQ  LATB,1
    GOTO    Loop_Ascendente
    INCF    LATD,1
    MOVLW   9
    CPFSGT  LATD,1
    GOTO    Ascendente_Unidades
    GOTO    Ascendente_Decenas
      
Config_OSC:
    ;Configuracion del oscilador interno a una frecuencia de 4MHz
    BANKSEL OSCCON1
    MOVLW   0X60 ;seleccionamos el bloque del oscilador interno con un div:1
    MOVWF   OSCCON1,1
    MOVLW   0X02 ;seleccionamos una frecuencia de 4MHz
    MOVWF   OSCFRQ,1 
    RETURN
 
Config_Port:  ;PORT-LAT-ANSEL-TRIS   LED:RF3, BUTTON:RA3
    BANKSEL PORTB
    CLRF    PORTB,1    ;PORTB = 0
    CLRF    LATB,1     ;LATB = 1   Led_off
    CLRF    ANSELB,1   ;ANSEL<7:0> = 0  Port B Digital
    CLRF    TRISB,1    ;TRISF = 0   PortB como salida
    SETF    WPUB,1     ;activamos resistencias pull-up del puerto B
    BANKSEL PORTD
    CLRF    PORTD,1    ;PORTD = 0  
    CLRF    LATD,1     ;LATD = 1   Led_off
    CLRF    ANSELD,1   ;ANSEL<7:0> = 0  Port D Digital 
    CLRF    TRISD,1    ;TRISF = 0   PortD como salida
    SETF    WPUD,1     ;activamos resistencias pull-up del puerto D
    
    ;Config button
    BANKSEL PORTA
    CLRF    PORTA,1      ;PortA<7:0> = 0
    CLRF    ANSELA,1     ;PortA digital
    BSF     TRISA,3,1    ;RA3 como entrada
    BSF     WPUA,3,1     ;activamos la resistencia pull-up del pin RA3
    RETURN

END resetVect


