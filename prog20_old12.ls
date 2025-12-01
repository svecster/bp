/PROG  PROG20_OLD12
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Vyroba 12 <370m";
PROG_SIZE	= 6789;
CREATE		= DATE 17-09-15  TIME 20:06:44;
MODIFIED	= DATE 17-09-15  TIME 20:06:44;
FILE_NAME	= PROG20;
VERSION		= 0;
LINE_COUNT	= 262;
MEMORY_SIZE	= 7277;
PROTECT		= READ_WRITE;
TCD:  STACK_SIZE	= 0,
      TASK_PRIORITY	= 50,
      TIME_SLICE	= 0,
      BUSY_LAMP_OFF	= 0,
      ABORT_REQUEST	= 0,
      PAUSE_REQUEST	= 0;
DEFAULT_GROUP	= 1,*,*,*,*;
CONTROL_CODE	= 00000000 00000000;
/APPL
/MN
   1:  !HOME ? ;
   2:  WAIT (DO[7] AND !DO[13] AND !DI[15] AND DI[16])    ;
   3:J PR[2] 20% FINE    ;
   4:   ;
   5:  CALL INIT    ;
   6:   ;
   7:  UFRAME_NUM=1 ;
   8:  UTOOL_NUM=4 ;
   9:J P[1] 100% CNT100    ;
  10:   ;
  11:  !Novy cyklus ;
  12:  LBL[100] ;
  13:   ;
  14:  UFRAME_NUM=1 ;
  15:  UTOOL_NUM=4 ;
  16:J P[2] 100% CNT50    ;
  17:   ;
  18:   ;
  19:  !Delka trubky OK? ;
  20:  LBL[1] ;
  21:  R[10]=GI[2]    ;
  22:  IF (R[10]<150 OR R[10]>300),JMP LBL[1] ;
  23:   ;
  24:  !Kontrola neni dil ;
  25:  WAIT (!DI[50] AND !DI[52])    ;
  26:  DO[49]=ON ;
  27:  DO[51]=ON ;
  28:  WAIT (DI[49] AND DI[51])    ;
  29:   ;
  30:  !***************** ;
  31:  !Vstupni zasobnik ;
  32:  !***************** ;
  33:   ;
  34:  !Takt puls ;
  35:  DO[58]=PULSE,0.5sec ;
  36:   ;
  37:  WAIT (DI[57] OR DI[53])    ;
  38:  IF (DI[53]),JMP LBL[20] ;
  39:   ;
  40:  GO[3]=1 ;
  41:   ;
  42:  PR[10,1]=R[10]+70    ;
  43:  PR[11,1]=R[10]+5.5    ;
  44:  PR[12,1]=R[10]+50    ;
  45:   ;
  46:  UFRAME_NUM=1 ;
  47:  UTOOL_NUM=4 ;
  48:J PR[10] 100% CNT10 TB   0.00sec,DO[110]=ON    ;
  49:L PR[11] 400mm/sec FINE TB    .05sec,DO[57]=ON    ;
  50:   ;
  51:  DO[51]=OFF ;
  52:  WAIT (DI[52])    ;
  53:   ;
  54:L PR[12] 1000mm/sec CNT50 TB   0.00sec,DO[110]=OFF    ;
  55:  LBL[20] ;
  56:J P[3] 100% CNT80 TB   0.00sec,DO[57]=OFF    ;
  57:   ;
  58:   ;
  59:  !TOOL_OFFSET pro UTOOL 1 ;
  60:  PR[21,1]=0    ;
  61:  PR[21,2]=0    ;
  62:  PR[21,3]=184-R[10]    ;
  63:  PR[21,4]=0    ;
  64:  PR[21,5]=0    ;
  65:  PR[21,6]=0    ;
  66:  !TOOL_OFFSET pro UTOOL 2 ;
  67:  PR[22]=PR[21]    ;
  68:   ;
  69:  !Upinac 1 Pripraven? ;
  70:  WAIT (DI[61] AND DI[49] AND !DI[50])    ;
  71:   ;
  72:  !***************** ;
  73:  !Lis 1 ;
  74:  !***************** ;
  75:   ;
  76:  GO[3]=2 ;
  77:   ;
  78:  !Vyjmuti trubky LIS 1 ;
  79:   ;
  80:  UFRAME_NUM=2 ;
  81:  UTOOL_NUM=3 ;
  82:  //J P[4] 100% FINE    ;
  83:J P[5] 100% CNT100    ;
  84:J P[6] 100% CNT50 Tool_Offset,PR[21]    ;
  85:J P[7] 100% CNT10 Tool_Offset,PR[21] TB    .05sec,DO[111]=ON    ;
  86:L P[8] 400mm/sec FINE Tool_Offset,PR[21]    ;
  87:   ;
  88:  IF (DI[62] AND !DI[64]),JMP LBL[21] ;
  89:  DO[49]=OFF ;
  90:  WAIT (DI[50])    ;
  91:  DO[62]=ON ;
  92:  WAIT (DI[62] AND !DI[64])    ;
  93:  DO[62]=OFF ;
  94:  LBL[21] ;
  95:   ;
  96:L P[9] 200mm/sec FINE Tool_Offset,PR[21] TB   0.00sec,DO[63]=ON    ;
  97:L P[10] 2000mm/sec CNT50 Tool_Offset,PR[21] TB    .05sec,DO[111]=OFF    ;
  98:   ;
  99:  !Vlozeni trubky LIS 1 ;
 100:  WAIT (DI[62] AND !DI[64])    ;
 101:   ;
 102:  UFRAME_NUM=2 ;
 103:  UTOOL_NUM=4 ;
 104:J P[11] 100% CNT20 Tool_Offset,PR[22]    ;
 105:L P[12] 2000mm/sec CNT50 Tool_Offset,PR[22] TB    .05sec,DO[112]=ON    ;
 106:L P[13] 800mm/sec CNT50 Tool_Offset,PR[22]    ;
 107:L P[14] 50mm/sec FINE Tool_Offset,PR[22]    ;
 108:   ;
 109:  IF (!DI[52]),JMP LBL[22] ;
 110:  !Kontakt? ;
 111:  WAIT (DI[63])    ;
 112:  DO[64]=ON ;
 113:  WAIT (DI[64] AND !DI[62])    ;
 114:  DO[51]=ON ;
 115:   ;
 116:  //WAIT (DI[51])    ;
 117:   ;
 118:  DO[64]=OFF ;
 119:  LBL[22] ;
 120:  DO[61]=ON ;
 121:  WAIT (!DI[61])    ;
 122:  DO[61]=OFF ;
 123:   ;
 124:L P[15] 2000mm/sec CNT50 Tool_Offset,PR[22]    ;
 125:J P[16] 100% CNT80 Tool_Offset,PR[22] TB   0.00sec,DO[112]=OFF    ;
 126:   ;
 127:  !***************** ;
 128:  !Shawer 2 ;
 129:  !***************** ;
 130:   ;
 131:  GO[3]=3 ;
 132:   ;
 133:  !Vyjmuti trubky SHAWER 2 ;
 134:   ;
 135:  UFRAME_NUM=3 ;
 136:  UTOOL_NUM=4 ;
 137:  //J P[17] 100% FINE    ;
 138:J P[18] 100% CNT50 Tool_Offset,PR[21]    ;
 139:J P[19] 100% CNT10 Tool_Offset,PR[21] TB    .05sec,DO[113]=ON    ;
 140:L P[20] 1000mm/sec FINE Tool_Offset,PR[21]    ;
 141:   ;
 142:  IF (DI[66] AND !DI[68]),JMP LBL[31] ;
 143:  DO[51]=OFF ;
 144:  WAIT (DI[52])    ;
 145:  DO[66]=ON ;
 146:  WAIT (DI[66] AND !DI[68])    ;
 147:  DO[66]=OFF ;
 148:  LBL[31] ;
 149:   ;
 150:L P[21] 500mm/sec FINE Tool_Offset,PR[21] TB   0.00sec,DO[67]=ON    ;
 151:L P[22] 2000mm/sec CNT50 Tool_Offset,PR[21] TB    .05sec,DO[113]=OFF    ;
 152:   ;
 153:  !Vlozeni trubky SHAWER 2 ;
 154:  WAIT (DI[66] AND !DI[68])    ;
 155:   ;
 156:  !Korekce st.2 B ;
 157:  WAIT R[15]>=(-2) AND R[15]<=2    ;
 158:  PR[22,3]=PR[21,3]+R[15]    ;
 159:   ;
 160:  UFRAME_NUM=3 ;
 161:  UTOOL_NUM=3 ;
 162:  //J P[23] 100% FINE    ;
 163:J P[24] 100% CNT10 Tool_Offset,PR[22]    ;
 164:L P[25] 1500mm/sec CNT20 Tool_Offset,PR[22] TB    .05sec,DO[114]=ON    ;
 165:L P[26] 800mm/sec CNT50 Tool_Offset,PR[22]    ;
 166:L P[27] 50mm/sec FINE Tool_Offset,PR[22]    ;
 167:   ;
 168:  IF (!DI[50]),JMP LBL[32] ;
 169:  !Kontakt? ;
 170:  WAIT (DI[67])    ;
 171:  DO[68]=ON ;
 172:  WAIT (DI[68] AND !DI[66])    ;
 173:  DO[49]=ON ;
 174:   ;
 175:  //WAIT (DI[49])    ;
 176:   ;
 177:  DO[68]=OFF ;
 178:  LBL[32] ;
 179:  DO[65]=ON ;
 180:  WAIT (!DI[65])    ;
 181:  DO[65]=OFF ;
 182:   ;
 183:L P[28] 1500mm/sec CNT50 Tool_Offset,PR[22]    ;
 184:J P[29] 100% CNT80 Tool_Offset,PR[22] TB    .05sec,DO[114]=OFF    ;
 185:   ;
 186:   ;
 187:  !***************** ;
 188:  !Freza 1 ;
 189:  !***************** ;
 190:   ;
 191:  GO[3]=4 ;
 192:   ;
 193:  UFRAME_NUM=4 ;
 194:  UTOOL_NUM=4 ;
 195:   ;
 196:  !Korekce st.3 B ;
 197:  WAIT R[16]>=(-2) AND R[16]<=2    ;
 198:  PR[21,3]=184-R[10]+R[16]    ;
 199:   ;
 200:  //J P[30] 100% FINE    ;
 201:J P[31] 100% CNT100    ;
 202:J P[32] 100% CNT100    ;
 203:   ;
 204:  IF ((!DI[52] AND DI[51]) OR !DI[69]),JMP LBL[41] ;
 205:   ;
 206:J P[33] 100% CNT30 TB    .05sec,DO[115]=ON Tool_Offset,PR[21]    ;
 207:   ;
 208:L P[34] 300mm/sec CNT10 Tool_Offset,PR[21]    ;
 209:L P[35:Freza] 100mm/sec FINE Tool_Offset,PR[21]    ;
 210:   ;
 211:  !Doba frezovani ;
 212:  WAIT R[7] ;
 213:  DO[69]=PULSE,0.2sec ;
 214:   ;
 215:L P[36] 300mm/sec CNT20 Tool_Offset,PR[21]    ;
 216:J P[37] 100% CNT50 TB   0.00sec,DO[115]=OFF Tool_Offset,PR[21]    ;
 217:   ;
 218:  LBL[41] ;
 219:   ;
 220:  !***************** ;
 221:  !Vylozeni skluz ;
 222:  !***************** ;
 223:  GO[3]=5 ;
 224:   ;
 225:  UFRAME_NUM=1 ;
 226:  UTOOL_NUM=4 ;
 227:  //J P[38] 100% FINE    ;
 228:   ;
 229:  !TOOL_OFFSET pro UTOOL 1 ;
 230:  PR[23,1]=0    ;
 231:  PR[23,2]=0    ;
 232:  PR[23,3]=((92-R[10])/2) ;
 233:  PR[23,4]=0    ;
 234:  PR[23,5]=0    ;
 235:  PR[23,6]=0    ;
 236:   ;
 237:   ;
 238:J P[39] 100% CNT100    ;
 239:J P[40] 100% CNT50 Tool_Offset,PR[23] Offset,PR[23]    ;
 240:   ;
 241:J P[41] 100% FINE TB    .05sec,DO[51]=ON Tool_Offset,PR[23]    ;
 242:   ;
 243:  WAIT (DI[51])    ;
 244:  IF (DI[52]),DO[73]=PULSE,0.5sec ;
 245:   ;
 246:L P[42] 200mm/sec CNT50 Tool_Offset,PR[23]    ;
 247:J P[43] 100% CNT100    ;
 248:   ;
 249:  !Konec cyklu ;
 250:  IF (DI[54]),JMP LBL[50] ;
 251:   ;
 252:  //J P[44] 100% FINE    ;
 253:   ;
 254:  JMP LBL[100] ;
 255:   ;
 256:  LBL[50] ;
 257:   ;
 258:  UFRAME_NUM=1 ;
 259:  UTOOL_NUM=4 ;
 260:J P[45] 20% CNT100    ;
 261:  !HOME ;
 262:J PR[2] 20% FINE    ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 4,		CONFIG : 'F U T, 0, 0, 0',
	X =    38.490  mm,	Y =  -127.414  mm,	Z =  1350.863  mm,
	W =    63.834 deg,	P =   -64.706 deg,	R =   -45.826 deg
};
P[2]{
   GP1:
	UF : 1, UT : 4,		CONFIG : 'F U T, 0, 0, 0',
	X =   445.220  mm,	Y =    82.228  mm,	Z =   190.949  mm,
	W =   -88.833 deg,	P =   -65.723 deg,	R =    88.863 deg
};
P[3]{
   GP1:
	UF : 1, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =   240.390  mm,	Y =  -113.311  mm,	Z =   415.565  mm,
	W =   -93.285 deg,	P =   -31.950 deg,	R =    89.011 deg
};
P[4]{
   GP1:
	UF : 2, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X = -1092.013  mm,	Y = -1000.382  mm,	Z =   620.080  mm,
	W =   -22.336 deg,	P =     -.982 deg,	R =  -165.264 deg
};
P[5]{
   GP1:
	UF : 2, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =  -582.279  mm,	Y =  -624.851  mm,	Z =   440.690  mm,
	W =   -48.352 deg,	P =    -3.997 deg,	R =  -132.394 deg
};
P[6]{
   GP1:
	UF : 2, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =  -409.161  mm,	Y =    24.648  mm,	Z =   -34.393  mm,
	W =   -90.003 deg,	P =      .005 deg,	R =   -90.005 deg
};
P[7]{
   GP1:
	UF : 2, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =  -202.535  mm,	Y =    24.649  mm,	Z =   -34.393  mm,
	W =   -90.003 deg,	P =      .005 deg,	R =   -90.005 deg
};
P[8]{
   GP1:
	UF : 2, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =   -64.299  mm,	Y =    23.610  mm,	Z =   -33.460  mm,
	W =   -90.004 deg,	P =      .005 deg,	R =   -90.527 deg
};
P[9]{
   GP1:
	UF : 2, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =   -71.115  mm,	Y =    11.527  mm,	Z =   -34.450  mm,
	W =   -90.010 deg,	P =      .006 deg,	R =   -90.571 deg
};
P[10]{
   GP1:
	UF : 2, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =  -492.684  mm,	Y =    14.929  mm,	Z =   -22.155  mm,
	W =   -90.003 deg,	P =      .005 deg,	R =   -90.006 deg
};
P[11]{
   GP1:
	UF : 2, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =  -493.500  mm,	Y =     9.890  mm,	Z =   -34.393  mm,
	W =   -90.003 deg,	P =      .005 deg,	R =   -90.005 deg
};
P[12]{
   GP1:
	UF : 2, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =  -182.643  mm,	Y =     6.595  mm,	Z =   -33.563  mm,
	W =   -90.003 deg,	P =      .005 deg,	R =   -90.125 deg
};
P[13]{
   GP1:
	UF : 2, UT : 4,		CONFIG : 'N U T, 0, 0, -1',
	X =   -69.496  mm,	Y =    21.869  mm,	Z =   -34.179  mm,
	W =   -90.008 deg,	P =      .007 deg,	R =   -90.919 deg
};
P[14]{
   GP1:
	UF : 2, UT : 4,		CONFIG : 'N U T, 0, 0, -1',
	X =   -63.332  mm,	Y =    24.706  mm,	Z =   -33.578  mm,
	W =   -90.008 deg,	P =      .007 deg,	R =   -90.920 deg
};
P[15]{
   GP1:
	UF : 2, UT : 4,		CONFIG : 'N U T, 0, 0, -1',
	X =  -135.723  mm,	Y =    24.117  mm,	Z =   -33.965  mm,
	W =   -90.008 deg,	P =      .007 deg,	R =   -90.920 deg
};
P[16]{
   GP1:
	UF : 2, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =  -423.857  mm,	Y =    22.119  mm,	Z =   -33.632  mm,
	W =   -90.007 deg,	P =      .007 deg,	R =   -90.126 deg
};
P[17]{
   GP1:
	UF : 3, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X = -1397.181  mm,	Y =  -903.375  mm,	Z =   -31.490  mm,
	W =   -90.238 deg,	P =     -.586 deg,	R =   161.716 deg
};
P[18]{
   GP1:
	UF : 3, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =  -330.261  mm,	Y =    -2.969  mm,	Z =   -16.697  mm,
	W =   -90.582 deg,	P =      .820 deg,	R =   -89.925 deg
};
P[19]{
   GP1:
	UF : 3, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =  -110.128  mm,	Y =    -2.707  mm,	Z =   -16.744  mm,
	W =   -90.582 deg,	P =      .820 deg,	R =   -89.925 deg
};
P[20]{
   GP1:
	UF : 3, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =   -70.929  mm,	Y =    -2.393  mm,	Z =   -16.850  mm,
	W =   -90.567 deg,	P =      .816 deg,	R =   -90.354 deg
};
P[21]{
   GP1:
	UF : 3, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =   -74.350  mm,	Y =   -23.464  mm,	Z =   -16.869  mm,
	W =   -90.547 deg,	P =      .810 deg,	R =   -90.949 deg
};
P[22]{
   GP1:
	UF : 3, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =  -306.693  mm,	Y =   -17.323  mm,	Z =   -23.502  mm,
	W =   -90.188 deg,	P =      .792 deg,	R =   -90.049 deg
};
P[23]{
   GP1:
	UF : 3, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =  -621.947  mm,	Y =  -337.011  mm,	Z =   -26.904  mm,
	W =   -90.793 deg,	P =     -.186 deg,	R =   179.957 deg
};
P[24]{
   GP1:
	UF : 3, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =  -390.000  mm,	Y =   -18.990  mm,	Z =   -17.333  mm,
	W =   -90.324 deg,	P =      .348 deg,	R =   -90.711 deg
};
P[25]{
   GP1:
	UF : 3, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =  -239.169  mm,	Y =   -18.990  mm,	Z =   -17.333  mm,
	W =   -90.324 deg,	P =      .348 deg,	R =   -90.711 deg
};
P[26]{
   GP1:
	UF : 3, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =   -80.704  mm,	Y =    -9.549  mm,	Z =   -17.281  mm,
	W =   -90.324 deg,	P =      .348 deg,	R =   -90.712 deg
};
P[27]{
   GP1:
	UF : 3, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =   -70.628  mm,	Y =    -1.554  mm,	Z =   -17.400  mm,
	W =   -90.324 deg,	P =      .348 deg,	R =   -90.712 deg
};
P[28]{
   GP1:
	UF : 3, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =  -100.930  mm,	Y =    -1.709  mm,	Z =   -17.333  mm,
	W =   -90.324 deg,	P =      .348 deg,	R =   -90.711 deg
};
P[29]{
   GP1:
	UF : 3, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =  -380.000  mm,	Y =    -1.709  mm,	Z =   -17.333  mm,
	W =   -90.324 deg,	P =      .348 deg,	R =   -90.711 deg
};
P[30]{
   GP1:
	UF : 4, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X = -1470.330  mm,	Y =  -391.276  mm,	Z =   148.734  mm,
	W =   -90.519 deg,	P =      .004 deg,	R =  -142.616 deg
};
P[31]{
   GP1:
	UF : 4, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X = -1836.622  mm,	Y =   651.430  mm,	Z =   397.217  mm,
	W =  -111.166 deg,	P =   -38.099 deg,	R =    76.425 deg
};
P[32]{
   GP1:
	UF : 4, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =  -666.388  mm,	Y =   708.391  mm,	Z =   405.973  mm,
	W =   -83.614 deg,	P =   -14.647 deg,	R =   -36.407 deg
};
P[33]{
   GP1:
	UF : 4, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =  -481.831  mm,	Y =    49.137  mm,	Z =    78.407  mm,
	W =   -90.034 deg,	P =      .218 deg,	R =   -89.997 deg
};
P[34]{
   GP1:
	UF : 4, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =  -346.833  mm,	Y =    47.944  mm,	Z =    78.407  mm,
	W =   -90.034 deg,	P =      .218 deg,	R =   -89.997 deg
};
P[35:"Freza"]{
   GP1:
	UF : 4, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =  -301.445  mm,	Y =    48.898  mm,	Z =    78.405  mm,
	W =   -90.034 deg,	P =      .218 deg,	R =   -89.997 deg
};
P[36]{
   GP1:
	UF : 4, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =  -359.140  mm,	Y =    49.138  mm,	Z =    78.405  mm,
	W =   -90.034 deg,	P =      .218 deg,	R =   -89.997 deg
};
P[37]{
   GP1:
	UF : 4, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =  -460.659  mm,	Y =    49.138  mm,	Z =    78.404  mm,
	W =   -90.034 deg,	P =      .218 deg,	R =   -89.997 deg
};
P[38]{
   GP1:
	UF : 1, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =  1096.656  mm,	Y =  -599.371  mm,	Z =   255.934  mm,
	W =  -119.437 deg,	P =   -21.324 deg,	R =   -32.854 deg
};
P[39]{
   GP1:
	UF : 1, UT : 4,		CONFIG : 'N U T, 0, 0, -1',
	X =   860.872  mm,	Y =  -131.084  mm,	Z =   375.491  mm,
	W =  -119.827 deg,	P =   -11.654 deg,	R =   -29.230 deg
};
P[40]{
   GP1:
	UF : 1, UT : 4,		CONFIG : 'N U T, 0, 0, -1',
	X =   887.988  mm,	Y =   264.560  mm,	Z =     1.074  mm,
	W =  -130.366 deg,	P =   -16.067 deg,	R =   -34.858 deg
};
P[41]{
   GP1:
	UF : 1, UT : 4,		CONFIG : 'N U T, 0, 0, -1',
	X =   902.386  mm,	Y =   271.939  mm,	Z =   -87.608  mm,
	W =  -137.435 deg,	P =   -19.299 deg,	R =   -33.341 deg
};
P[42]{
   GP1:
	UF : 1, UT : 4,		CONFIG : 'N U T, 0, 0, -1',
	X =   842.186  mm,	Y =   200.210  mm,	Z =    14.325  mm,
	W =  -135.376 deg,	P =   -19.300 deg,	R =   -33.335 deg
};
P[43]{
   GP1:
	UF : 1, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =   732.498  mm,	Y =   314.475  mm,	Z =   164.764  mm,
	W =   -99.858 deg,	P =    -3.504 deg,	R =    -2.975 deg
};
P[44]{
   GP1:
	UF : 1, UT : 4,		CONFIG : 'F U T, 0, 0, 0',
	X =   445.219  mm,	Y =    82.228  mm,	Z =   190.949  mm,
	W =   -88.833 deg,	P =   -65.723 deg,	R =    88.863 deg
};
P[45]{
   GP1:
	UF : 1, UT : 4,		CONFIG : 'F U T, 0, 0, 0',
	X =    38.498  mm,	Y =  -127.408  mm,	Z =  1350.855  mm,
	W =    63.833 deg,	P =   -64.707 deg,	R =   -45.827 deg
};
/END
