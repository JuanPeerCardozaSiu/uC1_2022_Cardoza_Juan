;Nombre: P1_PARCIAL2
;Autor: Juan Peer Cardoza Siu
;Fecha: 30 de enero del 2023
;IDE: MPLAB X IDE
;Version: v6.00
;Descripcion: Programacion de interrupciones con prioridad con corrimiento de leds
    
PROCESSOR 18F57Q84
#include "CONFIG_BITS.inc"   /*config statements should precede project file includes.*/
#include <xc.inc>
    
PSECT resetVect,class=CODE,reloc=2
resetVect:
    GOTO Main
    
PSECT ISRVectLowPriority,class=CODE,reloc=2
ISRVectLowPriority:
    BTFSS   PIR1,0,0	; ¿Se ha producido la INT0?
    GOTO    Exit0
    BCF     PIR1,0,0    ; limpiamos el flag de INT0
    MOVLW   5
    MOVWF   contador3,0
Secuencia_Leds:
    BANKSEL LATC
    BSF	    LATC,0,1	
    BSF     LATC,7,1
    CALL    Delay_250ms,1
    BSF     LATC,1,1
    BSF     LATC,6,1
    CALL    Delay_250ms,1
    BSF	    LATC,2,1
    BSF	    LATC,5,1
    CALL    Delay_250ms,1
    BSF	    LATC,3,1
    BSF	    LATC,4,1
    CALL    Delay_250ms,1
    CLRF    LATC,1
    CALL    Delay_250ms,1
    BSF	    LATC,3,1	
    BSF     LATC,4,1
    CALL    Delay_250ms,1
    BSF	    LATC,2,1
    BSF	    LATC,5,1
    CALL    Delay_250ms,1
    BSF	    LATC,1,1
    BSF	    LATC,6,1
    CALL    Delay_250ms,1
    BSF	    LATC,0,1
    BSF	    LATC,7,1
    CALL    Delay_250ms,1
    CLRF    LATC,1
    CALL    Delay_250ms,1
    DECFSZ  contador3,1,0
    GOTO    Secuencia_Leds
Exit0:
    RETFIE

PSECT ISRVectHighPriority,class=CODE,reloc=2
ISRVectHighPriority:
    BTFSS   PIR6,0,0	; ¿Se ha producido la INT1?
    GOTO    Exit1
    BCF	    PIR6,0,0	; limpiamos el flag de INT1
Exit1:
    RETFIE

ISRVectHighPriority2:
    BTFSS   PIR10,0,0	; ¿Se ha producido la INT2?
    GOTO    Exit2
    BCF	    PIR10,0,0	; limpiamos el flag de INT2
Exit2:
    RETFIE

PSECT udata_acs
contador1:  DS 1	    
contador2:  DS 1
contador3:  DS 1

PSECT CODE    
Main:
    CALL    Config_OSC,1
    CALL    Config_Port,1
    CALL    Config_PPS,1
    CALL    Config_INT0_INT1_INT2,1
    BANKSEL LATF
    BTG     LATF,3,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    BTG     LATF,3,1
    CALL    Delay_250ms,1
    CALL    Delay_250ms,1
    GOTO    Main
    
    
Config_OSC:
    ;Configuracion del Oscilador Interno a una frecuencia de 4MHz
    BANKSEL OSCCON1
    MOVLW   0x60    ;seleccionamos el bloque del osc interno(HFINTOSC) con DIV=1
    MOVWF   OSCCON1,1 
    MOVLW   0x02    ;seleccionamos una frecuencia de Clock = 4MHz
    MOVWF   OSCFRQ,1
    RETURN
    
Config_Port:	
    ;Config UserLed
    BANKSEL PORTF
    CLRF    PORTF,1	
    BSF	    LATF,3,1
    CLRF    ANSELF,1	
    BCF	    TRISF,3,1
    ;Config button ext2
    CLRF    PORTF,1	
    BCF     ANSELF,2,1	
    BSF	    TRISF,2,1	
    BSF	    WPUF,2,1
    
    ;Config User Button
    BANKSEL PORTA
    CLRF    PORTA,1	
    CLRF    ANSELA,1	
    BSF	    TRISA,3,1	
    BSF	    WPUA,3,1
    
    ;Config Button ext1
    BANKSEL PORTB
    CLRF    PORTB,1	
    CLRF    ANSELB,1	
    BSF	    TRISB,4,1	
    BSF	    WPUB,4,1
    
    ;Config PORTC
    BANKSEL PORTC
    CLRF    PORTC,1	
    CLRF    LATC,1	
    CLRF    ANSELC,1	
    CLRF    TRISC,1
    RETURN
    
Config_PPS:
    ;Config INT0
    BANKSEL INT0PPS
    MOVLW   0x03
    MOVWF   INT0PPS,1	; INT0 --> RA3
    
    ;Config INT1
    BANKSEL INT1PPS
    MOVLW   0x0C
    MOVWF   INT1PPS,1	; INT1 --> RB4
    
    ;Config INT2
    BANKSEL INT2PPS
    MOVLW   0x2A
    MOVWF   INT2PPS,1	; INT2 --> RF2
    
    RETURN
    
;   Secuencia para configurar interrupcion:
;    1. Definir prioridades
;    2. Configurar interrupcion
;    3. Limpiar el flag
;    4. Habilitar la interrupcion
;    5. Habilitar las interrupciones globales
Config_INT0_INT1_INT2:
    ;Configuracion de prioridades
    BSF	INTCON0,5,0 ; INTCON0<IPEN> = 1 -- Habilitamos las prioridades
    BANKSEL IPR1
    BCF	IPR1,0,1    ; IPR1<INT0IP> = 0 -- INT0 de baja prioridad
    BSF	IPR6,0,1    ; IPR6<INT1IP> = 1 -- INT1 de alta prioridad
    BSF IPR10,0,1   ; IPR10<INT2IP> = 1 -- INT2 de alta prioridad
    
    ;Config INT0
    BCF	INTCON0,0,0 ; INTCON0<INT0EDG> = 0 -- INT0 por flanco de bajada
    BCF	PIR1,0,0    ; PIR1<INT0IF> = 0 -- limpiamos el flag de interrupcion
    BSF	PIE1,0,0    ; PIE1<INT0IE> = 1 -- habilitamos la interrupcion ext0
    
    ;Config INT1
    BCF	INTCON0,1,0 ; INTCON0<INT1EDG> = 0 -- INT1 por flanco de bajada
    BCF	PIR6,0,0    ; PIR6<INT1IF> = 0 -- limpiamos el flag de interrupcion
    BSF	PIE6,0,0    ; PIE6<INT1IE> = 1 -- habilitamos la interrupcion ext1
    
    ;Config INT2
    BCF	INTCON0,2,0 ; INTCON0<INT2EDG> = 0 -- INT2 por flanco de bajada
    BCF	PIR10,0,0    ; PIR10<INT2IF> = 0 -- limpiamos el flag de interrupcion
    BSF	PIE10,0,0    ; PIE10<INT2IE> = 1 -- habilitamos la interrupcion ext2
    
    ;Habilitacion de interrupciones
    BSF	INTCON0,7,0 ; INTCON0<GIE/GIEH> = 1 -- habilitamos las interrupciones de forma global y de alta prioridad
    BSF	INTCON0,6,0 ; INTCON0<GIEL> = 1 -- habilitamos las interrupciones de baja prioridad
    RETURN

Delay_250ms:		    ; 2Tcy -- Call
    MOVLW   250		    ; 1Tcy -- k2
    MOVWF   contador2,0	    ; 1Tcy
; T = (6 + 4k)us	    1Tcy = 1us
Ext_Loop:		    
    MOVLW   249		    ; 1Tcy -- k1
    MOVWF   contador1,0	    ; 1Tcy
Int_Loop:
    NOP			    ; k1*Tcy
    DECFSZ  contador1,1,0   ; (k1-1)+ 3Tcy
    GOTO    Int_Loop	    ; (k1-1)*2Tcy
    DECFSZ  contador2,1,0
    GOTO    Ext_Loop
    RETURN		    ; 2Tcy

End resetVect