/PROG  PROG30ZAL
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Vyroba 8.5 <370m";
PROG_SIZE	= 8128;
CREATE		= DATE 25-08-13  TIME 18:49:10;
MODIFIED	= DATE 25-08-13  TIME 18:49:10;
FILE_NAME	= PROG30;
VERSION		= 0;
LINE_COUNT	= 325;
MEMORY_SIZE	= 8620;
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
   2:  WAIT (DO[7] AND !DO[13] AND DI[15] AND DI[16])    ;
   3:J PR[2] 20% FINE    ;
   4:   ;
   5:  CALL INIT    ;
   6:   ;
   7:  UFRAME_NUM=1 ;
   8:  UTOOL_NUM=5 ;
   9:J P[1] 100% CNT100    ;
  10:   ;
  11:  !Novy cyklus ;
  12:  LBL[100] ;
  13:   ;
  14:  UFRAME_NUM=1 ;
  15:  UTOOL_NUM=5 ;
  16:J P[11] 100% CNT50    ;
  17:   ;
  18:  !Greifer OK? ;
  19:  WAIT (DI[15] AND DI[16])    ;
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
  32:  !****************** ;
  33:  !Vstupni zasobnik 2 ;
  34:  !****************** ;
  35:   ;
  36:  !Takt puls ;
  37:  DO[58]=PULSE,0.5sec ;
  38:   ;
  39:  WAIT (DI[77] OR DI[53])    ;
  40:  IF (DI[53]),JMP LBL[20] ;
  41:   ;
  42:  GO[3]=6 ;
  43:   ;
  44:  PR[14,1]=0    ;
  45:  PR[14,2]=0    ;
  46:  PR[14,3]=0    ;
  47:  PR[14,4]=0    ;
  48:  PR[14,5]=0    ;
  49:  PR[14,6]=0    ;
  50:   ;
  51:  R[5]=GI[3]    ;
  52:   ;
  53:  PR[14,1]=R[5]*(-38)    ;
  54:   ;
  55:  UFRAME_NUM=1 ;
  56:  UTOOL_NUM=5 ;
  57:J P[46] 100% CNT50 TB   0.00sec,DO[115]=ON Tool_Offset,PR[14]    ;
  58:   ;
  59:   ;
  60:L P[48] 1000mm/sec CNT50 Tool_Offset,PR[14]    ;
  61:L P[47] 600mm/sec FINE TB    .05sec,DO[77]=ON Tool_Offset,PR[14]    ;
  62:   ;
  63:  DO[49]=OFF ;
  64:  WAIT (DI[50])    ;
  65:   ;
  66:L P[52] 500mm/sec CNT20 Tool_Offset,PR[14]    ;
  67:L P[53] 800mm/sec CNT50 Tool_Offset,PR[14]    ;
  68:L P[54] 1500mm/sec CNT100 TB   0.00sec,DO[115]=OFF Tool_Offset,PR[14]    ;
  69:  LBL[20] ;
  70:J P[2] 100% CNT100 TB   0.00sec,DO[77]=OFF    ;
  71:   ;
  72:  !***************** ;
  73:  !Vyrovnavaci stanice ;
  74:  !***************** ;
  75:   ;
  76:  UFRAME_NUM=2 ;
  77:  UTOOL_NUM=5 ;
  78:   ;
  79:J P[45] 100% CNT50    ;
  80:  IF (DI[53] AND DI[49]),JMP LBL[30] ;
  81:   ;
  82:  WAIT DI[56]=OFF    ;
  83:   ;
  84:  !Zalozeni do luzka ;
  85:L P[27] 1500mm/sec CNT30 TB    .50sec,DO[116]=ON    ;
  86:L P[16] 1000mm/sec CNT0    ;
  87:L P[7] 500mm/sec FINE    ;
  88:  DO[49]=ON ;
  89:  WAIT DI[49]=ON    ;
  90:  WAIT    .50(sec) ;
  91:   ;
  92:  PR[13,1]=0    ;
  93:  PR[13,2]=0    ;
  94:  PR[13,3]=0    ;
  95:  PR[13,4]=0    ;
  96:  PR[13,5]=0    ;
  97:  PR[13,6]=0    ;
  98:   ;
  99:  PR[13,6]=R[9]    ;
 100:   ;
 101:L P[55] 500mm/sec FINE Tool_Offset,PR[13]    ;
 102:  DO[49]=OFF ;
 103:  WAIT DI[50]=ON    ;
 104:   ;
 105:L P[56] 500mm/sec CNT10 Tool_Offset,PR[13]    ;
 106:L P[57] 1000mm/sec CNT100    ;
 107:J P[58] 100% CNT100 TB    .50sec,DO[116]=OFF    ;
 108:   ;
 109:  LBL[30] ;
 110:   ;
 111:  !TOOL_OFFSET pro UTOOL 1 ;
 112:  PR[21,1]=0    ;
 113:  PR[21,2]=0    ;
 114:  PR[21,3]=0    ;
 115:  PR[21,4]=0    ;
 116:  PR[21,5]=0    ;
 117:  PR[21,6]=0    ;
 118:  !TOOL_OFFSET pro UTOOL 2 ;
 119:  PR[22]=PR[21]    ;
 120:   ;
 121:  !Upinac 6 Pripraven? ;
 122:  WAIT (DI[51] AND !DI[52])    ;
 123:   ;
 124:  !***************** ;
 125:  !5-stroke ;
 126:  !***************** ;
 127:   ;
 128:  GO[3]=2 ;
 129:   ;
 130:  !Vyjmuti trubky  ;
 131:   ;
 132:  UFRAME_NUM=2 ;
 133:  UTOOL_NUM=6 ;
 134:J P[20] 100% CNT100    ;
 135:J P[18] 100% CNT50    ;
 136:  WAIT (DI[61])    ;
 137:L P[4] 2000mm/sec CNT10 TB    .05sec,DO[111]=ON    ;
 138:L P[5] 1500mm/sec FINE    ;
 139:   ;
 140:  IF (DI[62] AND !DI[64]),JMP LBL[21] ;
 141:  DO[51]=OFF ;
 142:  WAIT (DI[52])    ;
 143:  DO[62]=ON ;
 144:  WAIT (DI[62] AND !DI[64])    ;
 145:  DO[62]=OFF ;
 146:  LBL[21] ;
 147:   ;
 148:L P[6] 200mm/sec CNT10 TB   0.00sec,DO[63]=PULSE,1.0sec    ;
 149:L P[8] 800mm/sec CNT50    ;
 150:L P[30] 2000mm/sec CNT50 TB    .05sec,DO[111]=OFF    ;
 151:   ;
 152:  !Vlozeni trubky ;
 153:  WAIT (DI[62] AND !DI[64])    ;
 154:   ;
 155:  !Vypocet delky ;
 156:  PR[21,3]=345-R[2]    ;
 157:   ;
 158:  !Korekce st.1 C ;
 159:  WAIT R[17]>=(-2) AND R[17]<=2    ;
 160:  PR[24]=PR[21]    ;
 161:  PR[24,3]=PR[24,3]+R[17]    ;
 162:   ;
 163:  UFRAME_NUM=2 ;
 164:  UTOOL_NUM=5 ;
 165:J P[12] 100% CNT20    ;
 166:L P[3] 2000mm/sec CNT50 TB    .05sec,DO[111]=ON Tool_Offset,PR[21]    ;
 167:L P[13] 1500mm/sec CNT50 Tool_Offset,PR[21]    ;
 168:L P[14] 200mm/sec FINE Tool_Offset,PR[24]    ;
 169:   ;
 170:  IF (!DI[50]),JMP LBL[22] ;
 171:  !Kontakt? ;
 172:  WAIT (DI[63])    ;
 173:  DO[64]=ON ;
 174:  WAIT (DI[64] AND !DI[62])    ;
 175:  DO[49]=ON ;
 176:  WAIT (DI[49])    ;
 177:  DO[64]=OFF ;
 178:  LBL[22] ;
 179:  DO[61]=ON ;
 180:  WAIT (!DI[61])    ;
 181:  DO[61]=OFF ;
 182:   ;
 183:L P[25] 2000mm/sec CNT50    ;
 184:J P[15] 100% CNT80 TB   0.00sec,DO[111]=OFF    ;
 185:   ;
 186:  !***************** ;
 187:  !Shawer 2 ;
 188:  !***************** ;
 189:   ;
 190:  GO[3]=3 ;
 191:   ;
 192:  !Vyjmuti trubky SHAWER 2 ;
 193:   ;
 194:  UFRAME_NUM=3 ;
 195:  UTOOL_NUM=5 ;
 196:  //J P[9] 100% FINE    ;
 197:J P[33] 100% CNT50    ;
 198:J P[34] 100% CNT20 TB    .05sec,DO[112]=ON    ;
 199:L P[35] 1500mm/sec FINE    ;
 200:   ;
 201:  IF (DI[66] AND !DI[68]),JMP LBL[31] ;
 202:  DO[49]=OFF ;
 203:  WAIT (DI[50])    ;
 204:  DO[66]=ON ;
 205:  WAIT (DI[66] AND !DI[68])    ;
 206:  DO[66]=OFF ;
 207:  LBL[31] ;
 208:   ;
 209:L P[36] 250mm/sec CNT10    ;
 210:L P[37] 500mm/sec CNT100    ;
 211:L P[44] 1500mm/sec CNT100 TB   0.00sec,DO[67]=PULSE,1.0sec    ;
 212:L P[31] 2000mm/sec CNT50 TB    .05sec,DO[112]=OFF    ;
 213:   ;
 214:  !Vlozeni trubky SHAWER 2 ;
 215:  WAIT (DI[66] AND !DI[68])    ;
 216:   ;
 217:  !Korekce st.2 C ;
 218:  WAIT R[18]>=(-2) AND R[18]<=2    ;
 219:  PR[25]=PR[22]    ;
 220:  PR[25,3]=PR[25,3]+R[18]    ;
 221:   ;
 222:   ;
 223:  UFRAME_NUM=3 ;
 224:  UTOOL_NUM=6 ;
 225:J P[38] 100% CNT10    ;
 226:L P[39] 2000mm/sec CNT100 TB    .05sec,DO[112]=ON    ;
 227:L P[32] 1000mm/sec CNT50    ;
 228:L P[40] 500mm/sec CNT20    ;
 229:L P[41] 250mm/sec FINE    ;
 230:   ;
 231:  IF (!DI[52]),JMP LBL[32] ;
 232:  !Kontakt? ;
 233:  WAIT (DI[67])    ;
 234:  DO[68]=ON ;
 235:  WAIT (DI[68] AND !DI[66])    ;
 236:  DO[51]=ON ;
 237:  WAIT (DI[51])    ;
 238:  DO[68]=OFF ;
 239:  LBL[32] ;
 240:  DO[65]=ON ;
 241:  WAIT (!DI[65])    ;
 242:  DO[65]=OFF ;
 243:   ;
 244:L P[42] 2000mm/sec CNT50    ;
 245:J P[43] 100% CNT80 TB    .05sec,DO[112]=OFF    ;
 246:   ;
 247:   ;
 248:  !***************** ;
 249:  !Freza 1 ;
 250:  !***************** ;
 251:   ;
 252:  GO[3]=4 ;
 253:   ;
 254:  UFRAME_NUM=4 ;
 255:  UTOOL_NUM=5 ;
 256:   ;
 257:  !Korekce st.3 C ;
 258:  WAIT R[19]>=(-2) AND R[19]<=2    ;
 259:  PR[26]=PR[21]    ;
 260:  PR[26,3]=PR[26,3]+R[19]    ;
 261:   ;
 262:J P[50] 100% CNT100    ;
 263:J P[17] 100% CNT100    ;
 264:   ;
 265:  IF ((!DI[50] AND DI[49]) OR !DI[69]),JMP LBL[41] ;
 266:   ;
 267:J P[19] 100% CNT30 TB    .05sec,DO[113]=ON    ;
 268:   ;
 269:L P[21] 500mm/sec CNT5    ;
 270:L P[22:Freza] 200mm/sec FINE    ;
 271:   ;
 272:  !Doba frezovani ;
 273:  WAIT R[7] ;
 274:  DO[69]=PULSE,0.2sec ;
 275:   ;
 276:L P[49] 500mm/sec CNT5    ;
 277:L P[10] 1200mm/sec CNT80 TB   0.00sec,DO[113]=OFF    ;
 278:   ;
 279:  LBL[41] ;
 280:   ;
 281:  !***************** ;
 282:  !Vystupni zasobnik ;
 283:  !***************** ;
 284:  GO[3]=5 ;
 285:   ;
 286:  UFRAME_NUM=5 ;
 287:  UTOOL_NUM=5 ;
 288:J P[23] 100% CNT50    ;
 289:   ;
 290:  WAIT (DI[73])    ;
 291:  !Vypocet PR ;
 292:  R[6]=GI[4]    ;
 293:   ;
 294:  PR[7,1]=(20.8+(251-R[6]*35.8)) ;
 295:  PR[7,3]=(-120)    ;
 296:  PR[8]=PR[7]    ;
 297:  PR[8,2]=(PR[8,2]+100) ;
 298:  PR[9]=PR[8]    ;
 299:  PR[9,2]=(PR[9,2]-150) ;
 300:   ;
 301:L PR[7] 2000mm/sec CNT20 TB    .05sec,DO[114]=ON    ;
 302:L PR[8] 1000mm/sec FINE    ;
 303:   ;
 304:  IF (DI[50]),DO[73]=PULSE,0.5sec ;
 305:  DO[49]=ON ;
 306:  WAIT (DI[49])    ;
 307:   ;
 308:L PR[9] 2000mm/sec CNT80 TB   0.00sec,DO[114]=OFF    ;
 309:   ;
 310:J P[26] 100% CNT100    ;
 311:   ;
 312:  !Konec cyklu ;
 313:  IF (DI[54]),JMP LBL[50] ;
 314:   ;
 315:  //J P[51] 100% FINE    ;
 316:   ;
 317:  JMP LBL[100] ;
 318:   ;
 319:  LBL[50] ;
 320:   ;
 321:  UFRAME_NUM=1 ;
 322:  UTOOL_NUM=2 ;
 323:J P[29] 20% CNT100    ;
 324:  !HOME ;
 325:J PR[2] 20% FINE    ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =   389.381  mm,	Y =   -16.356  mm,	Z =  1582.094  mm,
	W =    22.984 deg,	P =    10.860 deg,	R =    20.222 deg
};
P[2]{
   GP1:
	UF : 1, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =   446.298  mm,	Y =  -125.311  mm,	Z =   344.420  mm,
	W =  -154.943 deg,	P =     1.209 deg,	R =  -168.942 deg
};
P[3]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -125.716  mm,	Y =     4.815  mm,	Z =   -32.703  mm,
	W =   -90.213 deg,	P =      .021 deg,	R =   -90.074 deg
};
P[4]{
   GP1:
	UF : 2, UT : 6,		CONFIG : 'N U T, 0, 0, 0',
	X =  -143.584  mm,	Y =    22.756  mm,	Z =    18.310  mm,
	W =    89.409 deg,	P =     -.005 deg,	R =    90.057 deg
};
P[5]{
   GP1:
	UF : 2, UT : 6,		CONFIG : 'N U T, 0, 0, 0',
	X =  -143.419  mm,	Y =    22.590  mm,	Z =   -33.391  mm,
	W =    90.211 deg,	P =     -.017 deg,	R =    88.929 deg
};
P[6]{
   GP1:
	UF : 2, UT : 6,		CONFIG : 'N U T, 0, 0, 0',
	X =  -141.740  mm,	Y =     4.099  mm,	Z =   -31.164  mm,
	W =    90.211 deg,	P =     -.017 deg,	R =    88.929 deg
};
P[7]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =  -274.012  mm,	Y =  -428.422  mm,	Z =  -178.308  mm,
	W =   178.640 deg,	P =    -1.463 deg,	R =    96.920 deg
};
P[8]{
   GP1:
	UF : 2, UT : 6,		CONFIG : 'N U T, 0, 0, 0',
	X =  -281.401  mm,	Y =    11.802  mm,	Z =    -6.403  mm,
	W =    90.211 deg,	P =     -.017 deg,	R =    88.930 deg
};
P[9]{
   GP1:
	UF : 3, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X = -1388.820  mm,	Y =  -878.227  mm,	Z =   -31.397  mm,
	W =   -90.239 deg,	P =     -.585 deg,	R =   161.718 deg
};
P[10]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -542.229  mm,	Y =    49.121  mm,	Z =   104.776  mm,
	W =   -91.000 deg,	P =      .200 deg,	R =   -91.001 deg
};
P[11]{
   GP1:
	UF : 1, UT : 5,	
	J1=   -63.455 deg,	J2=   -12.555 deg,	J3=   -22.794 deg,
	J4=   -30.823 deg,	J5=    36.532 deg,	J6=   114.591 deg
};
P[12]{
   GP1:
	UF : 2, UT : 5,	
	J1=    16.255 deg,	J2=   -32.122 deg,	J3=   -18.016 deg,
	J4=      .452 deg,	J5=   -72.031 deg,	J6=   -92.895 deg
};
P[13]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -110.054  mm,	Y =    23.601  mm,	Z =   -33.708  mm,
	W =   -90.326 deg,	P =     -.083 deg,	R =   -89.499 deg
};
P[14]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =   -90.832  mm,	Y =    22.390  mm,	Z =   -33.067  mm,
	W =   -90.326 deg,	P =     -.083 deg,	R =   -89.499 deg
};
P[15]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -494.266  mm,	Y =    29.948  mm,	Z =     5.705  mm,
	W =   -90.214 deg,	P =      .017 deg,	R =   -91.068 deg
};
P[16]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =  -274.240  mm,	Y =  -428.734  mm,	Z =  -167.226  mm,
	W =   178.640 deg,	P =    -1.462 deg,	R =    96.920 deg
};
P[17]{
   GP1:
	UF : 4, UT : 5,	
	J1=   -54.229 deg,	J2=   -32.706 deg,	J3=    -7.972 deg,
	J4=    13.235 deg,	J5=   -72.201 deg,	J6=   -76.615 deg
};
P[18]{
   GP1:
	UF : 2, UT : 6,	
	J1=    15.377 deg,	J2=   -14.376 deg,	J3=   -21.566 deg,
	J4=      .494 deg,	J5=   -67.670 deg,	J6=     -.935 deg
};
P[19]{
   GP1:
	UF : 4, UT : 5,	
	J1=   -97.283 deg,	J2=   -34.811 deg,	J3=   -16.214 deg,
	J4=      .110 deg,	J5=   -74.577 deg,	J6=   -86.849 deg
};
P[20]{
   GP1:
	UF : 2, UT : 6,	
	J1=   -16.284 deg,	J2=   -25.800 deg,	J3=    -5.329 deg,
	J4=    15.510 deg,	J5=   -44.632 deg,	J6=   -16.282 deg
};
P[21]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -296.580  mm,	Y =    44.932  mm,	Z =    83.369  mm,
	W =   -91.502 deg,	P =      .273 deg,	R =   -90.593 deg
};
P[22:"Freza"]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -264.248  mm,	Y =    42.225  mm,	Z =    82.078  mm,
	W =   -91.521 deg,	P =      .278 deg,	R =   -90.576 deg
};
P[23]{
   GP1:
	UF : 5, UT : 5,	
	J1=   -98.934 deg,	J2=   -25.538 deg,	J3=    13.857 deg,
	J4=   -12.522 deg,	J5=   -38.668 deg,	J6=   -77.422 deg
};
P[25]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -175.126  mm,	Y =    24.001  mm,	Z =     4.512  mm,
	W =   -90.214 deg,	P =      .017 deg,	R =   -91.068 deg
};
P[26]{
   GP1:
	UF : 5, UT : 5,	
	J1=   -78.100 deg,	J2=   -18.581 deg,	J3=   -17.143 deg,
	J4=    45.482 deg,	J5=    22.059 deg,	J6=   -53.515 deg
};
P[27]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =  -342.505  mm,	Y =  -436.976  mm,	Z =  -168.858  mm,
	W =   178.639 deg,	P =    -1.462 deg,	R =    96.920 deg
};
P[29]{
   GP1:
	UF : 1, UT : 2,		CONFIG : 'F U T, 0, 0, 0',
	X =    62.911  mm,	Y =  -118.419  mm,	Z =  1345.870  mm,
	W =    63.834 deg,	P =   -64.706 deg,	R =   -45.826 deg
};
P[30]{
   GP1:
	UF : 2, UT : 6,		CONFIG : 'N U T, 0, 0, 0',
	X =  -598.488  mm,	Y =    23.521  mm,	Z =   -29.471  mm,
	W =    90.212 deg,	P =     -.017 deg,	R =    88.930 deg
};
P[31]{
   GP1:
	UF : 3, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -432.243  mm,	Y =   -14.738  mm,	Z =   -16.589  mm,
	W =   -90.001 deg,	P =      .000 deg,	R =   -90.906 deg
};
P[32]{
   GP1:
	UF : 3, UT : 6,		CONFIG : 'N U T, 0, 0, 0',
	X =  -158.788  mm,	Y =   -21.982  mm,	Z =   -14.604  mm,
	W =    90.001 deg,	P =     -.000 deg,	R =    90.161 deg
};
P[33]{
   GP1:
	UF : 3, UT : 5,	
	J1=   116.626 deg,	J2=   -51.522 deg,	J3=    -2.455 deg,
	J4=      .479 deg,	J5=   -87.201 deg,	J6=   -84.281 deg
};
P[34]{
   GP1:
	UF : 3, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -134.372  mm,	Y =    -2.433  mm,	Z =    16.695  mm,
	W =   -90.001 deg,	P =      .000 deg,	R =   -90.906 deg
};
P[35]{
   GP1:
	UF : 3, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =   -59.682  mm,	Y =    -3.614  mm,	Z =   -16.594  mm,
	W =   -90.001 deg,	P =      .000 deg,	R =   -90.906 deg
};
P[36]{
   GP1:
	UF : 3, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =   -56.352  mm,	Y =   -20.684  mm,	Z =   -16.595  mm,
	W =   -90.001 deg,	P =      .000 deg,	R =   -90.906 deg
};
P[37]{
   GP1:
	UF : 3, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -114.041  mm,	Y =   -19.772  mm,	Z =   -16.594  mm,
	W =   -90.001 deg,	P =      .000 deg,	R =   -90.906 deg
};
P[38]{
   GP1:
	UF : 3, UT : 6,	
	J1=   112.433 deg,	J2=   -51.034 deg,	J3=    -6.639 deg,
	J4=      .455 deg,	J5=   -82.984 deg,	J6=    10.948 deg
};
P[39]{
   GP1:
	UF : 3, UT : 6,		CONFIG : 'N U T, 0, 0, 0',
	X =  -209.908  mm,	Y =   -22.125  mm,	Z =   -14.603  mm,
	W =    90.001 deg,	P =     -.000 deg,	R =    90.161 deg
};
P[40]{
   GP1:
	UF : 3, UT : 6,		CONFIG : 'N U T, 0, 0, 0',
	X =  -147.245  mm,	Y =    -1.615  mm,	Z =   -14.630  mm,
	W =    90.003 deg,	P =     -.003 deg,	R =    90.161 deg
};
P[41]{
   GP1:
	UF : 3, UT : 6,		CONFIG : 'N U T, 0, 0, 0',
	X =  -141.967  mm,	Y =    -1.765  mm,	Z =   -14.700  mm,
	W =    90.013 deg,	P =     -.004 deg,	R =    90.146 deg
};
P[42]{
   GP1:
	UF : 3, UT : 6,		CONFIG : 'N U T, 0, 0, 0',
	X =  -151.490  mm,	Y =    -5.546  mm,	Z =    26.869  mm,
	W =    90.001 deg,	P =     -.000 deg,	R =    90.162 deg
};
P[43]{
   GP1:
	UF : 3, UT : 6,		CONFIG : 'N U T, 0, 0, 0',
	X =  -467.424  mm,	Y =    -6.437  mm,	Z =    85.842  mm,
	W =    90.001 deg,	P =     -.000 deg,	R =    90.162 deg
};
P[44]{
   GP1:
	UF : 3, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -234.267  mm,	Y =   -17.870  mm,	Z =   -16.592  mm,
	W =   -90.001 deg,	P =      .000 deg,	R =   -90.906 deg
};
P[45]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =  -541.203  mm,	Y =  -464.452  mm,	Z =   -38.265  mm,
	W =   178.639 deg,	P =    -1.463 deg,	R =    96.920 deg
};
P[46]{
   GP1:
	UF : 1, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =   695.674  mm,	Y =    95.781  mm,	Z =   -80.671  mm,
	W =  -169.873 deg,	P =    16.640 deg,	R =   151.400 deg
};
P[47]{
   GP1:
	UF : 1, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =   794.890  mm,	Y =   240.507  mm,	Z =  -166.436  mm,
	W =  -170.296 deg,	P =    16.885 deg,	R =   151.400 deg
};
P[48]{
   GP1:
	UF : 1, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =   777.984  mm,	Y =   209.956  mm,	Z =  -160.470  mm,
	W =  -169.873 deg,	P =    16.640 deg,	R =   151.400 deg
};
P[49]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -289.740  mm,	Y =    46.770  mm,	Z =    81.362  mm,
	W =   -91.000 deg,	P =      .200 deg,	R =   -91.001 deg
};
P[50]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X = -1489.965  mm,	Y =   757.868  mm,	Z =   476.113  mm,
	W =   -66.589 deg,	P =    -9.309 deg,	R =   -22.617 deg
};
P[51]{
   GP1:
	UF : 5, UT : 2,		CONFIG : 'F U T, 0, 0, 0',
	X =  -687.169  mm,	Y =   127.479  mm,	Z =  -708.758  mm,
	W =   116.874 deg,	P =   -56.363 deg,	R =   -75.501 deg
};
P[52]{
   GP1:
	UF : 1, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =   786.369  mm,	Y =   254.137  mm,	Z =  -120.800  mm,
	W =  -169.873 deg,	P =    16.639 deg,	R =   151.400 deg
};
P[53]{
   GP1:
	UF : 1, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =   767.364  mm,	Y =   215.343  mm,	Z =  -120.630  mm,
	W =  -179.765 deg,	P =    16.639 deg,	R =   151.400 deg
};
P[54]{
   GP1:
	UF : 1, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =   666.268  mm,	Y =   266.537  mm,	Z =   258.506  mm,
	W =  -179.765 deg,	P =    16.639 deg,	R =   151.400 deg
};
P[55]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =  -273.653  mm,	Y =  -428.000  mm,	Z =  -198.531  mm,
	W =   178.649 deg,	P =    -1.450 deg,	R =    96.911 deg
};
P[56]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =  -274.152  mm,	Y =  -428.684  mm,	Z =  -174.065  mm,
	W =   178.781 deg,	P =    -1.562 deg,	R =    96.911 deg
};
P[57]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =  -346.126  mm,	Y =  -431.564  mm,	Z =  -156.520  mm,
	W =   178.781 deg,	P =    -1.563 deg,	R =    91.911 deg
};
P[58]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =  -549.259  mm,	Y =  -407.578  mm,	Z =    11.443  mm,
	W =   178.640 deg,	P =    -1.462 deg,	R =    96.920 deg
};
/END
