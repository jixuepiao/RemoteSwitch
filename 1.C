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

//#define LED1_Debug_ON

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
#define LONGPRESS_OVERTIME	15							//单位s 配对超时
#define REMOTEKEY_SLICE_OVERTIME_ms	110			//单位ms 在time2中断中计数	//遥控字接收超时中断时间
#define REMOTEKEY_SLICE_OVERTIME_us	(REMOTEKEY_SLICE_OVERTIME_ms*1000)	//单位us 在time2中断中计数	//遥控字接收超时中断时间

#define MATCH_TIMES		3

#define BIT_edge_flag 							0x01//遥控波形接收时检测到的边沿属性标志，1为上升沿荆?为下降沿
#define BIT_remotekey_detected_flag 	0x02//遥控波形接收时检测到的边沿属性标志，1为上升沿荆?为下降沿
#define BIT_SYN480_Runflag 				0x04//0没在接收	1在接收
#define BIT_Head_flag			 				0x08//遥控波形的起始为9ms左右低电平，检测到该波形时认为检测到遥控波形头，置该标志位。检测到头标志后记录之后24个负脉冲作为位数据,之后清零
#define BIT_key1_remotekey_dealed_flag	0x10
#define BIT_key2_remotekey_dealed_flag	0x20
#define BIT_key3_remotekey_dealed_flag	0x40
#define BIT_remotekey_detecting_flag			0x80

#define BIT_KEY1_LONGPRESS_FLAG	0x10
#define BIT_KEY2_LONGPRESS_FLAG	0x20
#define BIT_KEY3_LONGPRESS_FLAG	0x40

unsigned char FLAGs = 0;
unsigned char PRESS_FLAG = 0;//按键按下标识	bit0～bit2：KEY1～KEY3	高4位作为长按标志

//unsigned char SYN480_Runflag = 0;	//0没在接收	1在接收
//unsigned char edge_flag = 0;//遥控波形接收时检测到的边沿属性标志，1为上升沿，0为下降沿
//unsigned char Head_flag = 0;//遥控波形的起始为9ms左右低电平，检测到该波形时认为检测到遥控波形头，置该标志位。检测到头标志后记录之后24个负脉冲作为位数据,之后清零

//接收到有效遥控字后，如果还连续接收到头，则不再响应后续遥控字
//在两个头间隔大于(REMOTEKEY_SLICE_OVERTIME/TIMER2_us)时，认为上一个有效字发送完成，可以响应下一个有效字
//unsigned char key1_remotekey_dealed_flag = 0;//为1时表示有效遥控字已经处理
//unsigned char key2_remotekey_dealed_flag = 0;
//unsigned char key3_remotekey_dealed_flag = 0;


//unsigned char KEY1_LONGPRESS_FLAG = 0;//KEY1长按标志，在长按动作被处理完成之后清零，超时10s清零
//unsigned char KEY2_LONGPRESS_FLAG = 0;//KEY2长按标志，在长按动作被处理完成之后清零，超时10s清零
//unsigned char KEY3_LONGPRESS_FLAG = 0;//KEY3长按标志，在长按动作被处理完成之后清零，超时10s清零

unsigned int buff;
unsigned long remotekey = 0;//接收过程中遥控字暂存
unsigned long Ctrl_remotekey = 0;//控制时确认接收到的遥控字
unsigned long Match_remotekey = 0;//配对时确认接收到的遥控字
unsigned char remotekey_slice = 0;//两相同遥控字之间的接收间隔，当小于REMOTEKEY_SLICE_OVERTIME时认为连续接收，超过认为中断。连续接收的遥控字只响应一次。																	
unsigned char match_slice = 0;//配对时使用，两相同遥控字之间的接收间隔，当小于REMOTEKEY_SLICE_OVERTIME时认为连续接收，超过认为中断。连续接收的遥控字只响应一次?													
unsigned char remotekey_Receive_num = 0;//同一遥控字重复接收次数
unsigned int Indata = 0;	//定时器2数Din为0的个数来计算低电平脉宽

unsigned char num = 0;	//接收遥控码的第几位
unsigned char ms16_counter = 0;//16ms计数
unsigned char KEY_Match_counter = 0;//配对步骤计数
unsigned char PRESSED = 0;//按键确认按下标识	bit0～bit4：KEY1～KEY5
unsigned char KEY1_LongPress = 0;//KEY1长按ms计数
unsigned char KEY2_LongPress = 0;//KEY2长按ms计数
unsigned char KEY3_LongPress = 0;//KEY3长按ms计数
unsigned char LONGPRESS_OverTime_Counter = 0;//长按超时计时
unsigned char EE_Buff = 0;//EEPROM读取时暂存数据
unsigned long CH1_remotekey[4];//CH1遥控字
unsigned long CH2_remotekey[4];//CH2遥控字
unsigned long CH3_remotekey[4];//CH3遥控字
unsigned char CH1_remotekey_num = 0;//存放CH1遥控字的数量 遥控字的序号 最大为4
unsigned char CH2_remotekey_num = 0;//存放CH2遥控字的数量 遥控字的序号 最大为4
unsigned char CH3_remotekey_num = 0;//存放CH3遥控字的数量 遥控字的序号 最大为4
unsigned char CH1_remotekey_Latest = 0;//存放CH1最近一次控制时的遥控字的序号
unsigned char CH2_remotekey_Latest = 0;
unsigned char CH3_remotekey_Latest = 0;
unsigned char i;
unsigned int HIndata = 0;
unsigned int LIndata = 0;

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
//Funtion name：interrupt ISR
//parameters：无
//returned value：无
//===========================================================
void interrupt ISR(void){
  //PA2外部中断处理**********************
	if(INTE && INTF){
		INTF = 0;//清PA2 INT 标志位
		INTE = 0;//暂先禁止PA2中?
        TMR2_Disable;
		if((FLAGs&BIT_edge_flag) == 0){//为下降沿中断
			Indata = 0;
			EX_INT_RisingEdge();
		}else if((FLAGs&BIT_edge_flag) == BIT_edge_flag){//为上升沿中断
			EX_INT_FallingEdge();      
			buff = Indata*TIMER2_us;
			Indata = 0; 
			
			if(		((FLAGs&BIT_key1_remotekey_dealed_flag) == 0) &&
					((FLAGs&BIT_key2_remotekey_dealed_flag) == 0) &&
					((FLAGs&BIT_key3_remotekey_dealed_flag) == 0)
			){
				if((FLAGs&BIT_Head_flag) == BIT_Head_flag){	//接收到头时接收24个位
					if(num < 24){
						if((buff>200)&&(buff<600)){
							remotekey = remotekey<<1;
							remotekey |= 0x00000001;
						}
						if((buff>700)&&(buff<1800)){
							remotekey = remotekey<<1;
						}
						num++;
					}
					
					if(num >= 24){//接收到24个位之后
						
						if(remotekey>0){
							if(Match_remotekey == remotekey){
								remotekey_Receive_num++;
								match_slice = 0;
							}
							if(remotekey_Receive_num == 0) Match_remotekey = remotekey;	//在超时重复接收数清零时更新，
						}

						Ctrl_remotekey = remotekey;
						//遥控字响应，在长按状态下不响应遥控字
						if(		((PRESSED&BIT_KEY1_LONGPRESS_FLAG) == 0)	&&
								((PRESSED&BIT_KEY2_LONGPRESS_FLAG) == 0)	&&
								((PRESSED&BIT_KEY3_LONGPRESS_FLAG) == 0)
						){
							if((FLAGs&BIT_key1_remotekey_dealed_flag) == 0){
								for(buff=0;buff<CH1_remotekey_num;buff++){
									if(Ctrl_remotekey == CH1_remotekey[buff]){
										FLAGs |= BIT_key1_remotekey_dealed_flag;//接收到有效遥控字
										led1_debug();
										OUT1 = ~OUT1;
										CH1_remotekey_Latest = buff;
									}
								}
							}
							if((FLAGs&BIT_key2_remotekey_dealed_flag) == 0){
								for(buff=0;buff<CH2_remotekey_num;buff++){
									if(Ctrl_remotekey == CH2_remotekey[buff]){
										FLAGs |= BIT_key2_remotekey_dealed_flag;//接收到有效遥控字
										led1_debug();
										OUT2 = ~OUT2;
										CH2_remotekey_Latest = buff;
									}
								}
							}
							if((FLAGs&BIT_key3_remotekey_dealed_flag) == 0){
								 for(buff=0;buff<CH3_remotekey_num;buff++){
									if(Ctrl_remotekey == CH3_remotekey[buff]){
										FLAGs |= BIT_key3_remotekey_dealed_flag;//接收到有效遥控字
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
        TMR2_Enable;
		INTE = 1;//使能PA2 INT中断
	}
    
//定时器2的中断处理**********************
	if(TMR2IE && TMR2IF){			//50us中断一次
		TMR2IF = 0;
	
        if((FLAGs&BIT_remotekey_detected_flag) == BIT_remotekey_detected_flag){
			Indata++;
		}else{
        
//        if(DIN == 1){
//            FLAGs |= BIT_remotekey_detected_flag;
//            remotekey_slice = 0;
////            led1_debug();
//		}
      		
		
			if((FLAGs&BIT_remotekey_detecting_flag) == 0){
				if(DIN == 1){
					HIndata++;
				}else{
				   buff = HIndata*TIMER2_us; 
				   HIndata = 0; 
				   if(	((buff>200)&&(buff<600))	||
						((buff>700)&&(buff<1800))
				   ){
						FLAGs |= BIT_remotekey_detecting_flag;
					}else{
						i = 0;
					}
				}
			}
			if((FLAGs&BIT_remotekey_detecting_flag) == BIT_remotekey_detecting_flag){
				if(DIN == 0){
					LIndata++;
				}else{
					buff = LIndata*TIMER2_us;               
					LIndata = 0;
					if(	((buff>200)&&(buff<600))	||
						((buff>700)&&(buff<1800))
					){
						i++;                   
					}else{
						i = 0;
					}
					FLAGs &= ~BIT_remotekey_detecting_flag;
				}		
			}
			if(i>3){
				FLAGs |= BIT_remotekey_detected_flag;
				i = 0;
	//            led1_debug();
			}
        }
	}
    
//定时器0的中断处理**********************
	if(T0IE && T0IF){               //8ms定时
		T0IF = 0;
        ms16_counter ++;
        
        //相同码在接收间隔小于REMOTEKEY_SLICE_OVERTIME时只响应一次，在大于时清标志位
		if(		((FLAGs&BIT_key1_remotekey_dealed_flag) == BIT_key1_remotekey_dealed_flag) ||
				((FLAGs&BIT_key2_remotekey_dealed_flag) == BIT_key2_remotekey_dealed_flag) ||
				((FLAGs&BIT_key3_remotekey_dealed_flag) == BIT_key3_remotekey_dealed_flag)
		){
			remotekey_slice++;
			if(	remotekey_slice>(REMOTEKEY_SLICE_OVERTIME_ms/TIMER0_ms)){
				remotekey_slice = 0;
//				FLAGs &= ~BIT_Head_flag;
				FLAGs &= ~BIT_remotekey_detected_flag;
				FLAGs &= ~BIT_key1_remotekey_dealed_flag;
				FLAGs &= ~BIT_key2_remotekey_dealed_flag;		
				FLAGs &= ~BIT_key3_remotekey_dealed_flag;		
			}
		}
		//配对时接收到一个完整码之后，在间隔内没有再接收到，则舍掉当前码，重新接受
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

//SYN480低功耗控制
		if((FLAGs&BIT_remotekey_detected_flag) == 0){
			EE_Buff = ms16_counter%8;
			if(EE_Buff == 1){
				SHDN = 0;
//				FLAGs &= ~BIT_Head_flag;
				EX_INT_FallingEdge();
				EX_INT_Enable;
				TMR2_Enable;
			}
			if(EE_Buff == 4){
				SHDN = 1;	
				TMR2_Disable;
				EX_INT_Disable;
			}
        }else{
            SHDN = 0;
			EX_INT_Enable;
			TMR2_Enable;           
		}
        
//按键扫描
        if(ms16_counter%2 == 0){
			KEYSCAN();
			KEY();
        }
 
//整秒操作
//		if(ms16_counter >= 1000/TIMER0_ms){
		if(ms16_counter >= 120){
			ms16_counter = 0;			
//			led1_debug();			
			//长按超时计时
			if(		((PRESSED&BIT_KEY1_LONGPRESS_FLAG) == BIT_KEY1_LONGPRESS_FLAG)	||
					((PRESSED&BIT_KEY2_LONGPRESS_FLAG) == BIT_KEY2_LONGPRESS_FLAG)	||
					((PRESSED&BIT_KEY3_LONGPRESS_FLAG) == BIT_KEY3_LONGPRESS_FLAG)
			 ){
				if(KEY_Match_counter<4){
					KEY_Match_counter++;	//最大为4
				}
				LONGPRESS_OverTime_Counter++;
				if(LONGPRESS_OverTime_Counter > LONGPRESS_OVERTIME){//计时超时
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
	IOCA2 =0;  //禁止PA2电平变化中断
	EX_INT_FallingEdge();
	INTF =0;   //清PA2 INT中断标志位
//	INTE =1;   //使能PA2 INT中断
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
											//Bit0=1,系统时钟为内部振荡器
											//Bit0=0,时钟源由FOSC<2：0>决定即编译选项时选择

	INTCON = 0; //暂禁止所有中断
    
	PORTA = 0B00000000;		
	TRISA = 0B00010111;	//PA输入输出 0-输出 1-输入
	WPUA = 0B00000000;    //PA端口上拉控制 1-开上拉 0-关上拉//开PA6上?    
    PSRCA = 0B11111111;  //源电流设置最大
    PSINKA = 0B11111111;    //灌电流设置最大    
							
	PORTC = 0B00000000; 	
	TRISC = 0B11110000;	//PC输入输出 0-输出 1-输入  
	WPUC = 0B00000000;    //PC端口上拉控制 1-开上拉 0-关上拉//60系列PC口无上拉						
	PSRCC = 0B11111111;  
    PSINKC = 0B11111111;
        
	OPTION = 0B00001000;	//Bit3=1 WDT MODE,PS=000=1:1 WDT RATE
					 		//Bit7(PAPU)=0 ENABLED PULL UP PA
}
void WDT_INITIAL (void){
	CLRWDT();  				//清看门狗
	WDTCON = 0B00010110;	//WDTPS=1001=1:32768,PS=000=1:1
					 		//定时时间=(32768*1)/32000=1024ms
}
void TIMER0_INITIAL (void){
	T0CS = 0;//Bit5 T0CS Timer0时钟源选择 1-外部引脚电T0CKI平变化 0-内部时钟(FOSC/2)
    PSA = 0;//Bit3 PSA 预分频器分配位 0-Timer0 1-WDT 
    OPTION  &= 0xF8;
    OPTION  |= 0x06;//Bit2:0 PS2 8个预分频比 110 - 1:128
	//设置TMR0定时时长8ms=(1/8000000)*2*128*250				
	TMR0 = 5;
    T0IE = 1;				//开定时器/计数器0中断
	T0IF = 0;				//清空T0软件中断
}
void TIMER2_INITIAL (void){    
    T2CON0  = 0B00000001; 			//T2预分频1:1，后分频1：4
    //BIT7: 0：无意义； 1：把PR2/P1xDTy缓冲值分别更新到PR2寄存器和P1xDTy_ACT
    //BIT6~BIT3: 定时器2输出后分频比选择 0000:1:1;0001:1:2;……1:16
    //BIT2:0:关闭定时器2；1：打开定时器2
    //BIT1~0:定时器2预分频选择 00:1;01:4;1x:16
    
	T2CON1  = 0B00000000;		   //T2时钟来自系统时钟,PWM1连续模式
	//BIT4: PWM模式选择 0:连续模式；1：单脉冲模式
    //BIT3: 0:PWM模式；1：蜂鸣器模式	
    //Timer2时钟源选择：000：指令时钟；001：系统时钟；010：HIRC的2倍频；100：HIRC；101：LIRC
    						
    TMR2H  	= (TIMER2_us)/256;					//定时器2计数寄存器  =1/8*2*4*200
    TMR2L  	= (TIMER2_us)%256;
    
    
	PR2H    =  (TIMER2_us)/256; 					//周期=（PR+1）*Tt2ck*TMR2预分频(蜂鸣器模式周期*2)
	PR2L    = (TIMER2_us)%256;	  
                  
	TMR2IF  = 0;					//清TMER2中断标志
	TMR2IE = 1;						//使能TMER2的中断（配置成timer定时器时不注释）
//	TMR2ON  = 1;					//使能TMER2启动
    TMR2_Disable;
}
unsigned char IAPRead(unsigned char EEAddr){
	unsigned char ReEEPROMread;
	EEADR = EEAddr;    
	RD = 1;
	ReEEPROMread = EEDAT;     		//EEPROM的读数据 ReEEPROMread = EEDATA;
	return ReEEPROMread;
}
void IAPWrite(unsigned char EEAddr,unsigned char Data){
	GIE = 0;						//写数据必须关闭中断
	while(GIE); 					//等待GIE为0
	EEADR = EEAddr; 	 			//EEPROM的地址
	EEDAT = Data;		 			//EEPROM的写数据  EEDATA = Data;
	EEIF = 0;
	EECON1 |= 0x34;					//置位WREN1,WREN2,WREN3三个变量.
	WR = 1;							//置位WR启动编程
	while(WR);      				//等待EE写入完成
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
				Match_remotekey = 0xFFFFFFFF;	//清遥控字
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
				if(remotekey_Receive_num >= MATCH_TIMES){	//接收到新遥控字
					if((PRESSED&BIT_KEY1_LONGPRESS_FLAG) == BIT_KEY1_LONGPRESS_FLAG){
						if(	(Match_remotekey != CH1_remotekey[0])	&&
							(Match_remotekey != CH1_remotekey[1])	&&
							(Match_remotekey != CH1_remotekey[2])	&&
							(Match_remotekey != CH1_remotekey[3])
                        ){
							if(CH1_remotekey_num < 4){//4组遥控字还没有满，不清遥控字，只增加
								CH1_remotekey[CH1_remotekey_num] = Match_remotekey;
								CH1_remotekey_num++;
							}else{//4组遥控字满了，清最近一次遥控控制时的遥控字并更新为新遥控字
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
							if(CH2_remotekey_num < 4){//4组遥控字还没有满，不清遥控字，只增加
								CH2_remotekey[CH2_remotekey_num] = Match_remotekey;
								CH2_remotekey_num++;
							}else{//4组遥控字满了，清最近一次遥控控制时的遥控字并更新为新遥控字
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
							if(CH3_remotekey_num < 4){//4组遥控字还没有满，不清遥控字，只增加
								CH3_remotekey[CH3_remotekey_num] = Match_remotekey;
								CH3_remotekey_num++;
							}else{//4组遥控字满了，清最近一次遥控控制时的遥控字并更新为新遥控字
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

	//有按键被长按状态下不再响应按键按下动作
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
//Funtion name：main
//parameters：无
//returned value：无
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
	TMR2_Enable;

	PEIE    = 1;    				//使能外设中断
	GIE     = 1;   				//使能全局中断
    while(1){
		CLRWDT(); 		   //清看门狗

	}
}
//===========================================================
