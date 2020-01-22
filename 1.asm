//Deviec:FT60F12X
//-----------------------Variable---------------------------------
		_FLAGs		EQU		74H
		_PRESS_FLAG		EQU		27H
		_buff		EQU		20H
		_remotekey		EQU		A4H
		_Ctrl_remotekey		EQU		A0H
		_Match_remotekey		EQU		70H
		_remotekey_slice		EQU		2CH
		_match_slice		EQU		28H
		_remotekey_Receive_num		EQU		2BH
		_Indata		EQU		A8H
		_Key_dealed_counter		EQU		26H
		_num		EQU		2AH
		_ms16_counter		EQU		29H
		_KEY_Match_counter		EQU		25H
		_PRESSED		EQU		75H
		_KEY1_LongPress		EQU		22H
		_KEY2_LongPress		EQU		23H
		_KEY3_LongPress		EQU		24H
		_LONGPRESS_OverTime_Counter		EQU		AAH
		_EE_Buff		EQU		B6H
		_CH1_remotekey		EQU		2DH
		_CH2_remotekey		EQU		3DH
		_CH3_remotekey		EQU		4DH
		_CH1_remotekey_num		EQU		67H
		_CH2_remotekey_num		EQU		68H
		_CH3_remotekey_num		EQU		69H
		_CH1_remotekey_Latest		EQU		B3H
		_CH2_remotekey_Latest		EQU		B4H
		_CH3_remotekey_Latest		EQU		B5H
//-----------------------Variable END---------------------------------
		ORG		0000H
		LJUMP 	0FH 			//0000 	380F
		ORG		0004H
		STR 	7EH 			//0004 	01FE
		SWAPR 	STATUS,0 		//0005 	0703
		BCR 	STATUS,5 		//0006 	1283
		STR 	63H 			//0007 	01E3
		LDR 	FSR,0 			//0008 	0804
		STR 	64H 			//0009 	01E4
		LDR 	PCLATH,0 		//000A 	080A
		STR 	65H 			//000B 	01E5
		ORG		000CH
		LDR 	7FH,0 			//000C 	087F
		STR 	66H 			//000D 	01E6
		LJUMP 	10H 			//000E 	3810
		LJUMP 	661H 			//000F 	3E61

		//;1.C: 140: if(INTE && INTF){
		BTSC 	INTCON,4 		//0010 	160B
		BTSS 	INTCON,1 		//0011 	1C8B
		LJUMP 	162H 			//0012 	3962

		//;1.C: 141: INTF = 0;
		BCR 	INTCON,1 		//0013 	108B
		ORG		0014H

		//;1.C: 142: INTE = 0;
		BCR 	INTCON,4 		//0014 	120B

		//;1.C: 143: TMR2ON =0;
		BCR 	12H,2 			//0015 	1112

		//;1.C: 144: if((FLAGs&0x01) == 0){
		BTSC 	74H,0 			//0016 	1474
		LJUMP 	1DH 			//0017 	381D

		//;1.C: 145: Indata = 0;
		BSR 	STATUS,5 		//0018 	1A83
		CLRR 	28H 			//0019 	0128
		CLRR 	29H 			//001A 	0129

		//;1.C: 146: EX_INT_RisingEdge();
		LCALL 	6A5H 			//001B 	36A5
		ORG		001CH

		//;1.C: 147: }else if((FLAGs&0x01) == 0x01){
		LJUMP 	15FH 			//001C 	395F
		BTSS 	74H,0 			//001D 	1C74
		LJUMP 	15FH 			//001E 	395F

		//;1.C: 148: EX_INT_FallingEdge();
		LCALL 	69EH 			//001F 	369E

		//;1.C: 149: buff = Indata*53;
		LDR 	29H,0 			//0020 	0829
		STR 	77H 			//0021 	01F7
		LDR 	28H,0 			//0022 	0828
		STR 	76H 			//0023 	01F6
		ORG		0024H
		LDWI 	35H 			//0024 	2A35
		STR 	78H 			//0025 	01F8
		CLRR 	79H 			//0026 	0179
		LCALL 	60FH 			//0027 	360F
		LDR 	77H,0 			//0028 	0877
		BCR 	STATUS,5 		//0029 	1283
		STR 	21H 			//002A 	01A1
		LDR 	76H,0 			//002B 	0876
		ORG		002CH
		STR 	20H 			//002C 	01A0

		//;1.C: 150: Indata = 0;
		BSR 	STATUS,5 		//002D 	1A83
		CLRR 	28H 			//002E 	0128
		CLRR 	29H 			//002F 	0129

		//;1.C: 152: if( ((FLAGs&0x10) == 0) &&
		//;1.C: 153: ((FLAGs&0x20) == 0) &&
		//;1.C: 154: ((FLAGs&0x40) == 0)
		//;1.C: 155: ){
		BTSS 	74H,4 			//0030 	1E74
		BTSC 	74H,5 			//0031 	16F4
		LJUMP 	15FH 			//0032 	395F
		BTSC 	74H,6 			//0033 	1774
		ORG		0034H
		LJUMP 	15FH 			//0034 	395F

		//;1.C: 156: if((FLAGs&0x08) == 0x08){
		BTSS 	74H,3 			//0035 	1DF4
		LJUMP 	14BH 			//0036 	394B

		//;1.C: 157: if(num < 24){
		LDWI 	18H 			//0037 	2A18
		BCR 	STATUS,5 		//0038 	1283
		SUBWR 	2AH,0 			//0039 	0C2A
		BTSC 	STATUS,0 		//003A 	1403
		LJUMP 	60H 			//003B 	3860
		ORG		003CH

		//;1.C: 158: if((buff>200)&&(buff<600)){
		LDWI 	0H 			//003C 	2A00
		SUBWR 	21H,0 			//003D 	0C21
		LDWI 	C9H 			//003E 	2AC9
		BTSC 	STATUS,2 		//003F 	1503
		SUBWR 	20H,0 			//0040 	0C20
		LDWI 	2H 			//0041 	2A02
		BTSS 	STATUS,0 		//0042 	1C03
		LJUMP 	4EH 			//0043 	384E
		ORG		0044H
		SUBWR 	21H,0 			//0044 	0C21
		LDWI 	58H 			//0045 	2A58
		BTSC 	STATUS,2 		//0046 	1503
		SUBWR 	20H,0 			//0047 	0C20
		BTSC 	STATUS,0 		//0048 	1403
		LJUMP 	4DH 			//0049 	384D

		//;1.C: 159: remotekey = remotekey<<1;
		BCR 	STATUS,0 		//004A 	1003
		LCALL 	25DH 			//004B 	325D
		ORG		004CH

		//;1.C: 160: remotekey |= 0x00000001;
		BSR 	24H,0 			//004C 	1824

		//;1.C: 161: }
		//;1.C: 162: if((buff>700)&&(buff<1800)){
		LDWI 	2H 			//004D 	2A02
		BCR 	STATUS,5 		//004E 	1283
		SUBWR 	21H,0 			//004F 	0C21
		LDWI 	BDH 			//0050 	2ABD
		BTSC 	STATUS,2 		//0051 	1503
		SUBWR 	20H,0 			//0052 	0C20
		BTSS 	STATUS,0 		//0053 	1C03
		ORG		0054H
		LJUMP 	5EH 			//0054 	385E
		LDWI 	7H 			//0055 	2A07
		SUBWR 	21H,0 			//0056 	0C21
		LDWI 	8H 			//0057 	2A08
		BTSC 	STATUS,2 		//0058 	1503
		SUBWR 	20H,0 			//0059 	0C20
		BTSC 	STATUS,0 		//005A 	1403
		LJUMP 	5EH 			//005B 	385E
		ORG		005CH

		//;1.C: 163: remotekey = remotekey<<1;
		BCR 	STATUS,0 		//005C 	1003
		LCALL 	25DH 			//005D 	325D

		//;1.C: 164: }
		//;1.C: 165: num++;
		BCR 	STATUS,5 		//005E 	1283
		INCR	2AH,1 			//005F 	09AA

		//;1.C: 166: }
		//;1.C: 168: if(num >= 24){
		LDWI 	18H 			//0060 	2A18
		SUBWR 	2AH,0 			//0061 	0C2A
		BTSS 	STATUS,0 		//0062 	1C03
		LJUMP 	14BH 			//0063 	394B
		ORG		0064H

		//;1.C: 170: if(remotekey>0){
		BSR 	STATUS,5 		//0064 	1A83
		LDR 	27H,0 			//0065 	0827
		IORWR 	26H,0 			//0066 	0326
		IORWR 	25H,0 			//0067 	0325
		IORWR 	24H,0 			//0068 	0324
		BTSC 	STATUS,2 		//0069 	1503
		LJUMP 	8BH 			//006A 	388B

		//;1.C: 171: if(Match_remotekey == remotekey){
		LDR 	27H,0 			//006B 	0827
		ORG		006CH
		XORWR 	73H,0 			//006C 	0473
		BTSS 	STATUS,2 		//006D 	1D03
		LJUMP 	79H 			//006E 	3879
		LDR 	26H,0 			//006F 	0826
		XORWR 	72H,0 			//0070 	0472
		BTSS 	STATUS,2 		//0071 	1D03
		LJUMP 	79H 			//0072 	3879
		LDR 	25H,0 			//0073 	0825
		ORG		0074H
		XORWR 	71H,0 			//0074 	0471
		BTSS 	STATUS,2 		//0075 	1D03
		LJUMP 	79H 			//0076 	3879
		LDR 	24H,0 			//0077 	0824
		XORWR 	70H,0 			//0078 	0470

		//;1.C: 172: remotekey_Receive_num++;
		BCR 	STATUS,5 		//0079 	1283
		BTSS 	STATUS,2 		//007A 	1D03
		LJUMP 	7FH 			//007B 	387F
		ORG		007CH
		INCR	2BH,1 			//007C 	09AB

		//;1.C: 173: match_slice = 0;
		CLRR 	28H 			//007D 	0128

		//;1.C: 174: }
		//;1.C: 175: if(remotekey_Receive_num == 0) Match_remotekey = remotekey;
		BCR 	STATUS,5 		//007E 	1283
		LDR 	2BH,1 			//007F 	08AB
		BSR 	STATUS,5 		//0080 	1A83
		BTSS 	STATUS,2 		//0081 	1D03
		LJUMP 	8CH 			//0082 	388C
		LDR 	27H,0 			//0083 	0827
		ORG		0084H
		STR 	73H 			//0084 	01F3
		LDR 	26H,0 			//0085 	0826
		STR 	72H 			//0086 	01F2
		LDR 	25H,0 			//0087 	0825
		STR 	71H 			//0088 	01F1
		LDR 	24H,0 			//0089 	0824
		STR 	70H 			//008A 	01F0

		//;1.C: 176: }
		//;1.C: 178: Ctrl_remotekey = remotekey;
		BSR 	STATUS,5 		//008B 	1A83
		ORG		008CH
		LDR 	27H,0 			//008C 	0827
		STR 	23H 			//008D 	01A3
		LDR 	26H,0 			//008E 	0826
		STR 	22H 			//008F 	01A2
		LDR 	25H,0 			//0090 	0825
		STR 	21H 			//0091 	01A1
		LDR 	24H,0 			//0092 	0824
		STR 	20H 			//0093 	01A0
		ORG		0094H

		//;1.C: 180: if( ((PRESSED&0x10) == 0) &&
		//;1.C: 181: ((PRESSED&0x20) == 0) &&
		//;1.C: 182: ((PRESSED&0x40) == 0)
		//;1.C: 183: ){
		BTSS 	75H,4 			//0094 	1E75
		BTSC 	75H,5 			//0095 	16F5
		LJUMP 	141H 			//0096 	3941
		BTSC 	75H,6 			//0097 	1775
		LJUMP 	141H 			//0098 	3941

		//;1.C: 184: if((FLAGs&0x10) == 0){
		BTSC 	74H,4 			//0099 	1674
		LJUMP 	D1H 			//009A 	38D1

		//;1.C: 185: for(buff=0;buff<CH1_remotekey_num;buff++){
		BCR 	STATUS,5 		//009B 	1283
		ORG		009CH
		CLRR 	20H 			//009C 	0120
		CLRR 	21H 			//009D 	0121
		LDR 	67H,0 			//009E 	0867
		STR 	5DH 			//009F 	01DD
		CLRR 	5EH 			//00A0 	015E
		LDR 	5EH,0 			//00A1 	085E
		SUBWR 	21H,0 			//00A2 	0C21
		BTSS 	STATUS,2 		//00A3 	1D03
		ORG		00A4H
		LJUMP 	A7H 			//00A4 	38A7
		LDR 	5DH,0 			//00A5 	085D
		SUBWR 	20H,0 			//00A6 	0C20
		BTSC 	STATUS,0 		//00A7 	1403
		LJUMP 	D1H 			//00A8 	38D1

		//;1.C: 186: if(Ctrl_remotekey == CH1_remotekey[buff]){
		LDR 	20H,0 			//00A9 	0820
		LCALL 	23FH 			//00AA 	323F
		ADDWI 	2DH 			//00AB 	272D
		ORG		00ACH
		LCALL 	223H 			//00AC 	3223
		LDR 	23H,0 			//00AD 	0823
		BCR 	STATUS,5 		//00AE 	1283
		XORWR 	61H,0 			//00AF 	0461
		BTSS 	STATUS,2 		//00B0 	1D03
		LJUMP 	C2H 			//00B1 	38C2
		BSR 	STATUS,5 		//00B2 	1A83
		LDR 	22H,0 			//00B3 	0822
		ORG		00B4H
		BCR 	STATUS,5 		//00B4 	1283
		XORWR 	60H,0 			//00B5 	0460
		BTSS 	STATUS,2 		//00B6 	1D03
		LJUMP 	C2H 			//00B7 	38C2
		BSR 	STATUS,5 		//00B8 	1A83
		LDR 	21H,0 			//00B9 	0821
		BCR 	STATUS,5 		//00BA 	1283
		XORWR 	5FH,0 			//00BB 	045F
		ORG		00BCH
		BTSS 	STATUS,2 		//00BC 	1D03
		LJUMP 	C2H 			//00BD 	38C2
		BSR 	STATUS,5 		//00BE 	1A83
		LDR 	20H,0 			//00BF 	0820
		BCR 	STATUS,5 		//00C0 	1283
		XORWR 	5EH,0 			//00C1 	045E
		BTSS 	STATUS,2 		//00C2 	1D03
		LJUMP 	CCH 			//00C3 	38CC
		ORG		00C4H

		//;1.C: 187: FLAGs |= 0x10;
		BSR 	74H,4 			//00C4 	1A74

		//;1.C: 188: Key_dealed_counter = 0;
		CLRR 	26H 			//00C5 	0126

		//;1.C: 189: led1_debug();
		LCALL 	6A2H 			//00C6 	36A2

		//;1.C: 190: PA7 = ~PA7;
		LDWI 	80H 			//00C7 	2A80
		XORWR 	5H,1 			//00C8 	0485

		//;1.C: 191: CH1_remotekey_Latest = buff;
		LDR 	20H,0 			//00C9 	0820
		BSR 	STATUS,5 		//00CA 	1A83
		STR 	33H 			//00CB 	01B3
		ORG		00CCH
		BCR 	STATUS,5 		//00CC 	1283
		INCR	20H,1 			//00CD 	09A0
		BTSC 	STATUS,2 		//00CE 	1503
		INCR	21H,1 			//00CF 	09A1
		LJUMP 	9EH 			//00D0 	389E

		//;1.C: 192: }
		//;1.C: 193: }
		//;1.C: 194: }
		//;1.C: 195: if((FLAGs&0x20) == 0){
		BTSC 	74H,5 			//00D1 	16F4
		LJUMP 	109H 			//00D2 	3909

		//;1.C: 196: for(buff=0;buff<CH2_remotekey_num;buff++){
		BCR 	STATUS,5 		//00D3 	1283
		ORG		00D4H
		CLRR 	20H 			//00D4 	0120
		CLRR 	21H 			//00D5 	0121
		LDR 	68H,0 			//00D6 	0868
		STR 	5DH 			//00D7 	01DD
		CLRR 	5EH 			//00D8 	015E
		LDR 	5EH,0 			//00D9 	085E
		SUBWR 	21H,0 			//00DA 	0C21
		BTSS 	STATUS,2 		//00DB 	1D03
		ORG		00DCH
		LJUMP 	DFH 			//00DC 	38DF
		LDR 	5DH,0 			//00DD 	085D
		SUBWR 	20H,0 			//00DE 	0C20
		BTSC 	STATUS,0 		//00DF 	1403
		LJUMP 	109H 			//00E0 	3909

		//;1.C: 197: if(Ctrl_remotekey == CH2_remotekey[buff]){
		LDR 	20H,0 			//00E1 	0820
		LCALL 	23FH 			//00E2 	323F
		ADDWI 	3DH 			//00E3 	273D
		ORG		00E4H
		LCALL 	223H 			//00E4 	3223
		LDR 	23H,0 			//00E5 	0823
		BCR 	STATUS,5 		//00E6 	1283
		XORWR 	61H,0 			//00E7 	0461
		BTSS 	STATUS,2 		//00E8 	1D03
		LJUMP 	FAH 			//00E9 	38FA
		BSR 	STATUS,5 		//00EA 	1A83
		LDR 	22H,0 			//00EB 	0822
		ORG		00ECH
		BCR 	STATUS,5 		//00EC 	1283
		XORWR 	60H,0 			//00ED 	0460
		BTSS 	STATUS,2 		//00EE 	1D03
		LJUMP 	FAH 			//00EF 	38FA
		BSR 	STATUS,5 		//00F0 	1A83
		LDR 	21H,0 			//00F1 	0821
		BCR 	STATUS,5 		//00F2 	1283
		XORWR 	5FH,0 			//00F3 	045F
		ORG		00F4H
		BTSS 	STATUS,2 		//00F4 	1D03
		LJUMP 	FAH 			//00F5 	38FA
		BSR 	STATUS,5 		//00F6 	1A83
		LDR 	20H,0 			//00F7 	0820
		BCR 	STATUS,5 		//00F8 	1283
		XORWR 	5EH,0 			//00F9 	045E
		BTSS 	STATUS,2 		//00FA 	1D03
		LJUMP 	104H 			//00FB 	3904
		ORG		00FCH

		//;1.C: 198: FLAGs |= 0x20;
		BSR 	74H,5 			//00FC 	1AF4

		//;1.C: 199: Key_dealed_counter = 0;
		CLRR 	26H 			//00FD 	0126

		//;1.C: 200: led1_debug();
		LCALL 	6A2H 			//00FE 	36A2

		//;1.C: 201: PA6 = ~PA6;
		LDWI 	40H 			//00FF 	2A40
		XORWR 	5H,1 			//0100 	0485

		//;1.C: 202: CH2_remotekey_Latest = buff;
		LDR 	20H,0 			//0101 	0820
		BSR 	STATUS,5 		//0102 	1A83
		STR 	34H 			//0103 	01B4
		ORG		0104H
		BCR 	STATUS,5 		//0104 	1283
		INCR	20H,1 			//0105 	09A0
		BTSC 	STATUS,2 		//0106 	1503
		INCR	21H,1 			//0107 	09A1
		LJUMP 	D6H 			//0108 	38D6

		//;1.C: 203: }
		//;1.C: 204: }
		//;1.C: 205: }
		//;1.C: 206: if((FLAGs&0x40) == 0){
		BTSC 	74H,6 			//0109 	1774
		LJUMP 	141H 			//010A 	3941

		//;1.C: 207: for(buff=0;buff<CH3_remotekey_num;buff++){
		BCR 	STATUS,5 		//010B 	1283
		ORG		010CH
		CLRR 	20H 			//010C 	0120
		CLRR 	21H 			//010D 	0121
		LDR 	69H,0 			//010E 	0869
		STR 	5DH 			//010F 	01DD
		CLRR 	5EH 			//0110 	015E
		LDR 	5EH,0 			//0111 	085E
		SUBWR 	21H,0 			//0112 	0C21
		BTSS 	STATUS,2 		//0113 	1D03
		ORG		0114H
		LJUMP 	117H 			//0114 	3917
		LDR 	5DH,0 			//0115 	085D
		SUBWR 	20H,0 			//0116 	0C20
		BTSC 	STATUS,0 		//0117 	1403
		LJUMP 	141H 			//0118 	3941

		//;1.C: 208: if(Ctrl_remotekey == CH3_remotekey[buff]){
		LDR 	20H,0 			//0119 	0820
		LCALL 	23FH 			//011A 	323F
		ADDWI 	4DH 			//011B 	274D
		ORG		011CH
		LCALL 	223H 			//011C 	3223
		LDR 	23H,0 			//011D 	0823
		BCR 	STATUS,5 		//011E 	1283
		XORWR 	61H,0 			//011F 	0461
		BTSS 	STATUS,2 		//0120 	1D03
		LJUMP 	132H 			//0121 	3932
		BSR 	STATUS,5 		//0122 	1A83
		LDR 	22H,0 			//0123 	0822
		ORG		0124H
		BCR 	STATUS,5 		//0124 	1283
		XORWR 	60H,0 			//0125 	0460
		BTSS 	STATUS,2 		//0126 	1D03
		LJUMP 	132H 			//0127 	3932
		BSR 	STATUS,5 		//0128 	1A83
		LDR 	21H,0 			//0129 	0821
		BCR 	STATUS,5 		//012A 	1283
		XORWR 	5FH,0 			//012B 	045F
		ORG		012CH
		BTSS 	STATUS,2 		//012C 	1D03
		LJUMP 	132H 			//012D 	3932
		BSR 	STATUS,5 		//012E 	1A83
		LDR 	20H,0 			//012F 	0820
		BCR 	STATUS,5 		//0130 	1283
		XORWR 	5EH,0 			//0131 	045E
		BTSS 	STATUS,2 		//0132 	1D03
		LJUMP 	13CH 			//0133 	393C
		ORG		0134H

		//;1.C: 209: FLAGs |= 0x40;
		BSR 	74H,6 			//0134 	1B74

		//;1.C: 210: Key_dealed_counter = 0;
		CLRR 	26H 			//0135 	0126

		//;1.C: 211: led1_debug();
		LCALL 	6A2H 			//0136 	36A2

		//;1.C: 212: PA5 = ~PA5;
		LDWI 	20H 			//0137 	2A20
		XORWR 	5H,1 			//0138 	0485

		//;1.C: 213: CH3_remotekey_Latest = buff;
		LDR 	20H,0 			//0139 	0820
		BSR 	STATUS,5 		//013A 	1A83
		STR 	35H 			//013B 	01B5
		ORG		013CH
		BCR 	STATUS,5 		//013C 	1283
		INCR	20H,1 			//013D 	09A0
		BTSC 	STATUS,2 		//013E 	1503
		INCR	21H,1 			//013F 	09A1
		LJUMP 	10EH 			//0140 	390E

		//;1.C: 214: }
		//;1.C: 215: }
		//;1.C: 216: }
		//;1.C: 217: }
		//;1.C: 218: FLAGs &= ~0x08;
		BCR 	74H,3 			//0141 	11F4

		//;1.C: 219: Indata = 0;
		BSR 	STATUS,5 		//0142 	1A83
		CLRR 	28H 			//0143 	0128
		ORG		0144H
		CLRR 	29H 			//0144 	0129

		//;1.C: 220: num = 0;
		BCR 	STATUS,5 		//0145 	1283

		//;1.C: 221: remotekey = 0;
		LCALL 	256H 			//0146 	3256

		//;1.C: 222: Ctrl_remotekey = 0;
		CLRR 	20H 			//0147 	0120
		CLRR 	21H 			//0148 	0121
		CLRR 	22H 			//0149 	0122
		CLRR 	23H 			//014A 	0123

		//;1.C: 223: }
		//;1.C: 224: }
		//;1.C: 225: if((FLAGs&0x08) == 0){
		BTSC 	74H,3 			//014B 	15F4
		ORG		014CH
		LJUMP 	15FH 			//014C 	395F

		//;1.C: 226: if(buff > 7000){
		LDWI 	1BH 			//014D 	2A1B
		BCR 	STATUS,5 		//014E 	1283
		SUBWR 	21H,0 			//014F 	0C21
		LDWI 	59H 			//0150 	2A59
		BTSC 	STATUS,2 		//0151 	1503
		SUBWR 	20H,0 			//0152 	0C20
		BTSS 	STATUS,0 		//0153 	1C03
		ORG		0154H
		LJUMP 	15FH 			//0154 	395F

		//;1.C: 227: FLAGs |= 0x08;
		BSR 	74H,3 			//0155 	19F4

		//;1.C: 228: num = 0;
		//;1.C: 229: remotekey = 0;
		LCALL 	256H 			//0156 	3256

		//;1.C: 230: if( ((FLAGs&0x10) == 0x10) ||
		//;1.C: 231: ((FLAGs&0x20) == 0x20) ||
		//;1.C: 232: ((FLAGs&0x40) == 0x40)
		//;1.C: 233: ){
		BTSS 	74H,4 			//0157 	1E74
		BTSC 	74H,5 			//0158 	16F4
		LJUMP 	15CH 			//0159 	395C
		BTSS 	74H,6 			//015A 	1F74
		LJUMP 	15FH 			//015B 	395F
		ORG		015CH

		//;1.C: 234: remotekey_slice = 0;
		BCR 	STATUS,5 		//015C 	1283
		CLRR 	2CH 			//015D 	012C

		//;1.C: 235: FLAGs &= ~0x08;
		BCR 	74H,3 			//015E 	11F4

		//;1.C: 236: }
		//;1.C: 237: }
		//;1.C: 238: }
		//;1.C: 239: }
		//;1.C: 240: }
		//;1.C: 241: TMR2ON =1;
		BCR 	STATUS,5 		//015F 	1283
		BSR 	12H,2 			//0160 	1912

		//;1.C: 242: INTE = 1;
		BSR 	INTCON,4 		//0161 	1A0B

		//;1.C: 243: }
		//;1.C: 246: if(TMR2IE && TMR2IF){
		BSR 	STATUS,5 		//0162 	1A83
		BTSS 	CH,1 			//0163 	1C8C
		ORG		0164H
		LJUMP 	175H 			//0164 	3975
		BCR 	STATUS,5 		//0165 	1283
		BTSS 	CH,1 			//0166 	1C8C
		LJUMP 	175H 			//0167 	3975

		//;1.C: 247: TMR2IF = 0;
		BCR 	CH,1 			//0168 	108C

		//;1.C: 249: if((FLAGs&0x02) == 0x02){
		BTSS 	74H,1 			//0169 	1CF4
		LJUMP 	16FH 			//016A 	396F

		//;1.C: 250: Indata++;
		BSR 	STATUS,5 		//016B 	1A83
		ORG		016CH
		INCR	28H,1 			//016C 	09A8
		BTSC 	STATUS,2 		//016D 	1503
		INCR	29H,1 			//016E 	09A9

		//;1.C: 251: }
		//;1.C: 252: if(PA2 == 1){
		BCR 	STATUS,5 		//016F 	1283
		BTSS 	5H,2 			//0170 	1D05
		LJUMP 	175H 			//0171 	3975

		//;1.C: 253: FLAGs |= 0x02;
		BSR 	74H,1 			//0172 	18F4

		//;1.C: 254: remotekey_slice = 0;
		CLRR 	2CH 			//0173 	012C
		ORG		0174H

		//;1.C: 255: Key_dealed_counter = 0;
		CLRR 	26H 			//0174 	0126

		//;1.C: 257: }
		//;1.C: 295: }
		//;1.C: 298: if(T0IE && T0IF){
		BTSC 	INTCON,5 		//0175 	168B
		BTSS 	INTCON,2 		//0176 	1D0B
		LJUMP 	217H 			//0177 	3A17

		//;1.C: 299: T0IF = 0;
		BCR 	INTCON,2 		//0178 	110B

		//;1.C: 300: ms16_counter ++;
		BCR 	STATUS,5 		//0179 	1283
		INCR	29H,1 			//017A 	09A9

		//;1.C: 303: if( ((FLAGs&0x10) == 0x10) ||
		//;1.C: 304: ((FLAGs&0x20) == 0x20) ||
		//;1.C: 305: ((FLAGs&0x40) == 0x40)
		//;1.C: 306: ){
		BTSS 	74H,4 			//017B 	1E74
		ORG		017CH
		BTSC 	74H,5 			//017C 	16F4
		LJUMP 	180H 			//017D 	3980
		BTSS 	74H,6 			//017E 	1F74
		LJUMP 	197H 			//017F 	3997

		//;1.C: 307: if(PA2 == 0) remotekey_slice++;
		BTSC 	5H,2 			//0180 	1505
		LJUMP 	183H 			//0181 	3983
		INCR	2CH,1 			//0182 	09AC

		//;1.C: 308: if(PA2 == 1) remotekey_slice = 0;
		BTSS 	5H,2 			//0183 	1D05
		ORG		0184H
		LJUMP 	186H 			//0184 	3986
		CLRR 	2CH 			//0185 	012C

		//;1.C: 309: if(Key_dealed_counter<255) Key_dealed_counter++;
		LDR 	26H,0 			//0186 	0826
		XORWI 	FFH 			//0187 	26FF
		BTSS 	STATUS,2 		//0188 	1D03
		INCR	26H,1 			//0189 	09A6

		//;1.C: 310: if( (remotekey_slice>(150/8)) ||
		//;1.C: 311: (Key_dealed_counter > (1024/8))
		//;1.C: 312: ){
		LDWI 	13H 			//018A 	2A13
		SUBWR 	2CH,0 			//018B 	0C2C
		ORG		018CH
		BTSC 	STATUS,0 		//018C 	1403
		LJUMP 	192H 			//018D 	3992
		LDWI 	81H 			//018E 	2A81
		SUBWR 	26H,0 			//018F 	0C26
		BTSS 	STATUS,0 		//0190 	1C03
		LJUMP 	197H 			//0191 	3997

		//;1.C: 313: remotekey_slice = 0;
		CLRR 	2CH 			//0192 	012C

		//;1.C: 315: FLAGs &= ~0x02;
		BCR 	74H,1 			//0193 	10F4
		ORG		0194H

		//;1.C: 316: FLAGs &= ~0x10;
		BCR 	74H,4 			//0194 	1274

		//;1.C: 317: FLAGs &= ~0x20;
		BCR 	74H,5 			//0195 	12F4

		//;1.C: 318: FLAGs &= ~0x40;
		BCR 	74H,6 			//0196 	1374

		//;1.C: 319: }
		//;1.C: 320: }
		//;1.C: 323: if( ((PRESSED&0x10) == 0x10) ||
		//;1.C: 324: ((PRESSED&0x20) == 0x20) ||
		//;1.C: 325: ((PRESSED&0x40) == 0x40)
		//;1.C: 326: ){
		BTSS 	75H,4 			//0197 	1E75
		BTSC 	75H,5 			//0198 	16F5
		LJUMP 	19CH 			//0199 	399C
		BTSS 	75H,6 			//019A 	1F75
		LJUMP 	1A3H 			//019B 	39A3
		ORG		019CH
		LDWI 	13H 			//019C 	2A13

		//;1.C: 327: match_slice++;
		INCR	28H,1 			//019D 	09A8

		//;1.C: 328: if(match_slice>(150/8)){
		SUBWR 	28H,0 			//019E 	0C28
		BTSS 	STATUS,0 		//019F 	1C03
		LJUMP 	1A3H 			//01A0 	39A3

		//;1.C: 329: match_slice = 0;
		CLRR 	28H 			//01A1 	0128

		//;1.C: 330: remotekey_Receive_num = 0;
		CLRR 	2BH 			//01A2 	012B

		//;1.C: 331: }
		//;1.C: 332: }
		//;1.C: 335: if((FLAGs&0x02) == 0){
		BTSC 	74H,1 			//01A3 	14F4
		ORG		01A4H
		LJUMP 	1BCH 			//01A4 	39BC

		//;1.C: 336: EE_Buff = ms16_counter%8;
		LDR 	29H,0 			//01A5 	0829
		BSR 	STATUS,5 		//01A6 	1A83
		STR 	36H 			//01A7 	01B6
		LDWI 	7H 			//01A8 	2A07
		ANDWR 	36H,1 			//01A9 	02B6

		//;1.C: 337: if(EE_Buff == 1){
		DECRSZ 	36H,0 		//01AA 	0E36
		LJUMP 	1B2H 			//01AB 	39B2
		ORG		01ACH

		//;1.C: 338: PA3 = 0;
		BCR 	STATUS,5 		//01AC 	1283
		BCR 	5H,3 			//01AD 	1185

		//;1.C: 340: EX_INT_FallingEdge();
		LCALL 	69EH 			//01AE 	369E

		//;1.C: 341: INTE =1;
		BSR 	INTCON,4 		//01AF 	1A0B

		//;1.C: 342: TMR2ON =1;
		BCR 	STATUS,5 		//01B0 	1283
		BSR 	12H,2 			//01B1 	1912

		//;1.C: 343: }
		//;1.C: 344: if(EE_Buff == 3){
		BSR 	STATUS,5 		//01B2 	1A83
		LDR 	36H,0 			//01B3 	0836
		ORG		01B4H
		XORWI 	3H 			//01B4 	2603

		//;1.C: 345: PA3 = 1;
		BCR 	STATUS,5 		//01B5 	1283
		BTSS 	STATUS,2 		//01B6 	1D03
		LJUMP 	1C0H 			//01B7 	39C0
		BSR 	5H,3 			//01B8 	1985

		//;1.C: 346: TMR2ON =0;
		BCR 	12H,2 			//01B9 	1112

		//;1.C: 347: INTE =0;
		BCR 	INTCON,4 		//01BA 	120B
		LJUMP 	1BFH 			//01BB 	39BF
		ORG		01BCH

		//;1.C: 350: PA3 = 0;
		BCR 	5H,3 			//01BC 	1185

		//;1.C: 351: INTE =1;
		BSR 	INTCON,4 		//01BD 	1A0B

		//;1.C: 352: TMR2ON =1;
		BSR 	12H,2 			//01BE 	1912

		//;1.C: 353: }
		//;1.C: 356: if(ms16_counter%2 == 0){
		BCR 	STATUS,5 		//01BF 	1283
		BTSC 	29H,0 			//01C0 	1429
		LJUMP 	1C4H 			//01C1 	39C4

		//;1.C: 357: KEYSCAN();
		LCALL 	3EAH 			//01C2 	33EA

		//;1.C: 358: KEY();
		LCALL 	263H 			//01C3 	3263
		ORG		01C4H

		//;1.C: 359: }
		//;1.C: 363: if(ms16_counter >= 120){
		LDWI 	78H 			//01C4 	2A78
		SUBWR 	29H,0 			//01C5 	0C29
		BTSS 	STATUS,0 		//01C6 	1C03
		LJUMP 	217H 			//01C7 	3A17

		//;1.C: 364: ms16_counter = 0;
		CLRR 	29H 			//01C8 	0129

		//;1.C: 367: if( ((PRESSED&0x10) == 0x10) ||
		//;1.C: 368: ((PRESSED&0x20) == 0x20) ||
		//;1.C: 369: ((PRESSED&0x40) == 0x40)
		//;1.C: 370: ){
		BTSS 	75H,4 			//01C9 	1E75
		BTSC 	75H,5 			//01CA 	16F5
		LJUMP 	1CEH 			//01CB 	39CE
		ORG		01CCH
		BTSS 	75H,6 			//01CC 	1F75
		LJUMP 	217H 			//01CD 	3A17

		//;1.C: 371: if(KEY_Match_counter<4){
		LDWI 	4H 			//01CE 	2A04
		SUBWR 	25H,0 			//01CF 	0C25
		BTSS 	STATUS,0 		//01D0 	1C03

		//;1.C: 372: KEY_Match_counter++;
		INCR	25H,1 			//01D1 	09A5
		LDWI 	10H 			//01D2 	2A10

		//;1.C: 373: }
		//;1.C: 374: LONGPRESS_OverTime_Counter++;
		BSR 	STATUS,5 		//01D3 	1A83
		ORG		01D4H
		INCR	2AH,1 			//01D4 	09AA

		//;1.C: 375: if(LONGPRESS_OverTime_Counter > 15){
		SUBWR 	2AH,0 			//01D5 	0C2A
		BTSS 	STATUS,0 		//01D6 	1C03
		LJUMP 	217H 			//01D7 	3A17

		//;1.C: 376: LONGPRESS_OverTime_Counter = 0;
		CLRR 	2AH 			//01D8 	012A

		//;1.C: 377: if((PRESSED&0x10) == 0x10){
		BTSS 	75H,4 			//01D9 	1E75
		LJUMP 	1EDH 			//01DA 	39ED

		//;1.C: 378: CH1_remotekey[CH1_remotekey_Latest] = CH1_remotekey[CH1_remotekey_num-1];
		BCR 	STATUS,5 		//01DB 	1283
		ORG		01DCH
		LDR 	67H,0 			//01DC 	0867
		LCALL 	23FH 			//01DD 	323F
		ADDWI 	29H 			//01DE 	2729
		LCALL 	223H 			//01DF 	3223
		LDR 	33H,0 			//01E0 	0833
		LCALL 	24FH 			//01E1 	324F
		ADDWI 	2DH 			//01E2 	272D
		LCALL 	232H 			//01E3 	3232
		ORG		01E4H

		//;1.C: 379: CH1_remotekey[CH1_remotekey_num-1] = 0xFFFFFFFF;
		LDR 	67H,0 			//01E4 	0867
		LCALL 	23FH 			//01E5 	323F
		ADDWI 	29H 			//01E6 	2729
		LCALL 	245H 			//01E7 	3245

		//;1.C: 380: if(CH1_remotekey_num>0) CH1_remotekey_num--;
		LDR 	67H,0 			//01E8 	0867
		BTSS 	STATUS,2 		//01E9 	1D03
		DECR 	67H,1 			//01EA 	0DE7

		//;1.C: 381: PRESSED &= ~0x10;
		BCR 	75H,4 			//01EB 	1275
		ORG		01ECH

		//;1.C: 382: PA7 = 1;
		BSR 	5H,7 			//01EC 	1B85

		//;1.C: 383: }
		//;1.C: 384: if((PRESSED&0x20) == 0x20){
		BTSS 	75H,5 			//01ED 	1EF5
		LJUMP 	201H 			//01EE 	3A01

		//;1.C: 385: CH2_remotekey[CH2_remotekey_Latest] = CH2_remotekey[CH2_remotekey_num-1];
		BCR 	STATUS,5 		//01EF 	1283
		LDR 	68H,0 			//01F0 	0868
		LCALL 	23FH 			//01F1 	323F
		ADDWI 	39H 			//01F2 	2739
		LCALL 	223H 			//01F3 	3223
		ORG		01F4H
		LDR 	34H,0 			//01F4 	0834
		LCALL 	24FH 			//01F5 	324F
		ADDWI 	3DH 			//01F6 	273D
		LCALL 	232H 			//01F7 	3232

		//;1.C: 386: CH2_remotekey[CH2_remotekey_num-1] = 0xFFFFFFFF;
		LDR 	68H,0 			//01F8 	0868
		LCALL 	23FH 			//01F9 	323F
		ADDWI 	39H 			//01FA 	2739
		LCALL 	245H 			//01FB 	3245
		ORG		01FCH

		//;1.C: 387: if(CH2_remotekey_num>0) CH2_remotekey_num--;
		LDR 	68H,0 			//01FC 	0868
		BTSS 	STATUS,2 		//01FD 	1D03
		DECR 	68H,1 			//01FE 	0DE8

		//;1.C: 388: PRESSED &= ~0x20;
		BCR 	75H,5 			//01FF 	12F5

		//;1.C: 389: PA6 = 1;
		BSR 	5H,6 			//0200 	1B05

		//;1.C: 390: }
		//;1.C: 391: if((PRESSED&0x40) == 0x40){
		BTSS 	75H,6 			//0201 	1F75
		LJUMP 	215H 			//0202 	3A15

		//;1.C: 392: CH3_remotekey[CH3_remotekey_Latest] = CH3_remotekey[CH3_remotekey_num-1];
		BCR 	STATUS,5 		//0203 	1283
		ORG		0204H
		LDR 	69H,0 			//0204 	0869
		LCALL 	23FH 			//0205 	323F
		ADDWI 	49H 			//0206 	2749
		LCALL 	223H 			//0207 	3223
		LDR 	35H,0 			//0208 	0835
		LCALL 	24FH 			//0209 	324F
		ADDWI 	4DH 			//020A 	274D
		LCALL 	232H 			//020B 	3232
		ORG		020CH

		//;1.C: 393: CH3_remotekey[CH3_remotekey_num-1] = 0xFFFFFFFF;
		LDR 	69H,0 			//020C 	0869
		LCALL 	23FH 			//020D 	323F
		ADDWI 	49H 			//020E 	2749
		LCALL 	245H 			//020F 	3245

		//;1.C: 394: if(CH3_remotekey_num>0) CH3_remotekey_num--;
		LDR 	69H,0 			//0210 	0869
		BTSS 	STATUS,2 		//0211 	1D03
		DECR 	69H,1 			//0212 	0DE9

		//;1.C: 395: PRESSED &= ~0x40;
		BCR 	75H,6 			//0213 	1375
		ORG		0214H

		//;1.C: 396: PA5 = 1;
		BSR 	5H,5 			//0214 	1A85

		//;1.C: 397: }
		//;1.C: 398: PC0 = 1;
		BCR 	STATUS,5 		//0215 	1283
		BSR 	7H,0 			//0216 	1807
		BCR 	STATUS,5 		//0217 	1283
		LDR 	66H,0 			//0218 	0866
		STR 	7FH 			//0219 	01FF
		LDR 	65H,0 			//021A 	0865
		STR 	PCLATH 			//021B 	018A
		ORG		021CH
		LDR 	64H,0 			//021C 	0864
		STR 	FSR 			//021D 	0184
		SWAPR 	63H,0 			//021E 	0763
		STR 	STATUS 			//021F 	0183
		SWAPR 	7EH,1 			//0220 	07FE
		SWAPR 	7EH,0 			//0221 	077E
		RETI		 			//0222 	0009
		STR 	FSR 			//0223 	0184
		ORG		0224H
		BCR 	STATUS,7 		//0224 	1383
		LDR 	INDF,0 			//0225 	0800
		STR 	5EH 			//0226 	01DE
		INCR	FSR,1 			//0227 	0984
		LDR 	INDF,0 			//0228 	0800
		STR 	5FH 			//0229 	01DF
		INCR	FSR,1 			//022A 	0984
		LDR 	INDF,0 			//022B 	0800
		ORG		022CH
		STR 	60H 			//022C 	01E0
		INCR	FSR,1 			//022D 	0984
		LDR 	INDF,0 			//022E 	0800
		STR 	61H 			//022F 	01E1
		BSR 	STATUS,5 		//0230 	1A83
		RET		 					//0231 	0004
		STR 	FSR 			//0232 	0184
		LDR 	5EH,0 			//0233 	085E
		ORG		0234H
		STR 	INDF 			//0234 	0180
		INCR	FSR,1 			//0235 	0984
		LDR 	5FH,0 			//0236 	085F
		STR 	INDF 			//0237 	0180
		INCR	FSR,1 			//0238 	0984
		LDR 	60H,0 			//0239 	0860
		STR 	INDF 			//023A 	0180
		INCR	FSR,1 			//023B 	0984
		ORG		023CH
		LDR 	61H,0 			//023C 	0861
		STR 	INDF 			//023D 	0180
		RET		 					//023E 	0004
		STR 	5DH 			//023F 	01DD
		BCR 	STATUS,0 		//0240 	1003
		RLR 	5DH,1 			//0241 	05DD
		BCR 	STATUS,0 		//0242 	1003
		RLR 	5DH,0 			//0243 	055D
		ORG		0244H
		RET		 					//0244 	0004
		STR 	FSR 			//0245 	0184
		LDWI 	FFH 			//0246 	2AFF
		STR 	INDF 			//0247 	0180
		INCR	FSR,1 			//0248 	0984
		STR 	INDF 			//0249 	0180
		INCR	FSR,1 			//024A 	0984
		STR 	INDF 			//024B 	0180
		ORG		024CH
		INCR	FSR,1 			//024C 	0984
		STR 	INDF 			//024D 	0180
		RET		 					//024E 	0004
		BCR 	STATUS,5 		//024F 	1283
		STR 	62H 			//0250 	01E2
		BCR 	STATUS,0 		//0251 	1003
		RLR 	62H,1 			//0252 	05E2
		BCR 	STATUS,0 		//0253 	1003
		ORG		0254H
		RLR 	62H,0 			//0254 	0562
		RET		 					//0255 	0004
		CLRR 	2AH 			//0256 	012A
		BSR 	STATUS,5 		//0257 	1A83
		CLRR 	24H 			//0258 	0124
		CLRR 	25H 			//0259 	0125
		CLRR 	26H 			//025A 	0126
		CLRR 	27H 			//025B 	0127
		ORG		025CH
		RET		 					//025C 	0004
		BSR 	STATUS,5 		//025D 	1A83
		RLR 	24H,1 			//025E 	05A4
		RLR 	25H,1 			//025F 	05A5
		RLR 	26H,1 			//0260 	05A6
		RLR 	27H,1 			//0261 	05A7
		RET		 					//0262 	0004

		//;1.C: 674: if( ((PRESSED&0x10) == 0x10) ||
		//;1.C: 675: ((PRESSED&0x20) == 0x20) ||
		//;1.C: 676: ((PRESSED&0x40) == 0x40)
		//;1.C: 677: ){
		BTSS 	75H,4 			//0263 	1E75
		ORG		0264H
		BTSC 	75H,5 			//0264 	16F5
		LJUMP 	3A2H 			//0265 	3BA2
		BTSC 	75H,6 			//0266 	1775
		LJUMP 	3A2H 			//0267 	3BA2
		LJUMP 	3ADH 			//0268 	3BAD

		//;1.C: 680: Match_remotekey = 0xFFFFFFFF;
		LDWI 	FFH 			//0269 	2AFF
		STR 	73H 			//026A 	01F3
		STR 	72H 			//026B 	01F2
		ORG		026CH
		STR 	71H 			//026C 	01F1
		STR 	70H 			//026D 	01F0

		//;1.C: 681: break;
		LJUMP 	3ADH 			//026E 	3BAD

		//;1.C: 682: case 1:
		//;1.C: 683: PC0 = 0;
		BCR 	7H,0 			//026F 	1007

		//;1.C: 684: if((PRESSED&0x10) == 0x10) PA7 = 0;
		BTSS 	75H,4 			//0270 	1E75
		LJUMP 	273H 			//0271 	3A73
		BCR 	5H,7 			//0272 	1385

		//;1.C: 685: if((PRESSED&0x20) == 0x20) PA6 = 0;
		BTSS 	75H,5 			//0273 	1EF5
		ORG		0274H
		LJUMP 	276H 			//0274 	3A76
		BCR 	5H,6 			//0275 	1305

		//;1.C: 686: if((PRESSED&0x40) == 0x40) PA5 = 0;
		BTSS 	75H,6 			//0276 	1F75
		LJUMP 	3ADH 			//0277 	3BAD
		BCR 	5H,5 			//0278 	1285
		LJUMP 	3ADH 			//0279 	3BAD

		//;1.C: 688: case 2:
		//;1.C: 689: PC0 = 1;
		BSR 	7H,0 			//027A 	1807

		//;1.C: 690: if((PRESSED&0x10) == 0x10) PA7 = 1;
		BTSS 	75H,4 			//027B 	1E75
		ORG		027CH
		LJUMP 	27EH 			//027C 	3A7E
		BSR 	5H,7 			//027D 	1B85

		//;1.C: 691: if((PRESSED&0x20) == 0x20) PA6 = 1;
		BTSS 	75H,5 			//027E 	1EF5
		LJUMP 	281H 			//027F 	3A81
		BSR 	5H,6 			//0280 	1B05

		//;1.C: 692: if((PRESSED&0x40) == 0x40) PA5 = 1;
		BTSS 	75H,6 			//0281 	1F75
		LJUMP 	3ADH 			//0282 	3BAD
		BSR 	5H,5 			//0283 	1A85
		ORG		0284H
		LJUMP 	3ADH 			//0284 	3BAD

		//;1.C: 694: case 3:
		LDWI 	3H 			//0285 	2A03

		//;1.C: 695: KEY_Match_counter = 1;
		CLRR 	25H 			//0286 	0125
		INCR	25H,1 			//0287 	09A5

		//;1.C: 696: if(remotekey_Receive_num >= 3){
		SUBWR 	2BH,0 			//0288 	0C2B
		BTSS 	STATUS,0 		//0289 	1C03
		LJUMP 	3ADH 			//028A 	3BAD

		//;1.C: 697: if((PRESSED&0x10) == 0x10){
		BTSS 	75H,4 			//028B 	1E75
		ORG		028CH
		LJUMP 	2E7H 			//028C 	3AE7

		//;1.C: 698: if( (Match_remotekey != CH1_remotekey[0]) &&
		//;1.C: 699: (Match_remotekey != CH1_remotekey[1]) &&
		//;1.C: 700: (Match_remotekey != CH1_remotekey[2]) &&
		//;1.C: 701: (Match_remotekey != CH1_remotekey[3])
		//;1.C: 702: ){
		LDR 	73H,0 			//028D 	0873
		XORWR 	30H,0 			//028E 	0430
		BTSS 	STATUS,2 		//028F 	1D03
		LJUMP 	29BH 			//0290 	3A9B
		LDR 	72H,0 			//0291 	0872
		XORWR 	2FH,0 			//0292 	042F
		BTSS 	STATUS,2 		//0293 	1D03
		ORG		0294H
		LJUMP 	29BH 			//0294 	3A9B
		LDR 	71H,0 			//0295 	0871
		XORWR 	2EH,0 			//0296 	042E
		BTSS 	STATUS,2 		//0297 	1D03
		LJUMP 	29BH 			//0298 	3A9B
		LDR 	70H,0 			//0299 	0870
		XORWR 	2DH,0 			//029A 	042D
		BTSC 	STATUS,2 		//029B 	1503
		ORG		029CH
		LJUMP 	2DCH 			//029C 	3ADC
		LDR 	73H,0 			//029D 	0873
		XORWR 	34H,0 			//029E 	0434
		BTSS 	STATUS,2 		//029F 	1D03
		LJUMP 	2ABH 			//02A0 	3AAB
		LDR 	72H,0 			//02A1 	0872
		XORWR 	33H,0 			//02A2 	0433
		BTSS 	STATUS,2 		//02A3 	1D03
		ORG		02A4H
		LJUMP 	2ABH 			//02A4 	3AAB
		LDR 	71H,0 			//02A5 	0871
		XORWR 	32H,0 			//02A6 	0432
		BTSS 	STATUS,2 		//02A7 	1D03
		LJUMP 	2ABH 			//02A8 	3AAB
		LDR 	70H,0 			//02A9 	0870
		XORWR 	31H,0 			//02AA 	0431
		BTSC 	STATUS,2 		//02AB 	1503
		ORG		02ACH
		LJUMP 	2DCH 			//02AC 	3ADC
		LDR 	73H,0 			//02AD 	0873
		XORWR 	38H,0 			//02AE 	0438
		BTSS 	STATUS,2 		//02AF 	1D03
		LJUMP 	2BBH 			//02B0 	3ABB
		LDR 	72H,0 			//02B1 	0872
		XORWR 	37H,0 			//02B2 	0437
		BTSS 	STATUS,2 		//02B3 	1D03
		ORG		02B4H
		LJUMP 	2BBH 			//02B4 	3ABB
		LDR 	71H,0 			//02B5 	0871
		XORWR 	36H,0 			//02B6 	0436
		BTSS 	STATUS,2 		//02B7 	1D03
		LJUMP 	2BBH 			//02B8 	3ABB
		LDR 	70H,0 			//02B9 	0870
		XORWR 	35H,0 			//02BA 	0435
		BTSC 	STATUS,2 		//02BB 	1503
		ORG		02BCH
		LJUMP 	2DCH 			//02BC 	3ADC
		LDR 	73H,0 			//02BD 	0873
		XORWR 	3CH,0 			//02BE 	043C
		BTSS 	STATUS,2 		//02BF 	1D03
		LJUMP 	2CBH 			//02C0 	3ACB
		LDR 	72H,0 			//02C1 	0872
		XORWR 	3BH,0 			//02C2 	043B
		BTSS 	STATUS,2 		//02C3 	1D03
		ORG		02C4H
		LJUMP 	2CBH 			//02C4 	3ACB
		LDR 	71H,0 			//02C5 	0871
		XORWR 	3AH,0 			//02C6 	043A
		BTSS 	STATUS,2 		//02C7 	1D03
		LJUMP 	2CBH 			//02C8 	3ACB
		LDR 	70H,0 			//02C9 	0870
		XORWR 	39H,0 			//02CA 	0439
		BTSC 	STATUS,2 		//02CB 	1503
		ORG		02CCH
		LJUMP 	2DCH 			//02CC 	3ADC

		//;1.C: 703: if(CH1_remotekey_num < 4){
		LDWI 	4H 			//02CD 	2A04
		SUBWR 	67H,0 			//02CE 	0C67
		BTSC 	STATUS,0 		//02CF 	1403
		LJUMP 	2D7H 			//02D0 	3AD7

		//;1.C: 704: CH1_remotekey[CH1_remotekey_num] = Match_remotekey;
		LDR 	67H,0 			//02D1 	0867
		LCALL 	3E4H 			//02D2 	33E4
		ADDWI 	2DH 			//02D3 	272D
		ORG		02D4H
		LCALL 	3D6H 			//02D4 	33D6

		//;1.C: 705: CH1_remotekey_num++;
		INCR	67H,1 			//02D5 	09E7

		//;1.C: 706: }else{
		LJUMP 	2DCH 			//02D6 	3ADC

		//;1.C: 707: CH1_remotekey[CH1_remotekey_Latest] = Match_remotekey;
		BSR 	STATUS,5 		//02D7 	1A83
		LDR 	33H,0 			//02D8 	0833
		LCALL 	3E4H 			//02D9 	33E4
		ADDWI 	2DH 			//02DA 	272D
		LCALL 	3D6H 			//02DB 	33D6
		ORG		02DCH

		//;1.C: 708: }
		//;1.C: 709: }
		//;1.C: 710: if(CH1_remotekey_num > 4) CH1_remotekey_num = 4;
		LDWI 	5H 			//02DC 	2A05
		BCR 	STATUS,5 		//02DD 	1283
		SUBWR 	67H,0 			//02DE 	0C67
		BTSS 	STATUS,0 		//02DF 	1C03
		LJUMP 	2E3H 			//02E0 	3AE3
		LDWI 	4H 			//02E1 	2A04
		STR 	67H 			//02E2 	01E7

		//;1.C: 711: PRESSED &= ~0x10;
		BCR 	75H,4 			//02E3 	1275
		ORG		02E4H

		//;1.C: 712: CH1_EEPROM_Write();
		LCALL 	5B6H 			//02E4 	35B6

		//;1.C: 713: PA7 = 1;
		BCR 	STATUS,5 		//02E5 	1283
		BSR 	5H,7 			//02E6 	1B85

		//;1.C: 714: }
		//;1.C: 715: if((PRESSED&0x20) == 0x20){
		BTSS 	75H,5 			//02E7 	1EF5
		LJUMP 	343H 			//02E8 	3B43

		//;1.C: 716: if( (Match_remotekey != CH2_remotekey[0]) &&
		//;1.C: 717: (Match_remotekey != CH2_remotekey[1]) &&
		//;1.C: 718: (Match_remotekey != CH2_remotekey[2]) &&
		//;1.C: 719: (Match_remotekey != CH2_remotekey[3])
		//;1.C: 720: ){
		LDR 	73H,0 			//02E9 	0873
		XORWR 	40H,0 			//02EA 	0440
		BTSS 	STATUS,2 		//02EB 	1D03
		ORG		02ECH
		LJUMP 	2F7H 			//02EC 	3AF7
		LDR 	72H,0 			//02ED 	0872
		XORWR 	3FH,0 			//02EE 	043F
		BTSS 	STATUS,2 		//02EF 	1D03
		LJUMP 	2F7H 			//02F0 	3AF7
		LDR 	71H,0 			//02F1 	0871
		XORWR 	3EH,0 			//02F2 	043E
		BTSS 	STATUS,2 		//02F3 	1D03
		ORG		02F4H
		LJUMP 	2F7H 			//02F4 	3AF7
		LDR 	70H,0 			//02F5 	0870
		XORWR 	3DH,0 			//02F6 	043D
		BTSC 	STATUS,2 		//02F7 	1503
		LJUMP 	338H 			//02F8 	3B38
		LDR 	73H,0 			//02F9 	0873
		XORWR 	44H,0 			//02FA 	0444
		BTSS 	STATUS,2 		//02FB 	1D03
		ORG		02FCH
		LJUMP 	307H 			//02FC 	3B07
		LDR 	72H,0 			//02FD 	0872
		XORWR 	43H,0 			//02FE 	0443
		BTSS 	STATUS,2 		//02FF 	1D03
		LJUMP 	307H 			//0300 	3B07
		LDR 	71H,0 			//0301 	0871
		XORWR 	42H,0 			//0302 	0442
		BTSS 	STATUS,2 		//0303 	1D03
		ORG		0304H
		LJUMP 	307H 			//0304 	3B07
		LDR 	70H,0 			//0305 	0870
		XORWR 	41H,0 			//0306 	0441
		BTSC 	STATUS,2 		//0307 	1503
		LJUMP 	338H 			//0308 	3B38
		LDR 	73H,0 			//0309 	0873
		XORWR 	48H,0 			//030A 	0448
		BTSS 	STATUS,2 		//030B 	1D03
		ORG		030CH
		LJUMP 	317H 			//030C 	3B17
		LDR 	72H,0 			//030D 	0872
		XORWR 	47H,0 			//030E 	0447
		BTSS 	STATUS,2 		//030F 	1D03
		LJUMP 	317H 			//0310 	3B17
		LDR 	71H,0 			//0311 	0871
		XORWR 	46H,0 			//0312 	0446
		BTSS 	STATUS,2 		//0313 	1D03
		ORG		0314H
		LJUMP 	317H 			//0314 	3B17
		LDR 	70H,0 			//0315 	0870
		XORWR 	45H,0 			//0316 	0445
		BTSC 	STATUS,2 		//0317 	1503
		LJUMP 	338H 			//0318 	3B38
		LDR 	73H,0 			//0319 	0873
		XORWR 	4CH,0 			//031A 	044C
		BTSS 	STATUS,2 		//031B 	1D03
		ORG		031CH
		LJUMP 	327H 			//031C 	3B27
		LDR 	72H,0 			//031D 	0872
		XORWR 	4BH,0 			//031E 	044B
		BTSS 	STATUS,2 		//031F 	1D03
		LJUMP 	327H 			//0320 	3B27
		LDR 	71H,0 			//0321 	0871
		XORWR 	4AH,0 			//0322 	044A
		BTSS 	STATUS,2 		//0323 	1D03
		ORG		0324H
		LJUMP 	327H 			//0324 	3B27
		LDR 	70H,0 			//0325 	0870
		XORWR 	49H,0 			//0326 	0449
		BTSC 	STATUS,2 		//0327 	1503
		LJUMP 	338H 			//0328 	3B38

		//;1.C: 721: if(CH2_remotekey_num < 4){
		LDWI 	4H 			//0329 	2A04
		SUBWR 	68H,0 			//032A 	0C68
		BTSC 	STATUS,0 		//032B 	1403
		ORG		032CH
		LJUMP 	333H 			//032C 	3B33

		//;1.C: 722: CH2_remotekey[CH2_remotekey_num] = Match_remotekey;
		LDR 	68H,0 			//032D 	0868
		LCALL 	3E4H 			//032E 	33E4
		ADDWI 	3DH 			//032F 	273D
		LCALL 	3D6H 			//0330 	33D6

		//;1.C: 723: CH2_remotekey_num++;
		INCR	68H,1 			//0331 	09E8

		//;1.C: 724: }else{
		LJUMP 	338H 			//0332 	3B38

		//;1.C: 725: CH2_remotekey[CH2_remotekey_Latest] = Match_remotekey;
		BSR 	STATUS,5 		//0333 	1A83
		ORG		0334H
		LDR 	34H,0 			//0334 	0834
		LCALL 	3E4H 			//0335 	33E4
		ADDWI 	3DH 			//0336 	273D
		LCALL 	3D6H 			//0337 	33D6

		//;1.C: 726: }
		//;1.C: 727: }
		//;1.C: 728: if(CH2_remotekey_num > 4) CH2_remotekey_num = 4;
		LDWI 	5H 			//0338 	2A05
		BCR 	STATUS,5 		//0339 	1283
		SUBWR 	68H,0 			//033A 	0C68
		BTSS 	STATUS,0 		//033B 	1C03
		ORG		033CH
		LJUMP 	33FH 			//033C 	3B3F
		LDWI 	4H 			//033D 	2A04
		STR 	68H 			//033E 	01E8

		//;1.C: 729: PRESSED &= ~0x20;
		BCR 	75H,5 			//033F 	12F5

		//;1.C: 730: CH2_EEPROM_Write();
		LCALL 	576H 			//0340 	3576

		//;1.C: 731: PA6 = 1;
		BCR 	STATUS,5 		//0341 	1283
		BSR 	5H,6 			//0342 	1B05

		//;1.C: 732: }
		//;1.C: 733: if((PRESSED&0x40) == 0x40){
		BTSS 	75H,6 			//0343 	1F75
		ORG		0344H
		LJUMP 	39FH 			//0344 	3B9F

		//;1.C: 734: if( (Match_remotekey != CH3_remotekey[0]) &&
		//;1.C: 735: (Match_remotekey != CH3_remotekey[1]) &&
		//;1.C: 736: (Match_remotekey != CH3_remotekey[2]) &&
		//;1.C: 737: (Match_remotekey != CH3_remotekey[3])
		//;1.C: 738: ){
		LDR 	73H,0 			//0345 	0873
		XORWR 	50H,0 			//0346 	0450
		BTSS 	STATUS,2 		//0347 	1D03
		LJUMP 	353H 			//0348 	3B53
		LDR 	72H,0 			//0349 	0872
		XORWR 	4FH,0 			//034A 	044F
		BTSS 	STATUS,2 		//034B 	1D03
		ORG		034CH
		LJUMP 	353H 			//034C 	3B53
		LDR 	71H,0 			//034D 	0871
		XORWR 	4EH,0 			//034E 	044E
		BTSS 	STATUS,2 		//034F 	1D03
		LJUMP 	353H 			//0350 	3B53
		LDR 	70H,0 			//0351 	0870
		XORWR 	4DH,0 			//0352 	044D
		BTSC 	STATUS,2 		//0353 	1503
		ORG		0354H
		LJUMP 	394H 			//0354 	3B94
		LDR 	73H,0 			//0355 	0873
		XORWR 	54H,0 			//0356 	0454
		BTSS 	STATUS,2 		//0357 	1D03
		LJUMP 	363H 			//0358 	3B63
		LDR 	72H,0 			//0359 	0872
		XORWR 	53H,0 			//035A 	0453
		BTSS 	STATUS,2 		//035B 	1D03
		ORG		035CH
		LJUMP 	363H 			//035C 	3B63
		LDR 	71H,0 			//035D 	0871
		XORWR 	52H,0 			//035E 	0452
		BTSS 	STATUS,2 		//035F 	1D03
		LJUMP 	363H 			//0360 	3B63
		LDR 	70H,0 			//0361 	0870
		XORWR 	51H,0 			//0362 	0451
		BTSC 	STATUS,2 		//0363 	1503
		ORG		0364H
		LJUMP 	394H 			//0364 	3B94
		LDR 	73H,0 			//0365 	0873
		XORWR 	58H,0 			//0366 	0458
		BTSS 	STATUS,2 		//0367 	1D03
		LJUMP 	373H 			//0368 	3B73
		LDR 	72H,0 			//0369 	0872
		XORWR 	57H,0 			//036A 	0457
		BTSS 	STATUS,2 		//036B 	1D03
		ORG		036CH
		LJUMP 	373H 			//036C 	3B73
		LDR 	71H,0 			//036D 	0871
		XORWR 	56H,0 			//036E 	0456
		BTSS 	STATUS,2 		//036F 	1D03
		LJUMP 	373H 			//0370 	3B73
		LDR 	70H,0 			//0371 	0870
		XORWR 	55H,0 			//0372 	0455
		BTSC 	STATUS,2 		//0373 	1503
		ORG		0374H
		LJUMP 	394H 			//0374 	3B94
		LDR 	73H,0 			//0375 	0873
		XORWR 	5CH,0 			//0376 	045C
		BTSS 	STATUS,2 		//0377 	1D03
		LJUMP 	383H 			//0378 	3B83
		LDR 	72H,0 			//0379 	0872
		XORWR 	5BH,0 			//037A 	045B
		BTSS 	STATUS,2 		//037B 	1D03
		ORG		037CH
		LJUMP 	383H 			//037C 	3B83
		LDR 	71H,0 			//037D 	0871
		XORWR 	5AH,0 			//037E 	045A
		BTSS 	STATUS,2 		//037F 	1D03
		LJUMP 	383H 			//0380 	3B83
		LDR 	70H,0 			//0381 	0870
		XORWR 	59H,0 			//0382 	0459
		BTSC 	STATUS,2 		//0383 	1503
		ORG		0384H
		LJUMP 	394H 			//0384 	3B94

		//;1.C: 739: if(CH3_remotekey_num < 4){
		LDWI 	4H 			//0385 	2A04
		SUBWR 	69H,0 			//0386 	0C69
		BTSC 	STATUS,0 		//0387 	1403
		LJUMP 	38FH 			//0388 	3B8F

		//;1.C: 740: CH3_remotekey[CH3_remotekey_num] = Match_remotekey;
		LDR 	69H,0 			//0389 	0869
		LCALL 	3E4H 			//038A 	33E4
		ADDWI 	4DH 			//038B 	274D
		ORG		038CH
		LCALL 	3D6H 			//038C 	33D6

		//;1.C: 741: CH3_remotekey_num++;
		INCR	69H,1 			//038D 	09E9

		//;1.C: 742: }else{
		LJUMP 	394H 			//038E 	3B94

		//;1.C: 743: CH3_remotekey[CH3_remotekey_Latest] = Match_remotekey;
		BSR 	STATUS,5 		//038F 	1A83
		LDR 	35H,0 			//0390 	0835
		LCALL 	3E4H 			//0391 	33E4
		ADDWI 	4DH 			//0392 	274D
		LCALL 	3D6H 			//0393 	33D6
		ORG		0394H

		//;1.C: 744: }
		//;1.C: 745: }
		//;1.C: 746: if(CH3_remotekey_num > 4) CH3_remotekey_num = 4;
		LDWI 	5H 			//0394 	2A05
		BCR 	STATUS,5 		//0395 	1283
		SUBWR 	69H,0 			//0396 	0C69
		BTSS 	STATUS,0 		//0397 	1C03
		LJUMP 	39BH 			//0398 	3B9B
		LDWI 	4H 			//0399 	2A04
		STR 	69H 			//039A 	01E9

		//;1.C: 747: PRESSED &= ~0x40;
		BCR 	75H,6 			//039B 	1375
		ORG		039CH

		//;1.C: 748: CH3_EEPROM_Write();
		LCALL 	536H 			//039C 	3536

		//;1.C: 749: PA5 = 1;
		BCR 	STATUS,5 		//039D 	1283
		BSR 	5H,5 			//039E 	1A85

		//;1.C: 750: }
		//;1.C: 751: KEY_Match_counter = 0;
		CLRR 	25H 			//039F 	0125

		//;1.C: 752: PC0 = 1;
		BSR 	7H,0 			//03A0 	1807
		LJUMP 	3ADH 			//03A1 	3BAD
		LDR 	25H,0 			//03A2 	0825
		STR 	FSR 			//03A3 	0184
		ORG		03A4H
		LDWI 	4H 			//03A4 	2A04
		SUBWR 	FSR,0 			//03A5 	0C04
		BTSC 	STATUS,0 		//03A6 	1403
		LJUMP 	3ADH 			//03A7 	3BAD
		LDWI 	6H 			//03A8 	2A06
		STR 	PCLATH 			//03A9 	018A
		LDWI 	9AH 			//03AA 	2A9A
		ADDWR 	FSR,0 			//03AB 	0B04
		ORG		03ACH
		STR 	PCL 			//03AC 	0182

		//;1.C: 756: }
		//;1.C: 759: if( ((PRESSED&0x10) == 0) &&
		//;1.C: 760: ((PRESSED&0x20) == 0) &&
		//;1.C: 761: ((PRESSED&0x40) == 0)
		//;1.C: 762: ){
		BTSS 	75H,4 			//03AD 	1E75
		BTSC 	75H,5 			//03AE 	16F5
		RET		 					//03AF 	0004
		BTSC 	75H,6 			//03B0 	1775
		RET		 					//03B1 	0004

		//;1.C: 763: if((PRESSED&0x0F) > 0){
		LDR 	75H,0 			//03B2 	0875
		ANDWI 	FH 			//03B3 	240F
		ORG		03B4H
		BTSS 	STATUS,2 		//03B4 	1D03
		LJUMP 	3BFH 			//03B5 	3BBF
		LJUMP 	3D3H 			//03B6 	3BD3

		//;1.C: 766: PA7 = ~PA7;
		LDWI 	80H 			//03B7 	2A80
		XORWR 	5H,1 			//03B8 	0485

		//;1.C: 767: led1_debug();
		LCALL 	6A2H 			//03B9 	36A2

		//;1.C: 768: break;
		LJUMP 	3D3H 			//03BA 	3BD3

		//;1.C: 770: PA6 = ~PA6;
		LDWI 	40H 			//03BB 	2A40
		ORG		03BCH
		LJUMP 	3B8H 			//03BC 	3BB8

		//;1.C: 774: PA5 = ~PA5;
		LDWI 	20H 			//03BD 	2A20
		LJUMP 	3B8H 			//03BE 	3BB8
		LDR 	75H,0 			//03BF 	0875
		ANDWI 	FH 			//03C0 	240F
		STR 	78H 			//03C1 	01F8
		CLRR 	79H 			//03C2 	0179
		LDR 	79H,0 			//03C3 	0879
		ORG		03C4H
		XORWI 	0H 			//03C4 	2600
		BTSC 	STATUS,2 		//03C5 	1503
		LJUMP 	3C8H 			//03C6 	3BC8
		LJUMP 	3D3H 			//03C7 	3BD3
		LDR 	78H,0 			//03C8 	0878
		XORWI 	1H 			//03C9 	2601
		BTSC 	STATUS,2 		//03CA 	1503
		LJUMP 	3B7H 			//03CB 	3BB7
		ORG		03CCH
		XORWI 	3H 			//03CC 	2603
		BTSC 	STATUS,2 		//03CD 	1503
		LJUMP 	3BBH 			//03CE 	3BBB
		XORWI 	6H 			//03CF 	2606
		BTSC 	STATUS,2 		//03D0 	1503
		LJUMP 	3BDH 			//03D1 	3BBD
		LJUMP 	3D3H 			//03D2 	3BD3

		//;1.C: 778: }
		//;1.C: 779: PRESSED &= 0xF0;
		LDWI 	F0H 			//03D3 	2AF0
		ORG		03D4H
		ANDWR 	75H,1 			//03D4 	02F5
		RET		 					//03D5 	0004
		STR 	FSR 			//03D6 	0184
		LDR 	70H,0 			//03D7 	0870
		BCR 	STATUS,7 		//03D8 	1383
		STR 	INDF 			//03D9 	0180
		INCR	FSR,1 			//03DA 	0984
		LDR 	71H,0 			//03DB 	0871
		ORG		03DCH
		STR 	INDF 			//03DC 	0180
		INCR	FSR,1 			//03DD 	0984
		LDR 	72H,0 			//03DE 	0872
		STR 	INDF 			//03DF 	0180
		INCR	FSR,1 			//03E0 	0984
		LDR 	73H,0 			//03E1 	0873
		STR 	INDF 			//03E2 	0180
		RET		 					//03E3 	0004
		ORG		03E4H
		STR 	78H 			//03E4 	01F8
		BCR 	STATUS,0 		//03E5 	1003
		RLR 	78H,1 			//03E6 	05F8
		BCR 	STATUS,0 		//03E7 	1003
		RLR 	78H,0 			//03E8 	0578
		RET		 					//03E9 	0004

		//;1.C: 591: if(PRESSED == 0){
		LDR 	75H,1 			//03EA 	08F5
		BTSS 	STATUS,2 		//03EB 	1D03
		ORG		03ECH
		RET		 					//03EC 	0004

		//;1.C: 592: if(PC5 == 0){
		BTSC 	7H,5 			//03ED 	1687
		LJUMP 	426H 			//03EE 	3C26

		//;1.C: 593: if(KEY1_LongPress < 125) PRESS_FLAG |= 0x01;
		LDWI 	7DH 			//03EF 	2A7D
		SUBWR 	22H,0 			//03F0 	0C22
		BTSC 	STATUS,0 		//03F1 	1403
		LJUMP 	3F4H 			//03F2 	3BF4
		BSR 	27H,0 			//03F3 	1827
		ORG		03F4H

		//;1.C: 594: if(KEY1_LongPress < 254) KEY1_LongPress++;
		LDWI 	FEH 			//03F4 	2AFE
		SUBWR 	22H,0 			//03F5 	0C22
		BTSS 	STATUS,0 		//03F6 	1C03
		INCR	22H,1 			//03F7 	09A2

		//;1.C: 595: if((KEY1_LongPress > 125) && (KEY1_LongPress < 250)){
		LDWI 	7EH 			//03F8 	2A7E
		SUBWR 	22H,0 			//03F9 	0C22
		BTSS 	STATUS,0 		//03FA 	1C03
		LJUMP 	406H 			//03FB 	3C06
		ORG		03FCH
		LDWI 	FAH 			//03FC 	2AFA
		SUBWR 	22H,0 			//03FD 	0C22
		BTSC 	STATUS,0 		//03FE 	1403
		LJUMP 	406H 			//03FF 	3C06

		//;1.C: 596: PRESS_FLAG |= 0x10;
		BSR 	27H,4 			//0400 	1A27

		//;1.C: 597: match_slice = 0;
		CLRR 	28H 			//0401 	0128

		//;1.C: 598: PC0 = 0;
		BCR 	7H,0 			//0402 	1007

		//;1.C: 599: PA7 = 0;
		BCR 	5H,7 			//0403 	1385
		ORG		0404H

		//;1.C: 600: LONGPRESS_OverTime_Counter = 0;
		BSR 	STATUS,5 		//0404 	1A83
		CLRR 	2AH 			//0405 	012A

		//;1.C: 601: }
		//;1.C: 602: if(KEY1_LongPress > 250){
		LDWI 	FBH 			//0406 	2AFB
		BCR 	STATUS,5 		//0407 	1283
		SUBWR 	22H,0 			//0408 	0C22
		BTSS 	STATUS,0 		//0409 	1C03
		LJUMP 	427H 			//040A 	3C27

		//;1.C: 603: CH1_remotekey[0] = 0xFFFFFFFF;
		LDWI 	FFH 			//040B 	2AFF
		ORG		040CH
		STR 	30H 			//040C 	01B0
		STR 	2FH 			//040D 	01AF
		STR 	2EH 			//040E 	01AE
		STR 	2DH 			//040F 	01AD

		//;1.C: 604: CH1_remotekey[1] = 0xFFFFFFFF;
		STR 	34H 			//0410 	01B4
		STR 	33H 			//0411 	01B3
		STR 	32H 			//0412 	01B2
		STR 	31H 			//0413 	01B1
		ORG		0414H

		//;1.C: 605: CH1_remotekey[2] = 0xFFFFFFFF;
		STR 	38H 			//0414 	01B8
		STR 	37H 			//0415 	01B7
		STR 	36H 			//0416 	01B6
		STR 	35H 			//0417 	01B5

		//;1.C: 606: CH1_remotekey[3] = 0xFFFFFFFF;
		STR 	3CH 			//0418 	01BC
		STR 	3BH 			//0419 	01BB
		STR 	3AH 			//041A 	01BA
		STR 	39H 			//041B 	01B9
		ORG		041CH

		//;1.C: 607: CH1_remotekey_num = 0;
		CLRR 	67H 			//041C 	0167

		//;1.C: 608: CH1_remotekey_Latest = 0;
		BSR 	STATUS,5 		//041D 	1A83
		CLRR 	33H 			//041E 	0133

		//;1.C: 609: PRESS_FLAG &= ~0x10;
		BCR 	STATUS,5 		//041F 	1283
		BCR 	27H,4 			//0420 	1227

		//;1.C: 610: PRESS_FLAG &= ~0x01;
		BCR 	27H,0 			//0421 	1027

		//;1.C: 611: PC0 = 1;
		BSR 	7H,0 			//0422 	1807

		//;1.C: 612: PA7 = 1;
		BSR 	5H,7 			//0423 	1B85
		ORG		0424H

		//;1.C: 613: KEY_Match_counter = 0;
		CLRR 	25H 			//0424 	0125
		LJUMP 	427H 			//0425 	3C27
		CLRR 	22H 			//0426 	0122

		//;1.C: 617: if(PA4 == 0){
		BTSC 	5H,4 			//0427 	1605
		LJUMP 	460H 			//0428 	3C60

		//;1.C: 618: if(KEY2_LongPress < 125) PRESS_FLAG |= 0x02;
		LDWI 	7DH 			//0429 	2A7D
		SUBWR 	23H,0 			//042A 	0C23
		BTSC 	STATUS,0 		//042B 	1403
		ORG		042CH
		LJUMP 	42EH 			//042C 	3C2E
		BSR 	27H,1 			//042D 	18A7

		//;1.C: 619: if(KEY2_LongPress < 254) KEY2_LongPress++;
		LDWI 	FEH 			//042E 	2AFE
		SUBWR 	23H,0 			//042F 	0C23
		BTSS 	STATUS,0 		//0430 	1C03
		INCR	23H,1 			//0431 	09A3

		//;1.C: 620: if((KEY2_LongPress > 125) && (KEY2_LongPress < 250)){
		LDWI 	7EH 			//0432 	2A7E
		SUBWR 	23H,0 			//0433 	0C23
		ORG		0434H
		BTSS 	STATUS,0 		//0434 	1C03
		LJUMP 	440H 			//0435 	3C40
		LDWI 	FAH 			//0436 	2AFA
		SUBWR 	23H,0 			//0437 	0C23
		BTSC 	STATUS,0 		//0438 	1403
		LJUMP 	440H 			//0439 	3C40

		//;1.C: 621: PRESS_FLAG |= 0x20;
		BSR 	27H,5 			//043A 	1AA7

		//;1.C: 622: match_slice = 0;
		CLRR 	28H 			//043B 	0128
		ORG		043CH

		//;1.C: 623: PC0 = 0;
		BCR 	7H,0 			//043C 	1007

		//;1.C: 624: PA6 = 0;
		BCR 	5H,6 			//043D 	1305

		//;1.C: 625: LONGPRESS_OverTime_Counter = 0;
		BSR 	STATUS,5 		//043E 	1A83
		CLRR 	2AH 			//043F 	012A

		//;1.C: 626: }
		//;1.C: 627: if(KEY2_LongPress > 250){
		LDWI 	FBH 			//0440 	2AFB
		BCR 	STATUS,5 		//0441 	1283
		SUBWR 	23H,0 			//0442 	0C23
		BTSS 	STATUS,0 		//0443 	1C03
		ORG		0444H
		LJUMP 	461H 			//0444 	3C61

		//;1.C: 628: CH2_remotekey[0] = 0xFFFFFFFF;
		LDWI 	FFH 			//0445 	2AFF
		STR 	40H 			//0446 	01C0
		STR 	3FH 			//0447 	01BF
		STR 	3EH 			//0448 	01BE
		STR 	3DH 			//0449 	01BD

		//;1.C: 629: CH2_remotekey[1] = 0xFFFFFFFF;
		STR 	44H 			//044A 	01C4
		STR 	43H 			//044B 	01C3
		ORG		044CH
		STR 	42H 			//044C 	01C2
		STR 	41H 			//044D 	01C1

		//;1.C: 630: CH2_remotekey[2] = 0xFFFFFFFF;
		STR 	48H 			//044E 	01C8
		STR 	47H 			//044F 	01C7
		STR 	46H 			//0450 	01C6
		STR 	45H 			//0451 	01C5

		//;1.C: 631: CH2_remotekey[3] = 0xFFFFFFFF;
		STR 	4CH 			//0452 	01CC
		STR 	4BH 			//0453 	01CB
		ORG		0454H
		STR 	4AH 			//0454 	01CA
		STR 	49H 			//0455 	01C9

		//;1.C: 632: CH2_remotekey_num = 0;
		CLRR 	68H 			//0456 	0168

		//;1.C: 633: CH2_remotekey_Latest = 0;
		BSR 	STATUS,5 		//0457 	1A83
		CLRR 	34H 			//0458 	0134

		//;1.C: 634: PRESS_FLAG &= ~0x20;
		BCR 	STATUS,5 		//0459 	1283
		BCR 	27H,5 			//045A 	12A7

		//;1.C: 635: PRESS_FLAG &= ~0x02;
		BCR 	27H,1 			//045B 	10A7
		ORG		045CH

		//;1.C: 636: PC0 = 1;
		BSR 	7H,0 			//045C 	1807

		//;1.C: 637: PA6 = 1;
		BSR 	5H,6 			//045D 	1B05

		//;1.C: 638: KEY_Match_counter = 0;
		CLRR 	25H 			//045E 	0125
		LJUMP 	461H 			//045F 	3C61
		CLRR 	23H 			//0460 	0123

		//;1.C: 642: if(PC4 == 0){
		BTSC 	7H,4 			//0461 	1607
		LJUMP 	49AH 			//0462 	3C9A

		//;1.C: 643: if(KEY3_LongPress < 125) PRESS_FLAG |= 0x04;
		LDWI 	7DH 			//0463 	2A7D
		ORG		0464H
		SUBWR 	24H,0 			//0464 	0C24
		BTSC 	STATUS,0 		//0465 	1403
		LJUMP 	468H 			//0466 	3C68
		BSR 	27H,2 			//0467 	1927

		//;1.C: 644: if(KEY3_LongPress < 254) KEY3_LongPress++;
		LDWI 	FEH 			//0468 	2AFE
		SUBWR 	24H,0 			//0469 	0C24
		BTSS 	STATUS,0 		//046A 	1C03
		INCR	24H,1 			//046B 	09A4
		ORG		046CH

		//;1.C: 645: if((KEY3_LongPress > 125) && (KEY3_LongPress < 250)){
		LDWI 	7EH 			//046C 	2A7E
		SUBWR 	24H,0 			//046D 	0C24
		BTSS 	STATUS,0 		//046E 	1C03
		LJUMP 	47AH 			//046F 	3C7A
		LDWI 	FAH 			//0470 	2AFA
		SUBWR 	24H,0 			//0471 	0C24
		BTSC 	STATUS,0 		//0472 	1403
		LJUMP 	47AH 			//0473 	3C7A
		ORG		0474H

		//;1.C: 646: PRESS_FLAG |= 0x40;
		BSR 	27H,6 			//0474 	1B27

		//;1.C: 647: match_slice = 0;
		CLRR 	28H 			//0475 	0128

		//;1.C: 648: PC0 = 0;
		BCR 	7H,0 			//0476 	1007

		//;1.C: 649: PA5 = 0;
		BCR 	5H,5 			//0477 	1285

		//;1.C: 650: LONGPRESS_OverTime_Counter = 0;
		BSR 	STATUS,5 		//0478 	1A83
		CLRR 	2AH 			//0479 	012A

		//;1.C: 651: }
		//;1.C: 652: if(KEY3_LongPress > 250){
		LDWI 	FBH 			//047A 	2AFB
		BCR 	STATUS,5 		//047B 	1283
		ORG		047CH
		SUBWR 	24H,0 			//047C 	0C24
		BTSS 	STATUS,0 		//047D 	1C03
		LJUMP 	49BH 			//047E 	3C9B

		//;1.C: 653: CH3_remotekey[0] = 0xFFFFFFFF;
		LDWI 	FFH 			//047F 	2AFF
		STR 	50H 			//0480 	01D0
		STR 	4FH 			//0481 	01CF
		STR 	4EH 			//0482 	01CE
		STR 	4DH 			//0483 	01CD
		ORG		0484H

		//;1.C: 654: CH3_remotekey[1] = 0xFFFFFFFF;
		STR 	54H 			//0484 	01D4
		STR 	53H 			//0485 	01D3
		STR 	52H 			//0486 	01D2
		STR 	51H 			//0487 	01D1

		//;1.C: 655: CH3_remotekey[2] = 0xFFFFFFFF;
		STR 	58H 			//0488 	01D8
		STR 	57H 			//0489 	01D7
		STR 	56H 			//048A 	01D6
		STR 	55H 			//048B 	01D5
		ORG		048CH

		//;1.C: 656: CH3_remotekey[3] = 0xFFFFFFFF;
		STR 	5CH 			//048C 	01DC
		STR 	5BH 			//048D 	01DB
		STR 	5AH 			//048E 	01DA
		STR 	59H 			//048F 	01D9

		//;1.C: 657: CH3_remotekey_num = 0;
		CLRR 	69H 			//0490 	0169

		//;1.C: 658: CH3_remotekey_Latest = 0;
		BSR 	STATUS,5 		//0491 	1A83
		CLRR 	35H 			//0492 	0135

		//;1.C: 659: PRESS_FLAG &= ~0x40;
		BCR 	STATUS,5 		//0493 	1283
		ORG		0494H
		BCR 	27H,6 			//0494 	1327

		//;1.C: 660: PRESS_FLAG &= ~0x04;
		BCR 	27H,2 			//0495 	1127

		//;1.C: 661: PC0 = 1;
		BSR 	7H,0 			//0496 	1807

		//;1.C: 662: PA5 = 1;
		BSR 	5H,5 			//0497 	1A85

		//;1.C: 663: KEY_Match_counter = 0;
		CLRR 	25H 			//0498 	0125
		LJUMP 	49BH 			//0499 	3C9B
		CLRR 	24H 			//049A 	0124

		//;1.C: 667: if((PRESS_FLAG>0)&&(PC5==1)&&(PA4==1)&&(PC4==1)){
		LDR 	27H,0 			//049B 	0827
		ORG		049CH
		BTSS 	STATUS,2 		//049C 	1D03
		BTSS 	7H,5 			//049D 	1E87
		RET		 					//049E 	0004
		BTSC 	5H,4 			//049F 	1605
		BTSS 	7H,4 			//04A0 	1E07
		RET		 					//04A1 	0004

		//;1.C: 668: PRESSED = PRESS_FLAG;
		STR 	75H 			//04A2 	01F5

		//;1.C: 669: PRESS_FLAG = 0;
		CLRR 	27H 			//04A3 	0127
		ORG		04A4H
		RET		 					//04A4 	0004
		STR 	32H 			//04A5 	01B2

		//;1.C: 563: *buff = 0;
		STR 	FSR 			//04A6 	0184
		CLRR 	INDF 			//04A7 	0100
		INCR	FSR,1 			//04A8 	0984
		CLRR 	INDF 			//04A9 	0100
		INCR	FSR,1 			//04AA 	0984
		CLRR 	INDF 			//04AB 	0100
		ORG		04ACH
		INCR	FSR,1 			//04AC 	0984
		CLRR 	INDF 			//04AD 	0100

		//;1.C: 564: EE_Buff = IAPRead(data+2);
		LDR 	2DH,0 			//04AE 	082D
		ADDWI 	2H 			//04AF 	2702
		LCALL 	68BH 			//04B0 	368B

		//;1.C: 565: *buff |= EE_Buff;
		LCALL 	4E5H 			//04B1 	34E5

		//;1.C: 566: *buff = *buff<<8;
		LCALL 	4BFH 			//04B2 	34BF

		//;1.C: 567: EE_Buff = IAPRead(data+1);
		INCR	2DH,0 			//04B3 	092D
		ORG		04B4H
		LCALL 	68BH 			//04B4 	368B

		//;1.C: 568: *buff |= EE_Buff;
		LCALL 	4E5H 			//04B5 	34E5

		//;1.C: 569: *buff = *buff<<8;
		LCALL 	4BFH 			//04B6 	34BF

		//;1.C: 570: EE_Buff = IAPRead(data);
		LDR 	2DH,0 			//04B7 	082D
		LCALL 	68BH 			//04B8 	368B

		//;1.C: 571: *buff |= EE_Buff;
		LCALL 	4E5H 			//04B9 	34E5
		IORWR 	INDF,1 		//04BA 	0380
		INCR	FSR,1 			//04BB 	0984
		ORG		04BCH
		LDR 	31H,0 			//04BC 	0831
		IORWR 	INDF,1 		//04BD 	0380
		RET		 					//04BE 	0004
		IORWR 	INDF,1 		//04BF 	0380
		INCR	FSR,1 			//04C0 	0984
		LDR 	31H,0 			//04C1 	0831
		IORWR 	INDF,1 		//04C2 	0380
		LDR 	32H,0 			//04C3 	0832
		ORG		04C4H
		STR 	FSR 			//04C4 	0184
		LDR 	INDF,0 			//04C5 	0800
		STR 	2EH 			//04C6 	01AE
		INCR	FSR,1 			//04C7 	0984
		LDR 	INDF,0 			//04C8 	0800
		STR 	2FH 			//04C9 	01AF
		INCR	FSR,1 			//04CA 	0984
		LDR 	INDF,0 			//04CB 	0800
		ORG		04CCH
		STR 	30H 			//04CC 	01B0
		INCR	FSR,1 			//04CD 	0984
		LDR 	INDF,0 			//04CE 	0800
		STR 	31H 			//04CF 	01B1
		LDR 	30H,0 			//04D0 	0830
		STR 	31H 			//04D1 	01B1
		LDR 	2FH,0 			//04D2 	082F
		STR 	30H 			//04D3 	01B0
		ORG		04D4H
		LDR 	2EH,0 			//04D4 	082E
		STR 	2FH 			//04D5 	01AF
		CLRR 	2EH 			//04D6 	012E
		LDR 	32H,0 			//04D7 	0832
		STR 	FSR 			//04D8 	0184
		LDR 	2EH,0 			//04D9 	082E
		STR 	INDF 			//04DA 	0180
		INCR	FSR,1 			//04DB 	0984
		ORG		04DCH
		LDR 	2FH,0 			//04DC 	082F
		STR 	INDF 			//04DD 	0180
		INCR	FSR,1 			//04DE 	0984
		LDR 	30H,0 			//04DF 	0830
		STR 	INDF 			//04E0 	0180
		INCR	FSR,1 			//04E1 	0984
		LDR 	31H,0 			//04E2 	0831
		STR 	INDF 			//04E3 	0180
		ORG		04E4H
		RET		 					//04E4 	0004
		STR 	36H 			//04E5 	01B6
		STR 	2EH 			//04E6 	01AE
		CLRR 	2FH 			//04E7 	012F
		CLRR 	30H 			//04E8 	0130
		CLRR 	31H 			//04E9 	0131
		LDR 	32H,0 			//04EA 	0832
		STR 	FSR 			//04EB 	0184
		ORG		04ECH
		LDR 	2EH,0 			//04EC 	082E
		IORWR 	INDF,1 		//04ED 	0380
		INCR	FSR,1 			//04EE 	0984
		LDR 	2FH,0 			//04EF 	082F
		IORWR 	INDF,1 		//04F0 	0380
		INCR	FSR,1 			//04F1 	0984
		LDR 	30H,0 			//04F2 	0830
		RET		 					//04F3 	0004
		ORG		04F4H
		LDWI 	2DH 			//04F4 	2A2D

		//;1.C: 574: EEPROM_ReadWord(&CH1_remotekey[0],0x00);
		CLRR 	2DH 			//04F5 	012D
		LCALL 	4A5H 			//04F6 	34A5

		//;1.C: 575: EEPROM_ReadWord(&CH2_remotekey[0],0x04);
		LDWI 	4H 			//04F7 	2A04
		STR 	2DH 			//04F8 	01AD
		LDWI 	3DH 			//04F9 	2A3D
		LCALL 	4A5H 			//04FA 	34A5

		//;1.C: 576: EEPROM_ReadWord(&CH3_remotekey[0],0x08);
		LDWI 	8H 			//04FB 	2A08
		ORG		04FCH
		STR 	2DH 			//04FC 	01AD
		LDWI 	4DH 			//04FD 	2A4D
		LCALL 	4A5H 			//04FE 	34A5

		//;1.C: 577: EEPROM_ReadWord(&CH1_remotekey[1],0x0C);
		LDWI 	CH 			//04FF 	2A0C
		STR 	2DH 			//0500 	01AD
		LDWI 	31H 			//0501 	2A31
		LCALL 	4A5H 			//0502 	34A5

		//;1.C: 578: EEPROM_ReadWord(&CH2_remotekey[1],0x10);
		LDWI 	10H 			//0503 	2A10
		ORG		0504H
		STR 	2DH 			//0504 	01AD
		LDWI 	41H 			//0505 	2A41
		LCALL 	4A5H 			//0506 	34A5

		//;1.C: 579: EEPROM_ReadWord(&CH3_remotekey[1],0x14);
		LDWI 	14H 			//0507 	2A14
		STR 	2DH 			//0508 	01AD
		LDWI 	51H 			//0509 	2A51
		LCALL 	4A5H 			//050A 	34A5

		//;1.C: 580: EEPROM_ReadWord(&CH1_remotekey[2],0x18);
		LDWI 	18H 			//050B 	2A18
		ORG		050CH
		STR 	2DH 			//050C 	01AD
		LDWI 	35H 			//050D 	2A35
		LCALL 	4A5H 			//050E 	34A5

		//;1.C: 581: EEPROM_ReadWord(&CH2_remotekey[2],0x1C);
		LDWI 	1CH 			//050F 	2A1C
		STR 	2DH 			//0510 	01AD
		LDWI 	45H 			//0511 	2A45
		LCALL 	4A5H 			//0512 	34A5

		//;1.C: 582: EEPROM_ReadWord(&CH3_remotekey[2],0x20);
		LDWI 	20H 			//0513 	2A20
		ORG		0514H
		STR 	2DH 			//0514 	01AD
		LDWI 	55H 			//0515 	2A55
		LCALL 	4A5H 			//0516 	34A5

		//;1.C: 583: EEPROM_ReadWord(&CH1_remotekey[3],0x24);
		LDWI 	24H 			//0517 	2A24
		STR 	2DH 			//0518 	01AD
		LDWI 	39H 			//0519 	2A39
		LCALL 	4A5H 			//051A 	34A5

		//;1.C: 584: EEPROM_ReadWord(&CH2_remotekey[3],0x28);
		LDWI 	28H 			//051B 	2A28
		ORG		051CH
		STR 	2DH 			//051C 	01AD
		LDWI 	49H 			//051D 	2A49
		LCALL 	4A5H 			//051E 	34A5

		//;1.C: 585: EEPROM_ReadWord(&CH3_remotekey[3],0x2C);
		LDWI 	2CH 			//051F 	2A2C
		STR 	2DH 			//0520 	01AD
		LDWI 	59H 			//0521 	2A59
		LCALL 	4A5H 			//0522 	34A5

		//;1.C: 586: CH1_remotekey_Latest = CH1_remotekey_num = IAPRead(0x30);
		LDWI 	30H 			//0523 	2A30
		ORG		0524H
		LCALL 	68BH 			//0524 	368B
		BCR 	STATUS,5 		//0525 	1283
		STR 	67H 			//0526 	01E7
		BSR 	STATUS,5 		//0527 	1A83
		STR 	33H 			//0528 	01B3

		//;1.C: 587: CH2_remotekey_Latest = CH2_remotekey_num = IAPRead(0x31);
		LDWI 	31H 			//0529 	2A31
		LCALL 	68BH 			//052A 	368B
		BCR 	STATUS,5 		//052B 	1283
		ORG		052CH
		STR 	68H 			//052C 	01E8
		BSR 	STATUS,5 		//052D 	1A83
		STR 	34H 			//052E 	01B4

		//;1.C: 588: CH3_remotekey_Latest = CH3_remotekey_num = IAPRead(0x32);
		LDWI 	32H 			//052F 	2A32
		LCALL 	68BH 			//0530 	368B
		BCR 	STATUS,5 		//0531 	1283
		STR 	69H 			//0532 	01E9
		BSR 	STATUS,5 		//0533 	1A83
		ORG		0534H
		STR 	35H 			//0534 	01B5
		RET		 					//0535 	0004

		//;1.C: 544: IAPWrite(0x08,((CH3_remotekey[0]&0x000000FF)>>0));
		LDR 	4DH,0 			//0536 	084D
		STR 	76H 			//0537 	01F6
		LDWI 	8H 			//0538 	2A08
		LCALL 	63CH 			//0539 	363C

		//;1.C: 545: IAPWrite(0x09,((CH3_remotekey[0]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//053A 	1283
		LDR 	4EH,0 			//053B 	084E
		ORG		053CH
		STR 	76H 			//053C 	01F6
		LDWI 	9H 			//053D 	2A09
		LCALL 	63CH 			//053E 	363C

		//;1.C: 546: IAPWrite(0x0A,((CH3_remotekey[0]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//053F 	1283
		LDR 	4FH,0 			//0540 	084F
		STR 	76H 			//0541 	01F6
		LDWI 	AH 			//0542 	2A0A
		LCALL 	63CH 			//0543 	363C
		ORG		0544H

		//;1.C: 548: IAPWrite(0x14,((CH3_remotekey[1]&0x000000FF)>>0));
		BCR 	STATUS,5 		//0544 	1283
		LDR 	51H,0 			//0545 	0851
		STR 	76H 			//0546 	01F6
		LDWI 	14H 			//0547 	2A14
		LCALL 	63CH 			//0548 	363C

		//;1.C: 549: IAPWrite(0x15,((CH3_remotekey[1]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//0549 	1283
		LDR 	52H,0 			//054A 	0852
		STR 	76H 			//054B 	01F6
		ORG		054CH
		LDWI 	15H 			//054C 	2A15
		LCALL 	63CH 			//054D 	363C

		//;1.C: 550: IAPWrite(0x16,((CH3_remotekey[1]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//054E 	1283
		LDR 	53H,0 			//054F 	0853
		STR 	76H 			//0550 	01F6
		LDWI 	16H 			//0551 	2A16
		LCALL 	63CH 			//0552 	363C

		//;1.C: 552: IAPWrite(0x20,((CH3_remotekey[2]&0x000000FF)>>0));
		BCR 	STATUS,5 		//0553 	1283
		ORG		0554H
		LDR 	55H,0 			//0554 	0855
		STR 	76H 			//0555 	01F6
		LDWI 	20H 			//0556 	2A20
		LCALL 	63CH 			//0557 	363C

		//;1.C: 553: IAPWrite(0x21,((CH3_remotekey[2]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//0558 	1283
		LDR 	56H,0 			//0559 	0856
		STR 	76H 			//055A 	01F6
		LDWI 	21H 			//055B 	2A21
		ORG		055CH
		LCALL 	63CH 			//055C 	363C

		//;1.C: 554: IAPWrite(0x22,((CH3_remotekey[2]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//055D 	1283
		LDR 	57H,0 			//055E 	0857
		STR 	76H 			//055F 	01F6
		LDWI 	22H 			//0560 	2A22
		LCALL 	63CH 			//0561 	363C

		//;1.C: 556: IAPWrite(0x2C,((CH3_remotekey[3]&0x000000FF)>>0));
		BCR 	STATUS,5 		//0562 	1283
		LDR 	59H,0 			//0563 	0859
		ORG		0564H
		STR 	76H 			//0564 	01F6
		LDWI 	2CH 			//0565 	2A2C
		LCALL 	63CH 			//0566 	363C

		//;1.C: 557: IAPWrite(0x2D,((CH3_remotekey[3]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//0567 	1283
		LDR 	5AH,0 			//0568 	085A
		STR 	76H 			//0569 	01F6
		LDWI 	2DH 			//056A 	2A2D
		LCALL 	63CH 			//056B 	363C
		ORG		056CH

		//;1.C: 558: IAPWrite(0x2E,((CH3_remotekey[3]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//056C 	1283
		LDR 	5BH,0 			//056D 	085B
		STR 	76H 			//056E 	01F6
		LDWI 	2EH 			//056F 	2A2E
		LCALL 	63CH 			//0570 	363C

		//;1.C: 560: IAPWrite(0x32,CH3_remotekey_num);
		BCR 	STATUS,5 		//0571 	1283
		LDR 	69H,0 			//0572 	0869
		STR 	76H 			//0573 	01F6
		ORG		0574H
		LDWI 	32H 			//0574 	2A32
		LJUMP 	63CH 			//0575 	3E3C

		//;1.C: 525: IAPWrite(0x04,((CH2_remotekey[0]&0x000000FF)>>0));
		LDR 	3DH,0 			//0576 	083D
		STR 	76H 			//0577 	01F6
		LDWI 	4H 			//0578 	2A04
		LCALL 	63CH 			//0579 	363C

		//;1.C: 526: IAPWrite(0x05,((CH2_remotekey[0]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//057A 	1283
		LDR 	3EH,0 			//057B 	083E
		ORG		057CH
		STR 	76H 			//057C 	01F6
		LDWI 	5H 			//057D 	2A05
		LCALL 	63CH 			//057E 	363C

		//;1.C: 527: IAPWrite(0x06,((CH2_remotekey[0]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//057F 	1283
		LDR 	3FH,0 			//0580 	083F
		STR 	76H 			//0581 	01F6
		LDWI 	6H 			//0582 	2A06
		LCALL 	63CH 			//0583 	363C
		ORG		0584H

		//;1.C: 529: IAPWrite(0x10,((CH2_remotekey[1]&0x000000FF)>>0));
		BCR 	STATUS,5 		//0584 	1283
		LDR 	41H,0 			//0585 	0841
		STR 	76H 			//0586 	01F6
		LDWI 	10H 			//0587 	2A10
		LCALL 	63CH 			//0588 	363C

		//;1.C: 530: IAPWrite(0x11,((CH2_remotekey[1]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//0589 	1283
		LDR 	42H,0 			//058A 	0842
		STR 	76H 			//058B 	01F6
		ORG		058CH
		LDWI 	11H 			//058C 	2A11
		LCALL 	63CH 			//058D 	363C

		//;1.C: 531: IAPWrite(0x12,((CH2_remotekey[1]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//058E 	1283
		LDR 	43H,0 			//058F 	0843
		STR 	76H 			//0590 	01F6
		LDWI 	12H 			//0591 	2A12
		LCALL 	63CH 			//0592 	363C

		//;1.C: 533: IAPWrite(0x1C,((CH2_remotekey[2]&0x000000FF)>>0));
		BCR 	STATUS,5 		//0593 	1283
		ORG		0594H
		LDR 	45H,0 			//0594 	0845
		STR 	76H 			//0595 	01F6
		LDWI 	1CH 			//0596 	2A1C
		LCALL 	63CH 			//0597 	363C

		//;1.C: 534: IAPWrite(0x1D,((CH2_remotekey[2]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//0598 	1283
		LDR 	46H,0 			//0599 	0846
		STR 	76H 			//059A 	01F6
		LDWI 	1DH 			//059B 	2A1D
		ORG		059CH
		LCALL 	63CH 			//059C 	363C

		//;1.C: 535: IAPWrite(0x1E,((CH2_remotekey[2]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//059D 	1283
		LDR 	47H,0 			//059E 	0847
		STR 	76H 			//059F 	01F6
		LDWI 	1EH 			//05A0 	2A1E
		LCALL 	63CH 			//05A1 	363C

		//;1.C: 537: IAPWrite(0x28,((CH2_remotekey[3]&0x000000FF)>>0));
		BCR 	STATUS,5 		//05A2 	1283
		LDR 	49H,0 			//05A3 	0849
		ORG		05A4H
		STR 	76H 			//05A4 	01F6
		LDWI 	28H 			//05A5 	2A28
		LCALL 	63CH 			//05A6 	363C

		//;1.C: 538: IAPWrite(0x29,((CH2_remotekey[3]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//05A7 	1283
		LDR 	4AH,0 			//05A8 	084A
		STR 	76H 			//05A9 	01F6
		LDWI 	29H 			//05AA 	2A29
		LCALL 	63CH 			//05AB 	363C
		ORG		05ACH

		//;1.C: 539: IAPWrite(0x2A,((CH2_remotekey[3]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//05AC 	1283
		LDR 	4BH,0 			//05AD 	084B
		STR 	76H 			//05AE 	01F6
		LDWI 	2AH 			//05AF 	2A2A
		LCALL 	63CH 			//05B0 	363C

		//;1.C: 541: IAPWrite(0x31,CH2_remotekey_num);
		BCR 	STATUS,5 		//05B1 	1283
		LDR 	68H,0 			//05B2 	0868
		STR 	76H 			//05B3 	01F6
		ORG		05B4H
		LDWI 	31H 			//05B4 	2A31
		LJUMP 	63CH 			//05B5 	3E3C

		//;1.C: 506: IAPWrite(0x00,((CH1_remotekey[0]&0x000000FF)>>0));
		LDR 	2DH,0 			//05B6 	082D
		STR 	76H 			//05B7 	01F6
		LDWI 	0H 			//05B8 	2A00
		LCALL 	63CH 			//05B9 	363C

		//;1.C: 507: IAPWrite(0x01,((CH1_remotekey[0]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//05BA 	1283
		LDR 	2EH,0 			//05BB 	082E
		ORG		05BCH
		STR 	76H 			//05BC 	01F6
		LDWI 	1H 			//05BD 	2A01
		LCALL 	63CH 			//05BE 	363C

		//;1.C: 508: IAPWrite(0x02,((CH1_remotekey[0]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//05BF 	1283
		LDR 	2FH,0 			//05C0 	082F
		STR 	76H 			//05C1 	01F6
		LDWI 	2H 			//05C2 	2A02
		LCALL 	63CH 			//05C3 	363C
		ORG		05C4H

		//;1.C: 510: IAPWrite(0x0C,((CH1_remotekey[1]&0x000000FF)>>0));
		BCR 	STATUS,5 		//05C4 	1283
		LDR 	31H,0 			//05C5 	0831
		STR 	76H 			//05C6 	01F6
		LDWI 	CH 			//05C7 	2A0C
		LCALL 	63CH 			//05C8 	363C

		//;1.C: 511: IAPWrite(0x0D,((CH1_remotekey[1]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//05C9 	1283
		LDR 	32H,0 			//05CA 	0832
		STR 	76H 			//05CB 	01F6
		ORG		05CCH
		LDWI 	DH 			//05CC 	2A0D
		LCALL 	63CH 			//05CD 	363C

		//;1.C: 512: IAPWrite(0x0E,((CH1_remotekey[1]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//05CE 	1283
		LDR 	33H,0 			//05CF 	0833
		STR 	76H 			//05D0 	01F6
		LDWI 	EH 			//05D1 	2A0E
		LCALL 	63CH 			//05D2 	363C

		//;1.C: 514: IAPWrite(0x18,((CH1_remotekey[2]&0x000000FF)>>0));
		BCR 	STATUS,5 		//05D3 	1283
		ORG		05D4H
		LDR 	35H,0 			//05D4 	0835
		STR 	76H 			//05D5 	01F6
		LDWI 	18H 			//05D6 	2A18
		LCALL 	63CH 			//05D7 	363C

		//;1.C: 515: IAPWrite(0x19,((CH1_remotekey[2]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//05D8 	1283
		LDR 	36H,0 			//05D9 	0836
		STR 	76H 			//05DA 	01F6
		LDWI 	19H 			//05DB 	2A19
		ORG		05DCH
		LCALL 	63CH 			//05DC 	363C

		//;1.C: 516: IAPWrite(0x1A,((CH1_remotekey[2]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//05DD 	1283
		LDR 	37H,0 			//05DE 	0837
		STR 	76H 			//05DF 	01F6
		LDWI 	1AH 			//05E0 	2A1A
		LCALL 	63CH 			//05E1 	363C

		//;1.C: 518: IAPWrite(0x24,((CH1_remotekey[3]&0x000000FF)>>0));
		BCR 	STATUS,5 		//05E2 	1283
		LDR 	39H,0 			//05E3 	0839
		ORG		05E4H
		STR 	76H 			//05E4 	01F6
		LDWI 	24H 			//05E5 	2A24
		LCALL 	63CH 			//05E6 	363C

		//;1.C: 519: IAPWrite(0x25,((CH1_remotekey[3]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//05E7 	1283
		LDR 	3AH,0 			//05E8 	083A
		STR 	76H 			//05E9 	01F6
		LDWI 	25H 			//05EA 	2A25
		LCALL 	63CH 			//05EB 	363C
		ORG		05ECH

		//;1.C: 520: IAPWrite(0x26,((CH1_remotekey[3]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//05EC 	1283
		LDR 	3BH,0 			//05ED 	083B
		STR 	76H 			//05EE 	01F6
		LDWI 	26H 			//05EF 	2A26
		LCALL 	63CH 			//05F0 	363C

		//;1.C: 522: IAPWrite(0x30,CH1_remotekey_num);
		BCR 	STATUS,5 		//05F1 	1283
		LDR 	67H,0 			//05F2 	0867
		STR 	76H 			//05F3 	01F6
		ORG		05F4H
		LDWI 	30H 			//05F4 	2A30
		LJUMP 	63CH 			//05F5 	3E3C

		//;1.C: 426: OSCCON = 0B01100001;
		LDWI 	61H 			//05F6 	2A61
		BSR 	STATUS,5 		//05F7 	1A83
		STR 	FH 			//05F8 	018F

		//;1.C: 431: INTCON = 0;
		CLRR 	INTCON 			//05F9 	010B

		//;1.C: 433: PORTA = 0B00000000;
		BCR 	STATUS,5 		//05FA 	1283
		CLRR 	5H 			//05FB 	0105
		ORG		05FCH

		//;1.C: 434: TRISA = 0B00010111;
		LDWI 	17H 			//05FC 	2A17
		BSR 	STATUS,5 		//05FD 	1A83
		STR 	5H 			//05FE 	0185

		//;1.C: 435: WPUA = 0B00000000;
		CLRR 	15H 			//05FF 	0115

		//;1.C: 436: PSRCA = 0B11111111;
		LDWI 	FFH 			//0600 	2AFF
		STR 	8H 			//0601 	0188

		//;1.C: 437: PSINKA = 0B11111111;
		STR 	17H 			//0602 	0197

		//;1.C: 439: PORTC = 0B00000000;
		BCR 	STATUS,5 		//0603 	1283
		ORG		0604H
		CLRR 	7H 			//0604 	0107

		//;1.C: 440: TRISC = 0B11110000;
		LDWI 	F0H 			//0605 	2AF0
		BSR 	STATUS,5 		//0606 	1A83
		STR 	7H 			//0607 	0187

		//;1.C: 441: WPUC = 0B00000000;
		CLRR 	13H 			//0608 	0113

		//;1.C: 442: PSRCC = 0B11111111;
		LDWI 	FFH 			//0609 	2AFF
		STR 	14H 			//060A 	0194

		//;1.C: 443: PSINKC = 0B11111111;
		STR 	1FH 			//060B 	019F
		ORG		060CH

		//;1.C: 445: OPTION = 0B00001000;
		LDWI 	8H 			//060C 	2A08
		STR 	1H 			//060D 	0181
		RET		 					//060E 	0004
		CLRR 	7AH 			//060F 	017A
		CLRR 	7BH 			//0610 	017B
		BTSS 	76H,0 			//0611 	1C76
		LJUMP 	619H 			//0612 	3E19
		LDR 	78H,0 			//0613 	0878
		ORG		0614H
		ADDWR 	7AH,1 			//0614 	0BFA
		BTSC 	STATUS,0 		//0615 	1403
		INCR	7BH,1 			//0616 	09FB
		LDR 	79H,0 			//0617 	0879
		ADDWR 	7BH,1 			//0618 	0BFB
		BCR 	STATUS,0 		//0619 	1003
		RLR 	78H,1 			//061A 	05F8
		RLR 	79H,1 			//061B 	05F9
		ORG		061CH
		BCR 	STATUS,0 		//061C 	1003
		RRR	77H,1 			//061D 	06F7
		RRR	76H,1 			//061E 	06F6
		LDR 	77H,0 			//061F 	0877
		IORWR 	76H,0 			//0620 	0376
		BTSS 	STATUS,2 		//0621 	1D03
		LJUMP 	611H 			//0622 	3E11
		LDR 	7BH,0 			//0623 	087B
		ORG		0624H
		STR 	77H 			//0624 	01F7
		LDR 	7AH,0 			//0625 	087A
		STR 	76H 			//0626 	01F6
		RET		 					//0627 	0004

		//;1.C: 789: OSC_INIT();
		LCALL 	5F6H 			//0628 	35F6

		//;1.C: 790: TIMER0_INITIAL();
		LCALL 	670H 			//0629 	3670

		//;1.C: 791: TIMER2_INITIAL();
		LCALL 	64FH 			//062A 	364F

		//;1.C: 792: INT_INITIAL();
		LCALL 	684H 			//062B 	3684
		ORG		062CH

		//;1.C: 793: EEPROM_Read();
		LCALL 	4F4H 			//062C 	34F4

		//;1.C: 794: WDT_INITIAL();
		LCALL 	691H 			//062D 	3691

		//;1.C: 795: PC0 = 1;
		BSR 	7H,0 			//062E 	1807

		//;1.C: 796: PA7 = 1;
		BSR 	5H,7 			//062F 	1B85

		//;1.C: 797: PA6 = 1;
		BSR 	5H,6 			//0630 	1B05

		//;1.C: 798: PA5 = 1;
		BSR 	5H,5 			//0631 	1A85

		//;1.C: 800: PA3 = 0;
		BCR 	5H,3 			//0632 	1185

		//;1.C: 801: FLAGs &= ~0x08;
		BCR 	74H,3 			//0633 	11F4
		ORG		0634H

		//;1.C: 802: EX_INT_FallingEdge();
		LCALL 	696H 			//0634 	3696

		//;1.C: 803: INTE =1;
		BSR 	INTCON,4 		//0635 	1A0B

		//;1.C: 805: TMR2ON =1;
		BCR 	STATUS,5 		//0636 	1283
		BSR 	12H,2 			//0637 	1912

		//;1.C: 807: PEIE = 1;
		BSR 	INTCON,6 		//0638 	1B0B

		//;1.C: 808: GIE = 1;
		BSR 	INTCON,7 		//0639 	1B8B
		CLRWDT	 			//063A 	0001
		LJUMP 	63AH 			//063B 	3E3A
		ORG		063CH
		STR 	77H 			//063C 	01F7

		//;1.C: 495: GIE = 0;
		BCR 	INTCON,7 		//063D 	138B

		//;1.C: 496: while(GIE);
		BTSC 	INTCON,7 		//063E 	178B
		LJUMP 	63EH 			//063F 	3E3E

		//;1.C: 497: EEADR = EEAddr;
		LDR 	77H,0 			//0640 	0877
		BSR 	STATUS,5 		//0641 	1A83
		STR 	1BH 			//0642 	019B

		//;1.C: 498: EEDAT = Data;
		LDR 	76H,0 			//0643 	0876
		ORG		0644H
		STR 	1AH 			//0644 	019A
		LDWI 	34H 			//0645 	2A34

		//;1.C: 499: EEIF = 0;
		BCR 	STATUS,5 		//0646 	1283
		BCR 	CH,7 			//0647 	138C

		//;1.C: 500: EECON1 |= 0x34;
		BSR 	STATUS,5 		//0648 	1A83
		IORWR 	1CH,1 			//0649 	039C

		//;1.C: 501: WR = 1;
		BSR 	1DH,0 			//064A 	181D

		//;1.C: 502: while(WR);
		BTSC 	1DH,0 			//064B 	141D
		ORG		064CH
		LJUMP 	64BH 			//064C 	3E4B

		//;1.C: 503: GIE = 1;
		BSR 	INTCON,7 		//064D 	1B8B
		RET		 					//064E 	0004

		//;1.C: 464: T2CON0 = 0B00000001;
		LDWI 	1H 			//064F 	2A01
		STR 	12H 			//0650 	0192

		//;1.C: 470: T2CON1 = 0B00000000;
		BSR 	STATUS,5 		//0651 	1A83
		CLRR 	1EH 			//0652 	011E

		//;1.C: 475: TMR2H = (53)/256;
		BCR 	STATUS,5 		//0653 	1283
		ORG		0654H
		CLRR 	13H 			//0654 	0113

		//;1.C: 476: TMR2L = (53)%256;
		LDWI 	35H 			//0655 	2A35
		STR 	11H 			//0656 	0191

		//;1.C: 479: PR2H = (53)/256;
		BSR 	STATUS,5 		//0657 	1A83
		CLRR 	12H 			//0658 	0112

		//;1.C: 480: PR2L = (53)%256;
		STR 	11H 			//0659 	0191

		//;1.C: 482: TMR2IF = 0;
		BCR 	STATUS,5 		//065A 	1283
		BCR 	CH,1 			//065B 	108C
		ORG		065CH

		//;1.C: 483: TMR2IE = 1;
		BSR 	STATUS,5 		//065C 	1A83
		BSR 	CH,1 			//065D 	188C

		//;1.C: 485: TMR2ON =0;
		BCR 	STATUS,5 		//065E 	1283
		BCR 	12H,2 			//065F 	1112
		RET		 					//0660 	0004
		LDWI 	70H 			//0661 	2A70
		STR 	FSR 			//0662 	0184
		LDWI 	76H 			//0663 	2A76
		ORG		0664H
		LCALL 	67CH 			//0664 	367C
		LDWI 	20H 			//0665 	2A20
		BCR 	STATUS,7 		//0666 	1383
		STR 	FSR 			//0667 	0184
		LDWI 	5DH 			//0668 	2A5D
		LCALL 	67CH 			//0669 	367C
		LDWI 	A0H 			//066A 	2AA0
		STR 	FSR 			//066B 	0184
		ORG		066CH
		LDWI 	ABH 			//066C 	2AAB
		LCALL 	67CH 			//066D 	367C
		CLRR 	STATUS 			//066E 	0103
		LJUMP 	628H 			//066F 	3E28
		LDWI 	F8H 			//0670 	2AF8

		//;1.C: 454: T0CS = 0;
		BCR 	1H,5 			//0671 	1281

		//;1.C: 455: PSA = 0;
		BCR 	1H,3 			//0672 	1181

		//;1.C: 456: OPTION &= 0xF8;
		ANDWR 	1H,1 			//0673 	0281
		ORG		0674H

		//;1.C: 457: OPTION |= 0x06;
		LDWI 	6H 			//0674 	2A06
		IORWR 	1H,1 			//0675 	0381

		//;1.C: 459: TMR0 = 5;
		LDWI 	5H 			//0676 	2A05
		BCR 	STATUS,5 		//0677 	1283
		STR 	1H 			//0678 	0181

		//;1.C: 460: T0IE = 1;
		BSR 	INTCON,5 		//0679 	1A8B

		//;1.C: 461: T0IF = 0;
		BCR 	INTCON,2 		//067A 	110B
		RET		 					//067B 	0004
		ORG		067CH
		CLRWDT	 			//067C 	0001
		CLRR 	INDF 			//067D 	0100
		INCR	FSR,1 			//067E 	0984
		XORWR 	FSR,0 			//067F 	0404
		BTSC 	STATUS,2 		//0680 	1503
		RETW 	0H 			//0681 	2100
		XORWR 	FSR,0 			//0682 	0404
		LJUMP 	67DH 			//0683 	3E7D
		ORG		0684H

		//;1.C: 410: TRISA2 =1;
		BSR 	STATUS,5 		//0684 	1A83
		BSR 	5H,2 			//0685 	1905

		//;1.C: 411: IOCA2 =0;
		BCR 	16H,2 			//0686 	1116

		//;1.C: 412: EX_INT_FallingEdge();
		LCALL 	696H 			//0687 	3696

		//;1.C: 413: INTF =0;
		BCR 	INTCON,1 		//0688 	108B

		//;1.C: 415: INTE =0;
		BCR 	INTCON,4 		//0689 	120B
		RET		 					//068A 	0004
		STR 	2BH 			//068B 	01AB
		ORG		068CH

		//;1.C: 488: unsigned char ReEEPROMread;
		//;1.C: 489: EEADR = EEAddr;
		STR 	1BH 			//068C 	019B

		//;1.C: 490: RD = 1;
		BSR 	1CH,0 			//068D 	181C

		//;1.C: 491: ReEEPROMread = EEDAT;
		LDR 	1AH,0 			//068E 	081A
		STR 	2CH 			//068F 	01AC

		//;1.C: 492: return ReEEPROMread;
		RET		 					//0690 	0004
		CLRWDT	 			//0691 	0001

		//;1.C: 450: WDTCON = 0B00010110;
		LDWI 	16H 			//0692 	2A16
		BCR 	STATUS,5 		//0693 	1283
		ORG		0694H
		STR 	18H 			//0694 	0198
		RET		 					//0695 	0004

		//;1.C: 422: INTEDG =0;
		BSR 	STATUS,5 		//0696 	1A83
		BCR 	1H,6 			//0697 	1301

		//;1.C: 423: FLAGs &= ~0x01;
		BCR 	74H,0 			//0698 	1074
		RET		 					//0699 	0004
		LJUMP 	269H 			//069A 	3A69
		LJUMP 	26FH 			//069B 	3A6F
		ORG		069CH
		LJUMP 	27AH 			//069C 	3A7A
		LJUMP 	285H 			//069D 	3A85

		//;1.C: 422: INTEDG =0;
		BSR 	STATUS,5 		//069E 	1A83
		BCR 	1H,6 			//069F 	1301

		//;1.C: 423: FLAGs &= ~0x01;
		BCR 	74H,0 			//06A0 	1074
		RET		 					//06A1 	0004

		//;1.C: 406: PC0 = ~PC0;
		LDWI 	1H 			//06A2 	2A01
		XORWR 	7H,1 			//06A3 	0487
		ORG		06A4H
		RET		 					//06A4 	0004

		//;1.C: 418: INTEDG =1;
		BSR 	1H,6 			//06A5 	1B01

		//;1.C: 419: FLAGs |= 0x01;
		BSR 	74H,0 			//06A6 	1874
		RET		 					//06A7 	0004
			END
