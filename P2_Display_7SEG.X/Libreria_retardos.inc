;Autor: Juan Peer Cardoza Siu
;Fecha: 06 de enero del 2023
;IDE: MPLAB X IDE
;Versión: v6.00
;Descripcion general: 
;El programa desarrolla una libreria con diferentes tiempos de delay o retardos que van desde 10us hasta 250ms.
;La libreria de retardos esta implementada para una frecuencia de oscilador de 4MHz.
    
PSECT udata_acs
contador1: DS 1          ;reserva 1 byte en access RAM a contador1
contador2: DS 1          ;reserva 1 byte en access RAM a contador2

PSECT code

;T=6+4k  -->  Ecuacion para hallar el tiempo de retardo
 
Delay_10us:                     ;2Tcy -- CALL
    MOVLW 1                     ;1Tcy -- k=1
    MOVWF contador1,0           ;1Tcy
Loop_10us:
    NOP                         ;k*Tcy
    DECFSZ contador1,1,0        ;(k-1)+3Tcy
    GOTO Loop_10us              ;(k-1)*2Tcy
    RETURN                      ;2Tcy

    
Delay_25us:
    MOVLW 4                     ;k=4  
    NOP                         ;cuandp k=4, el tiempo de retardo es de 22us,
    NOP                         ;por ello completamos con tres instrucciones NOP 
    NOP                         ;antes del bucle para completar los 25us
    MOVWF contador1,0
Loop_25us:
    NOP
    DECFSZ contador1,1,0
    GOTO Loop_25us
    RETURN
    
    
Delay_50us:
    MOVLW 11                    ;k=11
    MOVWF contador1,0
Loop_50us:
    NOP
    DECFSZ contador1,1,0
    GOTO Loop_50us
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
    
;A partir de ahora ya no usaremos la ecuacion sino hacemos otro bucle para repetir 
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
    
    
Delay_25ms:                     
    MOVLW 25                   ;repetimos 25 veces el delay de 1ms       
    MOVWF contador2,0            
Ext_Loop_25ms:                        
    MOVLW 248
    NOP
    NOP
    NOP
    MOVWF contador1,0		 
Int_Loop_25ms:			 
    NOP				 
    DECFSZ contador1,1,0         
    GOTO Int_Loop_25ms                
    DECFSZ contador2,1,0
    GOTO Ext_Loop_25ms
    RETURN
    

Delay_50ms:                     
    MOVLW 50                   ;repetimos 50 veces el delay de 1ms            
    MOVWF contador2,0            
Ext_Loop_50ms:                        
    MOVLW 248
    NOP
    NOP
    NOP
    MOVWF contador1,0		 
Int_Loop_50ms:			 
    NOP				 
    DECFSZ contador1,1,0         
    GOTO Int_Loop_50ms                
    DECFSZ contador2,1,0
    GOTO Ext_Loop_50ms
    RETURN
    
    
Delay_100ms:                     
    MOVLW 100                  ;repetimos 100 veces el delay de 1ms    
    MOVWF contador2,0            
Ext_Loop_100ms:                        
    MOVLW 248
    NOP
    NOP
    NOP
    MOVWF contador1,0		 
Int_Loop_100ms:			 
    NOP				 
    DECFSZ contador1,1,0         
    GOTO Int_Loop_100ms                
    DECFSZ contador2,1,0
    GOTO Ext_Loop_100ms
    RETURN
    
    
Delay_200ms:                     
    MOVLW 200                  ;repetimos 200 veces el delay de 1ms  
    MOVWF contador2,0            
Ext_Loop_200ms:                        
    MOVLW 248
    NOP
    NOP
    NOP
    MOVWF contador1,0		 
Int_Loop_200ms:			 
    NOP				 
    DECFSZ contador1,1,0         
    GOTO Int_Loop_200ms                
    DECFSZ contador2,1,0
    GOTO Ext_Loop_200ms
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
    
Delay_500ms:
    CALL Delay_250ms
    CALL Delay_250ms
    RETURN
    
Delay_1s:
    CALL Delay_250ms
    CALL Delay_250ms
    CALL Delay_250ms
    CALL Delay_250ms
    RETURN



