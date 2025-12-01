/PROG  PNS900
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "STEHOVANI R6";
PROG_SIZE	= 4616;
CREATE		= DATE 22-07-25  TIME 20:46:08;
MODIFIED	= DATE 22-08-02  TIME 17:44:58;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 129;
MEMORY_SIZE	= 4984;
PROTECT		= READ_WRITE;
TCD:  STACK_SIZE	= 0,
      TASK_PRIORITY	= 50,
      TIME_SLICE	= 0,
      BUSY_LAMP_OFF	= 0,
      ABORT_REQUEST	= 0,
      PAUSE_REQUEST	= 0;
DEFAULT_GROUP	= 1,*,*,*,*;
CONTROL_CODE	= 00000000 00000000;
/MN
   1:   ;
   2:  ! SHAWER 2 ;
   3:   ;
   4:  UFRAME_NUM=3 ;
   5:  UTOOL_NUM=1 ;
   6:   ;
   7:J P[3] 100% CNT0    ;
   8:J P[2] 100% CNT0    ;
   9:   ;
  10:  !L ;
  11:J P[1] 100% FINE    ;
  12:J P[40] 100% FINE    ;
  13:   ;
  14:J P[4] 100% CNT50    ;
  15:J P[7] 100% CNT100    ;
  16:J P[5] 100% CNT50    ;
  17:   ;
  18:  !P ;
  19:J P[6] 100% FINE    ;
  20:J P[45] 100% FINE    ;
  21:   ;
  22:J P[8] 100% CNT50    ;
  23:J P[9] 100% CNT100    ;
  24:   ;
  25:  !5KROK ;
  26:   ;
  27:  UFRAME_NUM=2 ;
  28:  UTOOL_NUM=1 ;
  29:   ;
  30:J P[10] 100% CNT0    ;
  31:J P[12] 100% CNT0    ;
  32:   ;
  33:  !L ;
  34:J P[13] 100% FINE    ;
  35:   ;
  36:  //J P[50] 100% FINE    ;
  37:   ;
  38:J P[14] 100% CNT50    ;
  39:J P[15] 100% CNT100    ;
  40:J P[11] 100% CNT100    ;
  41:J P[20] 100% CNT0    ;
  42:   ;
  43:  !P ;
  44:J P[21] 100% FINE    ;
  45:   ;
  46:  //J P[51] 100% FINE    ;
  47:   ;
  48:J P[22] 100% CNT50    ;
  49:J P[23] 100% CNT100    ;
  50:   ;
  51:  !***************** ;
  52:  !Vstupni zasobnik ;
  53:  !***************** ;
  54:   ;
  55:  UFRAME_NUM=1 ;
  56:  UTOOL_NUM=1 ;
  57:J P[28] 100% CNT0    ;
  58:J P[56] 100% CNT100    ;
  59:J P[29] 100% CNT100    ;
  60:J P[24] 100% CNT50    ;
  61:   ;
  62:  !L ;
  63:J P[25] 100% FINE    ;
  64:  //J P[58] 100% FINE    ;
  65:   ;
  66:J P[26] 100% CNT50    ;
  67:J P[30] 100% CNT100    ;
  68:J P[16] 100% CNT50    ;
  69:   ;
  70:  !P ;
  71:J P[17] 100% FINE    ;
  72:  //J P[57] 100% FINE    ;
  73:   ;
  74:J P[18] 100% CNT50    ;
  75:J P[19] 100% CNT100    ;
  76:   ;
  77:   ;
  78:  !***************** ;
  79:  !FREZA ;
  80:  !***************** ;
  81:   ;
  82:  UFRAME_NUM=4 ;
  83:  UTOOL_NUM=1 ;
  84:   ;
  85:J P[27] 100% CNT0    ;
  86:J P[31] 100% CNT100    ;
  87:J P[32] 100% CNT50    ;
  88:   ;
  89:  !L ;
  90:J P[33] 100% FINE    ;
  91:  //J P[52] 100% FINE    ;
  92:   ;
  93:J P[34] 100% CNT50    ;
  94:J P[35] 100% CNT100    ;
  95:J P[36] 100% CNT50    ;
  96:   ;
  97:  !P ;
  98:J P[37] 100% FINE    ;
  99:  //J P[53] 100% FINE    ;
 100:   ;
 101:J P[38] 100% CNT50    ;
 102:J P[39] 100% CNT100    ;
 103:   ;
 104:  !***************** ;
 105:  !Vyst.zasobnik ;
 106:  !***************** ;
 107:   ;
 108:  UFRAME_NUM=5 ;
 109:  UTOOL_NUM=1 ;
 110:   ;
 111:J P[41] 100% CNT100    ;
 112:J P[42] 100% CNT50    ;
 113:   ;
 114:  !L ;
 115:J P[43] 100% FINE    ;
 116:  //J P[54] 100% FINE    ;
 117:   ;
 118:J P[44] 100% CNT50    ;
 119:J P[46] 100% CNT50    ;
 120:   ;
 121:  !P ;
 122:J P[47] 100% FINE    ;
 123:   ;
 124:  //J P[55] 100% FINE    ;
 125:   ;
 126:J P[48] 100% CNT50    ;
 127:J P[49] 100% CNT0    ;
 128:   ;
 129:   ;
/POS
P[1]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -266.146  mm,	Y =   209.157  mm,	Z =  -240.812  mm,
	W =   -90.463 deg,	P =      .404 deg,	R =   -90.831 deg
};
P[2]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -434.962  mm,	Y =   209.156  mm,	Z =  -240.812  mm,
	W =   -90.463 deg,	P =      .404 deg,	R =   -90.831 deg
};
P[3]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -522.805  mm,	Y =   393.752  mm,	Z =  -238.749  mm,
	W =   -90.292 deg,	P =      .470 deg,	R =   -72.998 deg
};
P[4]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -459.485  mm,	Y =   209.186  mm,	Z =  -240.840  mm,
	W =   -90.467 deg,	P =      .404 deg,	R =   -90.828 deg
};
P[5]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -459.487  mm,	Y =  -384.814  mm,	Z =  -240.840  mm,
	W =   -90.467 deg,	P =      .404 deg,	R =   -90.828 deg
};
P[6]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -268.161  mm,	Y =  -384.807  mm,	Z =  -240.850  mm,
	W =   -90.467 deg,	P =      .405 deg,	R =   -90.826 deg
};
P[7]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -349.168  mm,	Y =   -37.273  mm,	Z =  -372.347  mm,
	W =   -90.429 deg,	P =      .421 deg,	R =   -90.841 deg
};
P[8]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -472.172  mm,	Y =  -384.808  mm,	Z =  -240.850  mm,
	W =   -90.467 deg,	P =      .405 deg,	R =   -90.826 deg
};
P[9]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -782.628  mm,	Y =  -673.481  mm,	Z =  -240.425  mm,
	W =   -90.376 deg,	P =     -.491 deg,	R =   175.677 deg
};
P[10]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -832.996  mm,	Y =   536.559  mm,	Z =  -238.909  mm,
	W =   -90.008 deg,	P =      .029 deg,	R =   -76.165 deg
};
P[11]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -646.560  mm,	Y =   -35.405  mm,	Z =   -28.879  mm,
	W =   -90.337 deg,	P =     -.028 deg,	R =   -90.697 deg
};
P[12]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -493.198  mm,	Y =   588.717  mm,	Z =  -158.478  mm,
	W =   -90.337 deg,	P =     -.028 deg,	R =   -90.696 deg
};
P[13]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -414.930  mm,	Y =   588.718  mm,	Z =  -158.478  mm,
	W =   -90.337 deg,	P =     -.028 deg,	R =   -90.696 deg
};
P[14]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -493.198  mm,	Y =   588.717  mm,	Z =  -158.478  mm,
	W =   -90.337 deg,	P =     -.028 deg,	R =   -90.696 deg
};
P[15]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -565.560  mm,	Y =   459.115  mm,	Z =   -28.878  mm,
	W =   -90.337 deg,	P =     -.028 deg,	R =   -90.696 deg
};
P[16]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   933.591  mm,	Y =  -290.303  mm,	Z =  -401.381  mm,
	W =   -91.341 deg,	P =    -1.230 deg,	R =     -.898 deg
};
P[17]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   988.065  mm,	Y =  -225.257  mm,	Z =  -401.471  mm,
	W =   -91.346 deg,	P =    -1.226 deg,	R =     -.890 deg
};
P[18]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   933.591  mm,	Y =  -290.303  mm,	Z =  -401.381  mm,
	W =   -91.341 deg,	P =    -1.230 deg,	R =     -.898 deg
};
P[19]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   934.553  mm,	Y =  -366.474  mm,	Z =  -126.081  mm,
	W =  -108.870 deg,	P =   -13.512 deg,	R =    -4.090 deg
};
P[20]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -523.984  mm,	Y =  -764.707  mm,	Z =  -167.506  mm,
	W =   -90.337 deg,	P =     -.020 deg,	R =   -90.704 deg
};
P[21]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -414.963  mm,	Y =  -764.706  mm,	Z =  -167.506  mm,
	W =   -90.337 deg,	P =     -.020 deg,	R =   -90.704 deg
};
P[22]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -523.984  mm,	Y =  -764.707  mm,	Z =  -167.506  mm,
	W =   -90.337 deg,	P =     -.020 deg,	R =   -90.704 deg
};
P[23]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -683.209  mm,	Y =  -767.969  mm,	Z =  -188.029  mm,
	W =   -90.082 deg,	P =     -.323 deg,	R =  -162.418 deg
};
P[24]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -34.887  mm,	Y =  -300.005  mm,	Z =  -397.155  mm,
	W =   -91.335 deg,	P =    -1.228 deg,	R =     -.911 deg
};
P[25]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -34.888  mm,	Y =  -226.025  mm,	Z =  -397.156  mm,
	W =   -91.335 deg,	P =    -1.228 deg,	R =     -.911 deg
};
P[26]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -34.887  mm,	Y =  -300.005  mm,	Z =  -397.155  mm,
	W =   -91.335 deg,	P =    -1.228 deg,	R =     -.911 deg
};
P[27]{
   GP1:
	UF : 4, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -239.004  mm,	Y =   433.276  mm,	Z =   -94.108  mm,
	W =   -72.653 deg,	P =    -8.393 deg,	R =   -62.750 deg
};
P[28]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -120.111  mm,	Y =  -473.714  mm,	Z =    51.433  mm,
	W =  -116.611 deg,	P =    24.873 deg,	R =    40.048 deg
};
P[29]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   100.050  mm,	Y =  -405.257  mm,	Z =  -102.006  mm,
	W =  -104.844 deg,	P =   -17.138 deg,	R =     -.783 deg
};
P[30]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   677.100  mm,	Y =  -367.740  mm,	Z =  -290.798  mm,
	W =   -91.337 deg,	P =    -1.229 deg,	R =     -.895 deg
};
P[31]{
   GP1:
	UF : 4, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -543.633  mm,	Y =   324.964  mm,	Z =   -84.438  mm,
	W =   -90.961 deg,	P =      .195 deg,	R =   -65.716 deg
};
P[32]{
   GP1:
	UF : 4, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -516.850  mm,	Y =   200.721  mm,	Z =   -84.414  mm,
	W =   -90.952 deg,	P =     -.232 deg,	R =   -90.939 deg
};
P[33]{
   GP1:
	UF : 4, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -432.718  mm,	Y =   200.721  mm,	Z =   -84.413  mm,
	W =   -90.952 deg,	P =     -.232 deg,	R =   -90.939 deg
};
P[34]{
   GP1:
	UF : 4, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -516.850  mm,	Y =   200.721  mm,	Z =   -84.414  mm,
	W =   -90.952 deg,	P =     -.232 deg,	R =   -90.939 deg
};
P[35]{
   GP1:
	UF : 4, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -553.744  mm,	Y =    48.918  mm,	Z =   -96.752  mm,
	W =   -90.926 deg,	P =     -.215 deg,	R =   -90.943 deg
};
P[36]{
   GP1:
	UF : 4, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -536.312  mm,	Y =  -103.654  mm,	Z =  -109.641  mm,
	W =   -90.955 deg,	P =     -.231 deg,	R =   -90.942 deg
};
P[37]{
   GP1:
	UF : 4, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -434.144  mm,	Y =  -103.653  mm,	Z =  -109.641  mm,
	W =   -90.955 deg,	P =     -.231 deg,	R =   -90.942 deg
};
P[38]{
   GP1:
	UF : 4, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -536.312  mm,	Y =  -103.654  mm,	Z =  -109.641  mm,
	W =   -90.955 deg,	P =     -.231 deg,	R =   -90.942 deg
};
P[39]{
   GP1:
	UF : 4, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -581.314  mm,	Y =   136.427  mm,	Z =   469.892  mm,
	W =   -90.209 deg,	P =     -.462 deg,	R =   -90.982 deg
};
P[40]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -260.387  mm,	Y =   209.877  mm,	Z =  -242.829  mm,
	W =   -90.463 deg,	P =      .404 deg,	R =   -90.831 deg
};
P[41]{
   GP1:
	UF : 5, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    84.674  mm,	Y =   -54.682  mm,	Z =  -745.281  mm,
	W =   -66.046 deg,	P =     -.294 deg,	R =     -.149 deg
};
P[42]{
   GP1:
	UF : 5, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   -35.956  mm,	Y =   104.998  mm,	Z =  -324.876  mm,
	W =   -65.658 deg,	P =     -.081 deg,	R =     -.010 deg
};
P[43]{
   GP1:
	UF : 5, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   -37.149  mm,	Y =   168.694  mm,	Z =  -296.281  mm,
	W =   -65.657 deg,	P =     -.082 deg,	R =     -.009 deg
};
P[44]{
   GP1:
	UF : 5, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   -35.956  mm,	Y =   104.998  mm,	Z =  -324.876  mm,
	W =   -65.658 deg,	P =     -.081 deg,	R =     -.010 deg
};
P[45]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -258.478  mm,	Y =  -384.268  mm,	Z =  -241.897  mm,
	W =   -90.470 deg,	P =      .408 deg,	R =   -90.826 deg
};
P[46]{
   GP1:
	UF : 5, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   313.675  mm,	Y =    84.324  mm,	Z =  -335.063  mm,
	W =   -65.660 deg,	P =     -.081 deg,	R =     -.009 deg
};
P[47]{
   GP1:
	UF : 5, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   312.041  mm,	Y =   170.855  mm,	Z =  -296.223  mm,
	W =   -65.659 deg,	P =     -.082 deg,	R =     -.008 deg
};
P[48]{
   GP1:
	UF : 5, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   311.764  mm,	Y =   106.255  mm,	Z =  -318.885  mm,
	W =   -65.659 deg,	P =     -.082 deg,	R =     -.008 deg
};
P[49]{
   GP1:
	UF : 5, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   321.018  mm,	Y =  -313.047  mm,	Z =  -513.360  mm,
	W =   -65.660 deg,	P =     -.081 deg,	R =     -.009 deg
};
P[50]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -364.890  mm,	Y =   608.160  mm,	Z =  -154.339  mm,
	W =   -90.337 deg,	P =     -.028 deg,	R =   -90.696 deg
};
P[51]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -368.846  mm,	Y =  -745.085  mm,	Z =  -156.659  mm,
	W =   -90.337 deg,	P =     -.020 deg,	R =   -90.705 deg
};
P[52]{
   GP1:
	UF : 4, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -429.760  mm,	Y =   205.985  mm,	Z =   -78.057  mm,
	W =   -90.952 deg,	P =     -.232 deg,	R =   -90.939 deg
};
P[53]{
   GP1:
	UF : 4, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -419.750  mm,	Y =   -98.012  mm,	Z =  -105.886  mm,
	W =   -90.957 deg,	P =     -.231 deg,	R =   -90.938 deg
};
P[54]{
   GP1:
	UF : 5, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   -37.932  mm,	Y =   169.946  mm,	Z =  -284.815  mm,
	W =   -65.657 deg,	P =     -.082 deg,	R =     -.010 deg
};
P[55]{
   GP1:
	UF : 5, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   310.028  mm,	Y =   200.179  mm,	Z =  -276.743  mm,
	W =   -65.659 deg,	P =     -.082 deg,	R =     -.008 deg
};
P[56]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   -51.473  mm,	Y =  -421.992  mm,	Z =   123.637  mm,
	W =   -90.316 deg,	P =    28.575 deg,	R =    19.243 deg
};
P[57]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   988.886  mm,	Y =  -210.699  mm,	Z =  -387.291  mm,
	W =   -91.348 deg,	P =    -1.224 deg,	R =     -.881 deg
};
P[58]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -33.591  mm,	Y =  -229.373  mm,	Z =  -389.848  mm,
	W =   -91.335 deg,	P =    -1.228 deg,	R =     -.911 deg
};
/END
