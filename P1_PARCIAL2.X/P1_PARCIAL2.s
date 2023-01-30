;Nombre: P2_PARCIAL2
;Autor: Juan Peer Cardoza Siu
;Fecha: 30 de enero del 2023
;IDE: MPLAB X IDE
;Version: v6.00
;Descripcion: Programacion de interrupciones con prioridad con generacion de señal cuadrada
    
PROCESSOR 18F57Q84
#include "CONFIG_BITS.inc"   /*config statements should precede project file includes.*/
#include <xc.inc>
    
PSECT resetVect,class=CODE,reloc=2
resetVect:
    GOTO Main
    
PSECT ISRVectLowPriority,class=CODE,reloc=2
ISRVectLowPriority:
    BTFSS   PIR1,0,0	; ¿Se ha producido la INT1?
    GOTO    Exit0
    MOVLW   10
    MOVWF   N,0
Senal_cuadrada:
    BCF	    PIR1,0,0	; limpiamos el flag de INT1
    BANKSEL LATB
    BSF     LATB,0,1
    CALL    Delay_10ms,1
    BCF     LATB,0,1
    CALL    Delay_10ms,1
Division10:
    MOVLW   10
    CPFSEQ  N,0
    GOTO    Division9
    BSF     LATB,0,1
    CALL    Delay_1ms,1
    BCF     LATB,0,1
    CALL    Delay_1ms,1
    GOTO    Senal_cuadrada
Division9:
    MOVLW   9
    CPFSEQ  N,0
    GOTO    Division8
    BSF     LATB,0,1
    CALL    Delay_1ms,1
    CALL    Delay_100us,1
    BCF     LATB,0,1
    CALL    Delay_1ms,1
    CALL    Delay_100us,1
    GOTO    Senal_cuadrada
Division8:
    MOVLW   8
    CPFSEQ  N,0
    GOTO    Division7
    BSF     LATB,0,1
    CALL    Delay_1ms,1
    CALL    Delay_250us,1
    BCF     LATB,0,1
    CALL    Delay_1ms,1
    CALL    Delay_250us,1
    GOTO    Senal_cuadrada
Division7:
    MOVLW   7
    CPFSEQ  N,0
    GOTO    Division6
    BSF     LATB,0,1
    CALL    Delay_1ms,1
    CALL    Delay_200us,1
    CALL    Delay_200us,1
    BCF     LATB,0,1
    CALL    Delay_1ms,1
    CALL    Delay_200us,1
    CALL    Delay_200us,1
    GOTO    Senal_cuadrada
Division6:
    MOVLW   6
    CPFSEQ  N,0
    GOTO    Division5
    BSF     LATB,0,1
    CALL    Delay_1ms,1
    CALL    Delay_500us,1
    CALL    Delay_100us,1
    BCF     LATB,0,1
    CALL    Delay_1ms,1
    CALL    Delay_500us,1
    CALL    Delay_100us,1
    GOTO    Senal_cuadrada
Division5:
    MOVLW   5
    CPFSEQ  N,0
    GOTO    Division4
    BSF     LATB,0,1
    CALL    Delay_1ms,1
    CALL    Delay_1ms,1
    BCF     LATB,0,1
    CALL    Delay_1ms,1
    CALL    Delay_1ms,1
    GOTO    Senal_cuadrada
Division4:
    MOVLW   4
    CPFSEQ  N,0
    GOTO    Division3
    BSF     LATB,0,1
    CALL    Delay_1ms,1
    CALL    Delay_1ms,1
    CALL    Delay_500us,1
    BCF     LATB,0,1
    CALL    Delay_1ms,1
    CALL    Delay_1ms,1
    CALL    Delay_500us,1
    GOTO    Senal_cuadrada
Division3:
    MOVLW   3
    CPFSEQ  N,0
    GOTO    Division2
    BSF     LATB,0,1
    CALL    Delay_1ms,1
    CALL    Delay_1ms,1
    CALL    Delay_1ms,1
    CALL    Delay_100us,1
    CALL    Delay_100us,1
    CALL    Delay_100us,1
    BCF     LATB,0,1
    CALL    Delay_1ms,1
    CALL    Delay_1ms,1
    CALL    Delay_1ms,1
    CALL    Delay_100us,1
    CALL    Delay_100us,1
    CALL    Delay_100us,1
    GOTO    Senal_cuadrada
Division2:
    MOVLW   2
    CPFSEQ  N,0
    GOTO    Division1
    BSF     LATB,0,1
    CALL    Delay_5ms,1
    BCF     LATB,0,1
    CALL    Delay_5ms,1
    GOTO    Senal_cuadrada
Division1:
    MOVLW   1
    CPFSEQ  N,0
    GOTO    Senal_cuadrada
    BSF     LATB,0,1
    CALL    Delay_10ms,1
    BCF     LATB,0,1
    CALL    Delay_10ms,1
    GOTO    Senal_cuadrada
    
Exit0:
    RETFIE

PSECT ISRVectHighPriority,class=CODE,reloc=2
ISRVectHighPriority:
    BTFSS   PIR6,0,0	; ¿Se ha producido la INT0?
    RETFIE
    BCF	    PIR6,0,0	; limpiamos el flag de INT0
    DECFSZ  N,1,0
    RETFIE
    MOVLW   10
    MOVWF   N,0
    RETFIE
    
PSECT udata_acs
contador1:  DS 1	    
contador2:  DS 1
N:          DS 1

PSECT CODE    
Main:
    CALL    Config_OSC,1
    CALL    Config_Port,1
    CALL    Config_PPS,1
    CALL    Config_INT0_INT1,1
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
    ;Config Led
    BANKSEL PORTF
    CLRF    PORTF,1	
    BSF	    LATF,3,1
    CLRF    ANSELF,1	
    BCF	    TRISF,3,1
    
    ;Config User Button
    BANKSEL PORTA
    CLRF    PORTA,1	
    CLRF    ANSELA,1	
    BSF	    TRISA,3,1	
    BSF	    WPUA,3,1
    
    ;Config PORTC
    BANKSEL PORTC
    CLRF    PORTC,1	
    CLRF    LATC,1	
    CLRF     ANSELC,1	
    CLRF     TRISC,1
    RETURN
    
Config_PPS:
    ;Config INT0
    BANKSEL INT0PPS
    MOVLW   0x08
    MOVWF   INT0PPS,1	; INT0 --> RB0
    
    ;Config INT1
    BANKSEL INT1PPS
    MOVLW   0x03
    MOVWF   INT1PPS,1	; INT1 --> RA3
    
    RETURN
    
;   Secuencia para configurar interrupcion:
;    1. Definir prioridades
;    2. Configurar interrupcion
;    3. Limpiar el flag
;    4. Habilitar la interrupcion
;    5. Habilitar las interrupciones globales
Config_INT0_INT1:
    ;Configuracion de prioridades
    BSF	INTCON0,5,0 ; INTCON0<IPEN> = 1 -- Habilitamos las prioridades
    BANKSEL IPR1
    BCF	IPR1,0,1    ; IPR1<INT0IP> = 0 -- INT0 de baja prioridad
    BSF	IPR6,0,1    ; IPR6<INT1IP> = 1 -- INT1 de alta prioridad
    
    ;Config INT0
    BCF	INTCON0,0,0 ; INTCON0<INT0EDG> = 0 -- INT0 por flanco de bajada
    BCF	PIR1,0,0    ; PIR1<INT0IF> = 0 -- limpiamos el flag de interrupcion
    BSF	PIE1,0,0    ; PIE1<INT0IE> = 1 -- habilitamos la interrupcion ext0
    
    ;Config INT1
    BCF	INTCON0,1,0 ; INTCON0<INT1EDG> = 0 -- INT1 por flanco de bajada
    BCF	PIR6,0,0    ; PIR6<INT0IF> = 0 -- limpiamos el flag de interrupcion
    BSF	PIE6,0,0    ; PIE6<INT0IE> = 1 -- habilitamos la interrupcion ext1
    
    ;Habilitacion de interrupciones
    BSF	INTCON0,7,0 ; INTCON0<GIE/GIEH> = 1 -- habilitamos las interrupciones de forma global y de alta prioridad
    BSF	INTCON0,6,0 ; INTCON0<GIEL> = 1 -- habilitamos las interrupciones de baja prioridad
    RETURN

Delay_100us:
    MOVLW 23                    ;k=23 
    NOP                         ;si k=23 --> T=98   
    NOP                         ;ponemos dos NOP para completar los 100us
    MOVWF contador1,0
Loop_100us:
    NOP
    DECFSZ contador1,1,0
    GOTO Loop_100us
    RETURN
    
Delay_200us:
    MOVLW 48                    ;k=48
    NOP
    NOP
    MOVWF contador1,0
Loop_200us:
    NOP
    DECFSZ contador1,1,0
    GOTO Loop_200us
    RETURN
      
Delay_250us:
    MOVLW 61                    ;k=61 
    MOVWF contador1,0
Loop_250us:
    NOP
    DECFSZ contador1,1,0
    GOTO Loop_250us
    RETURN

Delay_500us:
    MOVLW 123                   ;k=123
    NOP
    NOP
    MOVWF contador1,0
Loop_500us:
    NOP
    DECFSZ contador1,1,0
    GOTO Loop_500us
    RETURN
    
Delay_1ms:
    MOVLW 248                   ;k=248
    NOP
    NOP
    MOVWF contador1,0
Loop_1ms:
    NOP
    DECFSZ contador1,1,0
    GOTO Loop_1ms
    RETURN
    
;A partir de ahora haremos otro bucle para repetir 
;tantas veces nos convenga el delay de 1ms
Delay_5ms:                     
    MOVLW 5                     ;repetimos 5 veces el delay de 1ms
    NOP
    NOP
    NOP
    NOP
    MOVWF contador2,0            
Ext_Loop_5ms:                        
    MOVLW 248
    NOP
    MOVWF contador1,0		 
Int_Loop_5ms:			 
    NOP				 
    DECFSZ contador1,1,0         
    GOTO Int_Loop_5ms                
    DECFSZ contador2,1,0
    GOTO Ext_Loop_5ms
    RETURN 
    
Delay_10ms:                         
    MOVLW 10                   ;repetimos 10 veces el delay de 1ms
    NOP
    NOP
    NOP
    NOP
    MOVWF contador2,0            
Ext_Loop_10ms:                        
    MOVLW 248
    NOP
    NOP
    MOVWF contador1,0		 
Int_Loop_10ms:			 
    NOP
    DECFSZ contador1,1,0         
    GOTO Int_Loop_10ms                
    DECFSZ contador2,1,0
    GOTO Ext_Loop_10ms
    RETURN
    
Delay_250ms:                     
    MOVLW 250                  ;repetimos 250 veces el delay de 1ms      
    MOVWF contador2,0            
Ext_Loop_250ms:                        
    MOVLW 248
    NOP
    NOP
    NOP
    MOVWF contador1,0		 
Int_Loop_250ms:			 
    NOP				 
    DECFSZ contador1,1,0         
    GOTO Int_Loop_250ms                
    DECFSZ contador2,1,0
    GOTO Ext_Loop_250ms
    RETURN
      
End resetVect



