//Project: 1.prj
// Device: FT60F12X
// Memory: Flash 2KX14b, EEPROM 256X8b, SRAM 128X8b
// Author: 
//Company: 
//Version:
//   Date: 
//===========================================================
//===========================================================
#include	"SYSCFG.h";
//===========================================================
//Variable definition
//===========================================================

#define LED1_Debug_ON

#define 	unchar     	unsigned char 
#define 	unint       	unsigned int
#define  	unlong 		unsigned long

#define	EX_INT_Enable		INTE =1
#define	EX_INT_Disable		INTE =0
#define	TMR2_Enable		TMR2ON =1
#define	TMR2_Disable		TMR2ON =0
#define	TMR0_Enable		T0IE = 1
#define	TMR0_Disable		T0IE = 0

#define TEST PC1
#define LED1 PC0
#define KEY1 PC5
#define KEY2 PA4
#define KEY3 PC4
#define OUT1 PA7
#define OUT2 PA6
#define OUT3 PA5
#define DIN	  PA2
#define SHDN PA3
#define KEY1_Pressed	0x01
#define KEY2_Pressed	0x02
#define KEY3_Pressed	0x04

#define TIMER0_ms	8
#define TIMER2_us	53
#define LONGPRESS_OVERTIME	15							//��λs ��Գ�ʱ
#define REMOTEKEY_SLICE_OVERTIME_ms	150			//��λms ��time2�ж��м���	//ң���ֽ��ճ�ʱ�ж�ʱ��
#define REMOTEKEY_SLICE_OVERTIME_us	(REMOTEKEY_SLICE_OVERTIME_ms*1000)	//��λus ��time2�ж��м���	//ң���ֽ��ճ�ʱ�ж�ʱ��

#define MATCH_TIMES		3

#define BIT_edge_flag 							0x01//ң�ز��ν���ʱ��⵽�ı������Ա�־��1Ϊ�����ؾ�?Ϊ�½���
#define BIT_remotekey_detected_flag 	0x02//ң�ز��ν���ʱ��⵽�ı������Ա�־��1Ϊ�����ؾ�?Ϊ�½���
#define BIT_SYN480_Runflag 				0x04//0û�ڽ���	1�ڽ���
#define BIT_Head_flag			 				0x08//ң�ز��ε���ʼΪ9ms���ҵ͵�ƽ����⵽�ò���ʱ��Ϊ��⵽ң�ز���ͷ���øñ�־λ����⵽ͷ��־���¼֮��24����������Ϊλ����,֮������
#define BIT_key1_remotekey_dealed_flag	0x10
#define BIT_key2_remotekey_dealed_flag	0x20
#define BIT_key3_remotekey_dealed_flag	0x40
#define BIT_remotekey_detecting_flag			0x80

#define BIT_KEY1_LONGPRESS_FLAG	0x10
#define BIT_KEY2_LONGPRESS_FLAG	0x20
#define BIT_KEY3_LONGPRESS_FLAG	0x40

unsigned char FLAGs = 0;
unsigned char PRESS_FLAG = 0;//�������±�ʶ	bit0��bit2��KEY1��KEY3	��4λ��Ϊ������־

//unsigned char SYN480_Runflag = 0;	//0û�ڽ���	1�ڽ���
//unsigned char edge_flag = 0;//ң�ز��ν���ʱ��⵽�ı������Ա�־��1Ϊ�����أ�0Ϊ�½���
//unsigned char Head_flag = 0;//ң�ز��ε���ʼΪ9ms���ҵ͵�ƽ����⵽�ò���ʱ��Ϊ��⵽ң�ز���ͷ���øñ�־λ����⵽ͷ��־���¼֮��24����������Ϊλ����,֮������

//���յ���Чң���ֺ�������������յ�ͷ��������Ӧ����ң����
//������ͷ�������(REMOTEKEY_SLICE_OVERTIME/TIMER2_us)ʱ����Ϊ��һ����Ч�ַ�����ɣ�������Ӧ��һ����Ч��
//unsigned char key1_remotekey_dealed_flag = 0;//Ϊ1ʱ��ʾ��Чң�����Ѿ�����
//unsigned char key2_remotekey_dealed_flag = 0;
//unsigned char key3_remotekey_dealed_flag = 0;


//unsigned char KEY1_LONGPRESS_FLAG = 0;//KEY1������־���ڳ����������������֮�����㣬��ʱ10s����
//unsigned char KEY2_LONGPRESS_FLAG = 0;//KEY2������־���ڳ����������������֮�����㣬��ʱ10s����
//unsigned char KEY3_LONGPRESS_FLAG = 0;//KEY3������־���ڳ����������������֮�����㣬��ʱ10s����

unsigned int buff;
unsigned long remotekey = 0;//���չ�����ң�����ݴ�
unsigned long Ctrl_remotekey = 0;//����ʱȷ�Ͻ��յ���ң����
unsigned long Match_remotekey = 0;//���ʱȷ�Ͻ��յ���ң����
unsigned char remotekey_slice = 0;//����ͬң����֮��Ľ��ռ������С��REMOTEKEY_SLICE_OVERTIMEʱ��Ϊ�������գ�������Ϊ�жϡ��������յ�ң����ֻ��Ӧһ�Ρ�																	
unsigned char match_slice = 0;//���ʱʹ�ã�����ͬң����֮��Ľ��ռ������С��REMOTEKEY_SLICE_OVERTIMEʱ��Ϊ�������գ�������Ϊ�жϡ��������յ�ң����ֻ��Ӧһ��?													
unsigned char remotekey_Receive_num = 0;//ͬһң�����ظ����մ���
unsigned int Indata = 0;	//��ʱ��2��DinΪ0�ĸ���������͵�ƽ����
unsigned char Key_dealed_counter = 0;

unsigned char num = 0;	//����ң����ĵڼ�λ
//unsigned char head_slice_counter = 0;	//ͷ�жϼ�������DIN==0ʱ�Լ�1������������7000/TIMER2_usʱ��Ϊ���յ�ͷ
unsigned char ms16_counter = 0;//16ms����
unsigned char KEY_Match_counter = 0;//��Բ������
unsigned char PRESSED = 0;//����ȷ�ϰ��±�ʶ	bit0��bit4��KEY1��KEY5
unsigned char KEY1_LongPress = 0;//KEY1����ms����
unsigned char KEY2_LongPress = 0;//KEY2����ms����
unsigned char KEY3_LongPress = 0;//KEY3����ms����
unsigned char LONGPRESS_OverTime_Counter = 0;//������ʱ��ʱ
unsigned char EE_Buff = 0;//EEPROM��ȡʱ�ݴ�����
unsigned long CH1_remotekey[4];//CH1ң����
unsigned long CH2_remotekey[4];//CH2ң����
unsigned long CH3_remotekey[4];//CH3ң����
unsigned char CH1_remotekey_num = 0;//���CH1ң���ֵ����� ң���ֵ���� ���Ϊ4
unsigned char CH2_remotekey_num = 0;//���CH2ң���ֵ����� ң���ֵ���� ���Ϊ4
unsigned char CH3_remotekey_num = 0;//���CH3ң���ֵ����� ң���ֵ���� ���Ϊ4
unsigned char CH1_remotekey_Latest = 0;//���CH1���һ�ο���ʱ��ң���ֵ����
unsigned char CH2_remotekey_Latest = 0;
unsigned char CH3_remotekey_Latest = 0;
//unsigned char i;
//unsigned int HIndata = 0;
//unsigned int LIndata = 0;

void led1_debug(void);
void INT_INITIAL(void);
void EX_INT_RisingEdge(void);
void EX_INT_FallingEdge(void);
void OSC_INIT (void);
void WDT_INITIAL (void);
void TIMER0_INITIAL (void);
void TIMER2_INITIAL (void);
unsigned char IAPRead(unsigned char EEAddr);
void IAPWrite(unsigned char EEAddr,unsigned char Data);
//void EEPROM_WriteWord(unsigned long buff,unsigned char data);
void CH1_EEPROM_Write(void);
void CH2_EEPROM_Write(void);
void CH3_EEPROM_Write(void);
void EEPROM_ReadWord(unsigned long *buff,unsigned char data);
void EEPROM_Read(void);
void KEYSCAN(void);
void KEY(void);

//===========================================================
//Funtion name��interrupt ISR
//parameters����
//returned value����
//===========================================================
void interrupt ISR(void){
  //PA2�ⲿ�жϴ���**********************
	if(INTE && INTF){
		INTF = 0;//��PA2 INT ��־λ
		INTE = 0;//���Ƚ�ֹPA2��?
        TMR2_Disable;
		if((FLAGs&BIT_edge_flag) == 0){//Ϊ�½����ж�
			Indata = 0;
			EX_INT_RisingEdge();
		}else if((FLAGs&BIT_edge_flag) == BIT_edge_flag){//Ϊ�������ж�
			EX_INT_FallingEdge();      
			buff = Indata*TIMER2_us;
			Indata = 0; 
			
			if(		((FLAGs&BIT_key1_remotekey_dealed_flag) == 0) &&
					((FLAGs&BIT_key2_remotekey_dealed_flag) == 0) &&
					((FLAGs&BIT_key3_remotekey_dealed_flag) == 0)
			){
				if((FLAGs&BIT_Head_flag) == BIT_Head_flag){	//���յ�ͷʱ����24��λ
					if(num < 24){
						if((buff>200)&&(buff<450)){
							remotekey = remotekey<<1;
							remotekey |= 0x00000001;
						}
						if((buff>700)&&(buff<1200)){
							remotekey = remotekey<<1;
						}
						num++;
					}
					
					if(num >= 24){//���յ�24��λ֮��
						
						if(remotekey>0){
							if(Match_remotekey == remotekey){
								remotekey_Receive_num++;
								match_slice = 0;
							}
							if(remotekey_Receive_num == 0) Match_remotekey = remotekey;	//�ڳ�ʱ�ظ�����������ʱ���£�
						}

						Ctrl_remotekey = remotekey;
						//ң������Ӧ���ڳ���״̬�²���Ӧң����
						if(		((PRESSED&BIT_KEY1_LONGPRESS_FLAG) == 0)	&&
								((PRESSED&BIT_KEY2_LONGPRESS_FLAG) == 0)	&&
								((PRESSED&BIT_KEY3_LONGPRESS_FLAG) == 0)
						){
							if((FLAGs&BIT_key1_remotekey_dealed_flag) == 0){
								for(buff=0;buff<CH1_remotekey_num;buff++){
									if(Ctrl_remotekey == CH1_remotekey[buff]){
										FLAGs |= BIT_key1_remotekey_dealed_flag;//���յ���Чң����
                                        Key_dealed_counter = 0;
										led1_debug();
										OUT1 = ~OUT1;
										CH1_remotekey_Latest = buff;
									}
								}
							}
							if((FLAGs&BIT_key2_remotekey_dealed_flag) == 0){
								for(buff=0;buff<CH2_remotekey_num;buff++){
									if(Ctrl_remotekey == CH2_remotekey[buff]){
										FLAGs |= BIT_key2_remotekey_dealed_flag;//���յ���Чң����
                                        Key_dealed_counter = 0;
										led1_debug();
										OUT2 = ~OUT2;
										CH2_remotekey_Latest = buff;
									}
								}
							}
							if((FLAGs&BIT_key3_remotekey_dealed_flag) == 0){
								 for(buff=0;buff<CH3_remotekey_num;buff++){
									if(Ctrl_remotekey == CH3_remotekey[buff]){
										FLAGs |= BIT_key3_remotekey_dealed_flag;//���յ���Чң����
                                        Key_dealed_counter = 0;
										led1_debug();
										OUT3 = ~OUT3;
										CH3_remotekey_Latest = buff;
									}
								}
							}
						}
                        FLAGs &= ~BIT_Head_flag;
						Indata = 0;
						num = 0;
						remotekey = 0;
						Ctrl_remotekey = 0;
					}
				}
                if((FLAGs&BIT_Head_flag) == 0){	
					if(buff > 7000){
						FLAGs |= BIT_Head_flag;
						num = 0;
						remotekey = 0;
						if(		((FLAGs&BIT_key1_remotekey_dealed_flag) == BIT_key1_remotekey_dealed_flag) ||
								((FLAGs&BIT_key2_remotekey_dealed_flag) == BIT_key2_remotekey_dealed_flag) ||
								((FLAGs&BIT_key3_remotekey_dealed_flag) == BIT_key3_remotekey_dealed_flag)
						){
							remotekey_slice = 0; 
							FLAGs &= ~BIT_Head_flag;
						}
					}
				}
			}
		}
        TMR2_Enable;
		INTE = 1;//ʹ��PA2 INT�ж�
	}
    
//��ʱ��2���жϴ���**********************
	if(TMR2IE && TMR2IF){			//50us�ж�һ��
		TMR2IF = 0;
	
        if((FLAGs&BIT_remotekey_detected_flag) == BIT_remotekey_detected_flag){
			Indata++;
		}
        if(DIN == 1){
            FLAGs |= BIT_remotekey_detected_flag;
            remotekey_slice = 0;
            Key_dealed_counter = 0;
//            led1_debug();
		}
      		

//		if((FLAGs&BIT_remotekey_detecting_flag) == 0){
//			if(DIN == 1){
//				HIndata++;
//			}else{
//               buff = HIndata*TIMER2_us; 
//               HIndata = 0; 
//			   if(	((buff>200)&&(buff<420))	||
//					((buff>700)&&(buff<1200))
//               ){
//					FLAGs |= BIT_remotekey_detecting_flag;
//				}else{
//                    i = 0;
//				}
//			}
//        }
//        if((FLAGs&BIT_remotekey_detecting_flag) == BIT_remotekey_detecting_flag){
//			if(DIN == 0){
//				LIndata++;
//			}else{
//                buff = LIndata*TIMER2_us;               
//                LIndata = 0;
//				if(	((buff>200)&&(buff<450))	||
//					((buff>700)&&(buff<1200))
//				){
//                    i++;                   
//				}else{
//					i = 0;
//				}
//				FLAGs &= ~BIT_remotekey_detecting_flag;
//			}		
//        }
//        if(i>1){
//            FLAGs |= BIT_remotekey_detected_flag;
//            i = 0;
////            led1_debug();
//		}
	}
    
//��ʱ��0���жϴ���**********************
	if(T0IE && T0IF){               //8ms��ʱ
		T0IF = 0;
        ms16_counter ++;
        
        //��ͬ���ڽ��ռ��С��REMOTEKEY_SLICE_OVERTIMEʱֻ��Ӧһ�Σ��ڴ���ʱ���־λ
		if(		((FLAGs&BIT_key1_remotekey_dealed_flag) == BIT_key1_remotekey_dealed_flag) ||
				((FLAGs&BIT_key2_remotekey_dealed_flag) == BIT_key2_remotekey_dealed_flag) ||
				((FLAGs&BIT_key3_remotekey_dealed_flag) == BIT_key3_remotekey_dealed_flag)
		){
			if(DIN == 0) remotekey_slice++;
			if(DIN == 1) remotekey_slice = 0;
			if(Key_dealed_counter<255) Key_dealed_counter++;
			if(		(remotekey_slice>(REMOTEKEY_SLICE_OVERTIME_ms/TIMER0_ms))	||
					(Key_dealed_counter > (1024/TIMER0_ms))
			){
				remotekey_slice = 0;
//				FLAGs &= ~BIT_Head_flag;
				FLAGs &= ~BIT_remotekey_detected_flag;
				FLAGs &= ~BIT_key1_remotekey_dealed_flag;
				FLAGs &= ~BIT_key2_remotekey_dealed_flag;		
				FLAGs &= ~BIT_key3_remotekey_dealed_flag;		
			}
		}
     
		//���ʱ���յ�һ��������֮���ڼ����û���ٽ��յ����������ǰ�룬���½���
		if(		((PRESSED&BIT_KEY1_LONGPRESS_FLAG) == BIT_KEY1_LONGPRESS_FLAG)	||
				((PRESSED&BIT_KEY2_LONGPRESS_FLAG) == BIT_KEY2_LONGPRESS_FLAG)	||
                ((PRESSED&BIT_KEY3_LONGPRESS_FLAG) == BIT_KEY3_LONGPRESS_FLAG)
           ){
			match_slice++;
			if(match_slice>(REMOTEKEY_SLICE_OVERTIME_ms/TIMER0_ms)){
				match_slice = 0;
				remotekey_Receive_num = 0;
			}
		}

//SYN480�͹��Ŀ���
		if((FLAGs&BIT_remotekey_detected_flag) == 0){
			EE_Buff = ms16_counter%10;
			if(EE_Buff == 1){
				SHDN = 0;
//				FLAGs &= ~BIT_Head_flag;
				EX_INT_FallingEdge();
				EX_INT_Enable;
				TMR2_Enable;
			}
			if(EE_Buff == 3){
				SHDN = 1;	
				TMR2_Disable;
				EX_INT_Disable;
			}
        }else{
            SHDN = 0;
			EX_INT_Enable;
			TMR2_Enable;           
		}
        
//����ɨ��
        if(ms16_counter%2 == 0){
			KEYSCAN();
			KEY();
        }
 
//�������
//		if(ms16_counter >= 1000/TIMER0_ms){
		if(ms16_counter >= 120){
			ms16_counter = 0;			
//			led1_debug();			
			//������ʱ��ʱ
			if(		((PRESSED&BIT_KEY1_LONGPRESS_FLAG) == BIT_KEY1_LONGPRESS_FLAG)	||
					((PRESSED&BIT_KEY2_LONGPRESS_FLAG) == BIT_KEY2_LONGPRESS_FLAG)	||
					((PRESSED&BIT_KEY3_LONGPRESS_FLAG) == BIT_KEY3_LONGPRESS_FLAG)
			 ){
				if(KEY_Match_counter<4){
					KEY_Match_counter++;	//���Ϊ4
				}
				LONGPRESS_OverTime_Counter++;
				if(LONGPRESS_OverTime_Counter > LONGPRESS_OVERTIME){//��ʱ��ʱ
					LONGPRESS_OverTime_Counter = 0;
					if((PRESSED&BIT_KEY1_LONGPRESS_FLAG) == BIT_KEY1_LONGPRESS_FLAG){
						CH1_remotekey[CH1_remotekey_Latest] = CH1_remotekey[CH1_remotekey_num-1];
						CH1_remotekey[CH1_remotekey_num-1] = 0xFFFFFFFF;
						if(CH1_remotekey_num>0) CH1_remotekey_num--;
						PRESSED &= ~BIT_KEY1_LONGPRESS_FLAG;  
						OUT1 = 1;                 
					}
					if((PRESSED&BIT_KEY2_LONGPRESS_FLAG) == BIT_KEY2_LONGPRESS_FLAG){
						CH2_remotekey[CH2_remotekey_Latest] = CH2_remotekey[CH2_remotekey_num-1];
						CH2_remotekey[CH2_remotekey_num-1] = 0xFFFFFFFF;
						if(CH2_remotekey_num>0) CH2_remotekey_num--;
						PRESSED &= ~BIT_KEY2_LONGPRESS_FLAG;
						OUT2 = 1;
					}                    
					if((PRESSED&BIT_KEY3_LONGPRESS_FLAG) == BIT_KEY3_LONGPRESS_FLAG){
						CH3_remotekey[CH3_remotekey_Latest] = CH3_remotekey[CH3_remotekey_num-1];
						CH3_remotekey[CH3_remotekey_num-1] = 0xFFFFFFFF;
						if(CH3_remotekey_num>0) CH3_remotekey_num--;
						PRESSED &= ~BIT_KEY3_LONGPRESS_FLAG;
						OUT3 = 1;
					}
					LED1 = 1;
				}
			}
		}
	} 
}
void led1_debug(void){
	#ifdef	LED1_Debug_ON
		LED1 = ~LED1;
	#endif   
}
void INT_INITIAL(void){
	TRISA2 =1; //SET PA2 INPUT
	IOCA2 =0;  //��ֹPA2��ƽ�仯�ж�
	EX_INT_FallingEdge();
	INTF =0;   //��PA2 INT�жϱ�־λ
//	INTE =1;   //ʹ��PA2 INT�ж�
    EX_INT_Disable;
}
void EX_INT_RisingEdge(void){
    INTEDG =1;
    FLAGs |= BIT_edge_flag;
}
void EX_INT_FallingEdge(void){
    INTEDG =0;
    FLAGs &= ~BIT_edge_flag;
}
void OSC_INIT (void){ 
	OSCCON = 0B01100001;	//WDT 32KHZ
											//IRCF=110=16MHZ/2=8MHZ,0.125US/T
											//Bit0=1,ϵͳʱ��Ϊ�ڲ�����
											//Bit0=0,ʱ��Դ��FOSC<2��0>����������ѡ��ʱѡ��

	INTCON = 0; //�ݽ�ֹ�����ж�
    
	PORTA = 0B00000000;		
	TRISA = 0B00010111;	//PA������� 0-��� 1-����
	WPUA = 0B00000000;    //PA�˿��������� 1-������ 0-������//��PA6��?    
    PSRCA = 0B11111111;  //Դ�����������
    PSINKA = 0B11111111;    //������������    
							
	PORTC = 0B00000000; 	
	TRISC = 0B11110000;	//PC������� 0-��� 1-����  
	WPUC = 0B00000000;    //PC�˿��������� 1-������ 0-������//60ϵ��PC��������						
	PSRCC = 0B11111111;  
    PSINKC = 0B11111111;
        
	OPTION = 0B00001000;	//Bit3=1 WDT MODE,PS=000=1:1 WDT RATE
					 		//Bit7(PAPU)=0 ENABLED PULL UP PA
}
void WDT_INITIAL (void){
	CLRWDT();  				//�忴�Ź�
	WDTCON = 0B00010110;	//WDTPS=1001=1:32768,PS=000=1:1
					 		//��ʱʱ��=(32768*1)/32000=1024ms
}
void TIMER0_INITIAL (void){
	T0CS = 0;//Bit5 T0CS Timer0ʱ��Դѡ�� 1-�ⲿ���ŵ�T0CKIƽ�仯 0-�ڲ�ʱ��(FOSC/2)
    PSA = 0;//Bit3 PSA Ԥ��Ƶ������λ 0-Timer0 1-WDT 
    OPTION  &= 0xF8;
    OPTION  |= 0x06;//Bit2:0 PS2 8��Ԥ��Ƶ�� 110 - 1:128
	//����TMR0��ʱʱ��8ms=(1/8000000)*2*128*250				
	TMR0 = 5;
    T0IE = 1;				//����ʱ��/������0�ж�
	T0IF = 0;				//���T0�����ж�
}
void TIMER2_INITIAL (void){    
    T2CON0  = 0B00000001; 			//T2Ԥ��Ƶ1:1�����Ƶ1��4
    //BIT7: 0�������壻 1����PR2/P1xDTy����ֵ�ֱ���µ�PR2�Ĵ�����P1xDTy_ACT
    //BIT6~BIT3: ��ʱ��2������Ƶ��ѡ�� 0000:1:1;0001:1:2;����1:16
    //BIT2:0:�رն�ʱ��2��1���򿪶�ʱ��2
    //BIT1~0:��ʱ��2Ԥ��Ƶѡ�� 00:1;01:4;1x:16
    
	T2CON1  = 0B00000000;		   //T2ʱ������ϵͳʱ��,PWM1����ģʽ
	//BIT4: PWMģʽѡ�� 0:����ģʽ��1��������ģʽ
    //BIT3: 0:PWMģʽ��1��������ģʽ	
    //Timer2ʱ��Դѡ��000��ָ��ʱ�ӣ�001��ϵͳʱ�ӣ�010��HIRC��2��Ƶ��100��HIRC��101��LIRC
    						
    TMR2H  	= (TIMER2_us)/256;					//��ʱ��2�����Ĵ���  =1/8*2*4*200
    TMR2L  	= (TIMER2_us)%256;
    
    
	PR2H    =  (TIMER2_us)/256; 					//����=��PR+1��*Tt2ck*TMR2Ԥ��Ƶ(������ģʽ����*2)
	PR2L    = (TIMER2_us)%256;	  
                  
	TMR2IF  = 0;					//��TMER2�жϱ�־
	TMR2IE = 1;						//ʹ��TMER2���жϣ����ó�timer��ʱ��ʱ��ע�ͣ�
//	TMR2ON  = 1;					//ʹ��TMER2����
    TMR2_Disable;
}
unsigned char IAPRead(unsigned char EEAddr){
	unsigned char ReEEPROMread;
	EEADR = EEAddr;    
	RD = 1;
	ReEEPROMread = EEDAT;     		//EEPROM�Ķ����� ReEEPROMread = EEDATA;
	return ReEEPROMread;
}
void IAPWrite(unsigned char EEAddr,unsigned char Data){
	GIE = 0;						//д���ݱ���ر��ж�
	while(GIE); 					//�ȴ�GIEΪ0
	EEADR = EEAddr; 	 			//EEPROM�ĵ�ַ
	EEDAT = Data;		 			//EEPROM��д����  EEDATA = Data;
	EEIF = 0;
	EECON1 |= 0x34;					//��λWREN1,WREN2,WREN3��������.
	WR = 1;							//��λWR�������
	while(WR);      				//�ȴ�EEд�����
	GIE = 1;
}
void CH1_EEPROM_Write(void){
	IAPWrite(0x00,((CH1_remotekey[0]&0x000000FF)>>0));
	IAPWrite(0x01,((CH1_remotekey[0]&0x0000FF00)>>8));
	IAPWrite(0x02,((CH1_remotekey[0]&0x00FF0000)>>16));
//	IAPWrite(0x03,((CH1_remotekey[0]&0xFF000000)>>24));
	IAPWrite(0x0C,((CH1_remotekey[1]&0x000000FF)>>0));
	IAPWrite(0x0D,((CH1_remotekey[1]&0x0000FF00)>>8));
	IAPWrite(0x0E,((CH1_remotekey[1]&0x00FF0000)>>16));
//	IAPWrite(0x0F,((CH1_remotekey[1]&0xFF000000)>>24));
	IAPWrite(0x18,((CH1_remotekey[2]&0x000000FF)>>0));
	IAPWrite(0x19,((CH1_remotekey[2]&0x0000FF00)>>8));
	IAPWrite(0x1A,((CH1_remotekey[2]&0x00FF0000)>>16));
//	IAPWrite(0x1B,((CH1_remotekey[2]&0xFF000000)>>24));    
 	IAPWrite(0x24,((CH1_remotekey[3]&0x000000FF)>>0));
	IAPWrite(0x25,((CH1_remotekey[3]&0x0000FF00)>>8));
	IAPWrite(0x26,((CH1_remotekey[3]&0x00FF0000)>>16));
//	IAPWrite(0x27,((CH1_remotekey[3]&0xFF000000)>>24));   
	IAPWrite(0x30,CH1_remotekey_num);
}
void CH2_EEPROM_Write(void){
	IAPWrite(0x04,((CH2_remotekey[0]&0x000000FF)>>0));
	IAPWrite(0x05,((CH2_remotekey[0]&0x0000FF00)>>8));
	IAPWrite(0x06,((CH2_remotekey[0]&0x00FF0000)>>16));
//	IAPWrite(0x07,((CH2_remotekey[0]&0xFF000000)>>24));	
	IAPWrite(0x10,((CH2_remotekey[1]&0x000000FF)>>0));
	IAPWrite(0x11,((CH2_remotekey[1]&0x0000FF00)>>8));
	IAPWrite(0x12,((CH2_remotekey[1]&0x00FF0000)>>16));
//	IAPWrite(0x13,((CH2_remotekey[1]&0xFF000000)>>24));	    
	IAPWrite(0x1C,((CH2_remotekey[2]&0x000000FF)>>0));
	IAPWrite(0x1D,((CH2_remotekey[2]&0x0000FF00)>>8));
	IAPWrite(0x1E,((CH2_remotekey[2]&0x00FF0000)>>16));
//	IAPWrite(0x1F,((CH2_remotekey[2]&0xFF000000)>>24));
	IAPWrite(0x28,((CH2_remotekey[3]&0x000000FF)>>0));
	IAPWrite(0x29,((CH2_remotekey[3]&0x0000FF00)>>8));
	IAPWrite(0x2A,((CH2_remotekey[3]&0x00FF0000)>>16));
//	IAPWrite(0x2B,((CH2_remotekey[3]&0xFF000000)>>24));	
 	IAPWrite(0x31,CH2_remotekey_num);   
}
void CH3_EEPROM_Write(void){
	IAPWrite(0x08,((CH3_remotekey[0]&0x000000FF)>>0));
	IAPWrite(0x09,((CH3_remotekey[0]&0x0000FF00)>>8));
	IAPWrite(0x0A,((CH3_remotekey[0]&0x00FF0000)>>16));
//	IAPWrite(0x0B,((CH3_remotekey[0]&0xFF000000)>>24));
	IAPWrite(0x14,((CH3_remotekey[1]&0x000000FF)>>0));
	IAPWrite(0x15,((CH3_remotekey[1]&0x0000FF00)>>8));
	IAPWrite(0x16,((CH3_remotekey[1]&0x00FF0000)>>16));
//	IAPWrite(0x17,((CH3_remotekey[1]&0xFF000000)>>24));
	IAPWrite(0x20,((CH3_remotekey[2]&0x000000FF)>>0));
	IAPWrite(0x21,((CH3_remotekey[2]&0x0000FF00)>>8));
	IAPWrite(0x22,((CH3_remotekey[2]&0x00FF0000)>>16));
//	IAPWrite(0x23,((CH3_remotekey[2]&0xFF000000)>>24));	
	IAPWrite(0x2C,((CH3_remotekey[3]&0x000000FF)>>0));
	IAPWrite(0x2D,((CH3_remotekey[3]&0x0000FF00)>>8));
	IAPWrite(0x2E,((CH3_remotekey[3]&0x00FF0000)>>16));
//	IAPWrite(0x2F,((CH3_remotekey[3]&0xFF000000)>>24));	
	IAPWrite(0x32,CH3_remotekey_num);
}
void EEPROM_ReadWord(unsigned long *buff,unsigned char data){
	*buff = 0;
	EE_Buff = IAPRead(data+2);
	*buff |= EE_Buff;
	*buff = *buff<<8;	
	EE_Buff = IAPRead(data+1);
	*buff |= EE_Buff;
	*buff = *buff<<8;
	EE_Buff = IAPRead(data);
	*buff |= EE_Buff;
}
void EEPROM_Read(void){
    EEPROM_ReadWord(&CH1_remotekey[0],0x00);
    EEPROM_ReadWord(&CH2_remotekey[0],0x04);   
    EEPROM_ReadWord(&CH3_remotekey[0],0x08);
    EEPROM_ReadWord(&CH1_remotekey[1],0x0C); 
    EEPROM_ReadWord(&CH2_remotekey[1],0x10);
    EEPROM_ReadWord(&CH3_remotekey[1],0x14);
    EEPROM_ReadWord(&CH1_remotekey[2],0x18);
    EEPROM_ReadWord(&CH2_remotekey[2],0x1C);   
    EEPROM_ReadWord(&CH3_remotekey[2],0x20);
    EEPROM_ReadWord(&CH1_remotekey[3],0x24); 
    EEPROM_ReadWord(&CH2_remotekey[3],0x28);
    EEPROM_ReadWord(&CH3_remotekey[3],0x2C);    
	CH1_remotekey_Latest = CH1_remotekey_num = IAPRead(0x30);
    CH2_remotekey_Latest = CH2_remotekey_num = IAPRead(0x31);
    CH3_remotekey_Latest = CH3_remotekey_num = IAPRead(0x32);
}
void KEYSCAN(void){
	if(PRESSED == 0){			
		if(KEY1 == 0){
			if(KEY1_LongPress < 125) PRESS_FLAG |= 0x01;
            if(KEY1_LongPress < 254) KEY1_LongPress++;
			if((KEY1_LongPress > 125) && (KEY1_LongPress < 250)){
				PRESS_FLAG |= BIT_KEY1_LONGPRESS_FLAG;
				match_slice = 0;
                LED1 = 0;
                OUT1 = 0;
                LONGPRESS_OverTime_Counter = 0;
			}
			if(KEY1_LongPress > 250){
				CH1_remotekey[0] = 0xFFFFFFFF;
				CH1_remotekey[1] = 0xFFFFFFFF;                
				CH1_remotekey[2] = 0xFFFFFFFF;
				CH1_remotekey[3] = 0xFFFFFFFF;
                CH1_remotekey_num = 0;
				CH1_remotekey_Latest = 0;
                PRESS_FLAG &= ~BIT_KEY1_LONGPRESS_FLAG;
                PRESS_FLAG &= ~0x01;
                LED1 = 1;
                OUT1 = 1;
                KEY_Match_counter = 0;
			}
		}else	KEY1_LongPress = 0;
		
		if(KEY2 == 0){	
			if(KEY2_LongPress < 125) PRESS_FLAG |= 0x02;	
            if(KEY2_LongPress < 254) KEY2_LongPress++;
			if((KEY2_LongPress > 125) && (KEY2_LongPress < 250)){
				PRESS_FLAG |= BIT_KEY2_LONGPRESS_FLAG;
				match_slice = 0;
                LED1 = 0;
                OUT2 = 0;
                LONGPRESS_OverTime_Counter = 0;
			}
			if(KEY2_LongPress > 250){
				CH2_remotekey[0] = 0xFFFFFFFF;
				CH2_remotekey[1] = 0xFFFFFFFF;                
				CH2_remotekey[2] = 0xFFFFFFFF;
				CH2_remotekey[3] = 0xFFFFFFFF;
                CH2_remotekey_num = 0;
				CH2_remotekey_Latest = 0;
                PRESS_FLAG &= ~BIT_KEY2_LONGPRESS_FLAG;
                PRESS_FLAG &= ~0x02;
                LED1 = 1;
                OUT2 = 1;
                KEY_Match_counter = 0;
			}
		}else	KEY2_LongPress = 0;
		
		if(KEY3 == 0){
			if(KEY3_LongPress < 125) PRESS_FLAG |= 0x04;
            if(KEY3_LongPress < 254) KEY3_LongPress++;
			if((KEY3_LongPress > 125) && (KEY3_LongPress < 250)){
				PRESS_FLAG |= BIT_KEY3_LONGPRESS_FLAG;
				match_slice = 0;
                LED1 = 0;
                OUT3 = 0;
                LONGPRESS_OverTime_Counter = 0;
			}
			if(KEY3_LongPress > 250){
				CH3_remotekey[0] = 0xFFFFFFFF;
				CH3_remotekey[1] = 0xFFFFFFFF;                
				CH3_remotekey[2] = 0xFFFFFFFF;
				CH3_remotekey[3] = 0xFFFFFFFF;
                CH3_remotekey_num = 0;
				CH3_remotekey_Latest = 0;
                PRESS_FLAG &= ~BIT_KEY3_LONGPRESS_FLAG;
                PRESS_FLAG &= ~0x04;
                LED1 = 1;
                OUT3 = 1;
                KEY_Match_counter = 0;
			}
		}else	KEY3_LongPress = 0;
		
		if((PRESS_FLAG>0)&&(KEY1==1)&&(KEY2==1)&&(KEY3==1)){
			PRESSED = PRESS_FLAG;
			PRESS_FLAG = 0;
		}
	}
}
void KEY(void){
	if(		((PRESSED&BIT_KEY1_LONGPRESS_FLAG) == BIT_KEY1_LONGPRESS_FLAG)	||
			((PRESSED&BIT_KEY2_LONGPRESS_FLAG) == BIT_KEY2_LONGPRESS_FLAG)	||
            ((PRESSED&BIT_KEY3_LONGPRESS_FLAG) == BIT_KEY3_LONGPRESS_FLAG)
	){	
		switch(KEY_Match_counter){
			case 0:
				Match_remotekey = 0xFFFFFFFF;	//��ң����
				break;			
			case 1:
				LED1 = 0;
                if((PRESSED&BIT_KEY1_LONGPRESS_FLAG) == BIT_KEY1_LONGPRESS_FLAG)		OUT1 = 0;
                if((PRESSED&BIT_KEY2_LONGPRESS_FLAG) == BIT_KEY2_LONGPRESS_FLAG)		OUT2 = 0;
                if((PRESSED&BIT_KEY3_LONGPRESS_FLAG) == BIT_KEY3_LONGPRESS_FLAG)		OUT3 = 0;
				break;
			case 2:
				LED1 = 1;
                if((PRESSED&BIT_KEY1_LONGPRESS_FLAG) == BIT_KEY1_LONGPRESS_FLAG)		OUT1 = 1;
                if((PRESSED&BIT_KEY2_LONGPRESS_FLAG) == BIT_KEY2_LONGPRESS_FLAG)		OUT2 = 1;
                if((PRESSED&BIT_KEY3_LONGPRESS_FLAG) == BIT_KEY3_LONGPRESS_FLAG)		OUT3 = 1;
				break;
			case 3:
				KEY_Match_counter = 1;
				if(remotekey_Receive_num >= MATCH_TIMES){	//���յ���ң����
					if((PRESSED&BIT_KEY1_LONGPRESS_FLAG) == BIT_KEY1_LONGPRESS_FLAG){
						if(	(Match_remotekey != CH1_remotekey[0])	&&
							(Match_remotekey != CH1_remotekey[1])	&&
							(Match_remotekey != CH1_remotekey[2])	&&
							(Match_remotekey != CH1_remotekey[3])
                        ){
							if(CH1_remotekey_num < 4){//4��ң���ֻ�û����������ң���֣�ֻ����
								CH1_remotekey[CH1_remotekey_num] = Match_remotekey;
								CH1_remotekey_num++;
							}else{//4��ң�������ˣ������һ��ң�ؿ���ʱ��ң���ֲ�����Ϊ��ң����
								CH1_remotekey[CH1_remotekey_Latest] = Match_remotekey;
							}
						}
						if(CH1_remotekey_num > 4)	CH1_remotekey_num = 4;
						PRESSED &= ~BIT_KEY1_LONGPRESS_FLAG;
                        CH1_EEPROM_Write();
                        OUT1 = 1;                
                    }
					if((PRESSED&BIT_KEY2_LONGPRESS_FLAG) == BIT_KEY2_LONGPRESS_FLAG){
						if(	(Match_remotekey != CH2_remotekey[0])	&&
							(Match_remotekey != CH2_remotekey[1])	&&
							(Match_remotekey != CH2_remotekey[2])	&&
							(Match_remotekey != CH2_remotekey[3])
                        ){
							if(CH2_remotekey_num < 4){//4��ң���ֻ�û����������ң���֣�ֻ����
								CH2_remotekey[CH2_remotekey_num] = Match_remotekey;
								CH2_remotekey_num++;
							}else{//4��ң�������ˣ������һ��ң�ؿ���ʱ��ң���ֲ�����Ϊ��ң����
								CH2_remotekey[CH2_remotekey_Latest] = Match_remotekey;
							}
						}
						if(CH2_remotekey_num > 4)	CH2_remotekey_num = 4;
						PRESSED &= ~BIT_KEY2_LONGPRESS_FLAG;
                        CH2_EEPROM_Write();
                        OUT2 = 1;                
                    }
					if((PRESSED&BIT_KEY3_LONGPRESS_FLAG) == BIT_KEY3_LONGPRESS_FLAG){
						if(	(Match_remotekey != CH3_remotekey[0])	&&
							(Match_remotekey != CH3_remotekey[1])	&&
							(Match_remotekey != CH3_remotekey[2])	&&
							(Match_remotekey != CH3_remotekey[3])
                        ){
							if(CH3_remotekey_num < 4){//4��ң���ֻ�û����������ң���֣�ֻ����
								CH3_remotekey[CH3_remotekey_num] = Match_remotekey;
								CH3_remotekey_num++;
							}else{//4��ң�������ˣ������һ��ң�ؿ���ʱ��ң���ֲ�����Ϊ��ң����
								CH3_remotekey[CH3_remotekey_Latest] = Match_remotekey;
							}
						}
						if(CH3_remotekey_num > 4)	CH3_remotekey_num = 4;
						PRESSED &= ~BIT_KEY3_LONGPRESS_FLAG;
                        CH3_EEPROM_Write();
                        OUT3 = 1;                
                    }
					KEY_Match_counter = 0;
					LED1 = 1;
				}
				break;
		}		
	}

	//�а���������״̬�²�����Ӧ�������¶���
	if(		((PRESSED&BIT_KEY1_LONGPRESS_FLAG) == 0)	&&
			((PRESSED&BIT_KEY2_LONGPRESS_FLAG) == 0)	&&
            ((PRESSED&BIT_KEY3_LONGPRESS_FLAG) == 0)
    ){	
		if((PRESSED&0x0F) > 0){
			switch(PRESSED&0x0F){
				case KEY1_Pressed:
					OUT1 = ~OUT1;
                    led1_debug();
					break;
				case KEY2_Pressed:
					OUT2 = ~OUT2;
					led1_debug();
					break;
				case KEY3_Pressed:
					OUT3 = ~OUT3;
                    led1_debug();
					break;			
			}
		}
		PRESSED &= 0xF0;       
	}

}
//===========================================================
//Funtion name��main
//parameters����
//returned value����
//===========================================================
main(){
    OSC_INIT();
    TIMER0_INITIAL();
    TIMER2_INITIAL();
    INT_INITIAL();
    EEPROM_Read();    
	WDT_INITIAL();
	LED1 = 1;
    OUT1 = 1;
    OUT2 = 1;
    OUT3 = 1;
    
	SHDN = 0;
	FLAGs &= ~BIT_Head_flag;
	EX_INT_FallingEdge();
	EX_INT_Enable;
//	head_slice_counter = 0;
	TMR2_Enable;

	PEIE    = 1;    				//ʹ�������ж�
	GIE     = 1;   				//ʹ��ȫ���ж�
    while(1){
		CLRWDT(); 		   //�忴�Ź�

	}
}
//===========================================================