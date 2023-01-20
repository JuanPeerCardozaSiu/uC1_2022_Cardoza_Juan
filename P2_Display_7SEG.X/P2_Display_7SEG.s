;Nombre: PRACTICA2
;Autor: Juan Peer Cardoza Siu
;Fecha: 15 de enero del 2023
;IDE: MPLAB X IDE
;Version: v6.00
;Descripcion: El programa muestra en el display de 7 segmentos los numeros del 0 al 9 si el
;boton no esta presionado. Si lo esta muestra las letras de la A a la F.
    
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
    GOTO    Numeros

Letras:
    BTFSC   PORTA,3,0        ;si boton esta presionado salta
    GOTO    Loop             ;vuelve al bucle
    MOVLW   00010000B
    MOVWF   LATD,1           ;LetraA
    CALL    Delay_1s
    BTFSC   PORTA,3,0        ;si boton esta presionado salta
    GOTO    Loop             ;vuelve al bucle
    MOVLW   00000000B
    MOVWF   LATD,1           ;LetraB
    CALL    Delay_1s
    BTFSC   PORTA,3,0
    GOTO    Loop
    MOVLW   01100010B
    MOVWF   LATD,1           ;LetraC
    CALL    Delay_1s
    BTFSC   PORTA,3,0
    GOTO    Loop
    MOVLW   00000010B
    MOVWF   LATD,1           ;LetraD
    CALL    Delay_1s
    BTFSC   PORTA,3,0
    GOTO    Loop
    MOVLW   01100000B
    MOVWF   LATD,1           ;LetraE
    CALL    Delay_1s
    BTFSC   PORTA,3,0
    GOTO    Loop
    MOVLW   01110000B
    MOVWF   LATD,1           ;LetraF
    CALL    Delay_1s
    GOTO    Letras
    
Numeros:
    BTFSS   PORTA,3,0         ;si boton no esta presionado salta
    GOTO    Loop              ;vuelve al bucle
    MOVLW   00000010B
    MOVWF   LATD,1            ;Numero0
    CALL    Delay_1s
    BTFSS   PORTA,3,0         ;si boton no esta presionado salta   
    GOTO    Loop              ;vuelve al bucle
    MOVLW   10011110B         
    MOVWF   LATD,1            ;Numero1
    CALL    Delay_1s
    BTFSS   PORTA,3,0
    GOTO    Loop
    MOVLW   00100100B
    MOVWF   LATD,1            ;Numero2
    CALL    Delay_1s
    BTFSS   PORTA,3,0
    GOTO    Loop
    MOVLW   00001100B
    MOVWF   LATD,1            ;Numero3
    CALL    Delay_1s
    BTFSS   PORTA,3,0
    GOTO    Loop
    MOVLW   10011000B
    MOVWF   LATD,1            ;Numero4
    CALL    Delay_1s
    BTFSS   PORTA,3,0
    GOTO    Loop
    MOVLW   01001000B
    MOVWF   LATD,1            ;Numero5
    CALL    Delay_1s
    BTFSS   PORTA,3,0
    GOTO    Loop
    MOVLW   01000000B
    MOVWF   LATD,1            ;Numero6
    CALL    Delay_1s
    BTFSS   PORTA,3,0
    GOTO    Loop
    MOVLW   00011110B
    MOVWF   LATD,1            ;Numero7
    CALL    Delay_1s
    BTFSS   PORTA,3,0
    GOTO    Loop
    MOVLW   00000000B
    MOVWF   LATD,1            ;Numero8
    CALL    Delay_1s
    BTFSS   PORTA,3,0
    GOTO    Loop
    MOVLW   00001000B
    MOVWF   LATD,1            ;Numero9
    CALL    Delay_1s
    GOTO    Numeros
      
Config_OSC:
    ;Configuracion del oscilador interno a una frecuencia de 4MHz
    BANKSEL OSCCON1
    MOVLW   0X60 ;seleccionamos el bloque del oscilador interno con un div:1
    MOVWF   OSCCON1,1
    MOVLW   0X02 ;seleccionamos una frecuencia de 4MHz
    MOVWF   OSCFRQ,1 
    RETURN
 
Config_Port:  ;PORT-LAT-ANSEL-TRIS   LED:RF3, BUTTON:RA3
    BANKSEL PORTD
    CLRF    PORTD,1    ;PORTF = 0
    CLRF    LATD,1   ;LATF<3>  = 1   Led_off
    CLRF    ANSELD,1   ;ANSEL<7:0> = 0  Port F Digital
    CLRF    TRISD,1  ;TRISF<3> = 0   RF3 como salida
    SETF    WPUD,1
    
    ;Config button
    BANKSEL PORTA
    CLRF    PORTA,1      ;PortA<7:0> = 0
    CLRF    ANSELA,1     ;PortA digital
    BSF     TRISA,3,1    ;RA3 como entrada
    BSF     WPUA,3,1     ;activamos la resistencia pull-up del pin RA3
    RETURN

END resetVect



