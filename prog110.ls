/PROG  PROG110
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Vyroba 8.5 <370m";
PROG_SIZE	= 7118;
CREATE		= DATE 15-09-10  TIME 23:47:24;
MODIFIED	= DATE 15-09-11  TIME 00:12:46;
FILE_NAME	= PROG10;
VERSION		= 0;
LINE_COUNT	= 269;
MEMORY_SIZE	= 7578;
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
  24:  IF (R[10]<250 OR R[10]>400),JMP LBL[1] ;
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
  51:L PR[11] 400mm/sec FINE TB    .05sec,DO[57]=ON    ;
  52:   ;
  53:  DO[51]=OFF ;
  54:  WAIT (DI[52])    ;
  55:   ;
  56:L PR[12] 1000mm/sec CNT50 TB   0.00sec,DO[110]=OFF    ;
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
  72:  WAIT (DI[61] AND DI[49] AND !DI[50])    ;
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
  84:  //J P[7] 100% FINE    ;
  85:J P[20] 100% CNT100    ;
  86:J P[18] 100% CNT50 Tool_Offset,PR[21]    ;
  87:J P[4] 100% CNT10 Tool_Offset,PR[21] TB    .05sec,DO[111]=ON    ;
  88:L P[5] 400mm/sec FINE Tool_Offset,PR[21]    ;
  89:   ;
  90:  IF (DI[62] AND !DI[64]),JMP LBL[21] ;
  91:  DO[49]=OFF ;
  92:  WAIT (DI[50])    ;
  93:  DO[62]=ON ;
  94:  WAIT (DI[62] AND !DI[64])    ;
  95:  DO[62]=OFF ;
  96:  LBL[21] ;
  97:   ;
  98:L P[6] 100mm/sec CNT20 Tool_Offset,PR[21] TB   0.00sec,DO[63]=ON    ;
  99:L P[8] 500mm/sec CNT50 Tool_Offset,PR[21]    ;
 100:L P[30] 2000mm/sec CNT50 Tool_Offset,PR[21] TB    .05sec,DO[111]=OFF    ;
 101:   ;
 102:  !Vlozeni trubky LIS 1 ;
 103:  WAIT (DI[62] AND !DI[64])    ;
 104:   ;
 105:  UFRAME_NUM=2 ;
 106:  UTOOL_NUM=2 ;
 107:J P[12] 100% CNT20 Tool_Offset,PR[22]    ;
 108:L P[3] 2000mm/sec CNT50 Tool_Offset,PR[22] TB    .05sec,DO[112]=ON    ;
 109:L P[13] 800mm/sec CNT50 Tool_Offset,PR[22]    ;
 110:L P[14] 50mm/sec FINE Tool_Offset,PR[22]    ;
 111:   ;
 112:  IF (!DI[52]),JMP LBL[22] ;
 113:  !Kontakt? ;
 114:  WAIT (DI[63])    ;
 115:  DO[64]=ON ;
 116:  WAIT (DI[64] AND !DI[62])    ;
 117:  DO[51]=ON ;
 118:  WAIT (DI[51])    ;
 119:  DO[64]=OFF ;
 120:  LBL[22] ;
 121:  DO[61]=ON ;
 122:  WAIT (!DI[61])    ;
 123:  DO[61]=OFF ;
 124:   ;
 125:L P[25] 2000mm/sec CNT50 Tool_Offset,PR[22]    ;
 126:J P[15] 100% CNT80 Tool_Offset,PR[22] TB   0.00sec,DO[112]=OFF    ;
 127:   ;
 128:  !***************** ;
 129:  !Shawer 2 ;
 130:  !***************** ;
 131:   ;
 132:  GO[3]=3 ;
 133:   ;
 134:  !Vyjmuti trubky SHAWER 2 ;
 135:   ;
 136:  UFRAME_NUM=3 ;
 137:  UTOOL_NUM=2 ;
 138:  //J P[9] 100% FINE    ;
 139:J P[33] 100% CNT50 Tool_Offset,PR[21]    ;
 140:J P[34] 100% CNT10 Tool_Offset,PR[21] TB    .05sec,DO[113]=ON    ;
 141:L P[35] 1000mm/sec FINE Tool_Offset,PR[21]    ;
 142:   ;
 143:  IF (DI[66] AND !DI[68]),JMP LBL[31] ;
 144:  DO[51]=OFF ;
 145:  WAIT (DI[52])    ;
 146:  DO[66]=ON ;
 147:  WAIT (DI[66] AND !DI[68])    ;
 148:  DO[66]=OFF ;
 149:  LBL[31] ;
 150:   ;
 151:L P[36] 150mm/sec CNT10 Tool_Offset,PR[21] TB   0.00sec,DO[67]=ON    ;
 152:L P[37] 500mm/sec CNT10 Tool_Offset,PR[21]    ;
 153:L P[44] 500mm/sec CNT10 Tool_Offset,PR[21]    ;
 154:L P[31] 2000mm/sec CNT50 Tool_Offset,PR[21] TB    .05sec,DO[113]=OFF    ;
 155:   ;
 156:  !Vlozeni trubky SHAWER 2 ;
 157:  WAIT (DI[66] AND !DI[68])    ;
 158:   ;
 159:  !Korekce st.2 A ;
 160:  WAIT R[12]>=(-2) AND R[12]<=2    ;
 161:  PR[22,3]=PR[21,3]+R[12]    ;
 162:   ;
 163:  UFRAME_NUM=3 ;
 164:  UTOOL_NUM=1 ;
 165:  //J P[45] 100% FINE    ;
 166:J P[38] 100% CNT10 Tool_Offset,PR[22]    ;
 167:L P[27] 500mm/sec CNT10 Tool_Offset,PR[22] TB    .05sec,DO[114]=ON    ;
 168:L P[39] 500mm/sec CNT10 Tool_Offset,PR[22]    ;
 169:L P[32] 500mm/sec CNT20 Tool_Offset,PR[22]    ;
 170:L P[40] 500mm/sec CNT50 Tool_Offset,PR[22]    ;
 171:L P[41] 50mm/sec FINE Tool_Offset,PR[22]    ;
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
 186:L P[42] 1500mm/sec CNT50 Tool_Offset,PR[22]    ;
 187:J P[43] 100% CNT80 Tool_Offset,PR[22] TB    .05sec,DO[114]=OFF    ;
 188:   ;
 189:   ;
 190:  !***************** ;
 191:  !Freza 1 ;
 192:  !***************** ;
 193:   ;
 194:  GO[3]=4 ;
 195:   ;
 196:  UFRAME_NUM=4 ;
 197:  UTOOL_NUM=2 ;
 198:   ;
 199:  !Korekce st.3 A ;
 200:  WAIT R[13]>=(-2) AND R[13]<=2    ;
 201:  PR[21,3]=259-R[10]+R[13]    ;
 202:   ;
 203:  //J P[16] 100% FINE    ;
 204:J P[50] 100% CNT100    ;
 205:J P[17] 100% CNT100    ;
 206:   ;
 207:  IF ((!DI[52] AND DI[51]) OR !DI[69]),JMP LBL[41] ;
 208:   ;
 209:J P[19] 100% CNT30 TB    .05sec,DO[115]=ON Tool_Offset,PR[21]    ;
 210:   ;
 211:L P[21] 300mm/sec CNT5 Tool_Offset,PR[21]    ;
 212:L P[22:Freza] 100mm/sec FINE Tool_Offset,PR[21]    ;
 213:   ;
 214:  !Doba frezovani ;
 215:  WAIT R[7] ;
 216:  DO[69]=PULSE,0.2sec ;
 217:   ;
 218:L P[49] 300mm/sec CNT5 Tool_Offset,PR[21]    ;
 219:L P[10] 1000mm/sec CNT80 TB   0.00sec,DO[115]=OFF Tool_Offset,PR[21]    ;
 220:   ;
 221:  LBL[41] ;
 222:   ;
 223:  !***************** ;
 224:  !Vystupni zasobnik ;
 225:  !***************** ;
 226:  GO[3]=5 ;
 227:   ;
 228:  UFRAME_NUM=5 ;
 229:  UTOOL_NUM=2 ;
 230:  //J P[28] 100% FINE    ;
 231:J P[23] 100% CNT50 Tool_Offset,PR[22]    ;
 232:   ;
 233:  WAIT (DI[73])    ;
 234:  !Vypocet PR ;
 235:  R[6]=GI[4]    ;
 236:  //!Touchup PR[7] ;
 237:  //J P[24] 100% FINE    ;
 238:   ;
 239:  PR[7,1]=(17.3+(251-R[6]*35.8)) ;
 240:  PR[8]=PR[7]    ;
 241:  PR[8,2]=(PR[8,2]+100) ;
 242:  PR[9]=PR[8]    ;
 243:  PR[9,3]=(PR[9,3]-150) ;
 244:   ;
 245:L PR[7] 2000mm/sec CNT50 TB    .05sec,DO[116]=ON Tool_Offset,PR[22]    ;
 246:L PR[8] 500mm/sec FINE Tool_Offset,PR[22]    ;
 247:   ;
 248:  IF (DI[52]),DO[73]=PULSE,0.5sec ;
 249:  DO[51]=ON ;
 250:  WAIT (DI[51])    ;
 251:   ;
 252:L PR[9] 2000mm/sec CNT80 TB   0.00sec,DO[116]=OFF Tool_Offset,PR[22]    ;
 253:   ;
 254:J P[26] 100% CNT100    ;
 255:   ;
 256:  !Konec cyklu ;
 257:  IF (DI[54]),JMP LBL[50] ;
 258:   ;
 259:  //J P[51] 100% FINE    ;
 260:   ;
 261:  JMP LBL[100] ;
 262:   ;
 263:  LBL[50] ;
 264:   ;
 265:  UFRAME_NUM=1 ;
 266:  UTOOL_NUM=2 ;
 267:J P[29] 20% CNT100    ;
 268:  !HOME ;
 269:J PR[2] 20% FINE    ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 2,		CONFIG : 'F U T, 0, 0, 0',
	X =    62.911  mm,	Y =  -118.419  mm,	Z =  1345.870  mm,
	W =    63.834 deg,	P =   -64.706 deg,	R =   -45.826 deg
};
P[2]{
   GP1:
	UF : 1, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   266.828  mm,	Y =  -114.571  mm,	Z =   416.854  mm,
	W =   -93.285 deg,	P =   -31.950 deg,	R =    89.011 deg
};
P[3]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =  -286.182  mm,	Y =     6.652  mm,	Z =   -33.561  mm,
	W =   -90.003 deg,	P =      .005 deg,	R =   -90.125 deg
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
	X =  -130.549  mm,	Y =     8.525  mm,	Z =   -34.392  mm,
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
	X =  -255.985  mm,	Y =    16.150  mm,	Z =   -20.999  mm,
	W =   -90.003 deg,	P =      .005 deg,	R =   -92.488 deg
};
P[9]{
   GP1:
	UF : 3, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X = -1388.820  mm,	Y =  -878.227  mm,	Z =   -31.397  mm,
	W =   -90.239 deg,	P =     -.585 deg,	R =   161.718 deg
};
P[10]{
   GP1:
	UF : 4, UT : 2,		CONFIG : 'N U T, 0, 0, -1',
	X =  -311.005  mm,	Y =    47.282  mm,	Z =   168.235  mm,
	W =   -90.707 deg,	P =      .218 deg,	R =   -90.929 deg
};
P[11]{
   GP1:
	UF : 1, UT : 2,		CONFIG : 'F U T, 0, 0, 0',
	X =   471.719  mm,	Y =    82.193  mm,	Z =   190.728  mm,
	W =   -88.833 deg,	P =   -65.723 deg,	R =    88.862 deg
};
P[12]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =  -520.000  mm,	Y =    24.652  mm,	Z =   -34.392  mm,
	W =   -90.003 deg,	P =      .005 deg,	R =   -90.005 deg
};
P[13]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =  -133.855  mm,	Y =    20.761  mm,	Z =   -33.563  mm,
	W =   -90.004 deg,	P =      .005 deg,	R =   -90.126 deg
};
P[14]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =  -130.745  mm,	Y =    25.446  mm,	Z =   -33.635  mm,
	W =   -90.008 deg,	P =      .007 deg,	R =   -90.127 deg
};
P[15]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =  -450.357  mm,	Y =    22.177  mm,	Z =   -33.629  mm,
	W =   -90.007 deg,	P =      .007 deg,	R =   -90.126 deg
};
P[16]{
   GP1:
	UF : 4, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X = -1742.831  mm,	Y =  -202.267  mm,	Z =  -146.674  mm,
	W =  -179.969 deg,	P =    -1.456 deg,	R =  -141.925 deg
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
	X =  -315.251  mm,	Y =    47.051  mm,	Z =   165.371  mm,
	W =   -90.707 deg,	P =      .218 deg,	R =   -90.929 deg
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
	X =  -301.570  mm,	Y =    47.052  mm,	Z =    79.559  mm,
	W =   -90.707 deg,	P =      .218 deg,	R =   -90.929 deg
};
P[22:"Freza"]{
   GP1:
	UF : 4, UT : 2,		CONFIG : 'N U T, 0, 0, -1',
	X =  -274.457  mm,	Y =    47.059  mm,	Z =    79.552  mm,
	W =   -90.707 deg,	P =      .218 deg,	R =   -90.929 deg
};
P[23]{
   GP1:
	UF : 5, UT : 2,		CONFIG : 'N U T, 0, 0, -1',
	X =   139.705  mm,	Y =  -251.631  mm,	Z =  -150.941  mm,
	W =      .014 deg,	P =      .074 deg,	R =      .809 deg
};
P[24]{
   GP1:
	UF : 5, UT : 2,		CONFIG : 'N U T, 0, 0, -1',
	X =    17.307  mm,	Y =   -53.630  mm,	Z =  -150.944  mm,
	W =      .022 deg,	P =      .735 deg,	R =      .809 deg
};
P[25]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
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
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -266.013  mm,	Y =    -4.125  mm,	Z =   -20.045  mm,
	W =   -89.229 deg,	P =      .376 deg,	R =   -90.838 deg
};
P[28]{
   GP1:
	UF : 5, UT : 2,		CONFIG : 'N U T, 0, 0, -1',
	X =   169.188  mm,	Y =   295.422  mm,	Z =  -922.193  mm,
	W =   -66.543 deg,	P =      .306 deg,	R =      .177 deg
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
	X =  -333.193  mm,	Y =   -17.301  mm,	Z =   -23.415  mm,
	W =   -90.188 deg,	P =      .792 deg,	R =   -90.049 deg
};
P[32]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -148.113  mm,	Y =   -16.724  mm,	Z =   -17.525  mm,
	W =   -89.229 deg,	P =      .376 deg,	R =   -90.838 deg
};
P[33]{
   GP1:
	UF : 3, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =  -356.760  mm,	Y =    -3.009  mm,	Z =   -16.426  mm,
	W =   -90.581 deg,	P =      .095 deg,	R =   -89.917 deg
};
P[34]{
   GP1:
	UF : 3, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =  -180.001  mm,	Y =   -17.049  mm,	Z =   -16.427  mm,
	W =   -90.582 deg,	P =      .242 deg,	R =   -90.050 deg
};
P[35]{
   GP1:
	UF : 3, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   -67.560  mm,	Y =    -3.010  mm,	Z =   -16.427  mm,
	W =   -90.582 deg,	P =      .242 deg,	R =   -90.050 deg
};
P[36]{
   GP1:
	UF : 3, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   -82.284  mm,	Y =   -13.294  mm,	Z =   -16.576  mm,
	W =   -90.188 deg,	P =      .001 deg,	R =   -90.046 deg
};
P[37]{
   GP1:
	UF : 3, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   -82.273  mm,	Y =   -17.304  mm,	Z =   -23.414  mm,
	W =   -90.188 deg,	P =      .792 deg,	R =   -90.048 deg
};
P[38]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -414.512  mm,	Y =    -4.127  mm,	Z =   -10.325  mm,
	W =   -89.229 deg,	P =      .376 deg,	R =   -90.838 deg
};
P[39]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -252.513  mm,	Y =   -16.726  mm,	Z =   -17.525  mm,
	W =   -89.229 deg,	P =      .376 deg,	R =   -90.837 deg
};
P[40]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -140.846  mm,	Y =    -2.977  mm,	Z =   -19.589  mm,
	W =   -88.853 deg,	P =      .014 deg,	R =   -90.037 deg
};
P[41]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -130.145  mm,	Y =     3.874  mm,	Z =   -19.467  mm,
	W =   -88.852 deg,	P =      .013 deg,	R =   -89.315 deg
};
P[42]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -233.134  mm,	Y =      .163  mm,	Z =   -20.032  mm,
	W =   -88.851 deg,	P =      .017 deg,	R =   -90.038 deg
};
P[43]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -312.173  mm,	Y =      .163  mm,	Z =   -20.034  mm,
	W =   -88.851 deg,	P =      .000 deg,	R =   -90.038 deg
};
P[44]{
   GP1:
	UF : 3, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =  -202.873  mm,	Y =   -17.302  mm,	Z =   -23.415  mm,
	W =   -90.188 deg,	P =      .792 deg,	R =   -90.049 deg
};
P[45]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -616.282  mm,	Y =   -10.340  mm,	Z =  -309.114  mm,
	W =   179.469 deg,	P =     -.188 deg,	R =   179.955 deg
};
P[49]{
   GP1:
	UF : 4, UT : 2,		CONFIG : 'N U T, 0, 0, -1',
	X =  -302.007  mm,	Y =    47.282  mm,	Z =    79.735  mm,
	W =   -90.707 deg,	P =      .218 deg,	R =   -90.929 deg
};
P[50]{
   GP1:
	UF : 4, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X = -1813.986  mm,	Y =   639.891  mm,	Z =   404.747  mm,
	W =  -111.166 deg,	P =   -38.099 deg,	R =    76.425 deg
};
P[51]{
   GP1:
	UF : 5, UT : 2,		CONFIG : 'F U T, 0, 0, 0',
	X =  -687.169  mm,	Y =   127.479  mm,	Z =  -708.758  mm,
	W =   116.874 deg,	P =   -56.363 deg,	R =   -75.501 deg
};
/END
