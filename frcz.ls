/PROG  FRCZ
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 1007;
CREATE		= DATE 17-01-13  TIME 16:51:54;
MODIFIED	= DATE 25-03-20  TIME 19:37:46;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 20;
MEMORY_SIZE	= 1431;
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
   1:J P[8:HOME] 100% FINE    ;
   2:  END ;
   3:J P[9] 5% CNT100    ;
   4:   ;
   5:   ;
   6:   ;
   7:  JMP LBL[...] ;
   8:L P[2] 100mm/sec FINE    ;
   9:L P[3] 100mm/sec FINE    ;
  10:  JMP LBL[1] ;
  11:L P[4] 100mm/sec FINE    ;
  12:L P[1:HOME] 100mm/sec FINE    ;
  13:  END ;
  14:J P[5] 5% FINE    ;
  15:   ;
  16:  LBL[1] ;
  17:J P[6] 100% FINE    ;
  18:J P[7] 100% FINE    ;
  19:   ;
  20:  JMP LBL[1] ;
/POS
P[1:"HOME"]{
   GP1:
	UF : 1, UT : 2,	
	J1=    33.578 deg,	J2=   -42.883 deg,	J3=    70.004 deg,
	J4=      .000 deg,	J5=    20.000 deg,	J6=   -90.000 deg
};
P[2]{
   GP1:
	UF : 1, UT : 4,		CONFIG : 'F U B, 0, 0, 0',
	X =   966.106  mm,	Y =  -472.565  mm,	Z =  1773.109  mm,
	W =    56.888 deg,	P =    14.767 deg,	R =    21.002 deg
};
P[3]{
   GP1:
	UF : 1, UT : 4,		CONFIG : 'F U B, 0, 0, 0',
	X =   863.024  mm,	Y =  -628.783  mm,	Z =  1886.654  mm,
	W =    54.153 deg,	P =    -2.217 deg,	R =    -3.411 deg
};
P[4]{
   GP1:
	UF : 1, UT : 4,	
	J1=    33.578 deg,	J2=   -42.883 deg,	J3=    70.004 deg,
	J4=     0.000 deg,	J5=    20.000 deg,	J6=   -90.000 deg
};
P[5]{
   GP1:
	UF : 1, UT : 4,		CONFIG : 'F U B, 0, 0, 0',
	X =   884.098  mm,	Y =  -608.884  mm,	Z =  1872.180  mm,
	W =    54.094 deg,	P =      .319 deg,	R =      .101 deg
};
P[6]{
   GP1:
	UF : 1, UT : 4,	
	J1=   -20.952 deg,	J2=   -77.643 deg,	J3=   -10.713 deg,
	J4=   -22.825 deg,	J5=    19.998 deg,	J6=   -89.993 deg
};
P[7]{
   GP1:
	UF : 1, UT : 4,		CONFIG : 'F U B, 0, 0, 0',
	X =  1227.329  mm,	Y = -1938.984  mm,	Z =  1851.220  mm,
	W =    69.129 deg,	P =    26.315 deg,	R =   -45.286 deg
};
P[8:"HOME"]{
   GP1:
	UF : 1, UT : 2,	
	J1=    33.581 deg,	J2=   -42.884 deg,	J3=    70.005 deg,
	J4=      .000 deg,	J5=    20.004 deg,	J6=   -90.005 deg
};
P[9]{
   GP1:
	UF : 1, UT : 2,	
	J1=    33.577 deg,	J2=   -42.883 deg,	J3=    70.004 deg,
	J4=      .000 deg,	J5=    20.001 deg,	J6=   -90.001 deg
};
/END
