;Nombre: PRACTICA1
;Autor: Juan Peer Cardoza Siu
;Fecha: 15 de enero del 2023
;IDE: MPLAB X IDE
;Version: v6.00
;Descripcion: El programa realiza corrimiento de 8 leds con retardo de 500ms, seguido de otro
;corrimiento con retardo 250ms. Inicia con pulso de boton y termina con otro pulso
    
PROCESSOR 18F57Q84
#include "Config_bits.inc" /*config statements should precede project file includes.*/
#include <xc.inc>
#include "Libreria_retardos.inc"
    
PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main
    
PSECT CODE
    
Main:
    CALL Config_OSC,1
    CALL Config_Port,1
 
Loop:
    BTFSC   PORTA,3,0    ;PORTA<3> = 0    Button press?
    GOTO    Led_off
    
Led_on:
    
    Corrimiento_impar:
    BANKSEL LATE
    BSF     LATE,0,1   ;LedImpar_on
    BANKSEL LATC
    BSF     LATC,0,1   ;Led1_on
    CALL    Delay_500ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BCF     LATC,0,1   ;led1_off
    CALL    Delay_500ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BSF     LATC,1,1   ;Led2_on
    CALL    Delay_500ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BCF     LATC,1,1   ;led2_off
    CALL    Delay_500ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BSF     LATC,2,1   ;Led3_on
    CALL    Delay_500ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BCF     LATC,2,1   ;led3_off
    CALL    Delay_500ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BSF     LATC,3,1   ;Led4_on
    CALL    Delay_500ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BCF     LATC,3,1   ;led4_off
    CALL    Delay_500ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BSF     LATC,4,1   ;Le5_on
    CALL    Delay_500ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BCF     LATC,4,1   ;led5_off
    CALL    Delay_500ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BSF     LATC,5,1   ;Le6_on
    CALL    Delay_500ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BCF     LATC,5,1   ;led6_off
    CALL    Delay_500ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BSF     LATC,6,1   ;Led7_on
    CALL    Delay_500ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BCF     LATC,6,1   ;led7_off
    CALL    Delay_500ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BSF     LATC,7,1   ;Led8_on
    CALL    Delay_500ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BCF     LATC,7,1   ;led8_off
    CALL    Delay_500ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BANKSEL LATE
    BCF     LATE,0,1    ;LedImpar_off
    
    Corrimiento_par:
    BSF     LATE,1,1    ;LedPar_on
    BANKSEL LATC
    BSF     LATC,0,1    ;Led1_on
    CALL    Delay_250ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BCF     LATC,0,1   ;led1_off
    CALL    Delay_250ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BSF     LATC,1,1   ;Led2_on
    CALL    Delay_250ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BCF     LATC,1,1   ;led2_off
    CALL    Delay_250ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BSF     LATC,2,1   ;Led3_on
    CALL    Delay_250ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BCF     LATC,2,1   ;led3_off
    CALL    Delay_250ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BSF     LATC,3,1   ;Led4_on
    CALL    Delay_250ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BCF     LATC,3,1   ;led4_off
    CALL    Delay_250ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BSF     LATC,4,1   ;Led5_on
    CALL    Delay_250ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BCF     LATC,4,1   ;led5_off
    CALL    Delay_250ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BSF     LATC,5,1   ;Led6_on
    CALL    Delay_250ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BCF     LATC,5,1   ;led6_off
    CALL    Delay_250ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BSF     LATC,6,1   ;Led7_on
    CALL    Delay_250ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BCF     LATC,6,1   ;led7_off
    CALL    Delay_250ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BSF     LATC,7,1   ;Led8_on
    CALL    Delay_250ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BCF     LATC,7,1   ;led8_off
    CALL    Delay_250ms
    BTFSS   PORTA,3,0
    GOTO    Led_off
    BANKSEL LATE
    BCF     LATE,1,1   ;LedPar_off
    GOTO    Led_on
    
Led_off:
    BANKSEL LATC
    CLRF    LATC,1     ;Todos los leds apagados
    CLRF    LATE,1     ;Led_impar y Led_par apagados
    BTFSS   PORTA,3,0
    GOTO    Led_off
    GOTO    Loop
       
Config_OSC:
    ;Configuracion del oscilador interno a una frecuencia de 4MHz
    BANKSEL OSCCON1
    MOVLW   0X60 ;seleccionamos el bloque del oscilador interno con un div:1
    MOVWF   OSCCON1,1
    MOVLW   0X02 ;seleccionamos una frecuencia de 4MHz
    MOVWF   OSCFRQ,1
    RETURN
 
Config_Port:  ;PORT-LAT-ANSEL-TRIS 
    BANKSEL PORTC
    CLRF    PORTC,1    ;PORTF = 0
    CLRF    LATC,1   ;LATF<3>  = 1   Led_off
    CLRF    ANSELC,1   ;ANSEL<7:0> = 0  Port F Digital
    CLRF    TRISC,1  ;TRISF<3> = 0   RF3 como salida
    SETF    WPUC,1     ;activamos la resistencia pull-up del pin RA3
    BANKSEL PORTE
    CLRF    PORTE,1
    CLRF    LATE,1
    BCF     ANSELE,0,1
    BCF     ANSELE,1,1
    BCF     TRISE,0,1    ;RE0 como salida
    BCF     TRISE,1,1    ;RE1 como salida
    BSF     WPUE,0,1     ;activamos reistencia pull-up de RE0
    BSF     WPUE,1,1     ;activamos reistencia pull-up de RE1
    ;Config button
    BANKSEL PORTA
    CLRF    PORTA,1      ;PortA<7:0> = 0
    CLRF    ANSELA,1     ;PortA digital
    BSF     TRISA,3,1    ;RA3 como entrada
    BSF     WPUA,3,1     ;activamos la resistencia pull-up del pin RA3    
    RETURN
    
    
END resetVect


