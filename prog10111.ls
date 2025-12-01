/PROG  PROG10111
/ATTR
OWNER		= SHIFT;
COMMENT		= "Vyroba 8.5 <370m";
PROG_SIZE	= 8021;
CREATE		= DATE 25-08-13  TIME 18:45:22;
MODIFIED	= DATE 25-08-13  TIME 18:46:10;
FILE_NAME	= PROG10;
VERSION		= 0;
LINE_COUNT	= 305;
MEMORY_SIZE	= 8465;
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
   2:  WAIT (DO[7] AND !DO[13] AND DI[15] AND !DI[16])    ;
   3:J PR[2] 20% FINE    ;
   4:   ;
   5:  CALL INIT    ;
   6:   ;
   7:  UFRAME_NUM=1 ;
   8:  UTOOL_NUM=2 ;
   9:J P[1] 100% CNT100    ;
  10:   ;
  11:  !Novy cyklus ;
  12:  LBL[100] ;
  13:   ;
  14:  UFRAME_NUM=1 ;
  15:  UTOOL_NUM=2 ;
  16:J P[2] 100% CNT50    ;
  17:   ;
  18:  !Greifer OK? ;
  19:  WAIT (DI[15] AND !DI[16])    ;
  20:   ;
  21:  !Delka trubky OK? ;
  22:  LBL[1] ;
  23:  R[10]=GI[2]    ;
  24:  IF (R[10]<170 OR R[10]>400),JMP LBL[1] ;
  25:   ;
  26:  !Kontrola neni dil ;
  27:  WAIT (!DI[50] AND !DI[52])    ;
  28:  DO[49]=ON ;
  29:  DO[51]=ON ;
  30:  WAIT (DI[49] AND DI[51])    ;
  31:   ;
  32:  !***************** ;
  33:  !Vstupni zasobnik ;
  34:  !***************** ;
  35:   ;
  36:  !Takt puls ;
  37:  DO[58]=PULSE,0.5sec ;
  38:   ;
  39:  WAIT (DI[57] OR DI[53])    ;
  40:  IF (DI[53]),JMP LBL[20] ;
  41:   ;
  42:  GO[3]=1 ;
  43:   ;
  44:  PR[10,1]=R[10]+70    ;
  45:  PR[11,1]=R[10]+0    ;
  46:  PR[12,1]=R[10]+50    ;
  47:   ;
  48:  UFRAME_NUM=1 ;
  49:  UTOOL_NUM=2 ;
  50:J PR[10] 100% CNT10 TB   0.00sec,DO[110]=ON    ;
  51:L PR[11] 600mm/sec FINE TB    .05sec,DO[57]=ON    ;
  52:   ;
  53:  DO[51]=OFF ;
  54:  WAIT (DI[52])    ;
  55:   ;
  56:L PR[12] 1200mm/sec CNT50 TB   0.00sec,DO[110]=OFF    ;
  57:  LBL[20] ;
  58:J P[3] 100% CNT80 TB   0.00sec,DO[57]=OFF    ;
  59:   ;
  60:   ;
  61:  !TOOL_OFFSET pro UTOOL 1 ;
  62:  PR[21,1]=0    ;
  63:  PR[21,2]=0    ;
  64:  PR[21,3]=259-R[10]    ;
  65:  PR[21,4]=0    ;
  66:  PR[21,5]=0    ;
  67:  PR[21,6]=0    ;
  68:  !TOOL_OFFSET pro UTOOL 2 ;
  69:  PR[22]=PR[21]    ;
  70:   ;
  71:  !Upinac 1 Pripraven? ;
  72:  WAIT (DI[49] AND !DI[50])    ;
  73:   ;
  74:  !***************** ;
  75:  !Lis 1 ;
  76:  !***************** ;
  77:   ;
  78:  GO[3]=2 ;
  79:   ;
  80:  !Vyjmuti trubky LIS 1 ;
  81:   ;
  82:  UFRAME_NUM=2 ;
  83:  UTOOL_NUM=1 ;
  84:  //J P[4] 100% FINE    ;
  85:J P[5] 100% CNT100    ;
  86:J P[6] 100% CNT50 Tool_Offset,PR[21]    ;
  87:  WAIT (DI[61])    ;
  88:J P[7] 100% CNT10 Tool_Offset,PR[21] TB    .05sec,DO[111]=ON    ;
  89:L P[8] 1500mm/sec FINE Tool_Offset,PR[21]    ;
  90:   ;
  91:  IF (DI[62] AND !DI[64]),JMP LBL[21] ;
  92:  DO[49]=OFF ;
  93:  WAIT (DI[50])    ;
  94:  DO[62]=ON ;
  95:  WAIT (DI[62] AND !DI[64])    ;
  96:  DO[62]=OFF ;
  97:  LBL[21] ;
  98:   ;
  99:L P[9] 100mm/sec CNT10 Tool_Offset,PR[21] TB   0.00sec,DO[63]=PULSE,1.0sec    ;
 100:L P[10] 500mm/sec CNT50 Tool_Offset,PR[21]    ;
 101:L P[11] 2000mm/sec CNT50 Tool_Offset,PR[21] TB    .05sec,DO[111]=OFF    ;
 102:   ;
 103:  !Vlozeni trubky LIS 1 ;
 104:  WAIT (DI[62] AND !DI[64])    ;
 105:   ;
 106:  UFRAME_NUM=2 ;
 107:  UTOOL_NUM=2 ;
 108:J P[12] 100% CNT20 Tool_Offset,PR[22]    ;
 109:L P[13] 2000mm/sec CNT50 Tool_Offset,PR[22] TB    .05sec,DO[111]=ON    ;
 110:L P[14] 1500mm/sec CNT50 Tool_Offset,PR[22]    ;
 111:L P[15] 200mm/sec FINE Tool_Offset,PR[22]    ;
 112:   ;
 113:  IF (!DI[52]),JMP LBL[22] ;
 114:  !Kontakt? ;
 115:  WAIT (DI[63])    ;
 116:  DO[64]=ON ;
 117:  WAIT (DI[64] AND !DI[62])    ;
 118:  DO[51]=ON ;
 119:  WAIT (DI[51])    ;
 120:  DO[64]=OFF ;
 121:  LBL[22] ;
 122:  DO[61]=ON ;
 123:  WAIT (!DI[61])    ;
 124:  DO[61]=OFF ;
 125:   ;
 126:L P[16] 2000mm/sec CNT50 Tool_Offset,PR[22]    ;
 127:J P[17] 100% CNT80 Tool_Offset,PR[22] TB   0.00sec,DO[111]=OFF    ;
 128:   ;
 129:  !***************** ;
 130:  !Shawer 2 ;
 131:  !***************** ;
 132:   ;
 133:  GO[3]=3 ;
 134:   ;
 135:  !Vyjmuti trubky SHAWER 2 ;
 136:   ;
 137:  UFRAME_NUM=3 ;
 138:  UTOOL_NUM=2 ;
 139:  //J P[18] 100% FINE    ;
 140:J P[19] 100% CNT50 Tool_Offset,PR[21]    ;
 141:J P[20] 100% CNT20 Tool_Offset,PR[21] TB    .05sec,DO[112]=ON    ;
 142:L P[21] 1500mm/sec FINE Tool_Offset,PR[21]    ;
 143:   ;
 144:  IF (DI[66] AND !DI[68]),JMP LBL[31] ;
 145:  DO[51]=OFF ;
 146:  WAIT (DI[52])    ;
 147:  DO[66]=ON ;
 148:  WAIT (DI[66] AND !DI[68])    ;
 149:  DO[66]=OFF ;
 150:  LBL[31] ;
 151:   ;
 152:L P[22] 250mm/sec CNT10 Tool_Offset,PR[21]    ;
 153:L P[23] 500mm/sec CNT20 Tool_Offset,PR[21]    ;
 154:L P[24] 1000mm/sec CNT100 Tool_Offset,PR[21] TB   0.00sec,DO[67]=PULSE,1.0sec    ;
 155:L P[25] 2000mm/sec CNT50 Tool_Offset,PR[21] TB    .05sec,DO[112]=OFF    ;
 156:   ;
 157:  !Vlozeni trubky SHAWER 2 ;
 158:  WAIT (DI[66] AND !DI[68])    ;
 159:   ;
 160:  !Korekce st.2 A ;
 161:  WAIT R[12]>=(-2) AND R[12]<=2    ;
 162:  PR[25]=PR[22]    ;
 163:  PR[25,3]=PR[22,3]+R[12]    ;
 164:   ;
 165:  UFRAME_NUM=3 ;
 166:  UTOOL_NUM=1 ;
 167:J P[26] 100% CNT10 Tool_Offset,PR[22]    ;
 168:L P[27] 2000mm/sec CNT100 Tool_Offset,PR[22] TB    .05sec,DO[112]=ON    ;
 169:L P[28] 500mm/sec CNT50 Tool_Offset,PR[22]    ;
 170:L P[29] 250mm/sec CNT25 Tool_Offset,PR[22]    ;
 171:L P[30] 100mm/sec FINE Tool_Offset,PR[25]    ;
 172:   ;
 173:  IF (!DI[50]),JMP LBL[32] ;
 174:  !Kontakt? ;
 175:  WAIT (DI[67])    ;
 176:  DO[68]=ON ;
 177:  WAIT (DI[68] AND !DI[66])    ;
 178:  DO[49]=ON ;
 179:  WAIT (DI[49])    ;
 180:  DO[68]=OFF ;
 181:  LBL[32] ;
 182:  DO[65]=ON ;
 183:  WAIT (!DI[65])    ;
 184:  DO[65]=OFF ;
 185:   ;
 186:L P[31] 2000mm/sec CNT50 Tool_Offset,PR[22]    ;
 187:J P[32] 100% CNT80 Tool_Offset,PR[22] TB    .05sec,DO[112]=OFF    ;
 188:   ;
 189:   ;
 190:  !***************** ;
 191:  !Cisteni ;
 192:  !***************** ;
 193:   ;
 194:  GO[3]=4 ;
 195:   ;
 196:  UFRAME_NUM=4 ;
 197:  UTOOL_NUM=5 ;
 198:   ;
 199:  !Korekce st.3 A ;
 200:  WAIT R[13]>=(-2) AND R[13]<=2    ;
 201:  PR[26]=PR[21]    ;
 202:  PR[26,3]=PR[21,3]+R[13]    ;
 203:   ;
 204:  //J P[33] 100% FINE    ;
 205:J P[34] 100% CNT100    ;
 206:J P[35] 100% CNT100    ;
 207:   ;
 208:  //WAIT DI[69]=ON    ;
 209:   ;
 210:  IF ((!DI[52] AND DI[51])),JMP LBL[41] ;
 211:   ;
 212:J P[36] 100% CNT30 TB    .05sec,DO[113]=ON Tool_Offset,PR[21]    ;
 213:   ;
 214:L P[37] 500mm/sec CNT5 Tool_Offset,PR[21]    ;
 215:L P[38] 500mm/sec CNT5 Tool_Offset,PR[21]    ;
 216:C P[39] Tool_Offset,PR[21]
    :  P[40] 500mm/sec CNT50 Tool_Offset,PR[21]    ;
 217:C P[41] Tool_Offset,PR[21]
    :  P[42] 500mm/sec CNT50 Tool_Offset,PR[21]    ;
 218:   ;
 219:L P[43] 500mm/sec CNT10 Tool_Offset,PR[21]    ;
 220:J P[44] 100% CNT100 Tool_Offset,PR[21]    ;
 221:   ;
 222:   ;
 223:  !***************** ;
 224:  !Odhrotovani ;
 225:  !***************** ;
 226:   ;
 227:  WAIT DI[69]=ON    ;
 228:   ;
 229:   ;
 230:J P[45] 100% CNT50 Tool_Offset,PR[21]    ;
 231:L P[46:nad celisti] 1000mm/sec CNT0 Tool_Offset,PR[21]    ;
 232:L P[47:do celisti] 500mm/sec FINE Tool_Offset,PR[26]    ;
 233:   ;
 234:  !Upnout celisti ;
 235:  DO[69]=ON ;
 236:  WAIT (!DI[69])    ;
 237:  DO[69]=OFF ;
 238:   ;
 239:  !Odepnout gripper robota ;
 240:  DO[51]=ON ;
 241:  WAIT (DI[51])    ;
 242:   ;
 243:  !Start hrotovani ;
 244:  DO[71]=ON ;
 245:  WAIT (!DI[71])    ;
 246:  DO[71]=OFF ;
 247:   ;
 248:   ;
 249:  !Odjezd ;
 250:  DO[73]=PULSE,0.5sec ;
 251:L P[48] 500mm/sec CNT5 Tool_Offset,PR[21]    ;
 252:J P[49] 100% CNT80 TB   0.00sec,DO[113]=OFF Tool_Offset,PR[21]    ;
 253:   ;
 254:  LBL[41] ;
 255:  //    ;
 256:  //!***************** ;
 257:  //!Vystupni zasobnik ;
 258:  //!***************** ;
 259:  //GO[3]=5 ;
 260:  //    ;
 261:  //UFRAME_NUM=5 ;
 262:  //UTOOL_NUM=2 ;
 263:  //J P[50] 100% FINE    ;
 264:  //J P[51] 100% CNT50 Tool_Offset,PR[22]    ;
 265:  //    ;
 266:  //WAIT (DI[73])    ;
 267:  //!Vypocet PR ;
 268:  //R[6]=GI[4]    ;
 269:  //!Touchup PR[7] ;
 270:  //J P[52] 100% FINE    ;
 271:  //    ;
 272:  //PR[7,1]=(20.8+(251-R[6]*35.8)) ;
 273:  //PR[7,3]=(-180)    ;
 274:  //PR[8]=PR[7]    ;
 275:  //PR[8,2]=(PR[8,2]+100) ;
 276:  //PR[9]=PR[8]    ;
 277:  //PR[9,3]=(PR[9,3]-150) ;
 278:  //    ;
 279:  //L PR[7] 2000mm/sec CNT20 TB    .05sec,DO[114]=ON Tool_Offset,PR[22]    ;
 280:  //L PR[8] 1000mm/sec FINE Tool_Offset,PR[22]    ;
 281:  //    ;
 282:  //IF (DI[52]),DO[73]=PULSE,0.5sec ;
 283:  //DO[51]=ON ;
 284:  //WAIT (DI[51])    ;
 285:  //    ;
 286:  //L PR[9] 2000mm/sec CNT80 TB   0.00sec,DO[114]=OFF Tool_Offset,PR[22]    ;
 287:  //    ;
 288:  UFRAME_NUM=5 ;
 289:  UTOOL_NUM=2 ;
 290:J P[53] 100% CNT100    ;
 291:   ;
 292:  !Konec cyklu ;
 293:  IF (DI[54]),JMP LBL[50] ;
 294:   ;
 295:  //J P[54] 100% FINE    ;
 296:   ;
 297:  JMP LBL[100] ;
 298:   ;
 299:  LBL[50] ;
 300:   ;
 301:  UFRAME_NUM=1 ;
 302:  UTOOL_NUM=2 ;
 303:J P[55] 20% CNT100    ;
 304:  !HOME ;
 305:J PR[2] 20% FINE    ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =    62.911  mm,	Y =  -118.419  mm,	Z =  1345.870  mm,
	W =    63.834 deg,	P =   -64.706 deg,	R =   -45.826 deg
};
P[2]{
   GP1:
	UF : 1, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =   471.719  mm,	Y =    82.193  mm,	Z =   190.728  mm,
	W =   -88.833 deg,	P =   -65.723 deg,	R =    88.862 deg
};
P[3]{
   GP1:
	UF : 1, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =   397.225  mm,	Y =    71.609  mm,	Z =   121.223  mm,
	W =   -89.464 deg,	P =   -53.709 deg,	R =    89.143 deg
};
P[4]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X = -1094.967  mm,	Y =  -990.720  mm,	Z =   595.620  mm,
	W =   -22.330 deg,	P =     -.976 deg,	R =  -165.263 deg
};
P[5]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -597.731  mm,	Y =  -612.406  mm,	Z =   423.122  mm,
	W =   -48.352 deg,	P =    -3.997 deg,	R =  -132.394 deg
};
P[6]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -435.661  mm,	Y =    24.651  mm,	Z =   -34.392  mm,
	W =   -90.003 deg,	P =      .005 deg,	R =   -90.005 deg
};
P[7]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -229.035  mm,	Y =    24.652  mm,	Z =   -34.392  mm,
	W =   -90.003 deg,	P =      .005 deg,	R =   -90.005 deg
};
P[8]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -132.709  mm,	Y =    24.078  mm,	Z =   -34.392  mm,
	W =   -90.003 deg,	P =      .005 deg,	R =   -90.573 deg
};
P[9]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -131.889  mm,	Y =    12.621  mm,	Z =   -34.346  mm,
	W =   -90.003 deg,	P =      .005 deg,	R =   -90.573 deg
};
P[10]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -132.336  mm,	Y =    17.005  mm,	Z =   -34.394  mm,
	W =   -90.004 deg,	P =      .005 deg,	R =   -92.784 deg
};
P[11]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -519.184  mm,	Y =    24.652  mm,	Z =   -22.153  mm,
	W =   -90.003 deg,	P =      .005 deg,	R =   -90.006 deg
};
P[12]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -520.000  mm,	Y =    24.652  mm,	Z =   -34.392  mm,
	W =   -90.003 deg,	P =      .005 deg,	R =   -90.005 deg
};
P[13]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -210.788  mm,	Y =     4.376  mm,	Z =   -30.716  mm,
	W =   -90.010 deg,	P =      .006 deg,	R =   -89.678 deg
};
P[14]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -139.544  mm,	Y =    25.162  mm,	Z =   -33.080  mm,
	W =   -90.017 deg,	P =      .014 deg,	R =   -89.688 deg
};
P[15]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -132.663  mm,	Y =    25.669  mm,	Z =   -33.086  mm,
	W =   -90.017 deg,	P =      .014 deg,	R =   -89.689 deg
};
P[16]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -228.594  mm,	Y =    22.154  mm,	Z =   -33.599  mm,
	W =   -90.005 deg,	P =      .007 deg,	R =   -90.127 deg
};
P[17]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -450.357  mm,	Y =    22.177  mm,	Z =   -33.629  mm,
	W =   -90.007 deg,	P =      .007 deg,	R =   -90.126 deg
};
P[18]{
   GP1:
	UF : 3, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X = -1388.820  mm,	Y =  -878.227  mm,	Z =   -31.397  mm,
	W =   -90.239 deg,	P =     -.585 deg,	R =   161.718 deg
};
P[19]{
   GP1:
	UF : 3, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -356.764  mm,	Y =    -3.029  mm,	Z =   -16.440  mm,
	W =   -90.000 deg,	P =     -.000 deg,	R =   -90.000 deg
};
P[20]{
   GP1:
	UF : 3, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -180.840  mm,	Y =    -3.009  mm,	Z =   -13.729  mm,
	W =   -90.000 deg,	P =     -.000 deg,	R =   -90.000 deg
};
P[21]{
   GP1:
	UF : 3, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -119.638  mm,	Y =    -3.216  mm,	Z =   -14.230  mm,
	W =   -90.093 deg,	P =     -.001 deg,	R =   -90.673 deg
};
P[22]{
   GP1:
	UF : 3, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -118.944  mm,	Y =    -8.154  mm,	Z =   -16.430  mm,
	W =   -90.000 deg,	P =      .000 deg,	R =   -90.001 deg
};
P[23]{
   GP1:
	UF : 3, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -118.944  mm,	Y =   -22.246  mm,	Z =   -16.430  mm,
	W =   -90.000 deg,	P =      .000 deg,	R =   -90.001 deg
};
P[24]{
   GP1:
	UF : 3, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -226.272  mm,	Y =   -17.302  mm,	Z =   -10.096  mm,
	W =   -90.000 deg,	P =     -.000 deg,	R =   -90.000 deg
};
P[25]{
   GP1:
	UF : 3, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -369.193  mm,	Y =   -17.301  mm,	Z =   -14.776  mm,
	W =   -90.000 deg,	P =      .000 deg,	R =   -90.000 deg
};
P[26]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -414.513  mm,	Y =   -19.907  mm,	Z =   -10.325  mm,
	W =   -90.000 deg,	P =      .000 deg,	R =   -90.000 deg
};
P[27]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -252.532  mm,	Y =   -19.151  mm,	Z =   -17.546  mm,
	W =   -90.002 deg,	P =      .008 deg,	R =   -90.002 deg
};
P[28]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -147.411  mm,	Y =   -20.336  mm,	Z =   -16.927  mm,
	W =   -90.288 deg,	P =     -.001 deg,	R =   -90.370 deg
};
P[29]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -147.275  mm,	Y =     -.817  mm,	Z =   -14.600  mm,
	W =   -90.288 deg,	P =      .000 deg,	R =   -90.001 deg
};
P[30]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -132.313  mm,	Y =     -.176  mm,	Z =   -14.772  mm,
	W =   -90.289 deg,	P =      .000 deg,	R =   -90.002 deg
};
P[31]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -233.133  mm,	Y =      .163  mm,	Z =   -20.036  mm,
	W =   -90.000 deg,	P =     -.000 deg,	R =   -90.000 deg
};
P[32]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -312.173  mm,	Y =      .163  mm,	Z =   -20.036  mm,
	W =   -90.000 deg,	P =     -.000 deg,	R =   -90.000 deg
};
P[33]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X = -1742.831  mm,	Y =  -202.267  mm,	Z =  -146.674  mm,
	W =  -179.969 deg,	P =    -1.456 deg,	R =  -141.925 deg
};
P[34]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X = -1813.986  mm,	Y =   639.891  mm,	Z =   404.747  mm,
	W =  -111.166 deg,	P =   -38.099 deg,	R =    76.425 deg
};
P[35]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -681.418  mm,	Y =   686.753  mm,	Z =   403.122  mm,
	W =   -83.614 deg,	P =   -14.647 deg,	R =   -36.407 deg
};
P[36]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -431.990  mm,	Y =   213.091  mm,	Z =   175.412  mm,
	W =   -90.232 deg,	P =    -2.071 deg,	R =   -90.752 deg
};
P[37]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -302.403  mm,	Y =   211.370  mm,	Z =   174.889  mm,
	W =   -90.232 deg,	P =    -2.071 deg,	R =   -90.753 deg
};
P[38]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -302.103  mm,	Y =   213.773  mm,	Z =   241.444  mm,
	W =   -90.232 deg,	P =    -2.071 deg,	R =   -90.752 deg
};
P[39]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -299.147  mm,	Y =   161.444  mm,	Z =   289.853  mm,
	W =   -90.225 deg,	P =    -2.071 deg,	R =   -90.753 deg
};
P[40]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -297.124  mm,	Y =   112.217  mm,	Z =   239.386  mm,
	W =   -90.225 deg,	P =    -2.071 deg,	R =   -90.753 deg
};
P[41]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -296.674  mm,	Y =   162.078  mm,	Z =   183.761  mm,
	W =   -90.225 deg,	P =    -2.071 deg,	R =   -90.753 deg
};
P[42]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -302.103  mm,	Y =   213.774  mm,	Z =   241.444  mm,
	W =   -90.232 deg,	P =    -2.071 deg,	R =   -90.752 deg
};
P[43]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -301.784  mm,	Y =   216.330  mm,	Z =   312.246  mm,
	W =   -90.232 deg,	P =    -2.071 deg,	R =   -90.752 deg
};
P[44]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, -1',
	X =  -437.854  mm,	Y =    64.863  mm,	Z =   318.329  mm,
	W =   -90.232 deg,	P =    -2.071 deg,	R =   -90.752 deg
};
P[45]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -388.210  mm,	Y =  -143.762  mm,	Z =   213.774  mm,
	W =   -90.128 deg,	P =     -.348 deg,	R =   -88.165 deg
};
P[46:"nad celisti"]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -180.856  mm,	Y =  -137.121  mm,	Z =   213.313  mm,
	W =   -90.128 deg,	P =     -.348 deg,	R =   -88.165 deg
};
P[47:"do celisti"]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -185.053  mm,	Y =  -137.427  mm,	Z =   171.109  mm,
	W =   -90.192 deg,	P =     -.319 deg,	R =   -88.202 deg
};
P[48]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -289.138  mm,	Y =  -140.835  mm,	Z =   172.267  mm,
	W =   -90.128 deg,	P =     -.348 deg,	R =   -88.166 deg
};
P[49]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -425.789  mm,	Y =   115.958  mm,	Z =   295.165  mm,
	W =   -90.128 deg,	P =     -.348 deg,	R =   -88.166 deg
};
P[50]{
   GP1:
	UF : 5, UT : 5,		CONFIG : 'N U T, 0, 0, -1',
	X =   169.188  mm,	Y =   295.422  mm,	Z =  -922.193  mm,
	W =   -66.543 deg,	P =      .306 deg,	R =      .177 deg
};
P[51]{
   GP1:
	UF : 5, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =   139.705  mm,	Y =  -251.631  mm,	Z =  -150.940  mm,
	W =      .014 deg,	P =      .074 deg,	R =      .809 deg
};
P[52]{
   GP1:
	UF : 5, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =    17.307  mm,	Y =   -53.630  mm,	Z =  -150.944  mm,
	W =      .022 deg,	P =      .735 deg,	R =      .809 deg
};
P[53]{
   GP1:
	UF : 5, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =  -385.611  mm,	Y =  -110.894  mm,	Z =  -549.693  mm,
	W =    35.640 deg,	P =   -55.113 deg,	R =      .311 deg
};
P[54]{
   GP1:
	UF : 5, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =  -687.169  mm,	Y =   127.480  mm,	Z =  -708.758  mm,
	W =   116.874 deg,	P =   -56.363 deg,	R =   -75.501 deg
};
P[55]{
   GP1:
	UF : 1, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =    62.911  mm,	Y =  -118.419  mm,	Z =  1345.870  mm,
	W =    63.834 deg,	P =   -64.706 deg,	R =   -45.826 deg
};
/END
