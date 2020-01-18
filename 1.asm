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
		LJUMP 	67EH 			//000F 	3E7E

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
		LCALL 	6BFH 			//001B 	36BF
		ORG		001CH

		//;1.C: 147: }else if((FLAGs&0x01) == 0x01){
		LJUMP 	15FH 			//001C 	395F
		BTSS 	74H,0 			//001D 	1C74
		LJUMP 	15FH 			//001E 	395F

		//;1.C: 148: EX_INT_FallingEdge();
		LCALL 	6BBH 			//001F 	36BB

		//;1.C: 149: buff = Indata*53;
		LDR 	29H,0 			//0020 	0829
		STR 	77H 			//0021 	01F7
		LDR 	28H,0 			//0022 	0828
		STR 	76H 			//0023 	01F6
		ORG		0024H
		LDWI 	35H 			//0024 	2A35
		STR 	78H 			//0025 	01F8
		CLRR 	79H 			//0026 	0179
		LCALL 	62CH 			//0027 	362C
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

		//;1.C: 158: if((buff>200)&&(buff<450)){
		LDWI 	0H 			//003C 	2A00
		SUBWR 	21H,0 			//003D 	0C21
		LDWI 	C9H 			//003E 	2AC9
		BTSC 	STATUS,2 		//003F 	1503
		SUBWR 	20H,0 			//0040 	0C20
		BTSS 	STATUS,0 		//0041 	1C03
		LJUMP 	4DH 			//0042 	384D
		LDWI 	1H 			//0043 	2A01
		ORG		0044H
		SUBWR 	21H,0 			//0044 	0C21
		LDWI 	C2H 			//0045 	2AC2
		BTSC 	STATUS,2 		//0046 	1503
		SUBWR 	20H,0 			//0047 	0C20
		BTSC 	STATUS,0 		//0048 	1403
		LJUMP 	4DH 			//0049 	384D

		//;1.C: 159: remotekey = remotekey<<1;
		BCR 	STATUS,0 		//004A 	1003
		LCALL 	25EH 			//004B 	325E
		ORG		004CH

		//;1.C: 160: remotekey |= 0x00000001;
		BSR 	24H,0 			//004C 	1824

		//;1.C: 161: }
		//;1.C: 162: if((buff>700)&&(buff<1200)){
		LDWI 	2H 			//004D 	2A02
		BCR 	STATUS,5 		//004E 	1283
		SUBWR 	21H,0 			//004F 	0C21
		LDWI 	BDH 			//0050 	2ABD
		BTSC 	STATUS,2 		//0051 	1503
		SUBWR 	20H,0 			//0052 	0C20
		BTSS 	STATUS,0 		//0053 	1C03
		ORG		0054H
		LJUMP 	5EH 			//0054 	385E
		LDWI 	4H 			//0055 	2A04
		SUBWR 	21H,0 			//0056 	0C21
		LDWI 	B0H 			//0057 	2AB0
		BTSC 	STATUS,2 		//0058 	1503
		SUBWR 	20H,0 			//0059 	0C20
		BTSC 	STATUS,0 		//005A 	1403
		LJUMP 	5EH 			//005B 	385E
		ORG		005CH

		//;1.C: 163: remotekey = remotekey<<1;
		BCR 	STATUS,0 		//005C 	1003
		LCALL 	25EH 			//005D 	325E

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
		LCALL 	240H 			//00AA 	3240
		ADDWI 	2DH 			//00AB 	272D
		ORG		00ACH
		LCALL 	224H 			//00AC 	3224
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
		LCALL 	6C2H 			//00C6 	36C2

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
		LCALL 	240H 			//00E2 	3240
		ADDWI 	3DH 			//00E3 	273D
		ORG		00E4H
		LCALL 	224H 			//00E4 	3224
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
		LCALL 	6C2H 			//00FE 	36C2

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
		LCALL 	240H 			//011A 	3240
		ADDWI 	4DH 			//011B 	274D
		ORG		011CH
		LCALL 	224H 			//011C 	3224
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
		LCALL 	6C2H 			//0136 	36C2

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
		LCALL 	257H 			//0146 	3257

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
		LCALL 	257H 			//0156 	3257

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
		//;1.C: 296: }
		//;1.C: 299: if(T0IE && T0IF){
		BTSC 	INTCON,5 		//0175 	168B
		BTSS 	INTCON,2 		//0176 	1D0B
		LJUMP 	218H 			//0177 	3A18

		//;1.C: 300: T0IF = 0;
		BCR 	INTCON,2 		//0178 	110B

		//;1.C: 301: ms16_counter ++;
		BCR 	STATUS,5 		//0179 	1283
		INCR	29H,1 			//017A 	09A9

		//;1.C: 304: if( ((FLAGs&0x10) == 0x10) ||
		//;1.C: 305: ((FLAGs&0x20) == 0x20) ||
		//;1.C: 306: ((FLAGs&0x40) == 0x40)
		//;1.C: 307: ){
		BTSS 	74H,4 			//017B 	1E74
		ORG		017CH
		BTSC 	74H,5 			//017C 	16F4
		LJUMP 	180H 			//017D 	3980
		BTSS 	74H,6 			//017E 	1F74
		LJUMP 	197H 			//017F 	3997

		//;1.C: 308: if(PA2 == 0) remotekey_slice++;
		BTSC 	5H,2 			//0180 	1505
		LJUMP 	183H 			//0181 	3983
		INCR	2CH,1 			//0182 	09AC

		//;1.C: 309: if(PA2 == 1) remotekey_slice = 0;
		BTSS 	5H,2 			//0183 	1D05
		ORG		0184H
		LJUMP 	186H 			//0184 	3986
		CLRR 	2CH 			//0185 	012C

		//;1.C: 310: if(Key_dealed_counter<255) Key_dealed_counter++;
		LDR 	26H,0 			//0186 	0826
		XORWI 	FFH 			//0187 	26FF
		BTSS 	STATUS,2 		//0188 	1D03
		INCR	26H,1 			//0189 	09A6

		//;1.C: 311: if( (remotekey_slice>(150/8)) ||
		//;1.C: 312: (Key_dealed_counter > (1024/8))
		//;1.C: 313: ){
		LDWI 	13H 			//018A 	2A13
		SUBWR 	2CH,0 			//018B 	0C2C
		ORG		018CH
		BTSC 	STATUS,0 		//018C 	1403
		LJUMP 	192H 			//018D 	3992
		LDWI 	81H 			//018E 	2A81
		SUBWR 	26H,0 			//018F 	0C26
		BTSS 	STATUS,0 		//0190 	1C03
		LJUMP 	197H 			//0191 	3997

		//;1.C: 314: remotekey_slice = 0;
		CLRR 	2CH 			//0192 	012C

		//;1.C: 316: FLAGs &= ~0x02;
		BCR 	74H,1 			//0193 	10F4
		ORG		0194H

		//;1.C: 317: FLAGs &= ~0x10;
		BCR 	74H,4 			//0194 	1274

		//;1.C: 318: FLAGs &= ~0x20;
		BCR 	74H,5 			//0195 	12F4

		//;1.C: 319: FLAGs &= ~0x40;
		BCR 	74H,6 			//0196 	1374

		//;1.C: 320: }
		//;1.C: 321: }
		//;1.C: 324: if( ((PRESSED&0x10) == 0x10) ||
		//;1.C: 325: ((PRESSED&0x20) == 0x20) ||
		//;1.C: 326: ((PRESSED&0x40) == 0x40)
		//;1.C: 327: ){
		BTSS 	75H,4 			//0197 	1E75
		BTSC 	75H,5 			//0198 	16F5
		LJUMP 	19CH 			//0199 	399C
		BTSS 	75H,6 			//019A 	1F75
		LJUMP 	1A3H 			//019B 	39A3
		ORG		019CH
		LDWI 	13H 			//019C 	2A13

		//;1.C: 328: match_slice++;
		INCR	28H,1 			//019D 	09A8

		//;1.C: 329: if(match_slice>(150/8)){
		SUBWR 	28H,0 			//019E 	0C28
		BTSS 	STATUS,0 		//019F 	1C03
		LJUMP 	1A3H 			//01A0 	39A3

		//;1.C: 330: match_slice = 0;
		CLRR 	28H 			//01A1 	0128

		//;1.C: 331: remotekey_Receive_num = 0;
		CLRR 	2BH 			//01A2 	012B

		//;1.C: 332: }
		//;1.C: 333: }
		//;1.C: 336: if((FLAGs&0x02) == 0){
		BTSC 	74H,1 			//01A3 	14F4
		ORG		01A4H
		LJUMP 	1BDH 			//01A4 	39BD

		//;1.C: 337: EE_Buff = ms16_counter%10;
		LDWI 	AH 			//01A5 	2A0A
		STR 	76H 			//01A6 	01F6
		LDR 	29H,0 			//01A7 	0829
		LCALL 	5F7H 			//01A8 	35F7
		BSR 	STATUS,5 		//01A9 	1A83
		STR 	36H 			//01AA 	01B6

		//;1.C: 338: if(EE_Buff == 1){
		DECRSZ 	36H,0 		//01AB 	0E36
		ORG		01ACH
		LJUMP 	1B3H 			//01AC 	39B3

		//;1.C: 339: PA3 = 0;
		BCR 	STATUS,5 		//01AD 	1283
		BCR 	5H,3 			//01AE 	1185

		//;1.C: 341: EX_INT_FallingEdge();
		LCALL 	6BBH 			//01AF 	36BB

		//;1.C: 342: INTE =1;
		BSR 	INTCON,4 		//01B0 	1A0B

		//;1.C: 343: TMR2ON =1;
		BCR 	STATUS,5 		//01B1 	1283
		BSR 	12H,2 			//01B2 	1912

		//;1.C: 344: }
		//;1.C: 345: if(EE_Buff == 3){
		BSR 	STATUS,5 		//01B3 	1A83
		ORG		01B4H
		LDR 	36H,0 			//01B4 	0836
		XORWI 	3H 			//01B5 	2603

		//;1.C: 346: PA3 = 1;
		BCR 	STATUS,5 		//01B6 	1283
		BTSS 	STATUS,2 		//01B7 	1D03
		LJUMP 	1C1H 			//01B8 	39C1
		BSR 	5H,3 			//01B9 	1985

		//;1.C: 347: TMR2ON =0;
		BCR 	12H,2 			//01BA 	1112

		//;1.C: 348: INTE =0;
		BCR 	INTCON,4 		//01BB 	120B
		ORG		01BCH
		LJUMP 	1C0H 			//01BC 	39C0

		//;1.C: 351: PA3 = 0;
		BCR 	5H,3 			//01BD 	1185

		//;1.C: 352: INTE =1;
		BSR 	INTCON,4 		//01BE 	1A0B

		//;1.C: 353: TMR2ON =1;
		BSR 	12H,2 			//01BF 	1912

		//;1.C: 354: }
		//;1.C: 357: if(ms16_counter%2 == 0){
		BCR 	STATUS,5 		//01C0 	1283
		BTSC 	29H,0 			//01C1 	1429
		LJUMP 	1C5H 			//01C2 	39C5

		//;1.C: 358: KEYSCAN();
		LCALL 	3EBH 			//01C3 	33EB
		ORG		01C4H

		//;1.C: 359: KEY();
		LCALL 	264H 			//01C4 	3264

		//;1.C: 360: }
		//;1.C: 364: if(ms16_counter >= 120){
		LDWI 	78H 			//01C5 	2A78
		SUBWR 	29H,0 			//01C6 	0C29
		BTSS 	STATUS,0 		//01C7 	1C03
		LJUMP 	218H 			//01C8 	3A18

		//;1.C: 365: ms16_counter = 0;
		CLRR 	29H 			//01C9 	0129

		//;1.C: 368: if( ((PRESSED&0x10) == 0x10) ||
		//;1.C: 369: ((PRESSED&0x20) == 0x20) ||
		//;1.C: 370: ((PRESSED&0x40) == 0x40)
		//;1.C: 371: ){
		BTSS 	75H,4 			//01CA 	1E75
		BTSC 	75H,5 			//01CB 	16F5
		ORG		01CCH
		LJUMP 	1CFH 			//01CC 	39CF
		BTSS 	75H,6 			//01CD 	1F75
		LJUMP 	218H 			//01CE 	3A18

		//;1.C: 372: if(KEY_Match_counter<4){
		LDWI 	4H 			//01CF 	2A04
		SUBWR 	25H,0 			//01D0 	0C25
		BTSS 	STATUS,0 		//01D1 	1C03

		//;1.C: 373: KEY_Match_counter++;
		INCR	25H,1 			//01D2 	09A5
		LDWI 	10H 			//01D3 	2A10
		ORG		01D4H

		//;1.C: 374: }
		//;1.C: 375: LONGPRESS_OverTime_Counter++;
		BSR 	STATUS,5 		//01D4 	1A83
		INCR	2AH,1 			//01D5 	09AA

		//;1.C: 376: if(LONGPRESS_OverTime_Counter > 15){
		SUBWR 	2AH,0 			//01D6 	0C2A
		BTSS 	STATUS,0 		//01D7 	1C03
		LJUMP 	218H 			//01D8 	3A18

		//;1.C: 377: LONGPRESS_OverTime_Counter = 0;
		CLRR 	2AH 			//01D9 	012A

		//;1.C: 378: if((PRESSED&0x10) == 0x10){
		BTSS 	75H,4 			//01DA 	1E75
		LJUMP 	1EEH 			//01DB 	39EE
		ORG		01DCH

		//;1.C: 379: CH1_remotekey[CH1_remotekey_Latest] = CH1_remotekey[CH1_remotekey_num-1];
		BCR 	STATUS,5 		//01DC 	1283
		LDR 	67H,0 			//01DD 	0867
		LCALL 	240H 			//01DE 	3240
		ADDWI 	29H 			//01DF 	2729
		LCALL 	224H 			//01E0 	3224
		LDR 	33H,0 			//01E1 	0833
		LCALL 	250H 			//01E2 	3250
		ADDWI 	2DH 			//01E3 	272D
		ORG		01E4H
		LCALL 	233H 			//01E4 	3233

		//;1.C: 380: CH1_remotekey[CH1_remotekey_num-1] = 0xFFFFFFFF;
		LDR 	67H,0 			//01E5 	0867
		LCALL 	240H 			//01E6 	3240
		ADDWI 	29H 			//01E7 	2729
		LCALL 	246H 			//01E8 	3246

		//;1.C: 381: if(CH1_remotekey_num>0) CH1_remotekey_num--;
		LDR 	67H,0 			//01E9 	0867
		BTSS 	STATUS,2 		//01EA 	1D03
		DECR 	67H,1 			//01EB 	0DE7
		ORG		01ECH

		//;1.C: 382: PRESSED &= ~0x10;
		BCR 	75H,4 			//01EC 	1275

		//;1.C: 383: PA7 = 1;
		BSR 	5H,7 			//01ED 	1B85

		//;1.C: 384: }
		//;1.C: 385: if((PRESSED&0x20) == 0x20){
		BTSS 	75H,5 			//01EE 	1EF5
		LJUMP 	202H 			//01EF 	3A02

		//;1.C: 386: CH2_remotekey[CH2_remotekey_Latest] = CH2_remotekey[CH2_remotekey_num-1];
		BCR 	STATUS,5 		//01F0 	1283
		LDR 	68H,0 			//01F1 	0868
		LCALL 	240H 			//01F2 	3240
		ADDWI 	39H 			//01F3 	2739
		ORG		01F4H
		LCALL 	224H 			//01F4 	3224
		LDR 	34H,0 			//01F5 	0834
		LCALL 	250H 			//01F6 	3250
		ADDWI 	3DH 			//01F7 	273D
		LCALL 	233H 			//01F8 	3233

		//;1.C: 387: CH2_remotekey[CH2_remotekey_num-1] = 0xFFFFFFFF;
		LDR 	68H,0 			//01F9 	0868
		LCALL 	240H 			//01FA 	3240
		ADDWI 	39H 			//01FB 	2739
		ORG		01FCH
		LCALL 	246H 			//01FC 	3246

		//;1.C: 388: if(CH2_remotekey_num>0) CH2_remotekey_num--;
		LDR 	68H,0 			//01FD 	0868
		BTSS 	STATUS,2 		//01FE 	1D03
		DECR 	68H,1 			//01FF 	0DE8

		//;1.C: 389: PRESSED &= ~0x20;
		BCR 	75H,5 			//0200 	12F5

		//;1.C: 390: PA6 = 1;
		BSR 	5H,6 			//0201 	1B05

		//;1.C: 391: }
		//;1.C: 392: if((PRESSED&0x40) == 0x40){
		BTSS 	75H,6 			//0202 	1F75
		LJUMP 	216H 			//0203 	3A16
		ORG		0204H

		//;1.C: 393: CH3_remotekey[CH3_remotekey_Latest] = CH3_remotekey[CH3_remotekey_num-1];
		BCR 	STATUS,5 		//0204 	1283
		LDR 	69H,0 			//0205 	0869
		LCALL 	240H 			//0206 	3240
		ADDWI 	49H 			//0207 	2749
		LCALL 	224H 			//0208 	3224
		LDR 	35H,0 			//0209 	0835
		LCALL 	250H 			//020A 	3250
		ADDWI 	4DH 			//020B 	274D
		ORG		020CH
		LCALL 	233H 			//020C 	3233

		//;1.C: 394: CH3_remotekey[CH3_remotekey_num-1] = 0xFFFFFFFF;
		LDR 	69H,0 			//020D 	0869
		LCALL 	240H 			//020E 	3240
		ADDWI 	49H 			//020F 	2749
		LCALL 	246H 			//0210 	3246

		//;1.C: 395: if(CH3_remotekey_num>0) CH3_remotekey_num--;
		LDR 	69H,0 			//0211 	0869
		BTSS 	STATUS,2 		//0212 	1D03
		DECR 	69H,1 			//0213 	0DE9
		ORG		0214H

		//;1.C: 396: PRESSED &= ~0x40;
		BCR 	75H,6 			//0214 	1375

		//;1.C: 397: PA5 = 1;
		BSR 	5H,5 			//0215 	1A85

		//;1.C: 398: }
		//;1.C: 399: PC0 = 1;
		BCR 	STATUS,5 		//0216 	1283
		BSR 	7H,0 			//0217 	1807
		BCR 	STATUS,5 		//0218 	1283
		LDR 	66H,0 			//0219 	0866
		STR 	7FH 			//021A 	01FF
		LDR 	65H,0 			//021B 	0865
		ORG		021CH
		STR 	PCLATH 			//021C 	018A
		LDR 	64H,0 			//021D 	0864
		STR 	FSR 			//021E 	0184
		SWAPR 	63H,0 			//021F 	0763
		STR 	STATUS 			//0220 	0183
		SWAPR 	7EH,1 			//0221 	07FE
		SWAPR 	7EH,0 			//0222 	077E
		RETI		 			//0223 	0009
		ORG		0224H
		STR 	FSR 			//0224 	0184
		BCR 	STATUS,7 		//0225 	1383
		LDR 	INDF,0 			//0226 	0800
		STR 	5EH 			//0227 	01DE
		INCR	FSR,1 			//0228 	0984
		LDR 	INDF,0 			//0229 	0800
		STR 	5FH 			//022A 	01DF
		INCR	FSR,1 			//022B 	0984
		ORG		022CH
		LDR 	INDF,0 			//022C 	0800
		STR 	60H 			//022D 	01E0
		INCR	FSR,1 			//022E 	0984
		LDR 	INDF,0 			//022F 	0800
		STR 	61H 			//0230 	01E1
		BSR 	STATUS,5 		//0231 	1A83
		RET		 					//0232 	0004
		STR 	FSR 			//0233 	0184
		ORG		0234H
		LDR 	5EH,0 			//0234 	085E
		STR 	INDF 			//0235 	0180
		INCR	FSR,1 			//0236 	0984
		LDR 	5FH,0 			//0237 	085F
		STR 	INDF 			//0238 	0180
		INCR	FSR,1 			//0239 	0984
		LDR 	60H,0 			//023A 	0860
		STR 	INDF 			//023B 	0180
		ORG		023CH
		INCR	FSR,1 			//023C 	0984
		LDR 	61H,0 			//023D 	0861
		STR 	INDF 			//023E 	0180
		RET		 					//023F 	0004
		STR 	5DH 			//0240 	01DD
		BCR 	STATUS,0 		//0241 	1003
		RLR 	5DH,1 			//0242 	05DD
		BCR 	STATUS,0 		//0243 	1003
		ORG		0244H
		RLR 	5DH,0 			//0244 	055D
		RET		 					//0245 	0004
		STR 	FSR 			//0246 	0184
		LDWI 	FFH 			//0247 	2AFF
		STR 	INDF 			//0248 	0180
		INCR	FSR,1 			//0249 	0984
		STR 	INDF 			//024A 	0180
		INCR	FSR,1 			//024B 	0984
		ORG		024CH
		STR 	INDF 			//024C 	0180
		INCR	FSR,1 			//024D 	0984
		STR 	INDF 			//024E 	0180
		RET		 					//024F 	0004
		BCR 	STATUS,5 		//0250 	1283
		STR 	62H 			//0251 	01E2
		BCR 	STATUS,0 		//0252 	1003
		RLR 	62H,1 			//0253 	05E2
		ORG		0254H
		BCR 	STATUS,0 		//0254 	1003
		RLR 	62H,0 			//0255 	0562
		RET		 					//0256 	0004
		CLRR 	2AH 			//0257 	012A
		BSR 	STATUS,5 		//0258 	1A83
		CLRR 	24H 			//0259 	0124
		CLRR 	25H 			//025A 	0125
		CLRR 	26H 			//025B 	0126
		ORG		025CH
		CLRR 	27H 			//025C 	0127
		RET		 					//025D 	0004
		BSR 	STATUS,5 		//025E 	1A83
		RLR 	24H,1 			//025F 	05A4
		RLR 	25H,1 			//0260 	05A5
		RLR 	26H,1 			//0261 	05A6
		RLR 	27H,1 			//0262 	05A7
		RET		 					//0263 	0004
		ORG		0264H

		//;1.C: 675: if( ((PRESSED&0x10) == 0x10) ||
		//;1.C: 676: ((PRESSED&0x20) == 0x20) ||
		//;1.C: 677: ((PRESSED&0x40) == 0x40)
		//;1.C: 678: ){
		BTSS 	75H,4 			//0264 	1E75
		BTSC 	75H,5 			//0265 	16F5
		LJUMP 	3A3H 			//0266 	3BA3
		BTSC 	75H,6 			//0267 	1775
		LJUMP 	3A3H 			//0268 	3BA3
		LJUMP 	3AEH 			//0269 	3BAE

		//;1.C: 681: Match_remotekey = 0xFFFFFFFF;
		LDWI 	FFH 			//026A 	2AFF
		STR 	73H 			//026B 	01F3
		ORG		026CH
		STR 	72H 			//026C 	01F2
		STR 	71H 			//026D 	01F1
		STR 	70H 			//026E 	01F0

		//;1.C: 682: break;
		LJUMP 	3AEH 			//026F 	3BAE

		//;1.C: 683: case 1:
		//;1.C: 684: PC0 = 0;
		BCR 	7H,0 			//0270 	1007

		//;1.C: 685: if((PRESSED&0x10) == 0x10) PA7 = 0;
		BTSS 	75H,4 			//0271 	1E75
		LJUMP 	274H 			//0272 	3A74
		BCR 	5H,7 			//0273 	1385
		ORG		0274H

		//;1.C: 686: if((PRESSED&0x20) == 0x20) PA6 = 0;
		BTSS 	75H,5 			//0274 	1EF5
		LJUMP 	277H 			//0275 	3A77
		BCR 	5H,6 			//0276 	1305

		//;1.C: 687: if((PRESSED&0x40) == 0x40) PA5 = 0;
		BTSS 	75H,6 			//0277 	1F75
		LJUMP 	3AEH 			//0278 	3BAE
		BCR 	5H,5 			//0279 	1285
		LJUMP 	3AEH 			//027A 	3BAE

		//;1.C: 689: case 2:
		//;1.C: 690: PC0 = 1;
		BSR 	7H,0 			//027B 	1807
		ORG		027CH

		//;1.C: 691: if((PRESSED&0x10) == 0x10) PA7 = 1;
		BTSS 	75H,4 			//027C 	1E75
		LJUMP 	27FH 			//027D 	3A7F
		BSR 	5H,7 			//027E 	1B85

		//;1.C: 692: if((PRESSED&0x20) == 0x20) PA6 = 1;
		BTSS 	75H,5 			//027F 	1EF5
		LJUMP 	282H 			//0280 	3A82
		BSR 	5H,6 			//0281 	1B05

		//;1.C: 693: if((PRESSED&0x40) == 0x40) PA5 = 1;
		BTSS 	75H,6 			//0282 	1F75
		LJUMP 	3AEH 			//0283 	3BAE
		ORG		0284H
		BSR 	5H,5 			//0284 	1A85
		LJUMP 	3AEH 			//0285 	3BAE

		//;1.C: 695: case 3:
		LDWI 	3H 			//0286 	2A03

		//;1.C: 696: KEY_Match_counter = 1;
		CLRR 	25H 			//0287 	0125
		INCR	25H,1 			//0288 	09A5

		//;1.C: 697: if(remotekey_Receive_num >= 3){
		SUBWR 	2BH,0 			//0289 	0C2B
		BTSS 	STATUS,0 		//028A 	1C03
		LJUMP 	3AEH 			//028B 	3BAE
		ORG		028CH

		//;1.C: 698: if((PRESSED&0x10) == 0x10){
		BTSS 	75H,4 			//028C 	1E75
		LJUMP 	2E8H 			//028D 	3AE8

		//;1.C: 699: if( (Match_remotekey != CH1_remotekey[0]) &&
		//;1.C: 700: (Match_remotekey != CH1_remotekey[1]) &&
		//;1.C: 701: (Match_remotekey != CH1_remotekey[2]) &&
		//;1.C: 702: (Match_remotekey != CH1_remotekey[3])
		//;1.C: 703: ){
		LDR 	73H,0 			//028E 	0873
		XORWR 	30H,0 			//028F 	0430
		BTSS 	STATUS,2 		//0290 	1D03
		LJUMP 	29CH 			//0291 	3A9C
		LDR 	72H,0 			//0292 	0872
		XORWR 	2FH,0 			//0293 	042F
		ORG		0294H
		BTSS 	STATUS,2 		//0294 	1D03
		LJUMP 	29CH 			//0295 	3A9C
		LDR 	71H,0 			//0296 	0871
		XORWR 	2EH,0 			//0297 	042E
		BTSS 	STATUS,2 		//0298 	1D03
		LJUMP 	29CH 			//0299 	3A9C
		LDR 	70H,0 			//029A 	0870
		XORWR 	2DH,0 			//029B 	042D
		ORG		029CH
		BTSC 	STATUS,2 		//029C 	1503
		LJUMP 	2DDH 			//029D 	3ADD
		LDR 	73H,0 			//029E 	0873
		XORWR 	34H,0 			//029F 	0434
		BTSS 	STATUS,2 		//02A0 	1D03
		LJUMP 	2ACH 			//02A1 	3AAC
		LDR 	72H,0 			//02A2 	0872
		XORWR 	33H,0 			//02A3 	0433
		ORG		02A4H
		BTSS 	STATUS,2 		//02A4 	1D03
		LJUMP 	2ACH 			//02A5 	3AAC
		LDR 	71H,0 			//02A6 	0871
		XORWR 	32H,0 			//02A7 	0432
		BTSS 	STATUS,2 		//02A8 	1D03
		LJUMP 	2ACH 			//02A9 	3AAC
		LDR 	70H,0 			//02AA 	0870
		XORWR 	31H,0 			//02AB 	0431
		ORG		02ACH
		BTSC 	STATUS,2 		//02AC 	1503
		LJUMP 	2DDH 			//02AD 	3ADD
		LDR 	73H,0 			//02AE 	0873
		XORWR 	38H,0 			//02AF 	0438
		BTSS 	STATUS,2 		//02B0 	1D03
		LJUMP 	2BCH 			//02B1 	3ABC
		LDR 	72H,0 			//02B2 	0872
		XORWR 	37H,0 			//02B3 	0437
		ORG		02B4H
		BTSS 	STATUS,2 		//02B4 	1D03
		LJUMP 	2BCH 			//02B5 	3ABC
		LDR 	71H,0 			//02B6 	0871
		XORWR 	36H,0 			//02B7 	0436
		BTSS 	STATUS,2 		//02B8 	1D03
		LJUMP 	2BCH 			//02B9 	3ABC
		LDR 	70H,0 			//02BA 	0870
		XORWR 	35H,0 			//02BB 	0435
		ORG		02BCH
		BTSC 	STATUS,2 		//02BC 	1503
		LJUMP 	2DDH 			//02BD 	3ADD
		LDR 	73H,0 			//02BE 	0873
		XORWR 	3CH,0 			//02BF 	043C
		BTSS 	STATUS,2 		//02C0 	1D03
		LJUMP 	2CCH 			//02C1 	3ACC
		LDR 	72H,0 			//02C2 	0872
		XORWR 	3BH,0 			//02C3 	043B
		ORG		02C4H
		BTSS 	STATUS,2 		//02C4 	1D03
		LJUMP 	2CCH 			//02C5 	3ACC
		LDR 	71H,0 			//02C6 	0871
		XORWR 	3AH,0 			//02C7 	043A
		BTSS 	STATUS,2 		//02C8 	1D03
		LJUMP 	2CCH 			//02C9 	3ACC
		LDR 	70H,0 			//02CA 	0870
		XORWR 	39H,0 			//02CB 	0439
		ORG		02CCH
		BTSC 	STATUS,2 		//02CC 	1503
		LJUMP 	2DDH 			//02CD 	3ADD

		//;1.C: 704: if(CH1_remotekey_num < 4){
		LDWI 	4H 			//02CE 	2A04
		SUBWR 	67H,0 			//02CF 	0C67
		BTSC 	STATUS,0 		//02D0 	1403
		LJUMP 	2D8H 			//02D1 	3AD8

		//;1.C: 705: CH1_remotekey[CH1_remotekey_num] = Match_remotekey;
		LDR 	67H,0 			//02D2 	0867
		LCALL 	3E5H 			//02D3 	33E5
		ORG		02D4H
		ADDWI 	2DH 			//02D4 	272D
		LCALL 	3D7H 			//02D5 	33D7

		//;1.C: 706: CH1_remotekey_num++;
		INCR	67H,1 			//02D6 	09E7

		//;1.C: 707: }else{
		LJUMP 	2DDH 			//02D7 	3ADD

		//;1.C: 708: CH1_remotekey[CH1_remotekey_Latest] = Match_remotekey;
		BSR 	STATUS,5 		//02D8 	1A83
		LDR 	33H,0 			//02D9 	0833
		LCALL 	3E5H 			//02DA 	33E5
		ADDWI 	2DH 			//02DB 	272D
		ORG		02DCH
		LCALL 	3D7H 			//02DC 	33D7

		//;1.C: 709: }
		//;1.C: 710: }
		//;1.C: 711: if(CH1_remotekey_num > 4) CH1_remotekey_num = 4;
		LDWI 	5H 			//02DD 	2A05
		BCR 	STATUS,5 		//02DE 	1283
		SUBWR 	67H,0 			//02DF 	0C67
		BTSS 	STATUS,0 		//02E0 	1C03
		LJUMP 	2E4H 			//02E1 	3AE4
		LDWI 	4H 			//02E2 	2A04
		STR 	67H 			//02E3 	01E7
		ORG		02E4H

		//;1.C: 712: PRESSED &= ~0x10;
		BCR 	75H,4 			//02E4 	1275

		//;1.C: 713: CH1_EEPROM_Write();
		LCALL 	5B7H 			//02E5 	35B7

		//;1.C: 714: PA7 = 1;
		BCR 	STATUS,5 		//02E6 	1283
		BSR 	5H,7 			//02E7 	1B85

		//;1.C: 715: }
		//;1.C: 716: if((PRESSED&0x20) == 0x20){
		BTSS 	75H,5 			//02E8 	1EF5
		LJUMP 	344H 			//02E9 	3B44

		//;1.C: 717: if( (Match_remotekey != CH2_remotekey[0]) &&
		//;1.C: 718: (Match_remotekey != CH2_remotekey[1]) &&
		//;1.C: 719: (Match_remotekey != CH2_remotekey[2]) &&
		//;1.C: 720: (Match_remotekey != CH2_remotekey[3])
		//;1.C: 721: ){
		LDR 	73H,0 			//02EA 	0873
		XORWR 	40H,0 			//02EB 	0440
		ORG		02ECH
		BTSS 	STATUS,2 		//02EC 	1D03
		LJUMP 	2F8H 			//02ED 	3AF8
		LDR 	72H,0 			//02EE 	0872
		XORWR 	3FH,0 			//02EF 	043F
		BTSS 	STATUS,2 		//02F0 	1D03
		LJUMP 	2F8H 			//02F1 	3AF8
		LDR 	71H,0 			//02F2 	0871
		XORWR 	3EH,0 			//02F3 	043E
		ORG		02F4H
		BTSS 	STATUS,2 		//02F4 	1D03
		LJUMP 	2F8H 			//02F5 	3AF8
		LDR 	70H,0 			//02F6 	0870
		XORWR 	3DH,0 			//02F7 	043D
		BTSC 	STATUS,2 		//02F8 	1503
		LJUMP 	339H 			//02F9 	3B39
		LDR 	73H,0 			//02FA 	0873
		XORWR 	44H,0 			//02FB 	0444
		ORG		02FCH
		BTSS 	STATUS,2 		//02FC 	1D03
		LJUMP 	308H 			//02FD 	3B08
		LDR 	72H,0 			//02FE 	0872
		XORWR 	43H,0 			//02FF 	0443
		BTSS 	STATUS,2 		//0300 	1D03
		LJUMP 	308H 			//0301 	3B08
		LDR 	71H,0 			//0302 	0871
		XORWR 	42H,0 			//0303 	0442
		ORG		0304H
		BTSS 	STATUS,2 		//0304 	1D03
		LJUMP 	308H 			//0305 	3B08
		LDR 	70H,0 			//0306 	0870
		XORWR 	41H,0 			//0307 	0441
		BTSC 	STATUS,2 		//0308 	1503
		LJUMP 	339H 			//0309 	3B39
		LDR 	73H,0 			//030A 	0873
		XORWR 	48H,0 			//030B 	0448
		ORG		030CH
		BTSS 	STATUS,2 		//030C 	1D03
		LJUMP 	318H 			//030D 	3B18
		LDR 	72H,0 			//030E 	0872
		XORWR 	47H,0 			//030F 	0447
		BTSS 	STATUS,2 		//0310 	1D03
		LJUMP 	318H 			//0311 	3B18
		LDR 	71H,0 			//0312 	0871
		XORWR 	46H,0 			//0313 	0446
		ORG		0314H
		BTSS 	STATUS,2 		//0314 	1D03
		LJUMP 	318H 			//0315 	3B18
		LDR 	70H,0 			//0316 	0870
		XORWR 	45H,0 			//0317 	0445
		BTSC 	STATUS,2 		//0318 	1503
		LJUMP 	339H 			//0319 	3B39
		LDR 	73H,0 			//031A 	0873
		XORWR 	4CH,0 			//031B 	044C
		ORG		031CH
		BTSS 	STATUS,2 		//031C 	1D03
		LJUMP 	328H 			//031D 	3B28
		LDR 	72H,0 			//031E 	0872
		XORWR 	4BH,0 			//031F 	044B
		BTSS 	STATUS,2 		//0320 	1D03
		LJUMP 	328H 			//0321 	3B28
		LDR 	71H,0 			//0322 	0871
		XORWR 	4AH,0 			//0323 	044A
		ORG		0324H
		BTSS 	STATUS,2 		//0324 	1D03
		LJUMP 	328H 			//0325 	3B28
		LDR 	70H,0 			//0326 	0870
		XORWR 	49H,0 			//0327 	0449
		BTSC 	STATUS,2 		//0328 	1503
		LJUMP 	339H 			//0329 	3B39

		//;1.C: 722: if(CH2_remotekey_num < 4){
		LDWI 	4H 			//032A 	2A04
		SUBWR 	68H,0 			//032B 	0C68
		ORG		032CH
		BTSC 	STATUS,0 		//032C 	1403
		LJUMP 	334H 			//032D 	3B34

		//;1.C: 723: CH2_remotekey[CH2_remotekey_num] = Match_remotekey;
		LDR 	68H,0 			//032E 	0868
		LCALL 	3E5H 			//032F 	33E5
		ADDWI 	3DH 			//0330 	273D
		LCALL 	3D7H 			//0331 	33D7

		//;1.C: 724: CH2_remotekey_num++;
		INCR	68H,1 			//0332 	09E8

		//;1.C: 725: }else{
		LJUMP 	339H 			//0333 	3B39
		ORG		0334H

		//;1.C: 726: CH2_remotekey[CH2_remotekey_Latest] = Match_remotekey;
		BSR 	STATUS,5 		//0334 	1A83
		LDR 	34H,0 			//0335 	0834
		LCALL 	3E5H 			//0336 	33E5
		ADDWI 	3DH 			//0337 	273D
		LCALL 	3D7H 			//0338 	33D7

		//;1.C: 727: }
		//;1.C: 728: }
		//;1.C: 729: if(CH2_remotekey_num > 4) CH2_remotekey_num = 4;
		LDWI 	5H 			//0339 	2A05
		BCR 	STATUS,5 		//033A 	1283
		SUBWR 	68H,0 			//033B 	0C68
		ORG		033CH
		BTSS 	STATUS,0 		//033C 	1C03
		LJUMP 	340H 			//033D 	3B40
		LDWI 	4H 			//033E 	2A04
		STR 	68H 			//033F 	01E8

		//;1.C: 730: PRESSED &= ~0x20;
		BCR 	75H,5 			//0340 	12F5

		//;1.C: 731: CH2_EEPROM_Write();
		LCALL 	577H 			//0341 	3577

		//;1.C: 732: PA6 = 1;
		BCR 	STATUS,5 		//0342 	1283
		BSR 	5H,6 			//0343 	1B05
		ORG		0344H

		//;1.C: 733: }
		//;1.C: 734: if((PRESSED&0x40) == 0x40){
		BTSS 	75H,6 			//0344 	1F75
		LJUMP 	3A0H 			//0345 	3BA0

		//;1.C: 735: if( (Match_remotekey != CH3_remotekey[0]) &&
		//;1.C: 736: (Match_remotekey != CH3_remotekey[1]) &&
		//;1.C: 737: (Match_remotekey != CH3_remotekey[2]) &&
		//;1.C: 738: (Match_remotekey != CH3_remotekey[3])
		//;1.C: 739: ){
		LDR 	73H,0 			//0346 	0873
		XORWR 	50H,0 			//0347 	0450
		BTSS 	STATUS,2 		//0348 	1D03
		LJUMP 	354H 			//0349 	3B54
		LDR 	72H,0 			//034A 	0872
		XORWR 	4FH,0 			//034B 	044F
		ORG		034CH
		BTSS 	STATUS,2 		//034C 	1D03
		LJUMP 	354H 			//034D 	3B54
		LDR 	71H,0 			//034E 	0871
		XORWR 	4EH,0 			//034F 	044E
		BTSS 	STATUS,2 		//0350 	1D03
		LJUMP 	354H 			//0351 	3B54
		LDR 	70H,0 			//0352 	0870
		XORWR 	4DH,0 			//0353 	044D
		ORG		0354H
		BTSC 	STATUS,2 		//0354 	1503
		LJUMP 	395H 			//0355 	3B95
		LDR 	73H,0 			//0356 	0873
		XORWR 	54H,0 			//0357 	0454
		BTSS 	STATUS,2 		//0358 	1D03
		LJUMP 	364H 			//0359 	3B64
		LDR 	72H,0 			//035A 	0872
		XORWR 	53H,0 			//035B 	0453
		ORG		035CH
		BTSS 	STATUS,2 		//035C 	1D03
		LJUMP 	364H 			//035D 	3B64
		LDR 	71H,0 			//035E 	0871
		XORWR 	52H,0 			//035F 	0452
		BTSS 	STATUS,2 		//0360 	1D03
		LJUMP 	364H 			//0361 	3B64
		LDR 	70H,0 			//0362 	0870
		XORWR 	51H,0 			//0363 	0451
		ORG		0364H
		BTSC 	STATUS,2 		//0364 	1503
		LJUMP 	395H 			//0365 	3B95
		LDR 	73H,0 			//0366 	0873
		XORWR 	58H,0 			//0367 	0458
		BTSS 	STATUS,2 		//0368 	1D03
		LJUMP 	374H 			//0369 	3B74
		LDR 	72H,0 			//036A 	0872
		XORWR 	57H,0 			//036B 	0457
		ORG		036CH
		BTSS 	STATUS,2 		//036C 	1D03
		LJUMP 	374H 			//036D 	3B74
		LDR 	71H,0 			//036E 	0871
		XORWR 	56H,0 			//036F 	0456
		BTSS 	STATUS,2 		//0370 	1D03
		LJUMP 	374H 			//0371 	3B74
		LDR 	70H,0 			//0372 	0870
		XORWR 	55H,0 			//0373 	0455
		ORG		0374H
		BTSC 	STATUS,2 		//0374 	1503
		LJUMP 	395H 			//0375 	3B95
		LDR 	73H,0 			//0376 	0873
		XORWR 	5CH,0 			//0377 	045C
		BTSS 	STATUS,2 		//0378 	1D03
		LJUMP 	384H 			//0379 	3B84
		LDR 	72H,0 			//037A 	0872
		XORWR 	5BH,0 			//037B 	045B
		ORG		037CH
		BTSS 	STATUS,2 		//037C 	1D03
		LJUMP 	384H 			//037D 	3B84
		LDR 	71H,0 			//037E 	0871
		XORWR 	5AH,0 			//037F 	045A
		BTSS 	STATUS,2 		//0380 	1D03
		LJUMP 	384H 			//0381 	3B84
		LDR 	70H,0 			//0382 	0870
		XORWR 	59H,0 			//0383 	0459
		ORG		0384H
		BTSC 	STATUS,2 		//0384 	1503
		LJUMP 	395H 			//0385 	3B95

		//;1.C: 740: if(CH3_remotekey_num < 4){
		LDWI 	4H 			//0386 	2A04
		SUBWR 	69H,0 			//0387 	0C69
		BTSC 	STATUS,0 		//0388 	1403
		LJUMP 	390H 			//0389 	3B90

		//;1.C: 741: CH3_remotekey[CH3_remotekey_num] = Match_remotekey;
		LDR 	69H,0 			//038A 	0869
		LCALL 	3E5H 			//038B 	33E5
		ORG		038CH
		ADDWI 	4DH 			//038C 	274D
		LCALL 	3D7H 			//038D 	33D7

		//;1.C: 742: CH3_remotekey_num++;
		INCR	69H,1 			//038E 	09E9

		//;1.C: 743: }else{
		LJUMP 	395H 			//038F 	3B95

		//;1.C: 744: CH3_remotekey[CH3_remotekey_Latest] = Match_remotekey;
		BSR 	STATUS,5 		//0390 	1A83
		LDR 	35H,0 			//0391 	0835
		LCALL 	3E5H 			//0392 	33E5
		ADDWI 	4DH 			//0393 	274D
		ORG		0394H
		LCALL 	3D7H 			//0394 	33D7

		//;1.C: 745: }
		//;1.C: 746: }
		//;1.C: 747: if(CH3_remotekey_num > 4) CH3_remotekey_num = 4;
		LDWI 	5H 			//0395 	2A05
		BCR 	STATUS,5 		//0396 	1283
		SUBWR 	69H,0 			//0397 	0C69
		BTSS 	STATUS,0 		//0398 	1C03
		LJUMP 	39CH 			//0399 	3B9C
		LDWI 	4H 			//039A 	2A04
		STR 	69H 			//039B 	01E9
		ORG		039CH

		//;1.C: 748: PRESSED &= ~0x40;
		BCR 	75H,6 			//039C 	1375

		//;1.C: 749: CH3_EEPROM_Write();
		LCALL 	537H 			//039D 	3537

		//;1.C: 750: PA5 = 1;
		BCR 	STATUS,5 		//039E 	1283
		BSR 	5H,5 			//039F 	1A85

		//;1.C: 751: }
		//;1.C: 752: KEY_Match_counter = 0;
		CLRR 	25H 			//03A0 	0125

		//;1.C: 753: PC0 = 1;
		BSR 	7H,0 			//03A1 	1807
		LJUMP 	3AEH 			//03A2 	3BAE
		LDR 	25H,0 			//03A3 	0825
		ORG		03A4H
		STR 	FSR 			//03A4 	0184
		LDWI 	4H 			//03A5 	2A04
		SUBWR 	FSR,0 			//03A6 	0C04
		BTSC 	STATUS,0 		//03A7 	1403
		LJUMP 	3AEH 			//03A8 	3BAE
		LDWI 	6H 			//03A9 	2A06
		STR 	PCLATH 			//03AA 	018A
		LDWI 	B7H 			//03AB 	2AB7
		ORG		03ACH
		ADDWR 	FSR,0 			//03AC 	0B04
		STR 	PCL 			//03AD 	0182

		//;1.C: 757: }
		//;1.C: 760: if( ((PRESSED&0x10) == 0) &&
		//;1.C: 761: ((PRESSED&0x20) == 0) &&
		//;1.C: 762: ((PRESSED&0x40) == 0)
		//;1.C: 763: ){
		BTSS 	75H,4 			//03AE 	1E75
		BTSC 	75H,5 			//03AF 	16F5
		RET		 					//03B0 	0004
		BTSC 	75H,6 			//03B1 	1775
		RET		 					//03B2 	0004

		//;1.C: 764: if((PRESSED&0x0F) > 0){
		LDR 	75H,0 			//03B3 	0875
		ORG		03B4H
		ANDWI 	FH 			//03B4 	240F
		BTSS 	STATUS,2 		//03B5 	1D03
		LJUMP 	3C0H 			//03B6 	3BC0
		LJUMP 	3D4H 			//03B7 	3BD4

		//;1.C: 767: PA7 = ~PA7;
		LDWI 	80H 			//03B8 	2A80
		XORWR 	5H,1 			//03B9 	0485

		//;1.C: 768: led1_debug();
		LCALL 	6C2H 			//03BA 	36C2

		//;1.C: 769: break;
		LJUMP 	3D4H 			//03BB 	3BD4
		ORG		03BCH

		//;1.C: 771: PA6 = ~PA6;
		LDWI 	40H 			//03BC 	2A40
		LJUMP 	3B9H 			//03BD 	3BB9

		//;1.C: 775: PA5 = ~PA5;
		LDWI 	20H 			//03BE 	2A20
		LJUMP 	3B9H 			//03BF 	3BB9
		LDR 	75H,0 			//03C0 	0875
		ANDWI 	FH 			//03C1 	240F
		STR 	78H 			//03C2 	01F8
		CLRR 	79H 			//03C3 	0179
		ORG		03C4H
		LDR 	79H,0 			//03C4 	0879
		XORWI 	0H 			//03C5 	2600
		BTSC 	STATUS,2 		//03C6 	1503
		LJUMP 	3C9H 			//03C7 	3BC9
		LJUMP 	3D4H 			//03C8 	3BD4
		LDR 	78H,0 			//03C9 	0878
		XORWI 	1H 			//03CA 	2601
		BTSC 	STATUS,2 		//03CB 	1503
		ORG		03CCH
		LJUMP 	3B8H 			//03CC 	3BB8
		XORWI 	3H 			//03CD 	2603
		BTSC 	STATUS,2 		//03CE 	1503
		LJUMP 	3BCH 			//03CF 	3BBC
		XORWI 	6H 			//03D0 	2606
		BTSC 	STATUS,2 		//03D1 	1503
		LJUMP 	3BEH 			//03D2 	3BBE
		LJUMP 	3D4H 			//03D3 	3BD4
		ORG		03D4H

		//;1.C: 779: }
		//;1.C: 780: PRESSED &= 0xF0;
		LDWI 	F0H 			//03D4 	2AF0
		ANDWR 	75H,1 			//03D5 	02F5
		RET		 					//03D6 	0004
		STR 	FSR 			//03D7 	0184
		LDR 	70H,0 			//03D8 	0870
		BCR 	STATUS,7 		//03D9 	1383
		STR 	INDF 			//03DA 	0180
		INCR	FSR,1 			//03DB 	0984
		ORG		03DCH
		LDR 	71H,0 			//03DC 	0871
		STR 	INDF 			//03DD 	0180
		INCR	FSR,1 			//03DE 	0984
		LDR 	72H,0 			//03DF 	0872
		STR 	INDF 			//03E0 	0180
		INCR	FSR,1 			//03E1 	0984
		LDR 	73H,0 			//03E2 	0873
		STR 	INDF 			//03E3 	0180
		ORG		03E4H
		RET		 					//03E4 	0004
		STR 	78H 			//03E5 	01F8
		BCR 	STATUS,0 		//03E6 	1003
		RLR 	78H,1 			//03E7 	05F8
		BCR 	STATUS,0 		//03E8 	1003
		RLR 	78H,0 			//03E9 	0578
		RET		 					//03EA 	0004

		//;1.C: 592: if(PRESSED == 0){
		LDR 	75H,1 			//03EB 	08F5
		ORG		03ECH
		BTSS 	STATUS,2 		//03EC 	1D03
		RET		 					//03ED 	0004

		//;1.C: 593: if(PC5 == 0){
		BTSC 	7H,5 			//03EE 	1687
		LJUMP 	427H 			//03EF 	3C27

		//;1.C: 594: if(KEY1_LongPress < 125) PRESS_FLAG |= 0x01;
		LDWI 	7DH 			//03F0 	2A7D
		SUBWR 	22H,0 			//03F1 	0C22
		BTSC 	STATUS,0 		//03F2 	1403
		LJUMP 	3F5H 			//03F3 	3BF5
		ORG		03F4H
		BSR 	27H,0 			//03F4 	1827

		//;1.C: 595: if(KEY1_LongPress < 254) KEY1_LongPress++;
		LDWI 	FEH 			//03F5 	2AFE
		SUBWR 	22H,0 			//03F6 	0C22
		BTSS 	STATUS,0 		//03F7 	1C03
		INCR	22H,1 			//03F8 	09A2

		//;1.C: 596: if((KEY1_LongPress > 125) && (KEY1_LongPress < 250)){
		LDWI 	7EH 			//03F9 	2A7E
		SUBWR 	22H,0 			//03FA 	0C22
		BTSS 	STATUS,0 		//03FB 	1C03
		ORG		03FCH
		LJUMP 	407H 			//03FC 	3C07
		LDWI 	FAH 			//03FD 	2AFA
		SUBWR 	22H,0 			//03FE 	0C22
		BTSC 	STATUS,0 		//03FF 	1403
		LJUMP 	407H 			//0400 	3C07

		//;1.C: 597: PRESS_FLAG |= 0x10;
		BSR 	27H,4 			//0401 	1A27

		//;1.C: 598: match_slice = 0;
		CLRR 	28H 			//0402 	0128

		//;1.C: 599: PC0 = 0;
		BCR 	7H,0 			//0403 	1007
		ORG		0404H

		//;1.C: 600: PA7 = 0;
		BCR 	5H,7 			//0404 	1385

		//;1.C: 601: LONGPRESS_OverTime_Counter = 0;
		BSR 	STATUS,5 		//0405 	1A83
		CLRR 	2AH 			//0406 	012A

		//;1.C: 602: }
		//;1.C: 603: if(KEY1_LongPress > 250){
		LDWI 	FBH 			//0407 	2AFB
		BCR 	STATUS,5 		//0408 	1283
		SUBWR 	22H,0 			//0409 	0C22
		BTSS 	STATUS,0 		//040A 	1C03
		LJUMP 	428H 			//040B 	3C28
		ORG		040CH

		//;1.C: 604: CH1_remotekey[0] = 0xFFFFFFFF;
		LDWI 	FFH 			//040C 	2AFF
		STR 	30H 			//040D 	01B0
		STR 	2FH 			//040E 	01AF
		STR 	2EH 			//040F 	01AE
		STR 	2DH 			//0410 	01AD

		//;1.C: 605: CH1_remotekey[1] = 0xFFFFFFFF;
		STR 	34H 			//0411 	01B4
		STR 	33H 			//0412 	01B3
		STR 	32H 			//0413 	01B2
		ORG		0414H
		STR 	31H 			//0414 	01B1

		//;1.C: 606: CH1_remotekey[2] = 0xFFFFFFFF;
		STR 	38H 			//0415 	01B8
		STR 	37H 			//0416 	01B7
		STR 	36H 			//0417 	01B6
		STR 	35H 			//0418 	01B5

		//;1.C: 607: CH1_remotekey[3] = 0xFFFFFFFF;
		STR 	3CH 			//0419 	01BC
		STR 	3BH 			//041A 	01BB
		STR 	3AH 			//041B 	01BA
		ORG		041CH
		STR 	39H 			//041C 	01B9

		//;1.C: 608: CH1_remotekey_num = 0;
		CLRR 	67H 			//041D 	0167

		//;1.C: 609: CH1_remotekey_Latest = 0;
		BSR 	STATUS,5 		//041E 	1A83
		CLRR 	33H 			//041F 	0133

		//;1.C: 610: PRESS_FLAG &= ~0x10;
		BCR 	STATUS,5 		//0420 	1283
		BCR 	27H,4 			//0421 	1227

		//;1.C: 611: PRESS_FLAG &= ~0x01;
		BCR 	27H,0 			//0422 	1027

		//;1.C: 612: PC0 = 1;
		BSR 	7H,0 			//0423 	1807
		ORG		0424H

		//;1.C: 613: PA7 = 1;
		BSR 	5H,7 			//0424 	1B85

		//;1.C: 614: KEY_Match_counter = 0;
		CLRR 	25H 			//0425 	0125
		LJUMP 	428H 			//0426 	3C28
		CLRR 	22H 			//0427 	0122

		//;1.C: 618: if(PA4 == 0){
		BTSC 	5H,4 			//0428 	1605
		LJUMP 	461H 			//0429 	3C61

		//;1.C: 619: if(KEY2_LongPress < 125) PRESS_FLAG |= 0x02;
		LDWI 	7DH 			//042A 	2A7D
		SUBWR 	23H,0 			//042B 	0C23
		ORG		042CH
		BTSC 	STATUS,0 		//042C 	1403
		LJUMP 	42FH 			//042D 	3C2F
		BSR 	27H,1 			//042E 	18A7

		//;1.C: 620: if(KEY2_LongPress < 254) KEY2_LongPress++;
		LDWI 	FEH 			//042F 	2AFE
		SUBWR 	23H,0 			//0430 	0C23
		BTSS 	STATUS,0 		//0431 	1C03
		INCR	23H,1 			//0432 	09A3

		//;1.C: 621: if((KEY2_LongPress > 125) && (KEY2_LongPress < 250)){
		LDWI 	7EH 			//0433 	2A7E
		ORG		0434H
		SUBWR 	23H,0 			//0434 	0C23
		BTSS 	STATUS,0 		//0435 	1C03
		LJUMP 	441H 			//0436 	3C41
		LDWI 	FAH 			//0437 	2AFA
		SUBWR 	23H,0 			//0438 	0C23
		BTSC 	STATUS,0 		//0439 	1403
		LJUMP 	441H 			//043A 	3C41

		//;1.C: 622: PRESS_FLAG |= 0x20;
		BSR 	27H,5 			//043B 	1AA7
		ORG		043CH

		//;1.C: 623: match_slice = 0;
		CLRR 	28H 			//043C 	0128

		//;1.C: 624: PC0 = 0;
		BCR 	7H,0 			//043D 	1007

		//;1.C: 625: PA6 = 0;
		BCR 	5H,6 			//043E 	1305

		//;1.C: 626: LONGPRESS_OverTime_Counter = 0;
		BSR 	STATUS,5 		//043F 	1A83
		CLRR 	2AH 			//0440 	012A

		//;1.C: 627: }
		//;1.C: 628: if(KEY2_LongPress > 250){
		LDWI 	FBH 			//0441 	2AFB
		BCR 	STATUS,5 		//0442 	1283
		SUBWR 	23H,0 			//0443 	0C23
		ORG		0444H
		BTSS 	STATUS,0 		//0444 	1C03
		LJUMP 	462H 			//0445 	3C62

		//;1.C: 629: CH2_remotekey[0] = 0xFFFFFFFF;
		LDWI 	FFH 			//0446 	2AFF
		STR 	40H 			//0447 	01C0
		STR 	3FH 			//0448 	01BF
		STR 	3EH 			//0449 	01BE
		STR 	3DH 			//044A 	01BD

		//;1.C: 630: CH2_remotekey[1] = 0xFFFFFFFF;
		STR 	44H 			//044B 	01C4
		ORG		044CH
		STR 	43H 			//044C 	01C3
		STR 	42H 			//044D 	01C2
		STR 	41H 			//044E 	01C1

		//;1.C: 631: CH2_remotekey[2] = 0xFFFFFFFF;
		STR 	48H 			//044F 	01C8
		STR 	47H 			//0450 	01C7
		STR 	46H 			//0451 	01C6
		STR 	45H 			//0452 	01C5

		//;1.C: 632: CH2_remotekey[3] = 0xFFFFFFFF;
		STR 	4CH 			//0453 	01CC
		ORG		0454H
		STR 	4BH 			//0454 	01CB
		STR 	4AH 			//0455 	01CA
		STR 	49H 			//0456 	01C9

		//;1.C: 633: CH2_remotekey_num = 0;
		CLRR 	68H 			//0457 	0168

		//;1.C: 634: CH2_remotekey_Latest = 0;
		BSR 	STATUS,5 		//0458 	1A83
		CLRR 	34H 			//0459 	0134

		//;1.C: 635: PRESS_FLAG &= ~0x20;
		BCR 	STATUS,5 		//045A 	1283
		BCR 	27H,5 			//045B 	12A7
		ORG		045CH

		//;1.C: 636: PRESS_FLAG &= ~0x02;
		BCR 	27H,1 			//045C 	10A7

		//;1.C: 637: PC0 = 1;
		BSR 	7H,0 			//045D 	1807

		//;1.C: 638: PA6 = 1;
		BSR 	5H,6 			//045E 	1B05

		//;1.C: 639: KEY_Match_counter = 0;
		CLRR 	25H 			//045F 	0125
		LJUMP 	462H 			//0460 	3C62
		CLRR 	23H 			//0461 	0123

		//;1.C: 643: if(PC4 == 0){
		BTSC 	7H,4 			//0462 	1607
		LJUMP 	49BH 			//0463 	3C9B
		ORG		0464H

		//;1.C: 644: if(KEY3_LongPress < 125) PRESS_FLAG |= 0x04;
		LDWI 	7DH 			//0464 	2A7D
		SUBWR 	24H,0 			//0465 	0C24
		BTSC 	STATUS,0 		//0466 	1403
		LJUMP 	469H 			//0467 	3C69
		BSR 	27H,2 			//0468 	1927

		//;1.C: 645: if(KEY3_LongPress < 254) KEY3_LongPress++;
		LDWI 	FEH 			//0469 	2AFE
		SUBWR 	24H,0 			//046A 	0C24
		BTSS 	STATUS,0 		//046B 	1C03
		ORG		046CH
		INCR	24H,1 			//046C 	09A4

		//;1.C: 646: if((KEY3_LongPress > 125) && (KEY3_LongPress < 250)){
		LDWI 	7EH 			//046D 	2A7E
		SUBWR 	24H,0 			//046E 	0C24
		BTSS 	STATUS,0 		//046F 	1C03
		LJUMP 	47BH 			//0470 	3C7B
		LDWI 	FAH 			//0471 	2AFA
		SUBWR 	24H,0 			//0472 	0C24
		BTSC 	STATUS,0 		//0473 	1403
		ORG		0474H
		LJUMP 	47BH 			//0474 	3C7B

		//;1.C: 647: PRESS_FLAG |= 0x40;
		BSR 	27H,6 			//0475 	1B27

		//;1.C: 648: match_slice = 0;
		CLRR 	28H 			//0476 	0128

		//;1.C: 649: PC0 = 0;
		BCR 	7H,0 			//0477 	1007

		//;1.C: 650: PA5 = 0;
		BCR 	5H,5 			//0478 	1285

		//;1.C: 651: LONGPRESS_OverTime_Counter = 0;
		BSR 	STATUS,5 		//0479 	1A83
		CLRR 	2AH 			//047A 	012A

		//;1.C: 652: }
		//;1.C: 653: if(KEY3_LongPress > 250){
		LDWI 	FBH 			//047B 	2AFB
		ORG		047CH
		BCR 	STATUS,5 		//047C 	1283
		SUBWR 	24H,0 			//047D 	0C24
		BTSS 	STATUS,0 		//047E 	1C03
		LJUMP 	49CH 			//047F 	3C9C

		//;1.C: 654: CH3_remotekey[0] = 0xFFFFFFFF;
		LDWI 	FFH 			//0480 	2AFF
		STR 	50H 			//0481 	01D0
		STR 	4FH 			//0482 	01CF
		STR 	4EH 			//0483 	01CE
		ORG		0484H
		STR 	4DH 			//0484 	01CD

		//;1.C: 655: CH3_remotekey[1] = 0xFFFFFFFF;
		STR 	54H 			//0485 	01D4
		STR 	53H 			//0486 	01D3
		STR 	52H 			//0487 	01D2
		STR 	51H 			//0488 	01D1

		//;1.C: 656: CH3_remotekey[2] = 0xFFFFFFFF;
		STR 	58H 			//0489 	01D8
		STR 	57H 			//048A 	01D7
		STR 	56H 			//048B 	01D6
		ORG		048CH
		STR 	55H 			//048C 	01D5

		//;1.C: 657: CH3_remotekey[3] = 0xFFFFFFFF;
		STR 	5CH 			//048D 	01DC
		STR 	5BH 			//048E 	01DB
		STR 	5AH 			//048F 	01DA
		STR 	59H 			//0490 	01D9

		//;1.C: 658: CH3_remotekey_num = 0;
		CLRR 	69H 			//0491 	0169

		//;1.C: 659: CH3_remotekey_Latest = 0;
		BSR 	STATUS,5 		//0492 	1A83
		CLRR 	35H 			//0493 	0135
		ORG		0494H

		//;1.C: 660: PRESS_FLAG &= ~0x40;
		BCR 	STATUS,5 		//0494 	1283
		BCR 	27H,6 			//0495 	1327

		//;1.C: 661: PRESS_FLAG &= ~0x04;
		BCR 	27H,2 			//0496 	1127

		//;1.C: 662: PC0 = 1;
		BSR 	7H,0 			//0497 	1807

		//;1.C: 663: PA5 = 1;
		BSR 	5H,5 			//0498 	1A85

		//;1.C: 664: KEY_Match_counter = 0;
		CLRR 	25H 			//0499 	0125
		LJUMP 	49CH 			//049A 	3C9C
		CLRR 	24H 			//049B 	0124
		ORG		049CH

		//;1.C: 668: if((PRESS_FLAG>0)&&(PC5==1)&&(PA4==1)&&(PC4==1)){
		LDR 	27H,0 			//049C 	0827
		BTSS 	STATUS,2 		//049D 	1D03
		BTSS 	7H,5 			//049E 	1E87
		RET		 					//049F 	0004
		BTSC 	5H,4 			//04A0 	1605
		BTSS 	7H,4 			//04A1 	1E07
		RET		 					//04A2 	0004

		//;1.C: 669: PRESSED = PRESS_FLAG;
		STR 	75H 			//04A3 	01F5
		ORG		04A4H

		//;1.C: 670: PRESS_FLAG = 0;
		CLRR 	27H 			//04A4 	0127
		RET		 					//04A5 	0004
		STR 	32H 			//04A6 	01B2

		//;1.C: 564: *buff = 0;
		STR 	FSR 			//04A7 	0184
		CLRR 	INDF 			//04A8 	0100
		INCR	FSR,1 			//04A9 	0984
		CLRR 	INDF 			//04AA 	0100
		INCR	FSR,1 			//04AB 	0984
		ORG		04ACH
		CLRR 	INDF 			//04AC 	0100
		INCR	FSR,1 			//04AD 	0984
		CLRR 	INDF 			//04AE 	0100

		//;1.C: 565: EE_Buff = IAPRead(data+2);
		LDR 	2DH,0 			//04AF 	082D
		ADDWI 	2H 			//04B0 	2702
		LCALL 	6A8H 			//04B1 	36A8

		//;1.C: 566: *buff |= EE_Buff;
		LCALL 	4E6H 			//04B2 	34E6

		//;1.C: 567: *buff = *buff<<8;
		LCALL 	4C0H 			//04B3 	34C0
		ORG		04B4H

		//;1.C: 568: EE_Buff = IAPRead(data+1);
		INCR	2DH,0 			//04B4 	092D
		LCALL 	6A8H 			//04B5 	36A8

		//;1.C: 569: *buff |= EE_Buff;
		LCALL 	4E6H 			//04B6 	34E6

		//;1.C: 570: *buff = *buff<<8;
		LCALL 	4C0H 			//04B7 	34C0

		//;1.C: 571: EE_Buff = IAPRead(data);
		LDR 	2DH,0 			//04B8 	082D
		LCALL 	6A8H 			//04B9 	36A8

		//;1.C: 572: *buff |= EE_Buff;
		LCALL 	4E6H 			//04BA 	34E6
		IORWR 	INDF,1 		//04BB 	0380
		ORG		04BCH
		INCR	FSR,1 			//04BC 	0984
		LDR 	31H,0 			//04BD 	0831
		IORWR 	INDF,1 		//04BE 	0380
		RET		 					//04BF 	0004
		IORWR 	INDF,1 		//04C0 	0380
		INCR	FSR,1 			//04C1 	0984
		LDR 	31H,0 			//04C2 	0831
		IORWR 	INDF,1 		//04C3 	0380
		ORG		04C4H
		LDR 	32H,0 			//04C4 	0832
		STR 	FSR 			//04C5 	0184
		LDR 	INDF,0 			//04C6 	0800
		STR 	2EH 			//04C7 	01AE
		INCR	FSR,1 			//04C8 	0984
		LDR 	INDF,0 			//04C9 	0800
		STR 	2FH 			//04CA 	01AF
		INCR	FSR,1 			//04CB 	0984
		ORG		04CCH
		LDR 	INDF,0 			//04CC 	0800
		STR 	30H 			//04CD 	01B0
		INCR	FSR,1 			//04CE 	0984
		LDR 	INDF,0 			//04CF 	0800
		STR 	31H 			//04D0 	01B1
		LDR 	30H,0 			//04D1 	0830
		STR 	31H 			//04D2 	01B1
		LDR 	2FH,0 			//04D3 	082F
		ORG		04D4H
		STR 	30H 			//04D4 	01B0
		LDR 	2EH,0 			//04D5 	082E
		STR 	2FH 			//04D6 	01AF
		CLRR 	2EH 			//04D7 	012E
		LDR 	32H,0 			//04D8 	0832
		STR 	FSR 			//04D9 	0184
		LDR 	2EH,0 			//04DA 	082E
		STR 	INDF 			//04DB 	0180
		ORG		04DCH
		INCR	FSR,1 			//04DC 	0984
		LDR 	2FH,0 			//04DD 	082F
		STR 	INDF 			//04DE 	0180
		INCR	FSR,1 			//04DF 	0984
		LDR 	30H,0 			//04E0 	0830
		STR 	INDF 			//04E1 	0180
		INCR	FSR,1 			//04E2 	0984
		LDR 	31H,0 			//04E3 	0831
		ORG		04E4H
		STR 	INDF 			//04E4 	0180
		RET		 					//04E5 	0004
		STR 	36H 			//04E6 	01B6
		STR 	2EH 			//04E7 	01AE
		CLRR 	2FH 			//04E8 	012F
		CLRR 	30H 			//04E9 	0130
		CLRR 	31H 			//04EA 	0131
		LDR 	32H,0 			//04EB 	0832
		ORG		04ECH
		STR 	FSR 			//04EC 	0184
		LDR 	2EH,0 			//04ED 	082E
		IORWR 	INDF,1 		//04EE 	0380
		INCR	FSR,1 			//04EF 	0984
		LDR 	2FH,0 			//04F0 	082F
		IORWR 	INDF,1 		//04F1 	0380
		INCR	FSR,1 			//04F2 	0984
		LDR 	30H,0 			//04F3 	0830
		ORG		04F4H
		RET		 					//04F4 	0004
		LDWI 	2DH 			//04F5 	2A2D

		//;1.C: 575: EEPROM_ReadWord(&CH1_remotekey[0],0x00);
		CLRR 	2DH 			//04F6 	012D
		LCALL 	4A6H 			//04F7 	34A6

		//;1.C: 576: EEPROM_ReadWord(&CH2_remotekey[0],0x04);
		LDWI 	4H 			//04F8 	2A04
		STR 	2DH 			//04F9 	01AD
		LDWI 	3DH 			//04FA 	2A3D
		LCALL 	4A6H 			//04FB 	34A6
		ORG		04FCH

		//;1.C: 577: EEPROM_ReadWord(&CH3_remotekey[0],0x08);
		LDWI 	8H 			//04FC 	2A08
		STR 	2DH 			//04FD 	01AD
		LDWI 	4DH 			//04FE 	2A4D
		LCALL 	4A6H 			//04FF 	34A6

		//;1.C: 578: EEPROM_ReadWord(&CH1_remotekey[1],0x0C);
		LDWI 	CH 			//0500 	2A0C
		STR 	2DH 			//0501 	01AD
		LDWI 	31H 			//0502 	2A31
		LCALL 	4A6H 			//0503 	34A6
		ORG		0504H

		//;1.C: 579: EEPROM_ReadWord(&CH2_remotekey[1],0x10);
		LDWI 	10H 			//0504 	2A10
		STR 	2DH 			//0505 	01AD
		LDWI 	41H 			//0506 	2A41
		LCALL 	4A6H 			//0507 	34A6

		//;1.C: 580: EEPROM_ReadWord(&CH3_remotekey[1],0x14);
		LDWI 	14H 			//0508 	2A14
		STR 	2DH 			//0509 	01AD
		LDWI 	51H 			//050A 	2A51
		LCALL 	4A6H 			//050B 	34A6
		ORG		050CH

		//;1.C: 581: EEPROM_ReadWord(&CH1_remotekey[2],0x18);
		LDWI 	18H 			//050C 	2A18
		STR 	2DH 			//050D 	01AD
		LDWI 	35H 			//050E 	2A35
		LCALL 	4A6H 			//050F 	34A6

		//;1.C: 582: EEPROM_ReadWord(&CH2_remotekey[2],0x1C);
		LDWI 	1CH 			//0510 	2A1C
		STR 	2DH 			//0511 	01AD
		LDWI 	45H 			//0512 	2A45
		LCALL 	4A6H 			//0513 	34A6
		ORG		0514H

		//;1.C: 583: EEPROM_ReadWord(&CH3_remotekey[2],0x20);
		LDWI 	20H 			//0514 	2A20
		STR 	2DH 			//0515 	01AD
		LDWI 	55H 			//0516 	2A55
		LCALL 	4A6H 			//0517 	34A6

		//;1.C: 584: EEPROM_ReadWord(&CH1_remotekey[3],0x24);
		LDWI 	24H 			//0518 	2A24
		STR 	2DH 			//0519 	01AD
		LDWI 	39H 			//051A 	2A39
		LCALL 	4A6H 			//051B 	34A6
		ORG		051CH

		//;1.C: 585: EEPROM_ReadWord(&CH2_remotekey[3],0x28);
		LDWI 	28H 			//051C 	2A28
		STR 	2DH 			//051D 	01AD
		LDWI 	49H 			//051E 	2A49
		LCALL 	4A6H 			//051F 	34A6

		//;1.C: 586: EEPROM_ReadWord(&CH3_remotekey[3],0x2C);
		LDWI 	2CH 			//0520 	2A2C
		STR 	2DH 			//0521 	01AD
		LDWI 	59H 			//0522 	2A59
		LCALL 	4A6H 			//0523 	34A6
		ORG		0524H

		//;1.C: 587: CH1_remotekey_Latest = CH1_remotekey_num = IAPRead(0x30);
		LDWI 	30H 			//0524 	2A30
		LCALL 	6A8H 			//0525 	36A8
		BCR 	STATUS,5 		//0526 	1283
		STR 	67H 			//0527 	01E7
		BSR 	STATUS,5 		//0528 	1A83
		STR 	33H 			//0529 	01B3

		//;1.C: 588: CH2_remotekey_Latest = CH2_remotekey_num = IAPRead(0x31);
		LDWI 	31H 			//052A 	2A31
		LCALL 	6A8H 			//052B 	36A8
		ORG		052CH
		BCR 	STATUS,5 		//052C 	1283
		STR 	68H 			//052D 	01E8
		BSR 	STATUS,5 		//052E 	1A83
		STR 	34H 			//052F 	01B4

		//;1.C: 589: CH3_remotekey_Latest = CH3_remotekey_num = IAPRead(0x32);
		LDWI 	32H 			//0530 	2A32
		LCALL 	6A8H 			//0531 	36A8
		BCR 	STATUS,5 		//0532 	1283
		STR 	69H 			//0533 	01E9
		ORG		0534H
		BSR 	STATUS,5 		//0534 	1A83
		STR 	35H 			//0535 	01B5
		RET		 					//0536 	0004

		//;1.C: 545: IAPWrite(0x08,((CH3_remotekey[0]&0x000000FF)>>0));
		LDR 	4DH,0 			//0537 	084D
		STR 	76H 			//0538 	01F6
		LDWI 	8H 			//0539 	2A08
		LCALL 	659H 			//053A 	3659

		//;1.C: 546: IAPWrite(0x09,((CH3_remotekey[0]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//053B 	1283
		ORG		053CH
		LDR 	4EH,0 			//053C 	084E
		STR 	76H 			//053D 	01F6
		LDWI 	9H 			//053E 	2A09
		LCALL 	659H 			//053F 	3659

		//;1.C: 547: IAPWrite(0x0A,((CH3_remotekey[0]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//0540 	1283
		LDR 	4FH,0 			//0541 	084F
		STR 	76H 			//0542 	01F6
		LDWI 	AH 			//0543 	2A0A
		ORG		0544H
		LCALL 	659H 			//0544 	3659

		//;1.C: 549: IAPWrite(0x14,((CH3_remotekey[1]&0x000000FF)>>0));
		BCR 	STATUS,5 		//0545 	1283
		LDR 	51H,0 			//0546 	0851
		STR 	76H 			//0547 	01F6
		LDWI 	14H 			//0548 	2A14
		LCALL 	659H 			//0549 	3659

		//;1.C: 550: IAPWrite(0x15,((CH3_remotekey[1]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//054A 	1283
		LDR 	52H,0 			//054B 	0852
		ORG		054CH
		STR 	76H 			//054C 	01F6
		LDWI 	15H 			//054D 	2A15
		LCALL 	659H 			//054E 	3659

		//;1.C: 551: IAPWrite(0x16,((CH3_remotekey[1]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//054F 	1283
		LDR 	53H,0 			//0550 	0853
		STR 	76H 			//0551 	01F6
		LDWI 	16H 			//0552 	2A16
		LCALL 	659H 			//0553 	3659
		ORG		0554H

		//;1.C: 553: IAPWrite(0x20,((CH3_remotekey[2]&0x000000FF)>>0));
		BCR 	STATUS,5 		//0554 	1283
		LDR 	55H,0 			//0555 	0855
		STR 	76H 			//0556 	01F6
		LDWI 	20H 			//0557 	2A20
		LCALL 	659H 			//0558 	3659

		//;1.C: 554: IAPWrite(0x21,((CH3_remotekey[2]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//0559 	1283
		LDR 	56H,0 			//055A 	0856
		STR 	76H 			//055B 	01F6
		ORG		055CH
		LDWI 	21H 			//055C 	2A21
		LCALL 	659H 			//055D 	3659

		//;1.C: 555: IAPWrite(0x22,((CH3_remotekey[2]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//055E 	1283
		LDR 	57H,0 			//055F 	0857
		STR 	76H 			//0560 	01F6
		LDWI 	22H 			//0561 	2A22
		LCALL 	659H 			//0562 	3659

		//;1.C: 557: IAPWrite(0x2C,((CH3_remotekey[3]&0x000000FF)>>0));
		BCR 	STATUS,5 		//0563 	1283
		ORG		0564H
		LDR 	59H,0 			//0564 	0859
		STR 	76H 			//0565 	01F6
		LDWI 	2CH 			//0566 	2A2C
		LCALL 	659H 			//0567 	3659

		//;1.C: 558: IAPWrite(0x2D,((CH3_remotekey[3]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//0568 	1283
		LDR 	5AH,0 			//0569 	085A
		STR 	76H 			//056A 	01F6
		LDWI 	2DH 			//056B 	2A2D
		ORG		056CH
		LCALL 	659H 			//056C 	3659

		//;1.C: 559: IAPWrite(0x2E,((CH3_remotekey[3]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//056D 	1283
		LDR 	5BH,0 			//056E 	085B
		STR 	76H 			//056F 	01F6
		LDWI 	2EH 			//0570 	2A2E
		LCALL 	659H 			//0571 	3659

		//;1.C: 561: IAPWrite(0x32,CH3_remotekey_num);
		BCR 	STATUS,5 		//0572 	1283
		LDR 	69H,0 			//0573 	0869
		ORG		0574H
		STR 	76H 			//0574 	01F6
		LDWI 	32H 			//0575 	2A32
		LJUMP 	659H 			//0576 	3E59

		//;1.C: 526: IAPWrite(0x04,((CH2_remotekey[0]&0x000000FF)>>0));
		LDR 	3DH,0 			//0577 	083D
		STR 	76H 			//0578 	01F6
		LDWI 	4H 			//0579 	2A04
		LCALL 	659H 			//057A 	3659

		//;1.C: 527: IAPWrite(0x05,((CH2_remotekey[0]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//057B 	1283
		ORG		057CH
		LDR 	3EH,0 			//057C 	083E
		STR 	76H 			//057D 	01F6
		LDWI 	5H 			//057E 	2A05
		LCALL 	659H 			//057F 	3659

		//;1.C: 528: IAPWrite(0x06,((CH2_remotekey[0]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//0580 	1283
		LDR 	3FH,0 			//0581 	083F
		STR 	76H 			//0582 	01F6
		LDWI 	6H 			//0583 	2A06
		ORG		0584H
		LCALL 	659H 			//0584 	3659

		//;1.C: 530: IAPWrite(0x10,((CH2_remotekey[1]&0x000000FF)>>0));
		BCR 	STATUS,5 		//0585 	1283
		LDR 	41H,0 			//0586 	0841
		STR 	76H 			//0587 	01F6
		LDWI 	10H 			//0588 	2A10
		LCALL 	659H 			//0589 	3659

		//;1.C: 531: IAPWrite(0x11,((CH2_remotekey[1]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//058A 	1283
		LDR 	42H,0 			//058B 	0842
		ORG		058CH
		STR 	76H 			//058C 	01F6
		LDWI 	11H 			//058D 	2A11
		LCALL 	659H 			//058E 	3659

		//;1.C: 532: IAPWrite(0x12,((CH2_remotekey[1]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//058F 	1283
		LDR 	43H,0 			//0590 	0843
		STR 	76H 			//0591 	01F6
		LDWI 	12H 			//0592 	2A12
		LCALL 	659H 			//0593 	3659
		ORG		0594H

		//;1.C: 534: IAPWrite(0x1C,((CH2_remotekey[2]&0x000000FF)>>0));
		BCR 	STATUS,5 		//0594 	1283
		LDR 	45H,0 			//0595 	0845
		STR 	76H 			//0596 	01F6
		LDWI 	1CH 			//0597 	2A1C
		LCALL 	659H 			//0598 	3659

		//;1.C: 535: IAPWrite(0x1D,((CH2_remotekey[2]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//0599 	1283
		LDR 	46H,0 			//059A 	0846
		STR 	76H 			//059B 	01F6
		ORG		059CH
		LDWI 	1DH 			//059C 	2A1D
		LCALL 	659H 			//059D 	3659

		//;1.C: 536: IAPWrite(0x1E,((CH2_remotekey[2]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//059E 	1283
		LDR 	47H,0 			//059F 	0847
		STR 	76H 			//05A0 	01F6
		LDWI 	1EH 			//05A1 	2A1E
		LCALL 	659H 			//05A2 	3659

		//;1.C: 538: IAPWrite(0x28,((CH2_remotekey[3]&0x000000FF)>>0));
		BCR 	STATUS,5 		//05A3 	1283
		ORG		05A4H
		LDR 	49H,0 			//05A4 	0849
		STR 	76H 			//05A5 	01F6
		LDWI 	28H 			//05A6 	2A28
		LCALL 	659H 			//05A7 	3659

		//;1.C: 539: IAPWrite(0x29,((CH2_remotekey[3]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//05A8 	1283
		LDR 	4AH,0 			//05A9 	084A
		STR 	76H 			//05AA 	01F6
		LDWI 	29H 			//05AB 	2A29
		ORG		05ACH
		LCALL 	659H 			//05AC 	3659

		//;1.C: 540: IAPWrite(0x2A,((CH2_remotekey[3]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//05AD 	1283
		LDR 	4BH,0 			//05AE 	084B
		STR 	76H 			//05AF 	01F6
		LDWI 	2AH 			//05B0 	2A2A
		LCALL 	659H 			//05B1 	3659

		//;1.C: 542: IAPWrite(0x31,CH2_remotekey_num);
		BCR 	STATUS,5 		//05B2 	1283
		LDR 	68H,0 			//05B3 	0868
		ORG		05B4H
		STR 	76H 			//05B4 	01F6
		LDWI 	31H 			//05B5 	2A31
		LJUMP 	659H 			//05B6 	3E59

		//;1.C: 507: IAPWrite(0x00,((CH1_remotekey[0]&0x000000FF)>>0));
		LDR 	2DH,0 			//05B7 	082D
		STR 	76H 			//05B8 	01F6
		LDWI 	0H 			//05B9 	2A00
		LCALL 	659H 			//05BA 	3659

		//;1.C: 508: IAPWrite(0x01,((CH1_remotekey[0]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//05BB 	1283
		ORG		05BCH
		LDR 	2EH,0 			//05BC 	082E
		STR 	76H 			//05BD 	01F6
		LDWI 	1H 			//05BE 	2A01
		LCALL 	659H 			//05BF 	3659

		//;1.C: 509: IAPWrite(0x02,((CH1_remotekey[0]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//05C0 	1283
		LDR 	2FH,0 			//05C1 	082F
		STR 	76H 			//05C2 	01F6
		LDWI 	2H 			//05C3 	2A02
		ORG		05C4H
		LCALL 	659H 			//05C4 	3659

		//;1.C: 511: IAPWrite(0x0C,((CH1_remotekey[1]&0x000000FF)>>0));
		BCR 	STATUS,5 		//05C5 	1283
		LDR 	31H,0 			//05C6 	0831
		STR 	76H 			//05C7 	01F6
		LDWI 	CH 			//05C8 	2A0C
		LCALL 	659H 			//05C9 	3659

		//;1.C: 512: IAPWrite(0x0D,((CH1_remotekey[1]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//05CA 	1283
		LDR 	32H,0 			//05CB 	0832
		ORG		05CCH
		STR 	76H 			//05CC 	01F6
		LDWI 	DH 			//05CD 	2A0D
		LCALL 	659H 			//05CE 	3659

		//;1.C: 513: IAPWrite(0x0E,((CH1_remotekey[1]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//05CF 	1283
		LDR 	33H,0 			//05D0 	0833
		STR 	76H 			//05D1 	01F6
		LDWI 	EH 			//05D2 	2A0E
		LCALL 	659H 			//05D3 	3659
		ORG		05D4H

		//;1.C: 515: IAPWrite(0x18,((CH1_remotekey[2]&0x000000FF)>>0));
		BCR 	STATUS,5 		//05D4 	1283
		LDR 	35H,0 			//05D5 	0835
		STR 	76H 			//05D6 	01F6
		LDWI 	18H 			//05D7 	2A18
		LCALL 	659H 			//05D8 	3659

		//;1.C: 516: IAPWrite(0x19,((CH1_remotekey[2]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//05D9 	1283
		LDR 	36H,0 			//05DA 	0836
		STR 	76H 			//05DB 	01F6
		ORG		05DCH
		LDWI 	19H 			//05DC 	2A19
		LCALL 	659H 			//05DD 	3659

		//;1.C: 517: IAPWrite(0x1A,((CH1_remotekey[2]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//05DE 	1283
		LDR 	37H,0 			//05DF 	0837
		STR 	76H 			//05E0 	01F6
		LDWI 	1AH 			//05E1 	2A1A
		LCALL 	659H 			//05E2 	3659

		//;1.C: 519: IAPWrite(0x24,((CH1_remotekey[3]&0x000000FF)>>0));
		BCR 	STATUS,5 		//05E3 	1283
		ORG		05E4H
		LDR 	39H,0 			//05E4 	0839
		STR 	76H 			//05E5 	01F6
		LDWI 	24H 			//05E6 	2A24
		LCALL 	659H 			//05E7 	3659

		//;1.C: 520: IAPWrite(0x25,((CH1_remotekey[3]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//05E8 	1283
		LDR 	3AH,0 			//05E9 	083A
		STR 	76H 			//05EA 	01F6
		LDWI 	25H 			//05EB 	2A25
		ORG		05ECH
		LCALL 	659H 			//05EC 	3659

		//;1.C: 521: IAPWrite(0x26,((CH1_remotekey[3]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//05ED 	1283
		LDR 	3BH,0 			//05EE 	083B
		STR 	76H 			//05EF 	01F6
		LDWI 	26H 			//05F0 	2A26
		LCALL 	659H 			//05F1 	3659

		//;1.C: 523: IAPWrite(0x30,CH1_remotekey_num);
		BCR 	STATUS,5 		//05F2 	1283
		LDR 	67H,0 			//05F3 	0867
		ORG		05F4H
		STR 	76H 			//05F4 	01F6
		LDWI 	30H 			//05F5 	2A30
		LJUMP 	659H 			//05F6 	3E59
		STR 	78H 			//05F7 	01F8
		LDWI 	8H 			//05F8 	2A08
		STR 	79H 			//05F9 	01F9
		CLRR 	7AH 			//05FA 	017A
		LDR 	78H,0 			//05FB 	0878
		ORG		05FCH
		STR 	77H 			//05FC 	01F7
		LDWI 	7H 			//05FD 	2A07
		BCR 	STATUS,0 		//05FE 	1003
		RRR	77H,1 			//05FF 	06F7
		ADDWI 	FFH 			//0600 	27FF
		BCR 	STATUS,0 		//0601 	1003
		BTSS 	STATUS,2 		//0602 	1D03
		LJUMP 	5FFH 			//0603 	3DFF
		ORG		0604H
		RLR 	7AH,0 			//0604 	057A
		IORWR 	77H,0 			//0605 	0377
		STR 	7AH 			//0606 	01FA
		BCR 	STATUS,0 		//0607 	1003
		RLR 	78H,1 			//0608 	05F8
		LDR 	76H,0 			//0609 	0876
		SUBWR 	7AH,0 			//060A 	0C7A
		BTSS 	STATUS,0 		//060B 	1C03
		ORG		060CH
		LJUMP 	60FH 			//060C 	3E0F
		LDR 	76H,0 			//060D 	0876
		SUBWR 	7AH,1 			//060E 	0CFA
		DECRSZ 	79H,1 		//060F 	0EF9
		LJUMP 	5FBH 			//0610 	3DFB
		LDR 	7AH,0 			//0611 	087A
		RET		 					//0612 	0004

		//;1.C: 427: OSCCON = 0B01100001;
		LDWI 	61H 			//0613 	2A61
		ORG		0614H
		BSR 	STATUS,5 		//0614 	1A83
		STR 	FH 			//0615 	018F

		//;1.C: 432: INTCON = 0;
		CLRR 	INTCON 			//0616 	010B

		//;1.C: 434: PORTA = 0B00000000;
		BCR 	STATUS,5 		//0617 	1283
		CLRR 	5H 			//0618 	0105

		//;1.C: 435: TRISA = 0B00010111;
		LDWI 	17H 			//0619 	2A17
		BSR 	STATUS,5 		//061A 	1A83
		STR 	5H 			//061B 	0185
		ORG		061CH

		//;1.C: 436: WPUA = 0B00000000;
		CLRR 	15H 			//061C 	0115

		//;1.C: 437: PSRCA = 0B11111111;
		LDWI 	FFH 			//061D 	2AFF
		STR 	8H 			//061E 	0188

		//;1.C: 438: PSINKA = 0B11111111;
		STR 	17H 			//061F 	0197

		//;1.C: 440: PORTC = 0B00000000;
		BCR 	STATUS,5 		//0620 	1283
		CLRR 	7H 			//0621 	0107

		//;1.C: 441: TRISC = 0B11110000;
		LDWI 	F0H 			//0622 	2AF0
		BSR 	STATUS,5 		//0623 	1A83
		ORG		0624H
		STR 	7H 			//0624 	0187

		//;1.C: 442: WPUC = 0B00000000;
		CLRR 	13H 			//0625 	0113

		//;1.C: 443: PSRCC = 0B11111111;
		LDWI 	FFH 			//0626 	2AFF
		STR 	14H 			//0627 	0194

		//;1.C: 444: PSINKC = 0B11111111;
		STR 	1FH 			//0628 	019F

		//;1.C: 446: OPTION = 0B00001000;
		LDWI 	8H 			//0629 	2A08
		STR 	1H 			//062A 	0181
		RET		 					//062B 	0004
		ORG		062CH
		CLRR 	7AH 			//062C 	017A
		CLRR 	7BH 			//062D 	017B
		BTSS 	76H,0 			//062E 	1C76
		LJUMP 	636H 			//062F 	3E36
		LDR 	78H,0 			//0630 	0878
		ADDWR 	7AH,1 			//0631 	0BFA
		BTSC 	STATUS,0 		//0632 	1403
		INCR	7BH,1 			//0633 	09FB
		ORG		0634H
		LDR 	79H,0 			//0634 	0879
		ADDWR 	7BH,1 			//0635 	0BFB
		BCR 	STATUS,0 		//0636 	1003
		RLR 	78H,1 			//0637 	05F8
		RLR 	79H,1 			//0638 	05F9
		BCR 	STATUS,0 		//0639 	1003
		RRR	77H,1 			//063A 	06F7
		RRR	76H,1 			//063B 	06F6
		ORG		063CH
		LDR 	77H,0 			//063C 	0877
		IORWR 	76H,0 			//063D 	0376
		BTSS 	STATUS,2 		//063E 	1D03
		LJUMP 	62EH 			//063F 	3E2E
		LDR 	7BH,0 			//0640 	087B
		STR 	77H 			//0641 	01F7
		LDR 	7AH,0 			//0642 	087A
		STR 	76H 			//0643 	01F6
		ORG		0644H
		RET		 					//0644 	0004

		//;1.C: 790: OSC_INIT();
		LCALL 	613H 			//0645 	3613

		//;1.C: 791: TIMER0_INITIAL();
		LCALL 	68DH 			//0646 	368D

		//;1.C: 792: TIMER2_INITIAL();
		LCALL 	66CH 			//0647 	366C

		//;1.C: 793: INT_INITIAL();
		LCALL 	6A1H 			//0648 	36A1

		//;1.C: 794: EEPROM_Read();
		LCALL 	4F5H 			//0649 	34F5

		//;1.C: 795: WDT_INITIAL();
		LCALL 	6AEH 			//064A 	36AE

		//;1.C: 796: PC0 = 1;
		BSR 	7H,0 			//064B 	1807
		ORG		064CH

		//;1.C: 797: PA7 = 1;
		BSR 	5H,7 			//064C 	1B85

		//;1.C: 798: PA6 = 1;
		BSR 	5H,6 			//064D 	1B05

		//;1.C: 799: PA5 = 1;
		BSR 	5H,5 			//064E 	1A85

		//;1.C: 801: PA3 = 0;
		BCR 	5H,3 			//064F 	1185

		//;1.C: 802: FLAGs &= ~0x08;
		BCR 	74H,3 			//0650 	11F4

		//;1.C: 803: EX_INT_FallingEdge();
		LCALL 	6B3H 			//0651 	36B3

		//;1.C: 804: INTE =1;
		BSR 	INTCON,4 		//0652 	1A0B

		//;1.C: 806: TMR2ON =1;
		BCR 	STATUS,5 		//0653 	1283
		ORG		0654H
		BSR 	12H,2 			//0654 	1912

		//;1.C: 808: PEIE = 1;
		BSR 	INTCON,6 		//0655 	1B0B

		//;1.C: 809: GIE = 1;
		BSR 	INTCON,7 		//0656 	1B8B
		CLRWDT	 			//0657 	0001
		LJUMP 	657H 			//0658 	3E57
		STR 	77H 			//0659 	01F7

		//;1.C: 496: GIE = 0;
		BCR 	INTCON,7 		//065A 	138B

		//;1.C: 497: while(GIE);
		BTSC 	INTCON,7 		//065B 	178B
		ORG		065CH
		LJUMP 	65BH 			//065C 	3E5B

		//;1.C: 498: EEADR = EEAddr;
		LDR 	77H,0 			//065D 	0877
		BSR 	STATUS,5 		//065E 	1A83
		STR 	1BH 			//065F 	019B

		//;1.C: 499: EEDAT = Data;
		LDR 	76H,0 			//0660 	0876
		STR 	1AH 			//0661 	019A
		LDWI 	34H 			//0662 	2A34

		//;1.C: 500: EEIF = 0;
		BCR 	STATUS,5 		//0663 	1283
		ORG		0664H
		BCR 	CH,7 			//0664 	138C

		//;1.C: 501: EECON1 |= 0x34;
		BSR 	STATUS,5 		//0665 	1A83
		IORWR 	1CH,1 			//0666 	039C

		//;1.C: 502: WR = 1;
		BSR 	1DH,0 			//0667 	181D

		//;1.C: 503: while(WR);
		BTSC 	1DH,0 			//0668 	141D
		LJUMP 	668H 			//0669 	3E68

		//;1.C: 504: GIE = 1;
		BSR 	INTCON,7 		//066A 	1B8B
		RET		 					//066B 	0004
		ORG		066CH

		//;1.C: 465: T2CON0 = 0B00000001;
		LDWI 	1H 			//066C 	2A01
		STR 	12H 			//066D 	0192

		//;1.C: 471: T2CON1 = 0B00000000;
		BSR 	STATUS,5 		//066E 	1A83
		CLRR 	1EH 			//066F 	011E

		//;1.C: 476: TMR2H = (53)/256;
		BCR 	STATUS,5 		//0670 	1283
		CLRR 	13H 			//0671 	0113

		//;1.C: 477: TMR2L = (53)%256;
		LDWI 	35H 			//0672 	2A35
		STR 	11H 			//0673 	0191
		ORG		0674H

		//;1.C: 480: PR2H = (53)/256;
		BSR 	STATUS,5 		//0674 	1A83
		CLRR 	12H 			//0675 	0112

		//;1.C: 481: PR2L = (53)%256;
		STR 	11H 			//0676 	0191

		//;1.C: 483: TMR2IF = 0;
		BCR 	STATUS,5 		//0677 	1283
		BCR 	CH,1 			//0678 	108C

		//;1.C: 484: TMR2IE = 1;
		BSR 	STATUS,5 		//0679 	1A83
		BSR 	CH,1 			//067A 	188C

		//;1.C: 486: TMR2ON =0;
		BCR 	STATUS,5 		//067B 	1283
		ORG		067CH
		BCR 	12H,2 			//067C 	1112
		RET		 					//067D 	0004
		LDWI 	70H 			//067E 	2A70
		STR 	FSR 			//067F 	0184
		LDWI 	76H 			//0680 	2A76
		LCALL 	699H 			//0681 	3699
		LDWI 	20H 			//0682 	2A20
		BCR 	STATUS,7 		//0683 	1383
		ORG		0684H
		STR 	FSR 			//0684 	0184
		LDWI 	5DH 			//0685 	2A5D
		LCALL 	699H 			//0686 	3699
		LDWI 	A0H 			//0687 	2AA0
		STR 	FSR 			//0688 	0184
		LDWI 	ABH 			//0689 	2AAB
		LCALL 	699H 			//068A 	3699
		CLRR 	STATUS 			//068B 	0103
		ORG		068CH
		LJUMP 	645H 			//068C 	3E45
		LDWI 	F8H 			//068D 	2AF8

		//;1.C: 455: T0CS = 0;
		BCR 	1H,5 			//068E 	1281

		//;1.C: 456: PSA = 0;
		BCR 	1H,3 			//068F 	1181

		//;1.C: 457: OPTION &= 0xF8;
		ANDWR 	1H,1 			//0690 	0281

		//;1.C: 458: OPTION |= 0x06;
		LDWI 	6H 			//0691 	2A06
		IORWR 	1H,1 			//0692 	0381

		//;1.C: 460: TMR0 = 5;
		LDWI 	5H 			//0693 	2A05
		ORG		0694H
		BCR 	STATUS,5 		//0694 	1283
		STR 	1H 			//0695 	0181

		//;1.C: 461: T0IE = 1;
		BSR 	INTCON,5 		//0696 	1A8B

		//;1.C: 462: T0IF = 0;
		BCR 	INTCON,2 		//0697 	110B
		RET		 					//0698 	0004
		CLRWDT	 			//0699 	0001
		CLRR 	INDF 			//069A 	0100
		INCR	FSR,1 			//069B 	0984
		ORG		069CH
		XORWR 	FSR,0 			//069C 	0404
		BTSC 	STATUS,2 		//069D 	1503
		RETW 	0H 			//069E 	2100
		XORWR 	FSR,0 			//069F 	0404
		LJUMP 	69AH 			//06A0 	3E9A

		//;1.C: 411: TRISA2 =1;
		BSR 	STATUS,5 		//06A1 	1A83
		BSR 	5H,2 			//06A2 	1905

		//;1.C: 412: IOCA2 =0;
		BCR 	16H,2 			//06A3 	1116
		ORG		06A4H

		//;1.C: 413: EX_INT_FallingEdge();
		LCALL 	6B3H 			//06A4 	36B3

		//;1.C: 414: INTF =0;
		BCR 	INTCON,1 		//06A5 	108B

		//;1.C: 416: INTE =0;
		BCR 	INTCON,4 		//06A6 	120B
		RET		 					//06A7 	0004
		STR 	2BH 			//06A8 	01AB

		//;1.C: 489: unsigned char ReEEPROMread;
		//;1.C: 490: EEADR = EEAddr;
		STR 	1BH 			//06A9 	019B

		//;1.C: 491: RD = 1;
		BSR 	1CH,0 			//06AA 	181C

		//;1.C: 492: ReEEPROMread = EEDAT;
		LDR 	1AH,0 			//06AB 	081A
		ORG		06ACH
		STR 	2CH 			//06AC 	01AC

		//;1.C: 493: return ReEEPROMread;
		RET		 					//06AD 	0004
		CLRWDT	 			//06AE 	0001

		//;1.C: 451: WDTCON = 0B00010110;
		LDWI 	16H 			//06AF 	2A16
		BCR 	STATUS,5 		//06B0 	1283
		STR 	18H 			//06B1 	0198
		RET		 					//06B2 	0004

		//;1.C: 423: INTEDG =0;
		BSR 	STATUS,5 		//06B3 	1A83
		ORG		06B4H
		BCR 	1H,6 			//06B4 	1301

		//;1.C: 424: FLAGs &= ~0x01;
		BCR 	74H,0 			//06B5 	1074
		RET		 					//06B6 	0004
		LJUMP 	26AH 			//06B7 	3A6A
		LJUMP 	270H 			//06B8 	3A70
		LJUMP 	27BH 			//06B9 	3A7B
		LJUMP 	286H 			//06BA 	3A86

		//;1.C: 423: INTEDG =0;
		BSR 	STATUS,5 		//06BB 	1A83
		ORG		06BCH
		BCR 	1H,6 			//06BC 	1301

		//;1.C: 424: FLAGs &= ~0x01;
		BCR 	74H,0 			//06BD 	1074
		RET		 					//06BE 	0004

		//;1.C: 419: INTEDG =1;
		BSR 	1H,6 			//06BF 	1B01

		//;1.C: 420: FLAGs |= 0x01;
		BSR 	74H,0 			//06C0 	1874
		RET		 					//06C1 	0004
		RET		 					//06C2 	0004
			END
