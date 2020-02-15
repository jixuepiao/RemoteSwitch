//Deviec:FT60F12X
//-----------------------Variable---------------------------------
		_FLAGs		EQU		72H
		_PRESS_FLAG		EQU		27H
		_buff		EQU		70H
		_remotekey		EQU		A4H
		_Ctrl_remotekey		EQU		A0H
		_Match_remotekey		EQU		20H
		_remotekey_slice		EQU		2CH
		_match_slice		EQU		28H
		_remotekey_Receive_num		EQU		2BH
		_Indata		EQU		AAH
		_num		EQU		2AH
		_ms16_counter		EQU		29H
		_KEY_Match_counter		EQU		25H
		_PRESSED		EQU		75H
		_KEY1_LongPress		EQU		73H
		_KEY2_LongPress		EQU		74H
		_KEY3_LongPress		EQU		24H
		_LONGPRESS_OverTime_Counter		EQU		26H
		_EE_Buff		EQU		BAH
		_CH1_remotekey		EQU		2DH
		_CH2_remotekey		EQU		3DH
		_CH3_remotekey		EQU		4DH
		_CH1_remotekey_num		EQU		67H
		_CH2_remotekey_num		EQU		68H
		_CH3_remotekey_num		EQU		69H
		_CH1_remotekey_Latest		EQU		B7H
		_CH2_remotekey_Latest		EQU		B8H
		_CH3_remotekey_Latest		EQU		B9H
		_i		EQU		AEH
		_HIndata		EQU		A8H
		_LIndata		EQU		ACH
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
		LJUMP 	6B3H 			//000F 	3EB3

		//;1.C: 138: if(INTE && INTF){
		BTSC 	INTCON,4 		//0010 	160B
		BTSS 	INTCON,1 		//0011 	1C8B
		LJUMP 	15BH 			//0012 	395B

		//;1.C: 139: INTF = 0;
		BCR 	INTCON,1 		//0013 	108B
		ORG		0014H

		//;1.C: 140: INTE = 0;
		BCR 	INTCON,4 		//0014 	120B

		//;1.C: 141: TMR2ON =0;
		BCR 	12H,2 			//0015 	1112

		//;1.C: 142: if((FLAGs&0x01) == 0){
		BTSC 	72H,0 			//0016 	1472
		LJUMP 	1DH 			//0017 	381D

		//;1.C: 143: Indata = 0;
		BSR 	STATUS,5 		//0018 	1A83
		CLRR 	2AH 			//0019 	012A
		CLRR 	2BH 			//001A 	012B

		//;1.C: 144: EX_INT_RisingEdge();
		LCALL 	6F4H 			//001B 	36F4
		ORG		001CH

		//;1.C: 145: }else if((FLAGs&0x01) == 0x01){
		LJUMP 	158H 			//001C 	3958
		BTSS 	72H,0 			//001D 	1C72
		LJUMP 	158H 			//001E 	3958

		//;1.C: 146: EX_INT_FallingEdge();
		LCALL 	6F0H 			//001F 	36F0

		//;1.C: 147: buff = Indata*53;
		LDR 	2BH,0 			//0020 	082B
		STR 	77H 			//0021 	01F7
		LDR 	2AH,0 			//0022 	082A
		LCALL 	2B1H 			//0023 	32B1
		ORG		0024H
		LCALL 	661H 			//0024 	3661
		LDR 	77H,0 			//0025 	0877
		STR 	71H 			//0026 	01F1
		LDR 	76H,0 			//0027 	0876
		STR 	70H 			//0028 	01F0

		//;1.C: 148: Indata = 0;
		CLRR 	2AH 			//0029 	012A
		CLRR 	2BH 			//002A 	012B

		//;1.C: 150: if( ((FLAGs&0x10) == 0) &&
		//;1.C: 151: ((FLAGs&0x20) == 0) &&
		//;1.C: 152: ((FLAGs&0x40) == 0)
		//;1.C: 153: ){
		BTSS 	72H,4 			//002B 	1E72
		ORG		002CH
		BTSC 	72H,5 			//002C 	16F2
		LJUMP 	145H 			//002D 	3945
		BTSS 	72H,6 			//002E 	1F72

		//;1.C: 154: if((FLAGs&0x08) == 0x08){
		BTSS 	72H,3 			//002F 	1DF2
		LJUMP 	145H 			//0030 	3945

		//;1.C: 155: if(num < 24){
		LDWI 	18H 			//0031 	2A18
		BCR 	STATUS,5 		//0032 	1283
		SUBWR 	2AH,0 			//0033 	0C2A
		ORG		0034H
		BTSC 	STATUS,0 		//0034 	1403
		LJUMP 	55H 			//0035 	3855

		//;1.C: 156: if((buff>200)&&(buff<600)){
		LDWI 	0H 			//0036 	2A00
		LCALL 	2A1H 			//0037 	32A1
		BTSS 	STATUS,0 		//0038 	1C03
		LJUMP 	44H 			//0039 	3844
		SUBWR 	71H,0 			//003A 	0C71
		LDWI 	58H 			//003B 	2A58
		ORG		003CH
		BTSC 	STATUS,2 		//003C 	1503
		SUBWR 	70H,0 			//003D 	0C70
		BTSC 	STATUS,0 		//003E 	1403
		LJUMP 	43H 			//003F 	3843

		//;1.C: 157: remotekey = remotekey<<1;
		BCR 	STATUS,0 		//0040 	1003
		LCALL 	2ABH 			//0041 	32AB

		//;1.C: 158: remotekey |= 0x00000001;
		BSR 	24H,0 			//0042 	1824

		//;1.C: 159: }
		//;1.C: 160: if((buff>700)&&(buff<1800)){
		LDWI 	2H 			//0043 	2A02
		ORG		0044H
		SUBWR 	71H,0 			//0044 	0C71
		LDWI 	BDH 			//0045 	2ABD
		BTSC 	STATUS,2 		//0046 	1503
		SUBWR 	70H,0 			//0047 	0C70
		BTSS 	STATUS,0 		//0048 	1C03
		LJUMP 	53H 			//0049 	3853
		LDWI 	7H 			//004A 	2A07
		SUBWR 	71H,0 			//004B 	0C71
		ORG		004CH
		LDWI 	8H 			//004C 	2A08
		BTSC 	STATUS,2 		//004D 	1503
		SUBWR 	70H,0 			//004E 	0C70
		BTSC 	STATUS,0 		//004F 	1403
		LJUMP 	53H 			//0050 	3853

		//;1.C: 161: remotekey = remotekey<<1;
		BCR 	STATUS,0 		//0051 	1003
		LCALL 	2ABH 			//0052 	32AB

		//;1.C: 162: }
		//;1.C: 163: num++;
		BCR 	STATUS,5 		//0053 	1283
		ORG		0054H
		INCR	2AH,1 			//0054 	09AA

		//;1.C: 164: }
		//;1.C: 166: if(num >= 24){
		LDWI 	18H 			//0055 	2A18
		SUBWR 	2AH,0 			//0056 	0C2A
		BTSS 	STATUS,0 		//0057 	1C03
		LJUMP 	145H 			//0058 	3945

		//;1.C: 168: if(remotekey>0){
		BSR 	STATUS,5 		//0059 	1A83
		LDR 	27H,0 			//005A 	0827
		IORWR 	26H,0 			//005B 	0326
		ORG		005CH
		IORWR 	25H,0 			//005C 	0325
		IORWR 	24H,0 			//005D 	0324
		BTSC 	STATUS,2 		//005E 	1503
		LJUMP 	8CH 			//005F 	388C

		//;1.C: 169: if(Match_remotekey == remotekey){
		LDR 	27H,0 			//0060 	0827
		BCR 	STATUS,5 		//0061 	1283
		XORWR 	23H,0 			//0062 	0423
		BTSS 	STATUS,2 		//0063 	1D03
		ORG		0064H
		LJUMP 	75H 			//0064 	3875
		BSR 	STATUS,5 		//0065 	1A83
		LDR 	26H,0 			//0066 	0826
		BCR 	STATUS,5 		//0067 	1283
		XORWR 	22H,0 			//0068 	0422
		BTSS 	STATUS,2 		//0069 	1D03
		LJUMP 	75H 			//006A 	3875
		BSR 	STATUS,5 		//006B 	1A83
		ORG		006CH
		LDR 	25H,0 			//006C 	0825
		BCR 	STATUS,5 		//006D 	1283
		XORWR 	21H,0 			//006E 	0421
		BTSS 	STATUS,2 		//006F 	1D03
		LJUMP 	75H 			//0070 	3875
		BSR 	STATUS,5 		//0071 	1A83
		LDR 	24H,0 			//0072 	0824
		BCR 	STATUS,5 		//0073 	1283
		ORG		0074H
		XORWR 	20H,0 			//0074 	0420
		BTSS 	STATUS,2 		//0075 	1D03
		LJUMP 	79H 			//0076 	3879

		//;1.C: 170: remotekey_Receive_num++;
		INCR	2BH,1 			//0077 	09AB

		//;1.C: 171: match_slice = 0;
		CLRR 	28H 			//0078 	0128

		//;1.C: 172: }
		//;1.C: 173: if(remotekey_Receive_num == 0) Match_remotekey = remotekey;
		LDR 	2BH,1 			//0079 	08AB
		BSR 	STATUS,5 		//007A 	1A83
		BTSS 	STATUS,2 		//007B 	1D03
		ORG		007CH
		LJUMP 	8DH 			//007C 	388D
		LDR 	27H,0 			//007D 	0827
		BCR 	STATUS,5 		//007E 	1283
		STR 	23H 			//007F 	01A3
		BSR 	STATUS,5 		//0080 	1A83
		LDR 	26H,0 			//0081 	0826
		BCR 	STATUS,5 		//0082 	1283
		STR 	22H 			//0083 	01A2
		ORG		0084H
		BSR 	STATUS,5 		//0084 	1A83
		LDR 	25H,0 			//0085 	0825
		BCR 	STATUS,5 		//0086 	1283
		STR 	21H 			//0087 	01A1
		BSR 	STATUS,5 		//0088 	1A83
		LDR 	24H,0 			//0089 	0824
		BCR 	STATUS,5 		//008A 	1283
		STR 	20H 			//008B 	01A0
		ORG		008CH

		//;1.C: 174: }
		//;1.C: 176: Ctrl_remotekey = remotekey;
		BSR 	STATUS,5 		//008C 	1A83
		LDR 	27H,0 			//008D 	0827
		STR 	23H 			//008E 	01A3
		LDR 	26H,0 			//008F 	0826
		STR 	22H 			//0090 	01A2
		LDR 	25H,0 			//0091 	0825
		STR 	21H 			//0092 	01A1
		LDR 	24H,0 			//0093 	0824
		ORG		0094H
		STR 	20H 			//0094 	01A0

		//;1.C: 178: if( ((PRESSED&0x10) == 0) &&
		//;1.C: 179: ((PRESSED&0x20) == 0) &&
		//;1.C: 180: ((PRESSED&0x40) == 0)
		//;1.C: 181: ){
		BTSS 	75H,4 			//0095 	1E75
		BTSC 	75H,5 			//0096 	16F5
		LJUMP 	13CH 			//0097 	393C
		BTSC 	75H,6 			//0098 	1775
		LJUMP 	13CH 			//0099 	393C

		//;1.C: 182: if((FLAGs&0x10) == 0){
		BTSC 	72H,4 			//009A 	1672
		LJUMP 	D0H 			//009B 	38D0
		ORG		009CH

		//;1.C: 183: for(buff=0;buff<CH1_remotekey_num;buff++){
		CLRR 	70H 			//009C 	0170
		CLRR 	71H 			//009D 	0171
		BCR 	STATUS,5 		//009E 	1283
		LDR 	67H,0 			//009F 	0867
		STR 	5DH 			//00A0 	01DD
		CLRR 	5EH 			//00A1 	015E
		LDR 	5EH,0 			//00A2 	085E
		SUBWR 	71H,0 			//00A3 	0C71
		ORG		00A4H
		BTSS 	STATUS,2 		//00A4 	1D03
		LJUMP 	A8H 			//00A5 	38A8
		LDR 	5DH,0 			//00A6 	085D
		SUBWR 	70H,0 			//00A7 	0C70
		BTSC 	STATUS,0 		//00A8 	1403
		LJUMP 	D0H 			//00A9 	38D0

		//;1.C: 184: if(Ctrl_remotekey == CH1_remotekey[buff]){
		LDR 	70H,0 			//00AA 	0870
		LCALL 	282H 			//00AB 	3282
		ORG		00ACH
		ADDWI 	2DH 			//00AC 	272D
		LCALL 	266H 			//00AD 	3266
		LDR 	23H,0 			//00AE 	0823
		BCR 	STATUS,5 		//00AF 	1283
		XORWR 	61H,0 			//00B0 	0461
		BTSS 	STATUS,2 		//00B1 	1D03
		LJUMP 	C3H 			//00B2 	38C3
		BSR 	STATUS,5 		//00B3 	1A83
		ORG		00B4H
		LDR 	22H,0 			//00B4 	0822
		BCR 	STATUS,5 		//00B5 	1283
		XORWR 	60H,0 			//00B6 	0460
		BTSS 	STATUS,2 		//00B7 	1D03
		LJUMP 	C3H 			//00B8 	38C3
		BSR 	STATUS,5 		//00B9 	1A83
		LDR 	21H,0 			//00BA 	0821
		BCR 	STATUS,5 		//00BB 	1283
		ORG		00BCH
		XORWR 	5FH,0 			//00BC 	045F
		BTSS 	STATUS,2 		//00BD 	1D03
		LJUMP 	C3H 			//00BE 	38C3
		BSR 	STATUS,5 		//00BF 	1A83
		LDR 	20H,0 			//00C0 	0820
		BCR 	STATUS,5 		//00C1 	1283
		XORWR 	5EH,0 			//00C2 	045E
		BTSS 	STATUS,2 		//00C3 	1D03
		ORG		00C4H
		LJUMP 	CCH 			//00C4 	38CC

		//;1.C: 185: FLAGs |= 0x10;
		BSR 	72H,4 			//00C5 	1A72

		//;1.C: 186: led1_debug();
		LCALL 	6F7H 			//00C6 	36F7

		//;1.C: 187: PA7 = ~PA7;
		LDWI 	80H 			//00C7 	2A80
		XORWR 	5H,1 			//00C8 	0485

		//;1.C: 188: CH1_remotekey_Latest = buff;
		LDR 	70H,0 			//00C9 	0870
		BSR 	STATUS,5 		//00CA 	1A83
		STR 	37H 			//00CB 	01B7
		ORG		00CCH
		INCR	70H,1 			//00CC 	09F0
		BTSC 	STATUS,2 		//00CD 	1503
		INCR	71H,1 			//00CE 	09F1
		LJUMP 	9EH 			//00CF 	389E

		//;1.C: 189: }
		//;1.C: 190: }
		//;1.C: 191: }
		//;1.C: 192: if((FLAGs&0x20) == 0){
		BTSC 	72H,5 			//00D0 	16F2
		LJUMP 	106H 			//00D1 	3906

		//;1.C: 193: for(buff=0;buff<CH2_remotekey_num;buff++){
		CLRR 	70H 			//00D2 	0170
		CLRR 	71H 			//00D3 	0171
		ORG		00D4H
		BCR 	STATUS,5 		//00D4 	1283
		LDR 	68H,0 			//00D5 	0868
		STR 	5DH 			//00D6 	01DD
		CLRR 	5EH 			//00D7 	015E
		LDR 	5EH,0 			//00D8 	085E
		SUBWR 	71H,0 			//00D9 	0C71
		BTSS 	STATUS,2 		//00DA 	1D03
		LJUMP 	DEH 			//00DB 	38DE
		ORG		00DCH
		LDR 	5DH,0 			//00DC 	085D
		SUBWR 	70H,0 			//00DD 	0C70
		BTSC 	STATUS,0 		//00DE 	1403
		LJUMP 	106H 			//00DF 	3906

		//;1.C: 194: if(Ctrl_remotekey == CH2_remotekey[buff]){
		LDR 	70H,0 			//00E0 	0870
		LCALL 	282H 			//00E1 	3282
		ADDWI 	3DH 			//00E2 	273D
		LCALL 	266H 			//00E3 	3266
		ORG		00E4H
		LDR 	23H,0 			//00E4 	0823
		BCR 	STATUS,5 		//00E5 	1283
		XORWR 	61H,0 			//00E6 	0461
		BTSS 	STATUS,2 		//00E7 	1D03
		LJUMP 	F9H 			//00E8 	38F9
		BSR 	STATUS,5 		//00E9 	1A83
		LDR 	22H,0 			//00EA 	0822
		BCR 	STATUS,5 		//00EB 	1283
		ORG		00ECH
		XORWR 	60H,0 			//00EC 	0460
		BTSS 	STATUS,2 		//00ED 	1D03
		LJUMP 	F9H 			//00EE 	38F9
		BSR 	STATUS,5 		//00EF 	1A83
		LDR 	21H,0 			//00F0 	0821
		BCR 	STATUS,5 		//00F1 	1283
		XORWR 	5FH,0 			//00F2 	045F
		BTSS 	STATUS,2 		//00F3 	1D03
		ORG		00F4H
		LJUMP 	F9H 			//00F4 	38F9
		BSR 	STATUS,5 		//00F5 	1A83
		LDR 	20H,0 			//00F6 	0820
		BCR 	STATUS,5 		//00F7 	1283
		XORWR 	5EH,0 			//00F8 	045E
		BTSS 	STATUS,2 		//00F9 	1D03
		LJUMP 	102H 			//00FA 	3902

		//;1.C: 195: FLAGs |= 0x20;
		BSR 	72H,5 			//00FB 	1AF2
		ORG		00FCH

		//;1.C: 196: led1_debug();
		LCALL 	6F7H 			//00FC 	36F7

		//;1.C: 197: PA6 = ~PA6;
		LDWI 	40H 			//00FD 	2A40
		XORWR 	5H,1 			//00FE 	0485

		//;1.C: 198: CH2_remotekey_Latest = buff;
		LDR 	70H,0 			//00FF 	0870
		BSR 	STATUS,5 		//0100 	1A83
		STR 	38H 			//0101 	01B8
		INCR	70H,1 			//0102 	09F0
		BTSC 	STATUS,2 		//0103 	1503
		ORG		0104H
		INCR	71H,1 			//0104 	09F1
		LJUMP 	D4H 			//0105 	38D4

		//;1.C: 199: }
		//;1.C: 200: }
		//;1.C: 201: }
		//;1.C: 202: if((FLAGs&0x40) == 0){
		BTSC 	72H,6 			//0106 	1772
		LJUMP 	13CH 			//0107 	393C

		//;1.C: 203: for(buff=0;buff<CH3_remotekey_num;buff++){
		CLRR 	70H 			//0108 	0170
		CLRR 	71H 			//0109 	0171
		BCR 	STATUS,5 		//010A 	1283
		LDR 	69H,0 			//010B 	0869
		ORG		010CH
		STR 	5DH 			//010C 	01DD
		CLRR 	5EH 			//010D 	015E
		LDR 	5EH,0 			//010E 	085E
		SUBWR 	71H,0 			//010F 	0C71
		BTSS 	STATUS,2 		//0110 	1D03
		LJUMP 	114H 			//0111 	3914
		LDR 	5DH,0 			//0112 	085D
		SUBWR 	70H,0 			//0113 	0C70
		ORG		0114H
		BTSC 	STATUS,0 		//0114 	1403
		LJUMP 	13CH 			//0115 	393C

		//;1.C: 204: if(Ctrl_remotekey == CH3_remotekey[buff]){
		LDR 	70H,0 			//0116 	0870
		LCALL 	282H 			//0117 	3282
		ADDWI 	4DH 			//0118 	274D
		LCALL 	266H 			//0119 	3266
		LDR 	23H,0 			//011A 	0823
		BCR 	STATUS,5 		//011B 	1283
		ORG		011CH
		XORWR 	61H,0 			//011C 	0461
		BTSS 	STATUS,2 		//011D 	1D03
		LJUMP 	12FH 			//011E 	392F
		BSR 	STATUS,5 		//011F 	1A83
		LDR 	22H,0 			//0120 	0822
		BCR 	STATUS,5 		//0121 	1283
		XORWR 	60H,0 			//0122 	0460
		BTSS 	STATUS,2 		//0123 	1D03
		ORG		0124H
		LJUMP 	12FH 			//0124 	392F
		BSR 	STATUS,5 		//0125 	1A83
		LDR 	21H,0 			//0126 	0821
		BCR 	STATUS,5 		//0127 	1283
		XORWR 	5FH,0 			//0128 	045F
		BTSS 	STATUS,2 		//0129 	1D03
		LJUMP 	12FH 			//012A 	392F
		BSR 	STATUS,5 		//012B 	1A83
		ORG		012CH
		LDR 	20H,0 			//012C 	0820
		BCR 	STATUS,5 		//012D 	1283
		XORWR 	5EH,0 			//012E 	045E
		BTSS 	STATUS,2 		//012F 	1D03
		LJUMP 	138H 			//0130 	3938

		//;1.C: 205: FLAGs |= 0x40;
		BSR 	72H,6 			//0131 	1B72

		//;1.C: 206: led1_debug();
		LCALL 	6F7H 			//0132 	36F7

		//;1.C: 207: PA5 = ~PA5;
		LDWI 	20H 			//0133 	2A20
		ORG		0134H
		XORWR 	5H,1 			//0134 	0485

		//;1.C: 208: CH3_remotekey_Latest = buff;
		LDR 	70H,0 			//0135 	0870
		BSR 	STATUS,5 		//0136 	1A83
		STR 	39H 			//0137 	01B9
		INCR	70H,1 			//0138 	09F0
		BTSC 	STATUS,2 		//0139 	1503
		INCR	71H,1 			//013A 	09F1
		LJUMP 	10AH 			//013B 	390A
		ORG		013CH

		//;1.C: 209: }
		//;1.C: 210: }
		//;1.C: 211: }
		//;1.C: 212: }
		//;1.C: 213: FLAGs &= ~0x08;
		BCR 	72H,3 			//013C 	11F2

		//;1.C: 214: Indata = 0;
		BSR 	STATUS,5 		//013D 	1A83
		CLRR 	2AH 			//013E 	012A
		CLRR 	2BH 			//013F 	012B

		//;1.C: 215: num = 0;
		//;1.C: 216: remotekey = 0;
		LCALL 	299H 			//0140 	3299

		//;1.C: 217: Ctrl_remotekey = 0;
		CLRR 	20H 			//0141 	0120
		CLRR 	21H 			//0142 	0121
		CLRR 	22H 			//0143 	0122
		ORG		0144H
		CLRR 	23H 			//0144 	0123

		//;1.C: 218: }
		//;1.C: 219: }
		//;1.C: 220: }
		//;1.C: 221: if((FLAGs&0x08) == 0){
		BTSC 	72H,3 			//0145 	15F2
		LJUMP 	158H 			//0146 	3958

		//;1.C: 222: if(buff > 7000){
		LDWI 	1BH 			//0147 	2A1B
		SUBWR 	71H,0 			//0148 	0C71
		LDWI 	59H 			//0149 	2A59
		BTSC 	STATUS,2 		//014A 	1503
		SUBWR 	70H,0 			//014B 	0C70
		ORG		014CH
		BTSS 	STATUS,0 		//014C 	1C03
		LJUMP 	158H 			//014D 	3958

		//;1.C: 223: FLAGs |= 0x08;
		BSR 	72H,3 			//014E 	19F2

		//;1.C: 224: num = 0;
		//;1.C: 225: remotekey = 0;
		LCALL 	299H 			//014F 	3299

		//;1.C: 227: if( ((FLAGs&0x10) == 0x10) ||
		//;1.C: 228: ((FLAGs&0x20) == 0x20) ||
		//;1.C: 229: ((FLAGs&0x40) == 0x40)
		//;1.C: 230: ){
		BTSS 	72H,4 			//0150 	1E72
		BTSC 	72H,5 			//0151 	16F2
		LJUMP 	155H 			//0152 	3955
		BTSS 	72H,6 			//0153 	1F72
		ORG		0154H
		LJUMP 	158H 			//0154 	3958

		//;1.C: 231: remotekey_slice = 0;
		BCR 	STATUS,5 		//0155 	1283
		CLRR 	2CH 			//0156 	012C

		//;1.C: 232: FLAGs &= ~0x08;
		BCR 	72H,3 			//0157 	11F2

		//;1.C: 233: }
		//;1.C: 234: }
		//;1.C: 235: }
		//;1.C: 236: }
		//;1.C: 237: TMR2ON =1;
		BCR 	STATUS,5 		//0158 	1283
		BSR 	12H,2 			//0159 	1912

		//;1.C: 238: INTE = 1;
		BSR 	INTCON,4 		//015A 	1A0B

		//;1.C: 239: }
		//;1.C: 242: if(TMR2IE && TMR2IF){
		BSR 	STATUS,5 		//015B 	1A83
		ORG		015CH
		BTSS 	CH,1 			//015C 	1C8C
		LJUMP 	1CAH 			//015D 	39CA
		BCR 	STATUS,5 		//015E 	1283
		BTSS 	CH,1 			//015F 	1C8C
		LJUMP 	1CAH 			//0160 	39CA

		//;1.C: 243: TMR2IF = 0;
		BCR 	CH,1 			//0161 	108C

		//;1.C: 245: if((FLAGs&0x02) == 0x02){
		BTSS 	72H,1 			//0162 	1CF2
		LJUMP 	169H 			//0163 	3969
		ORG		0164H

		//;1.C: 246: Indata++;
		BSR 	STATUS,5 		//0164 	1A83
		INCR	2AH,1 			//0165 	09AA
		BTSC 	STATUS,2 		//0166 	1503
		INCR	2BH,1 			//0167 	09AB

		//;1.C: 247: }else{
		LJUMP 	1CAH 			//0168 	39CA

		//;1.C: 256: if((FLAGs&0x80) == 0){
		BTSC 	72H,7 			//0169 	17F2
		LJUMP 	195H 			//016A 	3995

		//;1.C: 257: if(PA2 == 1){
		BTSS 	5H,2 			//016B 	1D05
		ORG		016CH
		LJUMP 	172H 			//016C 	3972

		//;1.C: 258: HIndata++;
		BSR 	STATUS,5 		//016D 	1A83
		INCR	28H,1 			//016E 	09A8
		BTSC 	STATUS,2 		//016F 	1503
		INCR	29H,1 			//0170 	09A9

		//;1.C: 259: }else{
		LJUMP 	195H 			//0171 	3995

		//;1.C: 260: buff = HIndata*53;
		BSR 	STATUS,5 		//0172 	1A83
		LDR 	29H,0 			//0173 	0829
		ORG		0174H
		STR 	77H 			//0174 	01F7
		LDR 	28H,0 			//0175 	0828
		LCALL 	2B1H 			//0176 	32B1
		LCALL 	661H 			//0177 	3661
		LCALL 	2A6H 			//0178 	32A6

		//;1.C: 261: HIndata = 0;
		CLRR 	28H 			//0179 	0128
		CLRR 	29H 			//017A 	0129

		//;1.C: 262: if( ((buff>200)&&(buff<600)) ||
		//;1.C: 263: ((buff>700)&&(buff<1800))
		//;1.C: 264: ){
		LCALL 	2A1H 			//017B 	32A1
		ORG		017CH
		BTSS 	STATUS,0 		//017C 	1C03
		LJUMP 	185H 			//017D 	3985
		SUBWR 	71H,0 			//017E 	0C71
		LDWI 	58H 			//017F 	2A58
		BTSC 	STATUS,2 		//0180 	1503
		SUBWR 	70H,0 			//0181 	0C70
		BTSS 	STATUS,0 		//0182 	1C03
		LJUMP 	192H 			//0183 	3992
		ORG		0184H
		LDWI 	2H 			//0184 	2A02
		SUBWR 	71H,0 			//0185 	0C71
		LDWI 	BDH 			//0186 	2ABD
		BTSC 	STATUS,2 		//0187 	1503
		SUBWR 	70H,0 			//0188 	0C70
		BTSS 	STATUS,0 		//0189 	1C03
		LJUMP 	194H 			//018A 	3994
		LDWI 	7H 			//018B 	2A07
		ORG		018CH
		SUBWR 	71H,0 			//018C 	0C71
		LDWI 	8H 			//018D 	2A08
		BTSC 	STATUS,2 		//018E 	1503
		SUBWR 	70H,0 			//018F 	0C70
		BTSC 	STATUS,0 		//0190 	1403
		LJUMP 	194H 			//0191 	3994

		//;1.C: 265: FLAGs |= 0x80;
		BSR 	72H,7 			//0192 	1BF2

		//;1.C: 266: }else{
		LJUMP 	195H 			//0193 	3995
		ORG		0194H

		//;1.C: 267: i = 0;
		CLRR 	2EH 			//0194 	012E

		//;1.C: 268: }
		//;1.C: 269: }
		//;1.C: 270: }
		//;1.C: 271: if((FLAGs&0x80) == 0x80){
		BTSS 	72H,7 			//0195 	1FF2
		LJUMP 	1C3H 			//0196 	39C3

		//;1.C: 272: if(PA2 == 0){
		BCR 	STATUS,5 		//0197 	1283
		BTSC 	5H,2 			//0198 	1505
		LJUMP 	19FH 			//0199 	399F

		//;1.C: 273: LIndata++;
		BSR 	STATUS,5 		//019A 	1A83
		INCR	2CH,1 			//019B 	09AC
		ORG		019CH
		BTSC 	STATUS,2 		//019C 	1503
		INCR	2DH,1 			//019D 	09AD

		//;1.C: 274: }else{
		LJUMP 	1C3H 			//019E 	39C3

		//;1.C: 275: buff = LIndata*53;
		BSR 	STATUS,5 		//019F 	1A83
		LDR 	2DH,0 			//01A0 	082D
		STR 	77H 			//01A1 	01F7
		LDR 	2CH,0 			//01A2 	082C
		LCALL 	2B1H 			//01A3 	32B1
		ORG		01A4H
		LCALL 	661H 			//01A4 	3661
		LCALL 	2A6H 			//01A5 	32A6

		//;1.C: 276: LIndata = 0;
		CLRR 	2CH 			//01A6 	012C
		CLRR 	2DH 			//01A7 	012D

		//;1.C: 277: if( ((buff>200)&&(buff<600)) ||
		//;1.C: 278: ((buff>700)&&(buff<1800))
		//;1.C: 279: ){
		LCALL 	2A1H 			//01A8 	32A1
		BTSS 	STATUS,0 		//01A9 	1C03
		LJUMP 	1B2H 			//01AA 	39B2
		SUBWR 	71H,0 			//01AB 	0C71
		ORG		01ACH
		LDWI 	58H 			//01AC 	2A58
		BTSC 	STATUS,2 		//01AD 	1503
		SUBWR 	70H,0 			//01AE 	0C70
		BTSS 	STATUS,0 		//01AF 	1C03
		LJUMP 	1BFH 			//01B0 	39BF
		LDWI 	2H 			//01B1 	2A02
		SUBWR 	71H,0 			//01B2 	0C71
		LDWI 	BDH 			//01B3 	2ABD
		ORG		01B4H
		BTSC 	STATUS,2 		//01B4 	1503
		SUBWR 	70H,0 			//01B5 	0C70
		BTSS 	STATUS,0 		//01B6 	1C03
		LJUMP 	1C1H 			//01B7 	39C1
		LDWI 	7H 			//01B8 	2A07
		SUBWR 	71H,0 			//01B9 	0C71
		LDWI 	8H 			//01BA 	2A08
		BTSC 	STATUS,2 		//01BB 	1503
		ORG		01BCH
		SUBWR 	70H,0 			//01BC 	0C70
		BTSC 	STATUS,0 		//01BD 	1403
		LJUMP 	1C1H 			//01BE 	39C1

		//;1.C: 280: i++;
		INCR	2EH,1 			//01BF 	09AE

		//;1.C: 281: }else{
		LJUMP 	1C2H 			//01C0 	39C2

		//;1.C: 282: i = 0;
		CLRR 	2EH 			//01C1 	012E

		//;1.C: 283: }
		//;1.C: 284: FLAGs &= ~0x80;
		BCR 	72H,7 			//01C2 	13F2

		//;1.C: 285: }
		//;1.C: 286: }
		//;1.C: 287: if(i>3){
		LDWI 	4H 			//01C3 	2A04
		ORG		01C4H
		BSR 	STATUS,5 		//01C4 	1A83
		SUBWR 	2EH,0 			//01C5 	0C2E
		BTSS 	STATUS,0 		//01C6 	1C03
		LJUMP 	1CAH 			//01C7 	39CA

		//;1.C: 288: FLAGs |= 0x02;
		BSR 	72H,1 			//01C8 	18F2

		//;1.C: 289: i = 0;
		CLRR 	2EH 			//01C9 	012E

		//;1.C: 291: }
		//;1.C: 292: }
		//;1.C: 293: }
		//;1.C: 296: if(T0IE && T0IF){
		BTSC 	INTCON,5 		//01CA 	168B
		BTSS 	INTCON,2 		//01CB 	1D0B
		ORG		01CCH
		LJUMP 	25AH 			//01CC 	3A5A

		//;1.C: 297: T0IF = 0;
		BCR 	INTCON,2 		//01CD 	110B

		//;1.C: 298: ms16_counter ++;
		BCR 	STATUS,5 		//01CE 	1283
		INCR	29H,1 			//01CF 	09A9

		//;1.C: 301: if( ((FLAGs&0x10) == 0x10) ||
		//;1.C: 302: ((FLAGs&0x20) == 0x20) ||
		//;1.C: 303: ((FLAGs&0x40) == 0x40)
		//;1.C: 304: ){
		BTSS 	72H,4 			//01D0 	1E72
		BTSC 	72H,5 			//01D1 	16F2
		LJUMP 	1D5H 			//01D2 	39D5
		BTSS 	72H,6 			//01D3 	1F72
		ORG		01D4H
		LJUMP 	1DFH 			//01D4 	39DF
		LDWI 	EH 			//01D5 	2A0E

		//;1.C: 305: remotekey_slice++;
		INCR	2CH,1 			//01D6 	09AC

		//;1.C: 306: if( remotekey_slice>(110/8)){
		SUBWR 	2CH,0 			//01D7 	0C2C
		BTSS 	STATUS,0 		//01D8 	1C03
		LJUMP 	1DFH 			//01D9 	39DF

		//;1.C: 307: remotekey_slice = 0;
		CLRR 	2CH 			//01DA 	012C

		//;1.C: 309: FLAGs &= ~0x02;
		BCR 	72H,1 			//01DB 	10F2
		ORG		01DCH

		//;1.C: 310: FLAGs &= ~0x10;
		BCR 	72H,4 			//01DC 	1272

		//;1.C: 311: FLAGs &= ~0x20;
		BCR 	72H,5 			//01DD 	12F2

		//;1.C: 312: FLAGs &= ~0x40;
		BCR 	72H,6 			//01DE 	1372

		//;1.C: 313: }
		//;1.C: 314: }
		//;1.C: 316: if( ((PRESSED&0x10) == 0x10) ||
		//;1.C: 317: ((PRESSED&0x20) == 0x20) ||
		//;1.C: 318: ((PRESSED&0x40) == 0x40)
		//;1.C: 319: ){
		BTSS 	75H,4 			//01DF 	1E75
		BTSC 	75H,5 			//01E0 	16F5
		LJUMP 	1E4H 			//01E1 	39E4
		BTSS 	75H,6 			//01E2 	1F75
		LJUMP 	1EBH 			//01E3 	39EB
		ORG		01E4H
		LDWI 	EH 			//01E4 	2A0E

		//;1.C: 320: match_slice++;
		INCR	28H,1 			//01E5 	09A8

		//;1.C: 321: if(match_slice>(110/8)){
		SUBWR 	28H,0 			//01E6 	0C28
		BTSS 	STATUS,0 		//01E7 	1C03
		LJUMP 	1EBH 			//01E8 	39EB

		//;1.C: 322: match_slice = 0;
		CLRR 	28H 			//01E9 	0128

		//;1.C: 323: remotekey_Receive_num = 0;
		CLRR 	2BH 			//01EA 	012B

		//;1.C: 324: }
		//;1.C: 325: }
		//;1.C: 328: if((FLAGs&0x02) == 0){
		BTSC 	72H,1 			//01EB 	14F2
		ORG		01ECH
		LJUMP 	204H 			//01EC 	3A04

		//;1.C: 329: EE_Buff = ms16_counter%8;
		LDR 	29H,0 			//01ED 	0829
		BSR 	STATUS,5 		//01EE 	1A83
		STR 	3AH 			//01EF 	01BA
		LDWI 	7H 			//01F0 	2A07
		ANDWR 	3AH,1 			//01F1 	02BA

		//;1.C: 330: if(EE_Buff == 1){
		DECRSZ 	3AH,0 		//01F2 	0E3A
		LJUMP 	1FAH 			//01F3 	39FA
		ORG		01F4H

		//;1.C: 331: PA3 = 0;
		BCR 	STATUS,5 		//01F4 	1283
		BCR 	5H,3 			//01F5 	1185

		//;1.C: 333: EX_INT_FallingEdge();
		LCALL 	6F0H 			//01F6 	36F0

		//;1.C: 334: INTE =1;
		BSR 	INTCON,4 		//01F7 	1A0B

		//;1.C: 335: TMR2ON =1;
		BCR 	STATUS,5 		//01F8 	1283
		BSR 	12H,2 			//01F9 	1912

		//;1.C: 336: }
		//;1.C: 337: if(EE_Buff == 4){
		BSR 	STATUS,5 		//01FA 	1A83
		LDR 	3AH,0 			//01FB 	083A
		ORG		01FCH
		XORWI 	4H 			//01FC 	2604

		//;1.C: 338: PA3 = 1;
		BCR 	STATUS,5 		//01FD 	1283
		BTSS 	STATUS,2 		//01FE 	1D03
		LJUMP 	208H 			//01FF 	3A08
		BSR 	5H,3 			//0200 	1985

		//;1.C: 339: TMR2ON =0;
		BCR 	12H,2 			//0201 	1112

		//;1.C: 340: INTE =0;
		BCR 	INTCON,4 		//0202 	120B
		LJUMP 	207H 			//0203 	3A07
		ORG		0204H

		//;1.C: 343: PA3 = 0;
		BCR 	5H,3 			//0204 	1185

		//;1.C: 344: INTE =1;
		BSR 	INTCON,4 		//0205 	1A0B

		//;1.C: 345: TMR2ON =1;
		BSR 	12H,2 			//0206 	1912

		//;1.C: 346: }
		//;1.C: 349: if(ms16_counter%2 == 0){
		BCR 	STATUS,5 		//0207 	1283
		BTSC 	29H,0 			//0208 	1429
		LJUMP 	20CH 			//0209 	3A0C

		//;1.C: 350: KEYSCAN();
		LCALL 	442H 			//020A 	3442

		//;1.C: 351: KEY();
		LCALL 	2B6H 			//020B 	32B6
		ORG		020CH

		//;1.C: 352: }
		//;1.C: 356: if(ms16_counter >= 120){
		LDWI 	78H 			//020C 	2A78
		SUBWR 	29H,0 			//020D 	0C29
		BTSS 	STATUS,0 		//020E 	1C03
		LJUMP 	25AH 			//020F 	3A5A

		//;1.C: 357: ms16_counter = 0;
		CLRR 	29H 			//0210 	0129

		//;1.C: 360: if( ((PRESSED&0x10) == 0x10) ||
		//;1.C: 361: ((PRESSED&0x20) == 0x20) ||
		//;1.C: 362: ((PRESSED&0x40) == 0x40)
		//;1.C: 363: ){
		BTSS 	75H,4 			//0211 	1E75
		BTSC 	75H,5 			//0212 	16F5
		LJUMP 	216H 			//0213 	3A16
		ORG		0214H
		BTSS 	75H,6 			//0214 	1F75
		LJUMP 	25AH 			//0215 	3A5A

		//;1.C: 364: if(KEY_Match_counter<4){
		LDWI 	4H 			//0216 	2A04
		SUBWR 	25H,0 			//0217 	0C25
		BTSS 	STATUS,0 		//0218 	1C03

		//;1.C: 365: KEY_Match_counter++;
		INCR	25H,1 			//0219 	09A5
		LDWI 	10H 			//021A 	2A10

		//;1.C: 366: }
		//;1.C: 367: LONGPRESS_OverTime_Counter++;
		INCR	26H,1 			//021B 	09A6
		ORG		021CH

		//;1.C: 368: if(LONGPRESS_OverTime_Counter > 15){
		SUBWR 	26H,0 			//021C 	0C26
		BTSS 	STATUS,0 		//021D 	1C03
		LJUMP 	25AH 			//021E 	3A5A

		//;1.C: 369: LONGPRESS_OverTime_Counter = 0;
		CLRR 	26H 			//021F 	0126

		//;1.C: 370: if((PRESSED&0x10) == 0x10){
		BTSS 	75H,4 			//0220 	1E75
		LJUMP 	233H 			//0221 	3A33

		//;1.C: 371: CH1_remotekey[CH1_remotekey_Latest] = CH1_remotekey[CH1_remotekey_num-1];
		LDR 	67H,0 			//0222 	0867
		LCALL 	282H 			//0223 	3282
		ORG		0224H
		ADDWI 	29H 			//0224 	2729
		LCALL 	266H 			//0225 	3266
		LDR 	37H,0 			//0226 	0837
		LCALL 	292H 			//0227 	3292
		ADDWI 	2DH 			//0228 	272D
		LCALL 	275H 			//0229 	3275

		//;1.C: 372: CH1_remotekey[CH1_remotekey_num-1] = 0xFFFFFFFF;
		LDR 	67H,0 			//022A 	0867
		LCALL 	282H 			//022B 	3282
		ORG		022CH
		ADDWI 	29H 			//022C 	2729
		LCALL 	288H 			//022D 	3288

		//;1.C: 373: if(CH1_remotekey_num>0) CH1_remotekey_num--;
		LDR 	67H,0 			//022E 	0867
		BTSS 	STATUS,2 		//022F 	1D03
		DECR 	67H,1 			//0230 	0DE7

		//;1.C: 374: PRESSED &= ~0x10;
		BCR 	75H,4 			//0231 	1275

		//;1.C: 375: PA7 = 1;
		BSR 	5H,7 			//0232 	1B85

		//;1.C: 376: }
		//;1.C: 377: if((PRESSED&0x20) == 0x20){
		BTSS 	75H,5 			//0233 	1EF5
		ORG		0234H
		LJUMP 	246H 			//0234 	3A46

		//;1.C: 378: CH2_remotekey[CH2_remotekey_Latest] = CH2_remotekey[CH2_remotekey_num-1];
		LDR 	68H,0 			//0235 	0868
		LCALL 	282H 			//0236 	3282
		ADDWI 	39H 			//0237 	2739
		LCALL 	266H 			//0238 	3266
		LDR 	38H,0 			//0239 	0838
		LCALL 	292H 			//023A 	3292
		ADDWI 	3DH 			//023B 	273D
		ORG		023CH
		LCALL 	275H 			//023C 	3275

		//;1.C: 379: CH2_remotekey[CH2_remotekey_num-1] = 0xFFFFFFFF;
		LDR 	68H,0 			//023D 	0868
		LCALL 	282H 			//023E 	3282
		ADDWI 	39H 			//023F 	2739
		LCALL 	288H 			//0240 	3288

		//;1.C: 380: if(CH2_remotekey_num>0) CH2_remotekey_num--;
		LDR 	68H,0 			//0241 	0868
		BTSS 	STATUS,2 		//0242 	1D03
		DECR 	68H,1 			//0243 	0DE8
		ORG		0244H

		//;1.C: 381: PRESSED &= ~0x20;
		BCR 	75H,5 			//0244 	12F5

		//;1.C: 382: PA6 = 1;
		BSR 	5H,6 			//0245 	1B05

		//;1.C: 383: }
		//;1.C: 384: if((PRESSED&0x40) == 0x40){
		BTSS 	75H,6 			//0246 	1F75
		LJUMP 	259H 			//0247 	3A59

		//;1.C: 385: CH3_remotekey[CH3_remotekey_Latest] = CH3_remotekey[CH3_remotekey_num-1];
		LDR 	69H,0 			//0248 	0869
		LCALL 	282H 			//0249 	3282
		ADDWI 	49H 			//024A 	2749
		LCALL 	266H 			//024B 	3266
		ORG		024CH
		LDR 	39H,0 			//024C 	0839
		LCALL 	292H 			//024D 	3292
		ADDWI 	4DH 			//024E 	274D
		LCALL 	275H 			//024F 	3275

		//;1.C: 386: CH3_remotekey[CH3_remotekey_num-1] = 0xFFFFFFFF;
		LDR 	69H,0 			//0250 	0869
		LCALL 	282H 			//0251 	3282
		ADDWI 	49H 			//0252 	2749
		LCALL 	288H 			//0253 	3288
		ORG		0254H

		//;1.C: 387: if(CH3_remotekey_num>0) CH3_remotekey_num--;
		LDR 	69H,0 			//0254 	0869
		BTSS 	STATUS,2 		//0255 	1D03
		DECR 	69H,1 			//0256 	0DE9

		//;1.C: 388: PRESSED &= ~0x40;
		BCR 	75H,6 			//0257 	1375

		//;1.C: 389: PA5 = 1;
		BSR 	5H,5 			//0258 	1A85

		//;1.C: 390: }
		//;1.C: 391: PC0 = 1;
		BSR 	7H,0 			//0259 	1807
		BCR 	STATUS,5 		//025A 	1283
		LDR 	66H,0 			//025B 	0866
		ORG		025CH
		STR 	7FH 			//025C 	01FF
		LDR 	65H,0 			//025D 	0865
		STR 	PCLATH 			//025E 	018A
		LDR 	64H,0 			//025F 	0864
		STR 	FSR 			//0260 	0184
		SWAPR 	63H,0 			//0261 	0763
		STR 	STATUS 			//0262 	0183
		SWAPR 	7EH,1 			//0263 	07FE
		ORG		0264H
		SWAPR 	7EH,0 			//0264 	077E
		RETI		 			//0265 	0009
		STR 	FSR 			//0266 	0184
		BCR 	STATUS,7 		//0267 	1383
		LDR 	INDF,0 			//0268 	0800
		STR 	5EH 			//0269 	01DE
		INCR	FSR,1 			//026A 	0984
		LDR 	INDF,0 			//026B 	0800
		ORG		026CH
		STR 	5FH 			//026C 	01DF
		INCR	FSR,1 			//026D 	0984
		LDR 	INDF,0 			//026E 	0800
		STR 	60H 			//026F 	01E0
		INCR	FSR,1 			//0270 	0984
		LDR 	INDF,0 			//0271 	0800
		STR 	61H 			//0272 	01E1
		BSR 	STATUS,5 		//0273 	1A83
		ORG		0274H
		RET		 					//0274 	0004
		STR 	FSR 			//0275 	0184
		LDR 	5EH,0 			//0276 	085E
		STR 	INDF 			//0277 	0180
		INCR	FSR,1 			//0278 	0984
		LDR 	5FH,0 			//0279 	085F
		STR 	INDF 			//027A 	0180
		INCR	FSR,1 			//027B 	0984
		ORG		027CH
		LDR 	60H,0 			//027C 	0860
		STR 	INDF 			//027D 	0180
		INCR	FSR,1 			//027E 	0984
		LDR 	61H,0 			//027F 	0861
		STR 	INDF 			//0280 	0180
		RET		 					//0281 	0004
		STR 	5DH 			//0282 	01DD
		BCR 	STATUS,0 		//0283 	1003
		ORG		0284H
		RLR 	5DH,1 			//0284 	05DD
		BCR 	STATUS,0 		//0285 	1003
		RLR 	5DH,0 			//0286 	055D
		RET		 					//0287 	0004
		STR 	FSR 			//0288 	0184
		LDWI 	FFH 			//0289 	2AFF
		STR 	INDF 			//028A 	0180
		INCR	FSR,1 			//028B 	0984
		ORG		028CH
		STR 	INDF 			//028C 	0180
		INCR	FSR,1 			//028D 	0984
		STR 	INDF 			//028E 	0180
		INCR	FSR,1 			//028F 	0984
		STR 	INDF 			//0290 	0180
		RET		 					//0291 	0004
		BCR 	STATUS,5 		//0292 	1283
		STR 	62H 			//0293 	01E2
		ORG		0294H
		BCR 	STATUS,0 		//0294 	1003
		RLR 	62H,1 			//0295 	05E2
		BCR 	STATUS,0 		//0296 	1003
		RLR 	62H,0 			//0297 	0562
		RET		 					//0298 	0004
		BCR 	STATUS,5 		//0299 	1283
		CLRR 	2AH 			//029A 	012A
		BSR 	STATUS,5 		//029B 	1A83
		ORG		029CH
		CLRR 	24H 			//029C 	0124
		CLRR 	25H 			//029D 	0125
		CLRR 	26H 			//029E 	0126
		CLRR 	27H 			//029F 	0127
		RET		 					//02A0 	0004
		SUBWR 	71H,0 			//02A1 	0C71
		LDWI 	C9H 			//02A2 	2AC9
		BTSC 	STATUS,2 		//02A3 	1503
		ORG		02A4H
		SUBWR 	70H,0 			//02A4 	0C70
		RETW 	2H 			//02A5 	2102
		LDR 	77H,0 			//02A6 	0877
		STR 	71H 			//02A7 	01F1
		LDR 	76H,0 			//02A8 	0876
		STR 	70H 			//02A9 	01F0
		RETW 	0H 			//02AA 	2100
		BSR 	STATUS,5 		//02AB 	1A83
		ORG		02ACH
		RLR 	24H,1 			//02AC 	05A4
		RLR 	25H,1 			//02AD 	05A5
		RLR 	26H,1 			//02AE 	05A6
		RLR 	27H,1 			//02AF 	05A7
		RET		 					//02B0 	0004
		STR 	76H 			//02B1 	01F6
		LDWI 	35H 			//02B2 	2A35
		STR 	78H 			//02B3 	01F8
		ORG		02B4H
		CLRR 	79H 			//02B4 	0179
		RET		 					//02B5 	0004

		//;1.C: 667: if( ((PRESSED&0x10) == 0x10) ||
		//;1.C: 668: ((PRESSED&0x20) == 0x20) ||
		//;1.C: 669: ((PRESSED&0x40) == 0x40)
		//;1.C: 670: ){
		BTSS 	75H,4 			//02B6 	1E75
		BTSC 	75H,5 			//02B7 	16F5
		LJUMP 	3FBH 			//02B8 	3BFB
		BTSC 	75H,6 			//02B9 	1775
		LJUMP 	3FBH 			//02BA 	3BFB
		LJUMP 	406H 			//02BB 	3C06
		ORG		02BCH

		//;1.C: 673: Match_remotekey = 0xFFFFFFFF;
		LDWI 	FFH 			//02BC 	2AFF
		STR 	23H 			//02BD 	01A3
		STR 	22H 			//02BE 	01A2
		STR 	21H 			//02BF 	01A1
		STR 	20H 			//02C0 	01A0

		//;1.C: 674: break;
		LJUMP 	406H 			//02C1 	3C06

		//;1.C: 675: case 1:
		//;1.C: 676: PC0 = 0;
		BCR 	7H,0 			//02C2 	1007

		//;1.C: 677: if((PRESSED&0x10) == 0x10) PA7 = 0;
		BTSS 	75H,4 			//02C3 	1E75
		ORG		02C4H
		LJUMP 	2C6H 			//02C4 	3AC6
		BCR 	5H,7 			//02C5 	1385

		//;1.C: 678: if((PRESSED&0x20) == 0x20) PA6 = 0;
		BTSS 	75H,5 			//02C6 	1EF5
		LJUMP 	2C9H 			//02C7 	3AC9
		BCR 	5H,6 			//02C8 	1305

		//;1.C: 679: if((PRESSED&0x40) == 0x40) PA5 = 0;
		BTSS 	75H,6 			//02C9 	1F75
		LJUMP 	406H 			//02CA 	3C06
		BCR 	5H,5 			//02CB 	1285
		ORG		02CCH
		LJUMP 	406H 			//02CC 	3C06

		//;1.C: 681: case 2:
		//;1.C: 682: PC0 = 1;
		BSR 	7H,0 			//02CD 	1807

		//;1.C: 683: if((PRESSED&0x10) == 0x10) PA7 = 1;
		BTSS 	75H,4 			//02CE 	1E75
		LJUMP 	2D1H 			//02CF 	3AD1
		BSR 	5H,7 			//02D0 	1B85

		//;1.C: 684: if((PRESSED&0x20) == 0x20) PA6 = 1;
		BTSS 	75H,5 			//02D1 	1EF5
		LJUMP 	2D4H 			//02D2 	3AD4
		BSR 	5H,6 			//02D3 	1B05
		ORG		02D4H

		//;1.C: 685: if((PRESSED&0x40) == 0x40) PA5 = 1;
		BTSS 	75H,6 			//02D4 	1F75
		LJUMP 	406H 			//02D5 	3C06
		BSR 	5H,5 			//02D6 	1A85
		LJUMP 	406H 			//02D7 	3C06

		//;1.C: 687: case 3:
		LDWI 	3H 			//02D8 	2A03

		//;1.C: 688: KEY_Match_counter = 1;
		CLRR 	25H 			//02D9 	0125
		INCR	25H,1 			//02DA 	09A5

		//;1.C: 689: if(remotekey_Receive_num >= 3){
		SUBWR 	2BH,0 			//02DB 	0C2B
		ORG		02DCH
		BTSS 	STATUS,0 		//02DC 	1C03
		LJUMP 	406H 			//02DD 	3C06

		//;1.C: 690: if((PRESSED&0x10) == 0x10){
		BTSS 	75H,4 			//02DE 	1E75
		LJUMP 	33CH 			//02DF 	3B3C

		//;1.C: 691: if( (Match_remotekey != CH1_remotekey[0]) &&
		//;1.C: 692: (Match_remotekey != CH1_remotekey[1]) &&
		//;1.C: 693: (Match_remotekey != CH1_remotekey[2]) &&
		//;1.C: 694: (Match_remotekey != CH1_remotekey[3])
		//;1.C: 695: ){
		LDR 	23H,0 			//02E0 	0823
		XORWR 	30H,0 			//02E1 	0430
		BTSS 	STATUS,2 		//02E2 	1D03
		LJUMP 	2EEH 			//02E3 	3AEE
		ORG		02E4H
		LDR 	22H,0 			//02E4 	0822
		XORWR 	2FH,0 			//02E5 	042F
		BTSS 	STATUS,2 		//02E6 	1D03
		LJUMP 	2EEH 			//02E7 	3AEE
		LDR 	21H,0 			//02E8 	0821
		XORWR 	2EH,0 			//02E9 	042E
		BTSS 	STATUS,2 		//02EA 	1D03
		LJUMP 	2EEH 			//02EB 	3AEE
		ORG		02ECH
		LDR 	20H,0 			//02EC 	0820
		XORWR 	2DH,0 			//02ED 	042D
		BTSC 	STATUS,2 		//02EE 	1503
		LJUMP 	332H 			//02EF 	3B32
		LDR 	23H,0 			//02F0 	0823
		XORWR 	34H,0 			//02F1 	0434
		BTSS 	STATUS,2 		//02F2 	1D03
		LJUMP 	2FEH 			//02F3 	3AFE
		ORG		02F4H
		LDR 	22H,0 			//02F4 	0822
		XORWR 	33H,0 			//02F5 	0433
		BTSS 	STATUS,2 		//02F6 	1D03
		LJUMP 	2FEH 			//02F7 	3AFE
		LDR 	21H,0 			//02F8 	0821
		XORWR 	32H,0 			//02F9 	0432
		BTSS 	STATUS,2 		//02FA 	1D03
		LJUMP 	2FEH 			//02FB 	3AFE
		ORG		02FCH
		LDR 	20H,0 			//02FC 	0820
		XORWR 	31H,0 			//02FD 	0431
		BTSC 	STATUS,2 		//02FE 	1503
		LJUMP 	332H 			//02FF 	3B32
		LDR 	23H,0 			//0300 	0823
		XORWR 	38H,0 			//0301 	0438
		BTSS 	STATUS,2 		//0302 	1D03
		LJUMP 	30EH 			//0303 	3B0E
		ORG		0304H
		LDR 	22H,0 			//0304 	0822
		XORWR 	37H,0 			//0305 	0437
		BTSS 	STATUS,2 		//0306 	1D03
		LJUMP 	30EH 			//0307 	3B0E
		LDR 	21H,0 			//0308 	0821
		XORWR 	36H,0 			//0309 	0436
		BTSS 	STATUS,2 		//030A 	1D03
		LJUMP 	30EH 			//030B 	3B0E
		ORG		030CH
		LDR 	20H,0 			//030C 	0820
		XORWR 	35H,0 			//030D 	0435
		BTSC 	STATUS,2 		//030E 	1503
		LJUMP 	332H 			//030F 	3B32
		LDR 	23H,0 			//0310 	0823
		XORWR 	3CH,0 			//0311 	043C
		BTSS 	STATUS,2 		//0312 	1D03
		LJUMP 	31EH 			//0313 	3B1E
		ORG		0314H
		LDR 	22H,0 			//0314 	0822
		XORWR 	3BH,0 			//0315 	043B
		BTSS 	STATUS,2 		//0316 	1D03
		LJUMP 	31EH 			//0317 	3B1E
		LDR 	21H,0 			//0318 	0821
		XORWR 	3AH,0 			//0319 	043A
		BTSS 	STATUS,2 		//031A 	1D03
		LJUMP 	31EH 			//031B 	3B1E
		ORG		031CH
		LDR 	20H,0 			//031C 	0820
		XORWR 	39H,0 			//031D 	0439
		BTSC 	STATUS,2 		//031E 	1503
		LJUMP 	332H 			//031F 	3B32

		//;1.C: 696: if(CH1_remotekey_num < 4){
		LDWI 	4H 			//0320 	2A04
		SUBWR 	67H,0 			//0321 	0C67
		BTSC 	STATUS,0 		//0322 	1403
		LJUMP 	32BH 			//0323 	3B2B
		ORG		0324H

		//;1.C: 697: CH1_remotekey[CH1_remotekey_num] = Match_remotekey;
		LDR 	67H,0 			//0324 	0867
		LCALL 	43CH 			//0325 	343C
		ADDWI 	2DH 			//0326 	272D
		STR 	FSR 			//0327 	0184
		LCALL 	42FH 			//0328 	342F

		//;1.C: 698: CH1_remotekey_num++;
		INCR	67H,1 			//0329 	09E7

		//;1.C: 699: }else{
		LJUMP 	332H 			//032A 	3B32

		//;1.C: 700: CH1_remotekey[CH1_remotekey_Latest] = Match_remotekey;
		BSR 	STATUS,5 		//032B 	1A83
		ORG		032CH
		LDR 	37H,0 			//032C 	0837
		LCALL 	43CH 			//032D 	343C
		ADDWI 	2DH 			//032E 	272D
		STR 	FSR 			//032F 	0184
		BCR 	STATUS,5 		//0330 	1283
		LCALL 	42FH 			//0331 	342F

		//;1.C: 701: }
		//;1.C: 702: }
		//;1.C: 703: if(CH1_remotekey_num > 4) CH1_remotekey_num = 4;
		LDWI 	5H 			//0332 	2A05
		SUBWR 	67H,0 			//0333 	0C67
		ORG		0334H
		BTSS 	STATUS,0 		//0334 	1C03
		LJUMP 	338H 			//0335 	3B38
		LDWI 	4H 			//0336 	2A04
		STR 	67H 			//0337 	01E7

		//;1.C: 704: PRESSED &= ~0x10;
		BCR 	75H,4 			//0338 	1275

		//;1.C: 705: CH1_EEPROM_Write();
		LCALL 	608H 			//0339 	3608

		//;1.C: 706: PA7 = 1;
		BCR 	STATUS,5 		//033A 	1283
		BSR 	5H,7 			//033B 	1B85
		ORG		033CH

		//;1.C: 707: }
		//;1.C: 708: if((PRESSED&0x20) == 0x20){
		BTSS 	75H,5 			//033C 	1EF5
		LJUMP 	39AH 			//033D 	3B9A

		//;1.C: 709: if( (Match_remotekey != CH2_remotekey[0]) &&
		//;1.C: 710: (Match_remotekey != CH2_remotekey[1]) &&
		//;1.C: 711: (Match_remotekey != CH2_remotekey[2]) &&
		//;1.C: 712: (Match_remotekey != CH2_remotekey[3])
		//;1.C: 713: ){
		LDR 	23H,0 			//033E 	0823
		XORWR 	40H,0 			//033F 	0440
		BTSS 	STATUS,2 		//0340 	1D03
		LJUMP 	34CH 			//0341 	3B4C
		LDR 	22H,0 			//0342 	0822
		XORWR 	3FH,0 			//0343 	043F
		ORG		0344H
		BTSS 	STATUS,2 		//0344 	1D03
		LJUMP 	34CH 			//0345 	3B4C
		LDR 	21H,0 			//0346 	0821
		XORWR 	3EH,0 			//0347 	043E
		BTSS 	STATUS,2 		//0348 	1D03
		LJUMP 	34CH 			//0349 	3B4C
		LDR 	20H,0 			//034A 	0820
		XORWR 	3DH,0 			//034B 	043D
		ORG		034CH
		BTSC 	STATUS,2 		//034C 	1503
		LJUMP 	390H 			//034D 	3B90
		LDR 	23H,0 			//034E 	0823
		XORWR 	44H,0 			//034F 	0444
		BTSS 	STATUS,2 		//0350 	1D03
		LJUMP 	35CH 			//0351 	3B5C
		LDR 	22H,0 			//0352 	0822
		XORWR 	43H,0 			//0353 	0443
		ORG		0354H
		BTSS 	STATUS,2 		//0354 	1D03
		LJUMP 	35CH 			//0355 	3B5C
		LDR 	21H,0 			//0356 	0821
		XORWR 	42H,0 			//0357 	0442
		BTSS 	STATUS,2 		//0358 	1D03
		LJUMP 	35CH 			//0359 	3B5C
		LDR 	20H,0 			//035A 	0820
		XORWR 	41H,0 			//035B 	0441
		ORG		035CH
		BTSC 	STATUS,2 		//035C 	1503
		LJUMP 	390H 			//035D 	3B90
		LDR 	23H,0 			//035E 	0823
		XORWR 	48H,0 			//035F 	0448
		BTSS 	STATUS,2 		//0360 	1D03
		LJUMP 	36CH 			//0361 	3B6C
		LDR 	22H,0 			//0362 	0822
		XORWR 	47H,0 			//0363 	0447
		ORG		0364H
		BTSS 	STATUS,2 		//0364 	1D03
		LJUMP 	36CH 			//0365 	3B6C
		LDR 	21H,0 			//0366 	0821
		XORWR 	46H,0 			//0367 	0446
		BTSS 	STATUS,2 		//0368 	1D03
		LJUMP 	36CH 			//0369 	3B6C
		LDR 	20H,0 			//036A 	0820
		XORWR 	45H,0 			//036B 	0445
		ORG		036CH
		BTSC 	STATUS,2 		//036C 	1503
		LJUMP 	390H 			//036D 	3B90
		LDR 	23H,0 			//036E 	0823
		XORWR 	4CH,0 			//036F 	044C
		BTSS 	STATUS,2 		//0370 	1D03
		LJUMP 	37CH 			//0371 	3B7C
		LDR 	22H,0 			//0372 	0822
		XORWR 	4BH,0 			//0373 	044B
		ORG		0374H
		BTSS 	STATUS,2 		//0374 	1D03
		LJUMP 	37CH 			//0375 	3B7C
		LDR 	21H,0 			//0376 	0821
		XORWR 	4AH,0 			//0377 	044A
		BTSS 	STATUS,2 		//0378 	1D03
		LJUMP 	37CH 			//0379 	3B7C
		LDR 	20H,0 			//037A 	0820
		XORWR 	49H,0 			//037B 	0449
		ORG		037CH
		BTSC 	STATUS,2 		//037C 	1503
		LJUMP 	390H 			//037D 	3B90

		//;1.C: 714: if(CH2_remotekey_num < 4){
		LDWI 	4H 			//037E 	2A04
		SUBWR 	68H,0 			//037F 	0C68
		BTSC 	STATUS,0 		//0380 	1403
		LJUMP 	389H 			//0381 	3B89

		//;1.C: 715: CH2_remotekey[CH2_remotekey_num] = Match_remotekey;
		LDR 	68H,0 			//0382 	0868
		LCALL 	43CH 			//0383 	343C
		ORG		0384H
		ADDWI 	3DH 			//0384 	273D
		STR 	FSR 			//0385 	0184
		LCALL 	42FH 			//0386 	342F

		//;1.C: 716: CH2_remotekey_num++;
		INCR	68H,1 			//0387 	09E8

		//;1.C: 717: }else{
		LJUMP 	390H 			//0388 	3B90

		//;1.C: 718: CH2_remotekey[CH2_remotekey_Latest] = Match_remotekey;
		BSR 	STATUS,5 		//0389 	1A83
		LDR 	38H,0 			//038A 	0838
		LCALL 	43CH 			//038B 	343C
		ORG		038CH
		ADDWI 	3DH 			//038C 	273D
		STR 	FSR 			//038D 	0184
		BCR 	STATUS,5 		//038E 	1283
		LCALL 	42FH 			//038F 	342F

		//;1.C: 719: }
		//;1.C: 720: }
		//;1.C: 721: if(CH2_remotekey_num > 4) CH2_remotekey_num = 4;
		LDWI 	5H 			//0390 	2A05
		SUBWR 	68H,0 			//0391 	0C68
		BTSS 	STATUS,0 		//0392 	1C03
		LJUMP 	396H 			//0393 	3B96
		ORG		0394H
		LDWI 	4H 			//0394 	2A04
		STR 	68H 			//0395 	01E8

		//;1.C: 722: PRESSED &= ~0x20;
		BCR 	75H,5 			//0396 	12F5

		//;1.C: 723: CH2_EEPROM_Write();
		LCALL 	5C8H 			//0397 	35C8

		//;1.C: 724: PA6 = 1;
		BCR 	STATUS,5 		//0398 	1283
		BSR 	5H,6 			//0399 	1B05

		//;1.C: 725: }
		//;1.C: 726: if((PRESSED&0x40) == 0x40){
		BTSS 	75H,6 			//039A 	1F75
		LJUMP 	3F8H 			//039B 	3BF8
		ORG		039CH

		//;1.C: 727: if( (Match_remotekey != CH3_remotekey[0]) &&
		//;1.C: 728: (Match_remotekey != CH3_remotekey[1]) &&
		//;1.C: 729: (Match_remotekey != CH3_remotekey[2]) &&
		//;1.C: 730: (Match_remotekey != CH3_remotekey[3])
		//;1.C: 731: ){
		LDR 	23H,0 			//039C 	0823
		XORWR 	50H,0 			//039D 	0450
		BTSS 	STATUS,2 		//039E 	1D03
		LJUMP 	3AAH 			//039F 	3BAA
		LDR 	22H,0 			//03A0 	0822
		XORWR 	4FH,0 			//03A1 	044F
		BTSS 	STATUS,2 		//03A2 	1D03
		LJUMP 	3AAH 			//03A3 	3BAA
		ORG		03A4H
		LDR 	21H,0 			//03A4 	0821
		XORWR 	4EH,0 			//03A5 	044E
		BTSS 	STATUS,2 		//03A6 	1D03
		LJUMP 	3AAH 			//03A7 	3BAA
		LDR 	20H,0 			//03A8 	0820
		XORWR 	4DH,0 			//03A9 	044D
		BTSC 	STATUS,2 		//03AA 	1503
		LJUMP 	3EEH 			//03AB 	3BEE
		ORG		03ACH
		LDR 	23H,0 			//03AC 	0823
		XORWR 	54H,0 			//03AD 	0454
		BTSS 	STATUS,2 		//03AE 	1D03
		LJUMP 	3BAH 			//03AF 	3BBA
		LDR 	22H,0 			//03B0 	0822
		XORWR 	53H,0 			//03B1 	0453
		BTSS 	STATUS,2 		//03B2 	1D03
		LJUMP 	3BAH 			//03B3 	3BBA
		ORG		03B4H
		LDR 	21H,0 			//03B4 	0821
		XORWR 	52H,0 			//03B5 	0452
		BTSS 	STATUS,2 		//03B6 	1D03
		LJUMP 	3BAH 			//03B7 	3BBA
		LDR 	20H,0 			//03B8 	0820
		XORWR 	51H,0 			//03B9 	0451
		BTSC 	STATUS,2 		//03BA 	1503
		LJUMP 	3EEH 			//03BB 	3BEE
		ORG		03BCH
		LDR 	23H,0 			//03BC 	0823
		XORWR 	58H,0 			//03BD 	0458
		BTSS 	STATUS,2 		//03BE 	1D03
		LJUMP 	3CAH 			//03BF 	3BCA
		LDR 	22H,0 			//03C0 	0822
		XORWR 	57H,0 			//03C1 	0457
		BTSS 	STATUS,2 		//03C2 	1D03
		LJUMP 	3CAH 			//03C3 	3BCA
		ORG		03C4H
		LDR 	21H,0 			//03C4 	0821
		XORWR 	56H,0 			//03C5 	0456
		BTSS 	STATUS,2 		//03C6 	1D03
		LJUMP 	3CAH 			//03C7 	3BCA
		LDR 	20H,0 			//03C8 	0820
		XORWR 	55H,0 			//03C9 	0455
		BTSC 	STATUS,2 		//03CA 	1503
		LJUMP 	3EEH 			//03CB 	3BEE
		ORG		03CCH
		LDR 	23H,0 			//03CC 	0823
		XORWR 	5CH,0 			//03CD 	045C
		BTSS 	STATUS,2 		//03CE 	1D03
		LJUMP 	3DAH 			//03CF 	3BDA
		LDR 	22H,0 			//03D0 	0822
		XORWR 	5BH,0 			//03D1 	045B
		BTSS 	STATUS,2 		//03D2 	1D03
		LJUMP 	3DAH 			//03D3 	3BDA
		ORG		03D4H
		LDR 	21H,0 			//03D4 	0821
		XORWR 	5AH,0 			//03D5 	045A
		BTSS 	STATUS,2 		//03D6 	1D03
		LJUMP 	3DAH 			//03D7 	3BDA
		LDR 	20H,0 			//03D8 	0820
		XORWR 	59H,0 			//03D9 	0459
		BTSC 	STATUS,2 		//03DA 	1503
		LJUMP 	3EEH 			//03DB 	3BEE
		ORG		03DCH

		//;1.C: 732: if(CH3_remotekey_num < 4){
		LDWI 	4H 			//03DC 	2A04
		SUBWR 	69H,0 			//03DD 	0C69
		BTSC 	STATUS,0 		//03DE 	1403
		LJUMP 	3E7H 			//03DF 	3BE7

		//;1.C: 733: CH3_remotekey[CH3_remotekey_num] = Match_remotekey;
		LDR 	69H,0 			//03E0 	0869
		LCALL 	43CH 			//03E1 	343C
		ADDWI 	4DH 			//03E2 	274D
		STR 	FSR 			//03E3 	0184
		ORG		03E4H
		LCALL 	42FH 			//03E4 	342F

		//;1.C: 734: CH3_remotekey_num++;
		INCR	69H,1 			//03E5 	09E9

		//;1.C: 735: }else{
		LJUMP 	3EEH 			//03E6 	3BEE

		//;1.C: 736: CH3_remotekey[CH3_remotekey_Latest] = Match_remotekey;
		BSR 	STATUS,5 		//03E7 	1A83
		LDR 	39H,0 			//03E8 	0839
		LCALL 	43CH 			//03E9 	343C
		ADDWI 	4DH 			//03EA 	274D
		STR 	FSR 			//03EB 	0184
		ORG		03ECH
		BCR 	STATUS,5 		//03EC 	1283
		LCALL 	42FH 			//03ED 	342F

		//;1.C: 737: }
		//;1.C: 738: }
		//;1.C: 739: if(CH3_remotekey_num > 4) CH3_remotekey_num = 4;
		LDWI 	5H 			//03EE 	2A05
		SUBWR 	69H,0 			//03EF 	0C69
		BTSS 	STATUS,0 		//03F0 	1C03
		LJUMP 	3F4H 			//03F1 	3BF4
		LDWI 	4H 			//03F2 	2A04
		STR 	69H 			//03F3 	01E9
		ORG		03F4H

		//;1.C: 740: PRESSED &= ~0x40;
		BCR 	75H,6 			//03F4 	1375

		//;1.C: 741: CH3_EEPROM_Write();
		LCALL 	588H 			//03F5 	3588

		//;1.C: 742: PA5 = 1;
		BCR 	STATUS,5 		//03F6 	1283
		BSR 	5H,5 			//03F7 	1A85

		//;1.C: 743: }
		//;1.C: 744: KEY_Match_counter = 0;
		CLRR 	25H 			//03F8 	0125

		//;1.C: 745: PC0 = 1;
		BSR 	7H,0 			//03F9 	1807
		LJUMP 	406H 			//03FA 	3C06
		LDR 	25H,0 			//03FB 	0825
		ORG		03FCH
		STR 	FSR 			//03FC 	0184
		LDWI 	4H 			//03FD 	2A04
		SUBWR 	FSR,0 			//03FE 	0C04
		BTSC 	STATUS,0 		//03FF 	1403
		LJUMP 	406H 			//0400 	3C06
		LDWI 	6H 			//0401 	2A06
		STR 	PCLATH 			//0402 	018A
		LDWI 	ECH 			//0403 	2AEC
		ORG		0404H
		ADDWR 	FSR,0 			//0404 	0B04
		STR 	PCL 			//0405 	0182

		//;1.C: 749: }
		//;1.C: 752: if( ((PRESSED&0x10) == 0) &&
		//;1.C: 753: ((PRESSED&0x20) == 0) &&
		//;1.C: 754: ((PRESSED&0x40) == 0)
		//;1.C: 755: ){
		BTSS 	75H,4 			//0406 	1E75
		BTSC 	75H,5 			//0407 	16F5
		RET		 					//0408 	0004
		BTSC 	75H,6 			//0409 	1775
		RET		 					//040A 	0004

		//;1.C: 756: if((PRESSED&0x0F) > 0){
		LDR 	75H,0 			//040B 	0875
		ORG		040CH
		ANDWI 	FH 			//040C 	240F
		BTSS 	STATUS,2 		//040D 	1D03
		LJUMP 	418H 			//040E 	3C18
		LJUMP 	42CH 			//040F 	3C2C

		//;1.C: 759: PA7 = ~PA7;
		LDWI 	80H 			//0410 	2A80
		XORWR 	5H,1 			//0411 	0485

		//;1.C: 760: led1_debug();
		LCALL 	6F7H 			//0412 	36F7

		//;1.C: 761: break;
		LJUMP 	42CH 			//0413 	3C2C
		ORG		0414H

		//;1.C: 763: PA6 = ~PA6;
		LDWI 	40H 			//0414 	2A40
		LJUMP 	411H 			//0415 	3C11

		//;1.C: 767: PA5 = ~PA5;
		LDWI 	20H 			//0416 	2A20
		LJUMP 	411H 			//0417 	3C11
		LDR 	75H,0 			//0418 	0875
		ANDWI 	FH 			//0419 	240F
		STR 	78H 			//041A 	01F8
		CLRR 	79H 			//041B 	0179
		ORG		041CH
		LDR 	79H,0 			//041C 	0879
		XORWI 	0H 			//041D 	2600
		BTSC 	STATUS,2 		//041E 	1503
		LJUMP 	421H 			//041F 	3C21
		LJUMP 	42CH 			//0420 	3C2C
		LDR 	78H,0 			//0421 	0878
		XORWI 	1H 			//0422 	2601
		BTSC 	STATUS,2 		//0423 	1503
		ORG		0424H
		LJUMP 	410H 			//0424 	3C10
		XORWI 	3H 			//0425 	2603
		BTSC 	STATUS,2 		//0426 	1503
		LJUMP 	414H 			//0427 	3C14
		XORWI 	6H 			//0428 	2606
		BTSC 	STATUS,2 		//0429 	1503
		LJUMP 	416H 			//042A 	3C16
		LJUMP 	42CH 			//042B 	3C2C
		ORG		042CH

		//;1.C: 771: }
		//;1.C: 772: PRESSED &= 0xF0;
		LDWI 	F0H 			//042C 	2AF0
		ANDWR 	75H,1 			//042D 	02F5
		RET		 					//042E 	0004
		LDR 	20H,0 			//042F 	0820
		BCR 	STATUS,7 		//0430 	1383
		STR 	INDF 			//0431 	0180
		INCR	FSR,1 			//0432 	0984
		LDR 	21H,0 			//0433 	0821
		ORG		0434H
		STR 	INDF 			//0434 	0180
		INCR	FSR,1 			//0435 	0984
		LDR 	22H,0 			//0436 	0822
		STR 	INDF 			//0437 	0180
		INCR	FSR,1 			//0438 	0984
		LDR 	23H,0 			//0439 	0823
		STR 	INDF 			//043A 	0180
		RET		 					//043B 	0004
		ORG		043CH
		STR 	78H 			//043C 	01F8
		BCR 	STATUS,0 		//043D 	1003
		RLR 	78H,1 			//043E 	05F8
		BCR 	STATUS,0 		//043F 	1003
		RLR 	78H,0 			//0440 	0578
		RET		 					//0441 	0004

		//;1.C: 584: if(PRESSED == 0){
		LDR 	75H,1 			//0442 	08F5
		BTSS 	STATUS,2 		//0443 	1D03
		ORG		0444H
		RET		 					//0444 	0004

		//;1.C: 585: if(PC5 == 0){
		BTSC 	7H,5 			//0445 	1687
		LJUMP 	47CH 			//0446 	3C7C

		//;1.C: 586: if(KEY1_LongPress < 125) PRESS_FLAG |= 0x01;
		LDWI 	7DH 			//0447 	2A7D
		SUBWR 	73H,0 			//0448 	0C73
		BTSC 	STATUS,0 		//0449 	1403
		LJUMP 	44CH 			//044A 	3C4C
		BSR 	27H,0 			//044B 	1827
		ORG		044CH

		//;1.C: 587: if(KEY1_LongPress < 254) KEY1_LongPress++;
		LDWI 	FEH 			//044C 	2AFE
		SUBWR 	73H,0 			//044D 	0C73
		BTSS 	STATUS,0 		//044E 	1C03
		INCR	73H,1 			//044F 	09F3

		//;1.C: 588: if((KEY1_LongPress > 125) && (KEY1_LongPress < 250)){
		LDWI 	7EH 			//0450 	2A7E
		SUBWR 	73H,0 			//0451 	0C73
		BTSS 	STATUS,0 		//0452 	1C03
		LJUMP 	45DH 			//0453 	3C5D
		ORG		0454H
		LDWI 	FAH 			//0454 	2AFA
		SUBWR 	73H,0 			//0455 	0C73
		BTSC 	STATUS,0 		//0456 	1403
		LJUMP 	45DH 			//0457 	3C5D

		//;1.C: 589: PRESS_FLAG |= 0x10;
		BSR 	27H,4 			//0458 	1A27

		//;1.C: 590: match_slice = 0;
		CLRR 	28H 			//0459 	0128

		//;1.C: 591: PC0 = 0;
		BCR 	7H,0 			//045A 	1007

		//;1.C: 592: PA7 = 0;
		BCR 	5H,7 			//045B 	1385
		ORG		045CH

		//;1.C: 593: LONGPRESS_OverTime_Counter = 0;
		CLRR 	26H 			//045C 	0126

		//;1.C: 594: }
		//;1.C: 595: if(KEY1_LongPress > 250){
		LDWI 	FBH 			//045D 	2AFB
		SUBWR 	73H,0 			//045E 	0C73
		BTSS 	STATUS,0 		//045F 	1C03
		LJUMP 	47DH 			//0460 	3C7D

		//;1.C: 596: CH1_remotekey[0] = 0xFFFFFFFF;
		LDWI 	FFH 			//0461 	2AFF
		STR 	30H 			//0462 	01B0
		STR 	2FH 			//0463 	01AF
		ORG		0464H
		STR 	2EH 			//0464 	01AE
		STR 	2DH 			//0465 	01AD

		//;1.C: 597: CH1_remotekey[1] = 0xFFFFFFFF;
		STR 	34H 			//0466 	01B4
		STR 	33H 			//0467 	01B3
		STR 	32H 			//0468 	01B2
		STR 	31H 			//0469 	01B1

		//;1.C: 598: CH1_remotekey[2] = 0xFFFFFFFF;
		STR 	38H 			//046A 	01B8
		STR 	37H 			//046B 	01B7
		ORG		046CH
		STR 	36H 			//046C 	01B6
		STR 	35H 			//046D 	01B5

		//;1.C: 599: CH1_remotekey[3] = 0xFFFFFFFF;
		STR 	3CH 			//046E 	01BC
		STR 	3BH 			//046F 	01BB
		STR 	3AH 			//0470 	01BA
		STR 	39H 			//0471 	01B9

		//;1.C: 600: CH1_remotekey_num = 0;
		CLRR 	67H 			//0472 	0167

		//;1.C: 601: CH1_remotekey_Latest = 0;
		BSR 	STATUS,5 		//0473 	1A83
		ORG		0474H
		CLRR 	37H 			//0474 	0137

		//;1.C: 602: PRESS_FLAG &= ~0x10;
		BCR 	STATUS,5 		//0475 	1283
		BCR 	27H,4 			//0476 	1227

		//;1.C: 603: PRESS_FLAG &= ~0x01;
		BCR 	27H,0 			//0477 	1027

		//;1.C: 604: PC0 = 1;
		BSR 	7H,0 			//0478 	1807

		//;1.C: 605: PA7 = 1;
		BSR 	5H,7 			//0479 	1B85

		//;1.C: 606: KEY_Match_counter = 0;
		CLRR 	25H 			//047A 	0125
		LJUMP 	47DH 			//047B 	3C7D
		ORG		047CH
		CLRR 	73H 			//047C 	0173

		//;1.C: 610: if(PA4 == 0){
		BTSC 	5H,4 			//047D 	1605
		LJUMP 	4B4H 			//047E 	3CB4

		//;1.C: 611: if(KEY2_LongPress < 125) PRESS_FLAG |= 0x02;
		LDWI 	7DH 			//047F 	2A7D
		SUBWR 	74H,0 			//0480 	0C74
		BTSC 	STATUS,0 		//0481 	1403
		LJUMP 	484H 			//0482 	3C84
		BSR 	27H,1 			//0483 	18A7
		ORG		0484H

		//;1.C: 612: if(KEY2_LongPress < 254) KEY2_LongPress++;
		LDWI 	FEH 			//0484 	2AFE
		SUBWR 	74H,0 			//0485 	0C74
		BTSS 	STATUS,0 		//0486 	1C03
		INCR	74H,1 			//0487 	09F4

		//;1.C: 613: if((KEY2_LongPress > 125) && (KEY2_LongPress < 250)){
		LDWI 	7EH 			//0488 	2A7E
		SUBWR 	74H,0 			//0489 	0C74
		BTSS 	STATUS,0 		//048A 	1C03
		LJUMP 	495H 			//048B 	3C95
		ORG		048CH
		LDWI 	FAH 			//048C 	2AFA
		SUBWR 	74H,0 			//048D 	0C74
		BTSC 	STATUS,0 		//048E 	1403
		LJUMP 	495H 			//048F 	3C95

		//;1.C: 614: PRESS_FLAG |= 0x20;
		BSR 	27H,5 			//0490 	1AA7

		//;1.C: 615: match_slice = 0;
		CLRR 	28H 			//0491 	0128

		//;1.C: 616: PC0 = 0;
		BCR 	7H,0 			//0492 	1007

		//;1.C: 617: PA6 = 0;
		BCR 	5H,6 			//0493 	1305
		ORG		0494H

		//;1.C: 618: LONGPRESS_OverTime_Counter = 0;
		CLRR 	26H 			//0494 	0126

		//;1.C: 619: }
		//;1.C: 620: if(KEY2_LongPress > 250){
		LDWI 	FBH 			//0495 	2AFB
		SUBWR 	74H,0 			//0496 	0C74
		BTSS 	STATUS,0 		//0497 	1C03
		LJUMP 	4B5H 			//0498 	3CB5

		//;1.C: 621: CH2_remotekey[0] = 0xFFFFFFFF;
		LDWI 	FFH 			//0499 	2AFF
		STR 	40H 			//049A 	01C0
		STR 	3FH 			//049B 	01BF
		ORG		049CH
		STR 	3EH 			//049C 	01BE
		STR 	3DH 			//049D 	01BD

		//;1.C: 622: CH2_remotekey[1] = 0xFFFFFFFF;
		STR 	44H 			//049E 	01C4
		STR 	43H 			//049F 	01C3
		STR 	42H 			//04A0 	01C2
		STR 	41H 			//04A1 	01C1

		//;1.C: 623: CH2_remotekey[2] = 0xFFFFFFFF;
		STR 	48H 			//04A2 	01C8
		STR 	47H 			//04A3 	01C7
		ORG		04A4H
		STR 	46H 			//04A4 	01C6
		STR 	45H 			//04A5 	01C5

		//;1.C: 624: CH2_remotekey[3] = 0xFFFFFFFF;
		STR 	4CH 			//04A6 	01CC
		STR 	4BH 			//04A7 	01CB
		STR 	4AH 			//04A8 	01CA
		STR 	49H 			//04A9 	01C9

		//;1.C: 625: CH2_remotekey_num = 0;
		CLRR 	68H 			//04AA 	0168

		//;1.C: 626: CH2_remotekey_Latest = 0;
		BSR 	STATUS,5 		//04AB 	1A83
		ORG		04ACH
		CLRR 	38H 			//04AC 	0138

		//;1.C: 627: PRESS_FLAG &= ~0x20;
		BCR 	STATUS,5 		//04AD 	1283
		BCR 	27H,5 			//04AE 	12A7

		//;1.C: 628: PRESS_FLAG &= ~0x02;
		BCR 	27H,1 			//04AF 	10A7

		//;1.C: 629: PC0 = 1;
		BSR 	7H,0 			//04B0 	1807

		//;1.C: 630: PA6 = 1;
		BSR 	5H,6 			//04B1 	1B05

		//;1.C: 631: KEY_Match_counter = 0;
		CLRR 	25H 			//04B2 	0125
		LJUMP 	4B5H 			//04B3 	3CB5
		ORG		04B4H
		CLRR 	74H 			//04B4 	0174

		//;1.C: 635: if(PC4 == 0){
		BTSC 	7H,4 			//04B5 	1607
		LJUMP 	4ECH 			//04B6 	3CEC

		//;1.C: 636: if(KEY3_LongPress < 125) PRESS_FLAG |= 0x04;
		LDWI 	7DH 			//04B7 	2A7D
		SUBWR 	24H,0 			//04B8 	0C24
		BTSC 	STATUS,0 		//04B9 	1403
		LJUMP 	4BCH 			//04BA 	3CBC
		BSR 	27H,2 			//04BB 	1927
		ORG		04BCH

		//;1.C: 637: if(KEY3_LongPress < 254) KEY3_LongPress++;
		LDWI 	FEH 			//04BC 	2AFE
		SUBWR 	24H,0 			//04BD 	0C24
		BTSS 	STATUS,0 		//04BE 	1C03
		INCR	24H,1 			//04BF 	09A4

		//;1.C: 638: if((KEY3_LongPress > 125) && (KEY3_LongPress < 250)){
		LDWI 	7EH 			//04C0 	2A7E
		SUBWR 	24H,0 			//04C1 	0C24
		BTSS 	STATUS,0 		//04C2 	1C03
		LJUMP 	4CDH 			//04C3 	3CCD
		ORG		04C4H
		LDWI 	FAH 			//04C4 	2AFA
		SUBWR 	24H,0 			//04C5 	0C24
		BTSC 	STATUS,0 		//04C6 	1403
		LJUMP 	4CDH 			//04C7 	3CCD

		//;1.C: 639: PRESS_FLAG |= 0x40;
		BSR 	27H,6 			//04C8 	1B27

		//;1.C: 640: match_slice = 0;
		CLRR 	28H 			//04C9 	0128

		//;1.C: 641: PC0 = 0;
		BCR 	7H,0 			//04CA 	1007

		//;1.C: 642: PA5 = 0;
		BCR 	5H,5 			//04CB 	1285
		ORG		04CCH

		//;1.C: 643: LONGPRESS_OverTime_Counter = 0;
		CLRR 	26H 			//04CC 	0126

		//;1.C: 644: }
		//;1.C: 645: if(KEY3_LongPress > 250){
		LDWI 	FBH 			//04CD 	2AFB
		SUBWR 	24H,0 			//04CE 	0C24
		BTSS 	STATUS,0 		//04CF 	1C03
		LJUMP 	4EDH 			//04D0 	3CED

		//;1.C: 646: CH3_remotekey[0] = 0xFFFFFFFF;
		LDWI 	FFH 			//04D1 	2AFF
		STR 	50H 			//04D2 	01D0
		STR 	4FH 			//04D3 	01CF
		ORG		04D4H
		STR 	4EH 			//04D4 	01CE
		STR 	4DH 			//04D5 	01CD

		//;1.C: 647: CH3_remotekey[1] = 0xFFFFFFFF;
		STR 	54H 			//04D6 	01D4
		STR 	53H 			//04D7 	01D3
		STR 	52H 			//04D8 	01D2
		STR 	51H 			//04D9 	01D1

		//;1.C: 648: CH3_remotekey[2] = 0xFFFFFFFF;
		STR 	58H 			//04DA 	01D8
		STR 	57H 			//04DB 	01D7
		ORG		04DCH
		STR 	56H 			//04DC 	01D6
		STR 	55H 			//04DD 	01D5

		//;1.C: 649: CH3_remotekey[3] = 0xFFFFFFFF;
		STR 	5CH 			//04DE 	01DC
		STR 	5BH 			//04DF 	01DB
		STR 	5AH 			//04E0 	01DA
		STR 	59H 			//04E1 	01D9

		//;1.C: 650: CH3_remotekey_num = 0;
		CLRR 	69H 			//04E2 	0169

		//;1.C: 651: CH3_remotekey_Latest = 0;
		BSR 	STATUS,5 		//04E3 	1A83
		ORG		04E4H
		CLRR 	39H 			//04E4 	0139

		//;1.C: 652: PRESS_FLAG &= ~0x40;
		BCR 	STATUS,5 		//04E5 	1283
		BCR 	27H,6 			//04E6 	1327

		//;1.C: 653: PRESS_FLAG &= ~0x04;
		BCR 	27H,2 			//04E7 	1127

		//;1.C: 654: PC0 = 1;
		BSR 	7H,0 			//04E8 	1807

		//;1.C: 655: PA5 = 1;
		BSR 	5H,5 			//04E9 	1A85

		//;1.C: 656: KEY_Match_counter = 0;
		CLRR 	25H 			//04EA 	0125
		LJUMP 	4EDH 			//04EB 	3CED
		ORG		04ECH
		CLRR 	24H 			//04EC 	0124

		//;1.C: 660: if((PRESS_FLAG>0)&&(PC5==1)&&(PA4==1)&&(PC4==1)){
		LDR 	27H,0 			//04ED 	0827
		BTSS 	STATUS,2 		//04EE 	1D03
		BTSS 	7H,5 			//04EF 	1E87
		RET		 					//04F0 	0004
		BTSC 	5H,4 			//04F1 	1605
		BTSS 	7H,4 			//04F2 	1E07
		RET		 					//04F3 	0004
		ORG		04F4H

		//;1.C: 661: PRESSED = PRESS_FLAG;
		STR 	75H 			//04F4 	01F5

		//;1.C: 662: PRESS_FLAG = 0;
		CLRR 	27H 			//04F5 	0127
		RET		 					//04F6 	0004
		STR 	36H 			//04F7 	01B6

		//;1.C: 556: *buff = 0;
		STR 	FSR 			//04F8 	0184
		CLRR 	INDF 			//04F9 	0100
		INCR	FSR,1 			//04FA 	0984
		CLRR 	INDF 			//04FB 	0100
		ORG		04FCH
		INCR	FSR,1 			//04FC 	0984
		CLRR 	INDF 			//04FD 	0100
		INCR	FSR,1 			//04FE 	0984
		CLRR 	INDF 			//04FF 	0100

		//;1.C: 557: EE_Buff = IAPRead(data+2);
		LDR 	31H,0 			//0500 	0831
		ADDWI 	2H 			//0501 	2702
		LCALL 	6DDH 			//0502 	36DD

		//;1.C: 558: *buff |= EE_Buff;
		LCALL 	537H 			//0503 	3537
		ORG		0504H

		//;1.C: 559: *buff = *buff<<8;
		LCALL 	511H 			//0504 	3511

		//;1.C: 560: EE_Buff = IAPRead(data+1);
		INCR	31H,0 			//0505 	0931
		LCALL 	6DDH 			//0506 	36DD

		//;1.C: 561: *buff |= EE_Buff;
		LCALL 	537H 			//0507 	3537

		//;1.C: 562: *buff = *buff<<8;
		LCALL 	511H 			//0508 	3511

		//;1.C: 563: EE_Buff = IAPRead(data);
		LDR 	31H,0 			//0509 	0831
		LCALL 	6DDH 			//050A 	36DD

		//;1.C: 564: *buff |= EE_Buff;
		LCALL 	537H 			//050B 	3537
		ORG		050CH
		IORWR 	INDF,1 		//050C 	0380
		INCR	FSR,1 			//050D 	0984
		LDR 	35H,0 			//050E 	0835
		IORWR 	INDF,1 		//050F 	0380
		RET		 					//0510 	0004
		IORWR 	INDF,1 		//0511 	0380
		INCR	FSR,1 			//0512 	0984
		LDR 	35H,0 			//0513 	0835
		ORG		0514H
		IORWR 	INDF,1 		//0514 	0380
		LDR 	36H,0 			//0515 	0836
		STR 	FSR 			//0516 	0184
		LDR 	INDF,0 			//0517 	0800
		STR 	32H 			//0518 	01B2
		INCR	FSR,1 			//0519 	0984
		LDR 	INDF,0 			//051A 	0800
		STR 	33H 			//051B 	01B3
		ORG		051CH
		INCR	FSR,1 			//051C 	0984
		LDR 	INDF,0 			//051D 	0800
		STR 	34H 			//051E 	01B4
		INCR	FSR,1 			//051F 	0984
		LDR 	INDF,0 			//0520 	0800
		STR 	35H 			//0521 	01B5
		LDR 	34H,0 			//0522 	0834
		STR 	35H 			//0523 	01B5
		ORG		0524H
		LDR 	33H,0 			//0524 	0833
		STR 	34H 			//0525 	01B4
		LDR 	32H,0 			//0526 	0832
		STR 	33H 			//0527 	01B3
		CLRR 	32H 			//0528 	0132
		LDR 	36H,0 			//0529 	0836
		STR 	FSR 			//052A 	0184
		LDR 	32H,0 			//052B 	0832
		ORG		052CH
		STR 	INDF 			//052C 	0180
		INCR	FSR,1 			//052D 	0984
		LDR 	33H,0 			//052E 	0833
		STR 	INDF 			//052F 	0180
		INCR	FSR,1 			//0530 	0984
		LDR 	34H,0 			//0531 	0834
		STR 	INDF 			//0532 	0180
		INCR	FSR,1 			//0533 	0984
		ORG		0534H
		LDR 	35H,0 			//0534 	0835
		STR 	INDF 			//0535 	0180
		RET		 					//0536 	0004
		STR 	3AH 			//0537 	01BA
		STR 	32H 			//0538 	01B2
		CLRR 	33H 			//0539 	0133
		CLRR 	34H 			//053A 	0134
		CLRR 	35H 			//053B 	0135
		ORG		053CH
		LDR 	36H,0 			//053C 	0836
		STR 	FSR 			//053D 	0184
		LDR 	32H,0 			//053E 	0832
		IORWR 	INDF,1 		//053F 	0380
		INCR	FSR,1 			//0540 	0984
		LDR 	33H,0 			//0541 	0833
		IORWR 	INDF,1 		//0542 	0380
		INCR	FSR,1 			//0543 	0984
		ORG		0544H
		LDR 	34H,0 			//0544 	0834
		RET		 					//0545 	0004
		LDWI 	2DH 			//0546 	2A2D

		//;1.C: 567: EEPROM_ReadWord(&CH1_remotekey[0],0x00);
		CLRR 	31H 			//0547 	0131
		LCALL 	4F7H 			//0548 	34F7

		//;1.C: 568: EEPROM_ReadWord(&CH2_remotekey[0],0x04);
		LDWI 	4H 			//0549 	2A04
		STR 	31H 			//054A 	01B1
		LDWI 	3DH 			//054B 	2A3D
		ORG		054CH
		LCALL 	4F7H 			//054C 	34F7

		//;1.C: 569: EEPROM_ReadWord(&CH3_remotekey[0],0x08);
		LDWI 	8H 			//054D 	2A08
		STR 	31H 			//054E 	01B1
		LDWI 	4DH 			//054F 	2A4D
		LCALL 	4F7H 			//0550 	34F7

		//;1.C: 570: EEPROM_ReadWord(&CH1_remotekey[1],0x0C);
		LDWI 	CH 			//0551 	2A0C
		STR 	31H 			//0552 	01B1
		LDWI 	31H 			//0553 	2A31
		ORG		0554H
		LCALL 	4F7H 			//0554 	34F7

		//;1.C: 571: EEPROM_ReadWord(&CH2_remotekey[1],0x10);
		LDWI 	10H 			//0555 	2A10
		STR 	31H 			//0556 	01B1
		LDWI 	41H 			//0557 	2A41
		LCALL 	4F7H 			//0558 	34F7

		//;1.C: 572: EEPROM_ReadWord(&CH3_remotekey[1],0x14);
		LDWI 	14H 			//0559 	2A14
		STR 	31H 			//055A 	01B1
		LDWI 	51H 			//055B 	2A51
		ORG		055CH
		LCALL 	4F7H 			//055C 	34F7

		//;1.C: 573: EEPROM_ReadWord(&CH1_remotekey[2],0x18);
		LDWI 	18H 			//055D 	2A18
		STR 	31H 			//055E 	01B1
		LDWI 	35H 			//055F 	2A35
		LCALL 	4F7H 			//0560 	34F7

		//;1.C: 574: EEPROM_ReadWord(&CH2_remotekey[2],0x1C);
		LDWI 	1CH 			//0561 	2A1C
		STR 	31H 			//0562 	01B1
		LDWI 	45H 			//0563 	2A45
		ORG		0564H
		LCALL 	4F7H 			//0564 	34F7

		//;1.C: 575: EEPROM_ReadWord(&CH3_remotekey[2],0x20);
		LDWI 	20H 			//0565 	2A20
		STR 	31H 			//0566 	01B1
		LDWI 	55H 			//0567 	2A55
		LCALL 	4F7H 			//0568 	34F7

		//;1.C: 576: EEPROM_ReadWord(&CH1_remotekey[3],0x24);
		LDWI 	24H 			//0569 	2A24
		STR 	31H 			//056A 	01B1
		LDWI 	39H 			//056B 	2A39
		ORG		056CH
		LCALL 	4F7H 			//056C 	34F7

		//;1.C: 577: EEPROM_ReadWord(&CH2_remotekey[3],0x28);
		LDWI 	28H 			//056D 	2A28
		STR 	31H 			//056E 	01B1
		LDWI 	49H 			//056F 	2A49
		LCALL 	4F7H 			//0570 	34F7

		//;1.C: 578: EEPROM_ReadWord(&CH3_remotekey[3],0x2C);
		LDWI 	2CH 			//0571 	2A2C
		STR 	31H 			//0572 	01B1
		LDWI 	59H 			//0573 	2A59
		ORG		0574H
		LCALL 	4F7H 			//0574 	34F7

		//;1.C: 579: CH1_remotekey_Latest = CH1_remotekey_num = IAPRead(0x30);
		LDWI 	30H 			//0575 	2A30
		LCALL 	6DDH 			//0576 	36DD
		BCR 	STATUS,5 		//0577 	1283
		STR 	67H 			//0578 	01E7
		BSR 	STATUS,5 		//0579 	1A83
		STR 	37H 			//057A 	01B7

		//;1.C: 580: CH2_remotekey_Latest = CH2_remotekey_num = IAPRead(0x31);
		LDWI 	31H 			//057B 	2A31
		ORG		057CH
		LCALL 	6DDH 			//057C 	36DD
		BCR 	STATUS,5 		//057D 	1283
		STR 	68H 			//057E 	01E8
		BSR 	STATUS,5 		//057F 	1A83
		STR 	38H 			//0580 	01B8

		//;1.C: 581: CH3_remotekey_Latest = CH3_remotekey_num = IAPRead(0x32);
		LDWI 	32H 			//0581 	2A32
		LCALL 	6DDH 			//0582 	36DD
		BCR 	STATUS,5 		//0583 	1283
		ORG		0584H
		STR 	69H 			//0584 	01E9
		BSR 	STATUS,5 		//0585 	1A83
		STR 	39H 			//0586 	01B9
		RET		 					//0587 	0004

		//;1.C: 537: IAPWrite(0x08,((CH3_remotekey[0]&0x000000FF)>>0));
		LDR 	4DH,0 			//0588 	084D
		STR 	76H 			//0589 	01F6
		LDWI 	8H 			//058A 	2A08
		LCALL 	68EH 			//058B 	368E
		ORG		058CH

		//;1.C: 538: IAPWrite(0x09,((CH3_remotekey[0]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//058C 	1283
		LDR 	4EH,0 			//058D 	084E
		STR 	76H 			//058E 	01F6
		LDWI 	9H 			//058F 	2A09
		LCALL 	68EH 			//0590 	368E

		//;1.C: 539: IAPWrite(0x0A,((CH3_remotekey[0]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//0591 	1283
		LDR 	4FH,0 			//0592 	084F
		STR 	76H 			//0593 	01F6
		ORG		0594H
		LDWI 	AH 			//0594 	2A0A
		LCALL 	68EH 			//0595 	368E

		//;1.C: 541: IAPWrite(0x14,((CH3_remotekey[1]&0x000000FF)>>0));
		BCR 	STATUS,5 		//0596 	1283
		LDR 	51H,0 			//0597 	0851
		STR 	76H 			//0598 	01F6
		LDWI 	14H 			//0599 	2A14
		LCALL 	68EH 			//059A 	368E

		//;1.C: 542: IAPWrite(0x15,((CH3_remotekey[1]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//059B 	1283
		ORG		059CH
		LDR 	52H,0 			//059C 	0852
		STR 	76H 			//059D 	01F6
		LDWI 	15H 			//059E 	2A15
		LCALL 	68EH 			//059F 	368E

		//;1.C: 543: IAPWrite(0x16,((CH3_remotekey[1]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//05A0 	1283
		LDR 	53H,0 			//05A1 	0853
		STR 	76H 			//05A2 	01F6
		LDWI 	16H 			//05A3 	2A16
		ORG		05A4H
		LCALL 	68EH 			//05A4 	368E

		//;1.C: 545: IAPWrite(0x20,((CH3_remotekey[2]&0x000000FF)>>0));
		BCR 	STATUS,5 		//05A5 	1283
		LDR 	55H,0 			//05A6 	0855
		STR 	76H 			//05A7 	01F6
		LDWI 	20H 			//05A8 	2A20
		LCALL 	68EH 			//05A9 	368E

		//;1.C: 546: IAPWrite(0x21,((CH3_remotekey[2]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//05AA 	1283
		LDR 	56H,0 			//05AB 	0856
		ORG		05ACH
		STR 	76H 			//05AC 	01F6
		LDWI 	21H 			//05AD 	2A21
		LCALL 	68EH 			//05AE 	368E

		//;1.C: 547: IAPWrite(0x22,((CH3_remotekey[2]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//05AF 	1283
		LDR 	57H,0 			//05B0 	0857
		STR 	76H 			//05B1 	01F6
		LDWI 	22H 			//05B2 	2A22
		LCALL 	68EH 			//05B3 	368E
		ORG		05B4H

		//;1.C: 549: IAPWrite(0x2C,((CH3_remotekey[3]&0x000000FF)>>0));
		BCR 	STATUS,5 		//05B4 	1283
		LDR 	59H,0 			//05B5 	0859
		STR 	76H 			//05B6 	01F6
		LDWI 	2CH 			//05B7 	2A2C
		LCALL 	68EH 			//05B8 	368E

		//;1.C: 550: IAPWrite(0x2D,((CH3_remotekey[3]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//05B9 	1283
		LDR 	5AH,0 			//05BA 	085A
		STR 	76H 			//05BB 	01F6
		ORG		05BCH
		LDWI 	2DH 			//05BC 	2A2D
		LCALL 	68EH 			//05BD 	368E

		//;1.C: 551: IAPWrite(0x2E,((CH3_remotekey[3]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//05BE 	1283
		LDR 	5BH,0 			//05BF 	085B
		STR 	76H 			//05C0 	01F6
		LDWI 	2EH 			//05C1 	2A2E
		LCALL 	68EH 			//05C2 	368E

		//;1.C: 553: IAPWrite(0x32,CH3_remotekey_num);
		BCR 	STATUS,5 		//05C3 	1283
		ORG		05C4H
		LDR 	69H,0 			//05C4 	0869
		STR 	76H 			//05C5 	01F6
		LDWI 	32H 			//05C6 	2A32
		LJUMP 	68EH 			//05C7 	3E8E

		//;1.C: 518: IAPWrite(0x04,((CH2_remotekey[0]&0x000000FF)>>0));
		LDR 	3DH,0 			//05C8 	083D
		STR 	76H 			//05C9 	01F6
		LDWI 	4H 			//05CA 	2A04
		LCALL 	68EH 			//05CB 	368E
		ORG		05CCH

		//;1.C: 519: IAPWrite(0x05,((CH2_remotekey[0]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//05CC 	1283
		LDR 	3EH,0 			//05CD 	083E
		STR 	76H 			//05CE 	01F6
		LDWI 	5H 			//05CF 	2A05
		LCALL 	68EH 			//05D0 	368E

		//;1.C: 520: IAPWrite(0x06,((CH2_remotekey[0]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//05D1 	1283
		LDR 	3FH,0 			//05D2 	083F
		STR 	76H 			//05D3 	01F6
		ORG		05D4H
		LDWI 	6H 			//05D4 	2A06
		LCALL 	68EH 			//05D5 	368E

		//;1.C: 522: IAPWrite(0x10,((CH2_remotekey[1]&0x000000FF)>>0));
		BCR 	STATUS,5 		//05D6 	1283
		LDR 	41H,0 			//05D7 	0841
		STR 	76H 			//05D8 	01F6
		LDWI 	10H 			//05D9 	2A10
		LCALL 	68EH 			//05DA 	368E

		//;1.C: 523: IAPWrite(0x11,((CH2_remotekey[1]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//05DB 	1283
		ORG		05DCH
		LDR 	42H,0 			//05DC 	0842
		STR 	76H 			//05DD 	01F6
		LDWI 	11H 			//05DE 	2A11
		LCALL 	68EH 			//05DF 	368E

		//;1.C: 524: IAPWrite(0x12,((CH2_remotekey[1]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//05E0 	1283
		LDR 	43H,0 			//05E1 	0843
		STR 	76H 			//05E2 	01F6
		LDWI 	12H 			//05E3 	2A12
		ORG		05E4H
		LCALL 	68EH 			//05E4 	368E

		//;1.C: 526: IAPWrite(0x1C,((CH2_remotekey[2]&0x000000FF)>>0));
		BCR 	STATUS,5 		//05E5 	1283
		LDR 	45H,0 			//05E6 	0845
		STR 	76H 			//05E7 	01F6
		LDWI 	1CH 			//05E8 	2A1C
		LCALL 	68EH 			//05E9 	368E

		//;1.C: 527: IAPWrite(0x1D,((CH2_remotekey[2]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//05EA 	1283
		LDR 	46H,0 			//05EB 	0846
		ORG		05ECH
		STR 	76H 			//05EC 	01F6
		LDWI 	1DH 			//05ED 	2A1D
		LCALL 	68EH 			//05EE 	368E

		//;1.C: 528: IAPWrite(0x1E,((CH2_remotekey[2]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//05EF 	1283
		LDR 	47H,0 			//05F0 	0847
		STR 	76H 			//05F1 	01F6
		LDWI 	1EH 			//05F2 	2A1E
		LCALL 	68EH 			//05F3 	368E
		ORG		05F4H

		//;1.C: 530: IAPWrite(0x28,((CH2_remotekey[3]&0x000000FF)>>0));
		BCR 	STATUS,5 		//05F4 	1283
		LDR 	49H,0 			//05F5 	0849
		STR 	76H 			//05F6 	01F6
		LDWI 	28H 			//05F7 	2A28
		LCALL 	68EH 			//05F8 	368E

		//;1.C: 531: IAPWrite(0x29,((CH2_remotekey[3]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//05F9 	1283
		LDR 	4AH,0 			//05FA 	084A
		STR 	76H 			//05FB 	01F6
		ORG		05FCH
		LDWI 	29H 			//05FC 	2A29
		LCALL 	68EH 			//05FD 	368E

		//;1.C: 532: IAPWrite(0x2A,((CH2_remotekey[3]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//05FE 	1283
		LDR 	4BH,0 			//05FF 	084B
		STR 	76H 			//0600 	01F6
		LDWI 	2AH 			//0601 	2A2A
		LCALL 	68EH 			//0602 	368E

		//;1.C: 534: IAPWrite(0x31,CH2_remotekey_num);
		BCR 	STATUS,5 		//0603 	1283
		ORG		0604H
		LDR 	68H,0 			//0604 	0868
		STR 	76H 			//0605 	01F6
		LDWI 	31H 			//0606 	2A31
		LJUMP 	68EH 			//0607 	3E8E

		//;1.C: 499: IAPWrite(0x00,((CH1_remotekey[0]&0x000000FF)>>0));
		LDR 	2DH,0 			//0608 	082D
		STR 	76H 			//0609 	01F6
		LDWI 	0H 			//060A 	2A00
		LCALL 	68EH 			//060B 	368E
		ORG		060CH

		//;1.C: 500: IAPWrite(0x01,((CH1_remotekey[0]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//060C 	1283
		LDR 	2EH,0 			//060D 	082E
		STR 	76H 			//060E 	01F6
		LDWI 	1H 			//060F 	2A01
		LCALL 	68EH 			//0610 	368E

		//;1.C: 501: IAPWrite(0x02,((CH1_remotekey[0]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//0611 	1283
		LDR 	2FH,0 			//0612 	082F
		STR 	76H 			//0613 	01F6
		ORG		0614H
		LDWI 	2H 			//0614 	2A02
		LCALL 	68EH 			//0615 	368E

		//;1.C: 503: IAPWrite(0x0C,((CH1_remotekey[1]&0x000000FF)>>0));
		BCR 	STATUS,5 		//0616 	1283
		LDR 	31H,0 			//0617 	0831
		STR 	76H 			//0618 	01F6
		LDWI 	CH 			//0619 	2A0C
		LCALL 	68EH 			//061A 	368E

		//;1.C: 504: IAPWrite(0x0D,((CH1_remotekey[1]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//061B 	1283
		ORG		061CH
		LDR 	32H,0 			//061C 	0832
		STR 	76H 			//061D 	01F6
		LDWI 	DH 			//061E 	2A0D
		LCALL 	68EH 			//061F 	368E

		//;1.C: 505: IAPWrite(0x0E,((CH1_remotekey[1]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//0620 	1283
		LDR 	33H,0 			//0621 	0833
		STR 	76H 			//0622 	01F6
		LDWI 	EH 			//0623 	2A0E
		ORG		0624H
		LCALL 	68EH 			//0624 	368E

		//;1.C: 507: IAPWrite(0x18,((CH1_remotekey[2]&0x000000FF)>>0));
		BCR 	STATUS,5 		//0625 	1283
		LDR 	35H,0 			//0626 	0835
		STR 	76H 			//0627 	01F6
		LDWI 	18H 			//0628 	2A18
		LCALL 	68EH 			//0629 	368E

		//;1.C: 508: IAPWrite(0x19,((CH1_remotekey[2]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//062A 	1283
		LDR 	36H,0 			//062B 	0836
		ORG		062CH
		STR 	76H 			//062C 	01F6
		LDWI 	19H 			//062D 	2A19
		LCALL 	68EH 			//062E 	368E

		//;1.C: 509: IAPWrite(0x1A,((CH1_remotekey[2]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//062F 	1283
		LDR 	37H,0 			//0630 	0837
		STR 	76H 			//0631 	01F6
		LDWI 	1AH 			//0632 	2A1A
		LCALL 	68EH 			//0633 	368E
		ORG		0634H

		//;1.C: 511: IAPWrite(0x24,((CH1_remotekey[3]&0x000000FF)>>0));
		BCR 	STATUS,5 		//0634 	1283
		LDR 	39H,0 			//0635 	0839
		STR 	76H 			//0636 	01F6
		LDWI 	24H 			//0637 	2A24
		LCALL 	68EH 			//0638 	368E

		//;1.C: 512: IAPWrite(0x25,((CH1_remotekey[3]&0x0000FF00)>>8));
		BCR 	STATUS,5 		//0639 	1283
		LDR 	3AH,0 			//063A 	083A
		STR 	76H 			//063B 	01F6
		ORG		063CH
		LDWI 	25H 			//063C 	2A25
		LCALL 	68EH 			//063D 	368E

		//;1.C: 513: IAPWrite(0x26,((CH1_remotekey[3]&0x00FF0000)>>16));
		BCR 	STATUS,5 		//063E 	1283
		LDR 	3BH,0 			//063F 	083B
		STR 	76H 			//0640 	01F6
		LDWI 	26H 			//0641 	2A26
		LCALL 	68EH 			//0642 	368E

		//;1.C: 515: IAPWrite(0x30,CH1_remotekey_num);
		BCR 	STATUS,5 		//0643 	1283
		ORG		0644H
		LDR 	67H,0 			//0644 	0867
		STR 	76H 			//0645 	01F6
		LDWI 	30H 			//0646 	2A30
		LJUMP 	68EH 			//0647 	3E8E

		//;1.C: 419: OSCCON = 0B01100001;
		LDWI 	61H 			//0648 	2A61
		BSR 	STATUS,5 		//0649 	1A83
		STR 	FH 			//064A 	018F

		//;1.C: 424: INTCON = 0;
		CLRR 	INTCON 			//064B 	010B
		ORG		064CH

		//;1.C: 426: PORTA = 0B00000000;
		BCR 	STATUS,5 		//064C 	1283
		CLRR 	5H 			//064D 	0105

		//;1.C: 427: TRISA = 0B00010111;
		LDWI 	17H 			//064E 	2A17
		BSR 	STATUS,5 		//064F 	1A83
		STR 	5H 			//0650 	0185

		//;1.C: 428: WPUA = 0B00000000;
		CLRR 	15H 			//0651 	0115

		//;1.C: 429: PSRCA = 0B11111111;
		LDWI 	FFH 			//0652 	2AFF
		STR 	8H 			//0653 	0188
		ORG		0654H

		//;1.C: 430: PSINKA = 0B11111111;
		STR 	17H 			//0654 	0197

		//;1.C: 432: PORTC = 0B00000000;
		BCR 	STATUS,5 		//0655 	1283
		CLRR 	7H 			//0656 	0107

		//;1.C: 433: TRISC = 0B11110000;
		LDWI 	F0H 			//0657 	2AF0
		BSR 	STATUS,5 		//0658 	1A83
		STR 	7H 			//0659 	0187

		//;1.C: 434: WPUC = 0B00000000;
		CLRR 	13H 			//065A 	0113

		//;1.C: 435: PSRCC = 0B11111111;
		LDWI 	FFH 			//065B 	2AFF
		ORG		065CH
		STR 	14H 			//065C 	0194

		//;1.C: 436: PSINKC = 0B11111111;
		STR 	1FH 			//065D 	019F

		//;1.C: 438: OPTION = 0B00001000;
		LDWI 	8H 			//065E 	2A08
		STR 	1H 			//065F 	0181
		RET		 					//0660 	0004
		CLRR 	7AH 			//0661 	017A
		CLRR 	7BH 			//0662 	017B
		BTSS 	76H,0 			//0663 	1C76
		ORG		0664H
		LJUMP 	66BH 			//0664 	3E6B
		LDR 	78H,0 			//0665 	0878
		ADDWR 	7AH,1 			//0666 	0BFA
		BTSC 	STATUS,0 		//0667 	1403
		INCR	7BH,1 			//0668 	09FB
		LDR 	79H,0 			//0669 	0879
		ADDWR 	7BH,1 			//066A 	0BFB
		BCR 	STATUS,0 		//066B 	1003
		ORG		066CH
		RLR 	78H,1 			//066C 	05F8
		RLR 	79H,1 			//066D 	05F9
		BCR 	STATUS,0 		//066E 	1003
		RRR	77H,1 			//066F 	06F7
		RRR	76H,1 			//0670 	06F6
		LDR 	77H,0 			//0671 	0877
		IORWR 	76H,0 			//0672 	0376
		BTSS 	STATUS,2 		//0673 	1D03
		ORG		0674H
		LJUMP 	663H 			//0674 	3E63
		LDR 	7BH,0 			//0675 	087B
		STR 	77H 			//0676 	01F7
		LDR 	7AH,0 			//0677 	087A
		STR 	76H 			//0678 	01F6
		RET		 					//0679 	0004

		//;1.C: 782: OSC_INIT();
		LCALL 	648H 			//067A 	3648

		//;1.C: 783: TIMER0_INITIAL();
		LCALL 	6C2H 			//067B 	36C2
		ORG		067CH

		//;1.C: 784: TIMER2_INITIAL();
		LCALL 	6A1H 			//067C 	36A1

		//;1.C: 785: INT_INITIAL();
		LCALL 	6D6H 			//067D 	36D6

		//;1.C: 786: EEPROM_Read();
		LCALL 	546H 			//067E 	3546

		//;1.C: 787: WDT_INITIAL();
		LCALL 	6E3H 			//067F 	36E3

		//;1.C: 788: PC0 = 1;
		BSR 	7H,0 			//0680 	1807

		//;1.C: 789: PA7 = 1;
		BSR 	5H,7 			//0681 	1B85

		//;1.C: 790: PA6 = 1;
		BSR 	5H,6 			//0682 	1B05

		//;1.C: 791: PA5 = 1;
		BSR 	5H,5 			//0683 	1A85
		ORG		0684H

		//;1.C: 793: PA3 = 0;
		BCR 	5H,3 			//0684 	1185

		//;1.C: 794: FLAGs &= ~0x08;
		BCR 	72H,3 			//0685 	11F2

		//;1.C: 795: EX_INT_FallingEdge();
		LCALL 	6E8H 			//0686 	36E8

		//;1.C: 796: INTE =1;
		BSR 	INTCON,4 		//0687 	1A0B

		//;1.C: 797: TMR2ON =1;
		BCR 	STATUS,5 		//0688 	1283
		BSR 	12H,2 			//0689 	1912

		//;1.C: 799: PEIE = 1;
		BSR 	INTCON,6 		//068A 	1B0B

		//;1.C: 800: GIE = 1;
		BSR 	INTCON,7 		//068B 	1B8B
		ORG		068CH
		CLRWDT	 			//068C 	0001
		LJUMP 	68CH 			//068D 	3E8C
		STR 	77H 			//068E 	01F7

		//;1.C: 488: GIE = 0;
		BCR 	INTCON,7 		//068F 	138B

		//;1.C: 489: while(GIE);
		BTSC 	INTCON,7 		//0690 	178B
		LJUMP 	690H 			//0691 	3E90

		//;1.C: 490: EEADR = EEAddr;
		LDR 	77H,0 			//0692 	0877
		BSR 	STATUS,5 		//0693 	1A83
		ORG		0694H
		STR 	1BH 			//0694 	019B

		//;1.C: 491: EEDAT = Data;
		LDR 	76H,0 			//0695 	0876
		STR 	1AH 			//0696 	019A
		LDWI 	34H 			//0697 	2A34

		//;1.C: 492: EEIF = 0;
		BCR 	STATUS,5 		//0698 	1283
		BCR 	CH,7 			//0699 	138C

		//;1.C: 493: EECON1 |= 0x34;
		BSR 	STATUS,5 		//069A 	1A83
		IORWR 	1CH,1 			//069B 	039C
		ORG		069CH

		//;1.C: 494: WR = 1;
		BSR 	1DH,0 			//069C 	181D

		//;1.C: 495: while(WR);
		BTSC 	1DH,0 			//069D 	141D
		LJUMP 	69DH 			//069E 	3E9D

		//;1.C: 496: GIE = 1;
		BSR 	INTCON,7 		//069F 	1B8B
		RET		 					//06A0 	0004

		//;1.C: 457: T2CON0 = 0B00000001;
		LDWI 	1H 			//06A1 	2A01
		STR 	12H 			//06A2 	0192

		//;1.C: 463: T2CON1 = 0B00000000;
		BSR 	STATUS,5 		//06A3 	1A83
		ORG		06A4H
		CLRR 	1EH 			//06A4 	011E

		//;1.C: 468: TMR2H = (53)/256;
		BCR 	STATUS,5 		//06A5 	1283
		CLRR 	13H 			//06A6 	0113

		//;1.C: 469: TMR2L = (53)%256;
		LDWI 	35H 			//06A7 	2A35
		STR 	11H 			//06A8 	0191

		//;1.C: 472: PR2H = (53)/256;
		BSR 	STATUS,5 		//06A9 	1A83
		CLRR 	12H 			//06AA 	0112

		//;1.C: 473: PR2L = (53)%256;
		STR 	11H 			//06AB 	0191
		ORG		06ACH

		//;1.C: 475: TMR2IF = 0;
		BCR 	STATUS,5 		//06AC 	1283
		BCR 	CH,1 			//06AD 	108C

		//;1.C: 476: TMR2IE = 1;
		BSR 	STATUS,5 		//06AE 	1A83
		BSR 	CH,1 			//06AF 	188C

		//;1.C: 478: TMR2ON =0;
		BCR 	STATUS,5 		//06B0 	1283
		BCR 	12H,2 			//06B1 	1112
		RET		 					//06B2 	0004
		LDWI 	70H 			//06B3 	2A70
		ORG		06B4H
		STR 	FSR 			//06B4 	0184
		LDWI 	76H 			//06B5 	2A76
		LCALL 	6CEH 			//06B6 	36CE
		LDWI 	20H 			//06B7 	2A20
		BCR 	STATUS,7 		//06B8 	1383
		STR 	FSR 			//06B9 	0184
		LDWI 	5DH 			//06BA 	2A5D
		LCALL 	6CEH 			//06BB 	36CE
		ORG		06BCH
		LDWI 	A0H 			//06BC 	2AA0
		STR 	FSR 			//06BD 	0184
		LDWI 	AFH 			//06BE 	2AAF
		LCALL 	6CEH 			//06BF 	36CE
		CLRR 	STATUS 			//06C0 	0103
		LJUMP 	67AH 			//06C1 	3E7A
		LDWI 	F8H 			//06C2 	2AF8

		//;1.C: 447: T0CS = 0;
		BCR 	1H,5 			//06C3 	1281
		ORG		06C4H

		//;1.C: 448: PSA = 0;
		BCR 	1H,3 			//06C4 	1181

		//;1.C: 449: OPTION &= 0xF8;
		ANDWR 	1H,1 			//06C5 	0281

		//;1.C: 450: OPTION |= 0x06;
		LDWI 	6H 			//06C6 	2A06
		IORWR 	1H,1 			//06C7 	0381

		//;1.C: 452: TMR0 = 5;
		LDWI 	5H 			//06C8 	2A05
		BCR 	STATUS,5 		//06C9 	1283
		STR 	1H 			//06CA 	0181

		//;1.C: 453: T0IE = 1;
		BSR 	INTCON,5 		//06CB 	1A8B
		ORG		06CCH

		//;1.C: 454: T0IF = 0;
		BCR 	INTCON,2 		//06CC 	110B
		RET		 					//06CD 	0004
		CLRWDT	 			//06CE 	0001
		CLRR 	INDF 			//06CF 	0100
		INCR	FSR,1 			//06D0 	0984
		XORWR 	FSR,0 			//06D1 	0404
		BTSC 	STATUS,2 		//06D2 	1503
		RETW 	0H 			//06D3 	2100
		ORG		06D4H
		XORWR 	FSR,0 			//06D4 	0404
		LJUMP 	6CFH 			//06D5 	3ECF

		//;1.C: 403: TRISA2 =1;
		BSR 	STATUS,5 		//06D6 	1A83
		BSR 	5H,2 			//06D7 	1905

		//;1.C: 404: IOCA2 =0;
		BCR 	16H,2 			//06D8 	1116

		//;1.C: 405: EX_INT_FallingEdge();
		LCALL 	6E8H 			//06D9 	36E8

		//;1.C: 406: INTF =0;
		BCR 	INTCON,1 		//06DA 	108B

		//;1.C: 408: INTE =0;
		BCR 	INTCON,4 		//06DB 	120B
		ORG		06DCH
		RET		 					//06DC 	0004
		STR 	2FH 			//06DD 	01AF

		//;1.C: 481: unsigned char ReEEPROMread;
		//;1.C: 482: EEADR = EEAddr;
		STR 	1BH 			//06DE 	019B

		//;1.C: 483: RD = 1;
		BSR 	1CH,0 			//06DF 	181C

		//;1.C: 484: ReEEPROMread = EEDAT;
		LDR 	1AH,0 			//06E0 	081A
		STR 	30H 			//06E1 	01B0

		//;1.C: 485: return ReEEPROMread;
		RET		 					//06E2 	0004
		CLRWDT	 			//06E3 	0001
		ORG		06E4H

		//;1.C: 443: WDTCON = 0B00010110;
		LDWI 	16H 			//06E4 	2A16
		BCR 	STATUS,5 		//06E5 	1283
		STR 	18H 			//06E6 	0198
		RET		 					//06E7 	0004

		//;1.C: 415: INTEDG =0;
		BSR 	STATUS,5 		//06E8 	1A83
		BCR 	1H,6 			//06E9 	1301

		//;1.C: 416: FLAGs &= ~0x01;
		BCR 	72H,0 			//06EA 	1072
		RET		 					//06EB 	0004
		ORG		06ECH
		LJUMP 	2BCH 			//06EC 	3ABC
		LJUMP 	2C2H 			//06ED 	3AC2
		LJUMP 	2CDH 			//06EE 	3ACD
		LJUMP 	2D8H 			//06EF 	3AD8

		//;1.C: 415: INTEDG =0;
		BSR 	STATUS,5 		//06F0 	1A83
		BCR 	1H,6 			//06F1 	1301

		//;1.C: 416: FLAGs &= ~0x01;
		BCR 	72H,0 			//06F2 	1072
		RET		 					//06F3 	0004
		ORG		06F4H

		//;1.C: 411: INTEDG =1;
		BSR 	1H,6 			//06F4 	1B01

		//;1.C: 412: FLAGs |= 0x01;
		BSR 	72H,0 			//06F5 	1872
		RET		 					//06F6 	0004
		RET		 					//06F7 	0004
			END
