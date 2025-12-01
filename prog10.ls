/PROG  PROG10
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Vyroba 8.5 <370m";
PROG_SIZE	= 7546;
CREATE		= DATE 14-12-04  TIME 12:51:58;
MODIFIED	= DATE 25-10-10  TIME 02:03:42;
FILE_NAME	= APROG;
VERSION		= 0;
LINE_COUNT	= 294;
MEMORY_SIZE	= 8034;
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
  16:J P[11] 100% CNT50    ;
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
  58:J P[2] 100% CNT80 TB   0.00sec,DO[57]=OFF    ;
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
  75:  !5-stroke ;
  76:  !***************** ;
  77:   ;
  78:  GO[3]=2 ;
  79:   ;
  80:  !Vyjmuti trubky LIS 1 ;
  81:   ;
  82:  UFRAME_NUM=2 ;
  83:  UTOOL_NUM=1 ;
  84:  //J P[7] 100% FINE    ;
  85:J P[20] 100% CNT100    ;
  86:J P[18] 100% CNT50 Tool_Offset,PR[21]    ;
  87:  WAIT (DI[61])    ;
  88:J P[4] 100% CNT10 Tool_Offset,PR[21] TB    .05sec,DO[111]=ON    ;
  89:L P[5] 1500mm/sec FINE Tool_Offset,PR[21]    ;
  90:   ;
  91:  IF (DI[62] AND !DI[64]),JMP LBL[21] ;
  92:  DO[49]=OFF ;
  93:  WAIT (DI[50])    ;
  94:  DO[62]=ON ;
  95:  WAIT (DI[62] AND !DI[64])    ;
  96:  DO[62]=OFF ;
  97:  LBL[21] ;
  98:   ;
  99:L P[6] 500mm/sec CNT10 Tool_Offset,PR[21] TB   0.00sec,DO[63]=PULSE,1.0sec    ;
 100:L P[8] 1000mm/sec CNT50 Tool_Offset,PR[21]    ;
 101:L P[30] 2000mm/sec CNT100 Tool_Offset,PR[21] TB    .05sec,DO[111]=OFF    ;
 102:   ;
 103:  !Vlozeni trubky LIS 1 ;
 104:  WAIT (DI[62] AND !DI[64])    ;
 105:   ;
 106:  UFRAME_NUM=2 ;
 107:  UTOOL_NUM=2 ;
 108:J P[12] 100% CNT50 Tool_Offset,PR[22]    ;
 109:L P[3] 2000mm/sec CNT50 Tool_Offset,PR[22] TB    .05sec,DO[111]=ON    ;
 110:L P[13] 1500mm/sec CNT50 Tool_Offset,PR[22]    ;
 111:L P[14] 500mm/sec FINE Tool_Offset,PR[22]    ;
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
 126:L P[25] 2000mm/sec CNT50 Tool_Offset,PR[22]    ;
 127:J P[15] 100% CNT100 Tool_Offset,PR[22] TB   0.00sec,DO[111]=OFF    ;
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
 139:  //J P[9] 100% FINE    ;
 140:J P[33] 100% CNT80 Tool_Offset,PR[21]    ;
 141:J P[34] 100% CNT50 Tool_Offset,PR[21] TB    .05sec,DO[112]=ON    ;
 142:   ;
 143:  !Offset pro vylozeni dilu 338  ;
 144:  IF (R[10]=338) THEN ;
 145:  PR[21,3]=10    ;
 146:  ENDIF ;
 147:   ;
 148:   ;
 149:L P[35] 2000mm/sec FINE Tool_Offset,PR[21]    ;
 150:   ;
 151:  IF (DI[66] AND !DI[68]),JMP LBL[31] ;
 152:  DO[51]=OFF ;
 153:  WAIT (DI[52])    ;
 154:  DO[66]=ON ;
 155:  WAIT (DI[66] AND !DI[68])    ;
 156:  DO[66]=OFF ;
 157:  LBL[31] ;
 158:   ;
 159:L P[36] 400mm/sec CNT10 Tool_Offset,PR[21]    ;
 160:L P[37] 1000mm/sec CNT100 Tool_Offset,PR[21]    ;
 161:L P[44] 2000mm/sec CNT100 Tool_Offset,PR[21] TB   0.00sec,DO[67]=PULSE,1.0sec    ;
 162:L P[31] 2000mm/sec CNT80 Tool_Offset,PR[21] TB    .05sec,DO[112]=OFF    ;
 163:   ;
 164:  !Vlozeni trubky SHAWER 2 ;
 165:  WAIT (DI[66] AND !DI[68])    ;
 166:   ;
 167:  !Korekce st.2 A ;
 168:  WAIT R[12]>=(-2) AND R[12]<=2    ;
 169:  PR[25]=PR[22]    ;
 170:  PR[25,3]=PR[22,3]+R[12]    ;
 171:   ;
 172:  UFRAME_NUM=3 ;
 173:  UTOOL_NUM=1 ;
 174:J P[38] 100% CNT30 Tool_Offset,PR[22]    ;
 175:L P[39] 2000mm/sec CNT100 Tool_Offset,PR[22] TB    .05sec,DO[112]=ON    ;
 176:L P[32] 500mm/sec CNT100 Tool_Offset,PR[22]    ;
 177:L P[40] 500mm/sec CNT50 Tool_Offset,PR[22]    ;
 178:L P[41] 500mm/sec FINE Tool_Offset,PR[25]    ;
 179:   ;
 180:  IF (!DI[50]),JMP LBL[32] ;
 181:  !Kontakt? ;
 182:  WAIT (DI[67])    ;
 183:  DO[68]=ON ;
 184:  WAIT (DI[68] AND !DI[66])    ;
 185:  DO[49]=ON ;
 186:  WAIT (DI[49])    ;
 187:  DO[68]=OFF ;
 188:  LBL[32] ;
 189:  DO[65]=ON ;
 190:  WAIT (!DI[65])    ;
 191:  DO[65]=OFF ;
 192:   ;
 193:L P[42] 2000mm/sec CNT50 Tool_Offset,PR[22]    ;
 194:J P[43] 100% CNT80 Tool_Offset,PR[22] TB    .05sec,DO[112]=OFF    ;
 195:   ;
 196:   ;
 197:  !***************** ;
 198:  !Cisteni ;
 199:  !***************** ;
 200:   ;
 201:  GO[3]=4 ;
 202:   ;
 203:  UFRAME_NUM=4 ;
 204:  UTOOL_NUM=2 ;
 205:   ;
 206:  !Korekce st.3 A ;
 207:  WAIT R[13]>=(-2) AND R[13]<=2    ;
 208:  PR[26]=PR[21]    ;
 209:  PR[26,3]=PR[21,3]+R[13]    ;
 210:   ;
 211:J P[50] 100% CNT100    ;
 212:J P[17] 100% CNT100    ;
 213:   ;
 214:   ;
 215:  IF ((!DI[52] AND DI[51])),JMP LBL[41] ;
 216:   ;
 217:J P[19] 100% CNT70 TB    .05sec,DO[113]=ON Tool_Offset,PR[21]    ;
 218:   ;
 219:  !Korekce levy bod ;
 220:  PR[27]=PR[26]    ;
 221:  PR[27,1]=100-R[21]    ;
 222:   ;
 223:  !Korekce horni bod ;
 224:  PR[28]=PR[26]    ;
 225:  PR[28,2]=100-R[21]    ;
 226:   ;
 227:  !Korekce pravy bod ;
 228:  PR[29]=PR[26]    ;
 229:  PR[29,1]=(-100)+R[21]    ;
 230:   ;
 231:  !Korekce spodni bod ;
 232:  PR[30]=PR[26]    ;
 233:  PR[30,2]=(-100)+R[21]    ;
 234:   ;
 235:   ;
 236:L P[27] 2000mm/sec CNT50 Tool_Offset,PR[21]    ;
 237:L P[21] R[23]mm/sec CNT100 Tool_Offset,PR[27]    ;
 238:C P[45] Tool_Offset,PR[28]
    :  P[46] R[23]mm/sec CNT100 Tool_Offset,PR[29]    ;
 239:C P[47] Tool_Offset,PR[30]
    :  P[48] R[23]mm/sec CNT100 Tool_Offset,PR[27]    ;
 240:   ;
 241:L P[52] 2000mm/sec CNT50 Tool_Offset,PR[21]    ;
 242:J P[53] 100% CNT100 Tool_Offset,PR[21]    ;
 243:   ;
 244:   ;
 245:  !***************** ;
 246:  !Odhrotovani ;
 247:  !***************** ;
 248:   ;
 249:  WAIT DI[69]=ON    ;
 250:   ;
 251:   ;
 252:J P[55] 100% CNT100 Tool_Offset,PR[21]    ;
 253:L P[54:nad celisti] 2000mm/sec CNT0 Tool_Offset,PR[21]    ;
 254:L P[22:do celisti] 1000mm/sec FINE Tool_Offset,PR[26]    ;
 255:   ;
 256:  !Upnout celisti ;
 257:  DO[69]=ON ;
 258:  WAIT (!DI[69] AND DI[71])    ;
 259:  DO[69]=OFF ;
 260:   ;
 261:  !Odepnout gripper robota ;
 262:  DO[51]=ON ;
 263:  WAIT (DI[51])    ;
 264:   ;
 265:  !Start hrotovani ;
 266:  DO[71]=PULSE,1.0sec ;
 267:  WAIT (!DI[71])    ;
 268:   ;
 269:   ;
 270:  !Odjezd ;
 271:  DO[73]=PULSE,0.5sec ;
 272:L P[49] 2000mm/sec CNT50 Tool_Offset,PR[21]    ;
 273:J P[10] 100% CNT80 TB   0.00sec,DO[113]=OFF Tool_Offset,PR[21]    ;
 274:   ;
 275:  LBL[41] ;
 276:   ;
 277:  UFRAME_NUM=5 ;
 278:  UTOOL_NUM=2 ;
 279:   ;
 280:J P[26] 100% CNT100    ;
 281:   ;
 282:  !Konec cyklu ;
 283:  IF (DI[54]),JMP LBL[50] ;
 284:   ;
 285:   ;
 286:  JMP LBL[100] ;
 287:   ;
 288:  LBL[50] ;
 289:   ;
 290:  UFRAME_NUM=1 ;
 291:  UTOOL_NUM=2 ;
 292:J P[29] 20% CNT100    ;
 293:  !HOME ;
 294:J PR[2] 20% FINE    ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 2,		CONFIG : 'F U T, 0, 0, 0',
	X =    62.911  mm,	Y =  -118.419  mm,	Z =  1345.870  mm,
	W =    63.834 deg,	P =   -64.706 deg,	R =   -45.826 deg
};
P[2]{
   GP1:
	UF : 1, UT : 2,		CONFIG : 'F U T, 0, 0, 0',
	X =   397.225  mm,	Y =    71.609  mm,	Z =   121.223  mm,
	W =   -89.464 deg,	P =   -53.709 deg,	R =    89.143 deg
};
P[3]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =  -210.788  mm,	Y =     4.376  mm,	Z =   -30.716  mm,
	W =   -90.010 deg,	P =      .006 deg,	R =   -89.678 deg
};
P[4]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -229.035  mm,	Y =    24.651  mm,	Z =   -34.392  mm,
	W =   -90.003 deg,	P =      .005 deg,	R =   -90.005 deg
};
P[5]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -132.709  mm,	Y =    24.078  mm,	Z =   -34.392  mm,
	W =   -90.003 deg,	P =      .005 deg,	R =   -90.573 deg
};
P[6]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -131.889  mm,	Y =    12.621  mm,	Z =   -34.346  mm,
	W =   -90.003 deg,	P =      .005 deg,	R =   -90.573 deg
};
P[7]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X = -1094.967  mm,	Y =  -990.720  mm,	Z =   595.620  mm,
	W =   -22.330 deg,	P =     -.976 deg,	R =  -165.263 deg
};
P[8]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -132.336  mm,	Y =    17.005  mm,	Z =   -34.394  mm,
	W =   -90.004 deg,	P =      .005 deg,	R =   -92.784 deg
};
P[9]{
   GP1:
	UF : 3, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X = -1388.820  mm,	Y =  -878.227  mm,	Z =   -31.397  mm,
	W =   -90.239 deg,	P =     -.585 deg,	R =   161.718 deg
};
P[10]{
   GP1:
	UF : 4, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =  -425.789  mm,	Y =   115.958  mm,	Z =   295.165  mm,
	W =   -90.128 deg,	P =     -.348 deg,	R =   -88.166 deg
};
P[11]{
   GP1:
	UF : 1, UT : 2,		CONFIG : 'F U T, 0, 0, 0',
	X =   471.719  mm,	Y =    82.193  mm,	Z =   190.728  mm,
	W =   -88.833 deg,	P =   -65.723 deg,	R =    88.862 deg
};
P[12]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, -1',
	X =  -520.000  mm,	Y =    24.652  mm,	Z =   -34.392  mm,
	W =   -90.003 deg,	P =      .005 deg,	R =   -90.005 deg
};
P[13]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, -1',
	X =  -139.544  mm,	Y =    25.162  mm,	Z =   -33.080  mm,
	W =   -90.017 deg,	P =      .014 deg,	R =   -89.688 deg
};
P[14]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, -1',
	X =  -132.664  mm,	Y =    25.669  mm,	Z =   -33.086  mm,
	W =   -90.017 deg,	P =      .014 deg,	R =   -89.689 deg
};
P[15]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, -1',
	X =  -450.357  mm,	Y =    22.177  mm,	Z =   -33.629  mm,
	W =   -90.007 deg,	P =      .007 deg,	R =   -90.126 deg
};
P[17]{
   GP1:
	UF : 4, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =  -681.418  mm,	Y =   686.753  mm,	Z =   403.122  mm,
	W =   -83.614 deg,	P =   -14.647 deg,	R =   -36.407 deg
};
P[18]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -435.661  mm,	Y =    24.651  mm,	Z =   -34.392  mm,
	W =   -90.003 deg,	P =      .005 deg,	R =   -90.005 deg
};
P[19]{
   GP1:
	UF : 4, UT : 2,		CONFIG : 'N U T, 0, 0, -1',
	X =  -431.990  mm,	Y =   213.091  mm,	Z =   175.412  mm,
	W =   -90.232 deg,	P =    -2.071 deg,	R =   -90.752 deg
};
P[20]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -597.731  mm,	Y =  -612.406  mm,	Z =   423.122  mm,
	W =   -48.352 deg,	P =    -3.997 deg,	R =  -132.394 deg
};
P[21]{
   GP1:
	UF : 4, UT : 2,		CONFIG : 'N U T, 0, 0, -1',
	X =  -302.121  mm,	Y =   212.466  mm,	Z =   241.491  mm,
	W =   -90.232 deg,	P =    -2.071 deg,	R =   -90.752 deg
};
P[22:"do celisti"]{
   GP1:
	UF : 4, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =  -185.069  mm,	Y =  -137.346  mm,	Z =   171.180  mm,
	W =   -90.199 deg,	P =     -.311 deg,	R =   -88.195 deg
};
P[25]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, -1',
	X =  -228.594  mm,	Y =    22.154  mm,	Z =   -33.599  mm,
	W =   -90.005 deg,	P =      .007 deg,	R =   -90.127 deg
};
P[26]{
   GP1:
	UF : 5, UT : 2,		CONFIG : 'F U T, 0, 0, 0',
	X =  -385.611  mm,	Y =  -110.894  mm,	Z =  -549.693  mm,
	W =    35.640 deg,	P =   -55.113 deg,	R =      .311 deg
};
P[27]{
   GP1:
	UF : 4, UT : 2,		CONFIG : 'N U T, 0, 0, -1',
	X =  -302.403  mm,	Y =   211.371  mm,	Z =   174.889  mm,
	W =   -90.232 deg,	P =    -2.071 deg,	R =   -90.753 deg
};
P[29]{
   GP1:
	UF : 1, UT : 2,		CONFIG : 'F U T, 0, 0, 0',
	X =    62.911  mm,	Y =  -118.419  mm,	Z =  1345.870  mm,
	W =    63.834 deg,	P =   -64.706 deg,	R =   -45.826 deg
};
P[30]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -519.184  mm,	Y =    24.652  mm,	Z =   -22.153  mm,
	W =   -90.003 deg,	P =      .005 deg,	R =   -90.006 deg
};
P[31]{
   GP1:
	UF : 3, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =  -369.193  mm,	Y =   -17.301  mm,	Z =   -14.776  mm,
	W =   -90.000 deg,	P =      .000 deg,	R =   -90.000 deg
};
P[32]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -147.384  mm,	Y =   -16.184  mm,	Z =   -16.928  mm,
	W =   -90.288 deg,	P =     -.001 deg,	R =   -90.370 deg
};
P[33]{
   GP1:
	UF : 3, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =  -356.764  mm,	Y =    -3.029  mm,	Z =   -16.440  mm,
	W =   -90.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[34]{
   GP1:
	UF : 3, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =  -180.840  mm,	Y =    -3.009  mm,	Z =   -13.729  mm,
	W =   -90.000 deg,	P =     -.000 deg,	R =   -90.000 deg
};
P[35]{
   GP1:
	UF : 3, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =  -119.638  mm,	Y =    -3.216  mm,	Z =   -14.230  mm,
	W =   -90.093 deg,	P =     -.001 deg,	R =   -90.673 deg
};
P[36]{
   GP1:
	UF : 3, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =  -118.944  mm,	Y =    -8.154  mm,	Z =   -16.430  mm,
	W =   -90.000 deg,	P =      .000 deg,	R =   -90.001 deg
};
P[37]{
   GP1:
	UF : 3, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =  -118.944  mm,	Y =   -22.246  mm,	Z =   -16.430  mm,
	W =   -90.000 deg,	P =      .000 deg,	R =   -90.001 deg
};
P[38]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -414.513  mm,	Y =   -19.907  mm,	Z =   -10.325  mm,
	W =   -90.000 deg,	P =      .000 deg,	R =   -90.000 deg
};
P[39]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -252.532  mm,	Y =   -19.151  mm,	Z =   -17.546  mm,
	W =   -90.002 deg,	P =      .008 deg,	R =   -90.002 deg
};
P[40]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -147.277  mm,	Y =     -.011  mm,	Z =   -14.946  mm,
	W =   -90.288 deg,	P =      .000 deg,	R =   -90.001 deg
};
P[41]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -135.002  mm,	Y =     -.176  mm,	Z =   -14.758  mm,
	W =   -90.288 deg,	P =      .000 deg,	R =   -90.002 deg
};
P[42]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -233.133  mm,	Y =      .163  mm,	Z =   -20.036  mm,
	W =   -90.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[43]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -312.173  mm,	Y =      .163  mm,	Z =   -20.036  mm,
	W =   -90.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[44]{
   GP1:
	UF : 3, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =  -226.272  mm,	Y =   -17.302  mm,	Z =   -10.096  mm,
	W =   -90.000 deg,	P =     -.000 deg,	R =   -90.000 deg
};
P[45]{
   GP1:
	UF : 4, UT : 2,		CONFIG : 'N U T, 0, 0, -1',
	X =  -299.118  mm,	Y =   165.163  mm,	Z =   285.144  mm,
	W =   -90.225 deg,	P =    -2.071 deg,	R =   -90.753 deg
};
P[46]{
   GP1:
	UF : 4, UT : 2,		CONFIG : 'N U T, 0, 0, -1',
	X =  -297.098  mm,	Y =   114.195  mm,	Z =   239.315  mm,
	W =   -90.225 deg,	P =    -2.071 deg,	R =   -90.753 deg
};
P[47]{
   GP1:
	UF : 4, UT : 2,		CONFIG : 'N U T, 0, 0, -1',
	X =  -298.025  mm,	Y =   159.984  mm,	Z =   189.173  mm,
	W =   -90.225 deg,	P =    -2.071 deg,	R =   -90.754 deg
};
P[48]{
   GP1:
	UF : 4, UT : 2,		CONFIG : 'N U T, 0, 0, -1',
	X =  -302.162  mm,	Y =   211.087  mm,	Z =   235.884  mm,
	W =   -90.231 deg,	P =    -2.071 deg,	R =   -90.752 deg
};
P[49]{
   GP1:
	UF : 4, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =  -289.138  mm,	Y =  -140.835  mm,	Z =   172.267  mm,
	W =   -90.128 deg,	P =     -.348 deg,	R =   -88.166 deg
};
P[50]{
   GP1:
	UF : 4, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X = -1813.986  mm,	Y =   639.891  mm,	Z =   404.747  mm,
	W =  -111.166 deg,	P =   -38.099 deg,	R =    76.425 deg
};
P[52]{
   GP1:
	UF : 4, UT : 2,		CONFIG : 'N U T, 0, 0, -1',
	X =  -301.784  mm,	Y =   216.330  mm,	Z =   312.246  mm,
	W =   -90.232 deg,	P =    -2.071 deg,	R =   -90.752 deg
};
P[53]{
   GP1:
	UF : 4, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =  -415.003  mm,	Y =    -5.800  mm,	Z =   272.147  mm,
	W =   -90.231 deg,	P =    -2.071 deg,	R =   -90.752 deg
};
P[54:"nad celisti"]{
   GP1:
	UF : 4, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =  -180.856  mm,	Y =  -137.121  mm,	Z =   213.312  mm,
	W =   -90.128 deg,	P =     -.348 deg,	R =   -88.165 deg
};
P[55]{
   GP1:
	UF : 4, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =  -388.210  mm,	Y =  -143.762  mm,	Z =   213.774  mm,
	W =   -90.128 deg,	P =     -.348 deg,	R =   -88.165 deg
};
/END
