/PROG  PROG20
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Vyroba 18 <370m";
PROG_SIZE	= 6039;
CREATE		= DATE 15-09-10  TIME 17:16:02;
MODIFIED	= DATE 22-11-12  TIME 21:04:54;
FILE_NAME	= PROG10;
VERSION		= 0;
LINE_COUNT	= 216;
MEMORY_SIZE	= 6455;
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
  15:  UTOOL_NUM=3 ;
  16:J P[2] 100% CNT20    ;
  17:   ;
  18:  !Greifer OK? ;
  19:  WAIT (!DI[15] AND DI[16])    ;
  20:   ;
  21:  !Delka trubky OK? ;
  22:  LBL[1] ;
  23:  R[10]=GI[2]    ;
  24:  IF (R[10]<150 OR R[10]>300),JMP LBL[1] ;
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
  44:  PR[10,1]=0    ;
  45:  PR[10,2]=0    ;
  46:  PR[10,3]=167-R[10]    ;
  47:  PR[10,4]=0    ;
  48:  PR[10,5]=0    ;
  49:  PR[10,6]=0    ;
  50:   ;
  51:  UFRAME_NUM=1 ;
  52:  UTOOL_NUM=3 ;
  53:J P[100] 100% CNT30 TB   0.00sec,DO[110]=ON Tool_Offset,PR[10]    ;
  54:L P[101] 800mm/sec FINE TB    .05sec,DO[57]=ON Tool_Offset,PR[10]    ;
  55:   ;
  56:  DO[51]=OFF ;
  57:  WAIT (DI[52])    ;
  58:   ;
  59:L P[102] 1200mm/sec CNT70 TB   0.00sec,DO[110]=OFF Tool_Offset,PR[10]    ;
  60:  LBL[20] ;
  61:J P[3] 100% CNT80 TB   0.00sec,DO[57]=OFF    ;
  62:   ;
  63:   ;
  64:  !TOOL_OFFSET pro UTOOL 1 ;
  65:  PR[21,1]=0    ;
  66:  PR[21,2]=0    ;
  67:  PR[21,3]=167-R[10]    ;
  68:  PR[21,4]=0    ;
  69:  PR[21,5]=0    ;
  70:  PR[21,6]=0    ;
  71:  !TOOL_OFFSET pro UTOOL 2 ;
  72:  PR[22]=PR[21]    ;
  73:   ;
  74:  !Upinac 1 Pripraven? ;
  75:  WAIT (DI[65] AND DI[49] AND !DI[50])    ;
  76:   ;
  77:  !***************** ;
  78:  !Shawer 2 ;
  79:  !***************** ;
  80:   ;
  81:  GO[3]=3 ;
  82:   ;
  83:  !Vyjmuti trubky SHAWER 2 ;
  84:   ;
  85:  UFRAME_NUM=3 ;
  86:  UTOOL_NUM=4 ;
  87:  //J P[17] 100% FINE    ;
  88:J P[4] 100% CNT100    ;
  89:J P[18] 100% CNT100 Tool_Offset,PR[21]    ;
  90:J P[19] 100% CNT50 Tool_Offset,PR[21] TB    .05sec,DO[112]=ON    ;
  91:L P[20] 1000mm/sec FINE Tool_Offset,PR[21]    ;
  92:   ;
  93:  IF (DI[66] AND !DI[68]),JMP LBL[31] ;
  94:  DO[49]=OFF ;
  95:  WAIT (DI[50])    ;
  96:  DO[66]=ON ;
  97:  WAIT (DI[66] AND !DI[68])    ;
  98:  DO[66]=OFF ;
  99:  LBL[31] ;
 100:   ;
 101:L P[21] 500mm/sec CNT50 Tool_Offset,PR[21]    ;
 102:L P[7] 500mm/sec CNT100 Tool_Offset,PR[21] TB   0.00sec,DO[67]=ON    ;
 103:L P[22] 2000mm/sec CNT100 Tool_Offset,PR[21] TB    .05sec,DO[112]=OFF    ;
 104:   ;
 105:  !Vlozeni trubky SHAWER 2 ;
 106:  WAIT (DI[66] AND !DI[68])    ;
 107:   ;
 108:  !Korekce st.2 B ;
 109:  WAIT R[15]>=(-2) AND R[15]<=2    ;
 110:  PR[22,3]=PR[21,3]+R[15]    ;
 111:   ;
 112:  UFRAME_NUM=3 ;
 113:  UTOOL_NUM=3 ;
 114:  //J P[23] 100% FINE    ;
 115:J P[24] 100% CNT50 Tool_Offset,PR[22]    ;
 116:L P[25] 1500mm/sec CNT30 Tool_Offset,PR[22] TB    .05sec,DO[112]=ON    ;
 117:L P[26] 1500mm/sec CNT80 Tool_Offset,PR[22]    ;
 118:L P[5] 1000mm/sec CNT80 Tool_Offset,PR[22]    ;
 119:L P[27] 600mm/sec FINE Tool_Offset,PR[22]    ;
 120:   ;
 121:  IF (!DI[52]),JMP LBL[32] ;
 122:  !Kontakt? ;
 123:  WAIT (DI[67])    ;
 124:  DO[68]=ON ;
 125:  WAIT (DI[68] AND !DI[66])    ;
 126:  DO[51]=ON ;
 127:   ;
 128:  WAIT (DI[51])    ;
 129:   ;
 130:  DO[68]=OFF ;
 131:  LBL[32] ;
 132:  DO[65]=ON ;
 133:  WAIT (!DI[65])    ;
 134:  DO[65]=OFF ;
 135:   ;
 136:L P[28] 1500mm/sec CNT80 Tool_Offset,PR[22]    ;
 137:J P[29] 100% CNT100 Tool_Offset,PR[22] TB    .05sec,DO[112]=OFF    ;
 138:   ;
 139:   ;
 140:  !***************** ;
 141:  !Freza 1 ;
 142:  !***************** ;
 143:   ;
 144:  GO[3]=4 ;
 145:   ;
 146:  UFRAME_NUM=4 ;
 147:  UTOOL_NUM=4 ;
 148:   ;
 149:  !Korekce st.3 B ;
 150:  WAIT R[16]>=(-2) AND R[16]<=2    ;
 151:  PR[21,3]=167-R[10]+R[16]    ;
 152:   ;
 153:  //J P[30] 100% FINE    ;
 154:J P[31] 100% CNT100    ;
 155:J P[32] 100% CNT100    ;
 156:   ;
 157:  IF ((!DI[50] AND DI[49]) OR !DI[69]),JMP LBL[41] ;
 158:   ;
 159:J P[33] 100% CNT80 TB    .05sec,DO[113]=ON Tool_Offset,PR[21]    ;
 160:   ;
 161:L P[6] 1200mm/sec CNT80 Tool_Offset,PR[21]    ;
 162:L P[34] 900mm/sec CNT80 Tool_Offset,PR[21]    ;
 163:L P[35:Freza] 100mm/sec FINE Tool_Offset,PR[21]    ;
 164:   ;
 165:  !Doba frezovani ;
 166:  WAIT R[7] ;
 167:  DO[69]=PULSE,0.2sec ;
 168:   ;
 169:L P[36] 1500mm/sec CNT100 Tool_Offset,PR[21]    ;
 170:J P[37] 100% CNT80 TB   0.00sec,DO[113]=OFF Tool_Offset,PR[21]    ;
 171:   ;
 172:  LBL[41] ;
 173:   ;
 174:  !***************** ;
 175:  !Vylozeni skluz ;
 176:  !***************** ;
 177:  GO[3]=5 ;
 178:   ;
 179:  UFRAME_NUM=1 ;
 180:  UTOOL_NUM=4 ;
 181:  //J P[38] 100% FINE    ;
 182:   ;
 183:  !TOOL_OFFSET pro UTOOL 1 ;
 184:  PR[23,1]=0    ;
 185:  PR[23,2]=0    ;
 186:  PR[23,3]=((92-R[10])/2) ;
 187:  PR[23,4]=0    ;
 188:  PR[23,5]=0    ;
 189:  PR[23,6]=0    ;
 190:   ;
 191:   ;
 192:J P[39] 100% CNT100    ;
 193:J P[40] 100% CNT80 Tool_Offset,PR[23]    ;
 194:   ;
 195:J P[41] 100% FINE TB    .50sec,DO[49]=ON Tool_Offset,PR[23]    ;
 196:   ;
 197:  WAIT (DI[49])    ;
 198:  IF (DI[49]),DO[73]=PULSE,0.5sec ;
 199:   ;
 200:L P[42] 500mm/sec CNT80 Tool_Offset,PR[23]    ;
 201:  //J P[43] 100% CNT100    ;
 202:J P[44] 100% CNT100    ;
 203:   ;
 204:   ;
 205:  !Konec cyklu ;
 206:  IF (DI[54]),JMP LBL[50] ;
 207:   ;
 208:  JMP LBL[100] ;
 209:   ;
 210:  LBL[50] ;
 211:   ;
 212:  UFRAME_NUM=1 ;
 213:  UTOOL_NUM=4 ;
 214:J P[45] 20% CNT100    ;
 215:  !HOME ;
 216:J PR[2] 20% FINE    ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 4,		CONFIG : 'F U T, 0, 0, 0',
	X =    38.490  mm,	Y =  -127.414  mm,	Z =  1350.863  mm,
	W =    63.834 deg,	P =   -64.706 deg,	R =   -45.826 deg
};
P[2]{
   GP1:
	UF : 1, UT : 3,		CONFIG : 'F U T, 0, 0, 0',
	X =   445.220  mm,	Y =    82.183  mm,	Z =   190.851  mm,
	W =   -88.884 deg,	P =   -65.723 deg,	R =    88.936 deg
};
P[3]{
   GP1:
	UF : 1, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =   240.398  mm,	Y =  -116.730  mm,	Z =   413.438  mm,
	W =   -93.819 deg,	P =   -31.896 deg,	R =    90.020 deg
};
P[4]{
   GP1:
	UF : 3, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X = -1133.960  mm,	Y =  -739.983  mm,	Z =    93.789  mm,
	W =  -117.335 deg,	P =   -35.189 deg,	R =   -88.228 deg
};
P[5]{
   GP1:
	UF : 3, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =   -21.619  mm,	Y =    -1.689  mm,	Z =   -16.102  mm,
	W =   -90.214 deg,	P =   -14.034 deg,	R =   -90.713 deg
};
P[6]{
   GP1:
	UF : 4, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =  -311.006  mm,	Y =    47.308  mm,	Z =    79.810  mm,
	W =   -90.357 deg,	P =      .161 deg,	R =   -90.308 deg
};
P[7]{
   GP1:
	UF : 3, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =  -118.342  mm,	Y =   -22.742  mm,	Z =   -16.449  mm,
	W =   -90.547 deg,	P =      .810 deg,	R =   -90.950 deg
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
	X =   -50.731  mm,	Y =    -2.621  mm,	Z =   -17.347  mm,
	W =   -90.582 deg,	P =      .820 deg,	R =   -89.925 deg
};
P[20]{
   GP1:
	UF : 3, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =     8.644  mm,	Y =    -2.527  mm,	Z =   -17.442  mm,
	W =   -90.573 deg,	P =      .817 deg,	R =   -90.204 deg
};
P[21]{
   GP1:
	UF : 3, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =     4.117  mm,	Y =   -24.754  mm,	Z =   -17.618  mm,
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
	X =  -177.255  mm,	Y =   -19.757  mm,	Z =   -17.683  mm,
	W =   -90.334 deg,	P =   -14.034 deg,	R =   -90.629 deg
};
P[26]{
   GP1:
	UF : 3, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =   -10.982  mm,	Y =   -19.128  mm,	Z =   -18.320  mm,
	W =   -90.324 deg,	P =   -14.034 deg,	R =   -90.712 deg
};
P[27]{
   GP1:
	UF : 3, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =     9.406  mm,	Y =    -2.108  mm,	Z =   -16.212  mm,
	W =   -90.214 deg,	P =   -14.034 deg,	R =   -90.713 deg
};
P[28]{
   GP1:
	UF : 3, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =   -54.135  mm,	Y =    -2.353  mm,	Z =   -17.590  mm,
	W =   -90.324 deg,	P =   -14.034 deg,	R =   -90.711 deg
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
	X =  -234.809  mm,	Y =    46.899  mm,	Z =    79.336  mm,
	W =   -90.357 deg,	P =      .161 deg,	R =   -90.308 deg
};
P[35:"Freza"]{
   GP1:
	UF : 4, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =  -222.451  mm,	Y =    46.858  mm,	Z =    79.771  mm,
	W =   -90.368 deg,	P =      .161 deg,	R =   -90.300 deg
};
P[36]{
   GP1:
	UF : 4, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =  -311.006  mm,	Y =    47.308  mm,	Z =    79.810  mm,
	W =   -90.357 deg,	P =      .161 deg,	R =   -90.309 deg
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
	X =   920.160  mm,	Y =   295.928  mm,	Z =  -102.770  mm,
	W =  -145.420 deg,	P =   -17.730 deg,	R =   -35.450 deg
};
P[41]{
   GP1:
	UF : 1, UT : 4,		CONFIG : 'N U T, 0, 0, -1',
	X =   941.695  mm,	Y =   319.631  mm,	Z =  -121.462  mm,
	W =  -131.068 deg,	P =   -16.014 deg,	R =   -34.942 deg
};
P[42]{
   GP1:
	UF : 1, UT : 4,		CONFIG : 'N U T, 0, 0, -1',
	X =   843.938  mm,	Y =   206.628  mm,	Z =    20.218  mm,
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
	UF : 1, UT : 4,		CONFIG : 'N U T, 0, 0, 0',
	X =   449.949  mm,	Y =    57.269  mm,	Z =   195.577  mm,
	W =   -93.405 deg,	P =     9.892 deg,	R =    87.300 deg
};
P[45]{
   GP1:
	UF : 1, UT : 4,		CONFIG : 'F U T, 0, 0, 0',
	X =    38.498  mm,	Y =  -127.408  mm,	Z =  1350.855  mm,
	W =    63.833 deg,	P =   -64.707 deg,	R =   -45.827 deg
};
P[100]{
   GP1:
	UF : 1, UT : 3,		CONFIG : 'F U T, 0, 0, 0',
	X =   234.501  mm,	Y =     8.271  mm,	Z =     8.559  mm,
	W =   -89.254 deg,	P =   -53.707 deg,	R =    88.884 deg
};
P[101]{
   GP1:
	UF : 1, UT : 3,		CONFIG : 'F U T, 0, 0, 0',
	X =   136.634  mm,	Y =     9.149  mm,	Z =     9.314  mm,
	W =   -89.254 deg,	P =   -53.707 deg,	R =    88.883 deg
};
P[102]{
   GP1:
	UF : 1, UT : 3,		CONFIG : 'F U T, 0, 0, 0',
	X =   234.097  mm,	Y =    77.823  mm,	Z =   103.281  mm,
	W =   -89.254 deg,	P =   -53.707 deg,	R =    88.883 deg
};
/END
