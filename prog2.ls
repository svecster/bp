/PROG  PROG2
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Vychozi";
PROG_SIZE	= 2017;
CREATE		= DATE 14-11-24  TIME 23:26:08;
MODIFIED	= DATE 22-11-12  TIME 21:48:36;
FILE_NAME	= PROG1;
VERSION		= 0;
LINE_COUNT	= 82;
MEMORY_SIZE	= 2513;
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
   1:  UFRAME_NUM=0 ;
   2:  UTOOL_NUM=1 ;
   3:   ;
   4:  !Vychozi pozice ;
   5:  DO[49]=ON ;
   6:  DO[51]=ON ;
   7:  GO[3]=0 ;
   8:   ;
   9:  OVERRIDE=R[3] ;
  10:   ;
  11:  IF (DO[7]),JMP LBL[97] ;
  12:  IF (DO[15] OR DO[16]),JMP LBL[99] ;
  13:   ;
  14:  COL DETECT ON ;
  15:   ;
  16:  IF (!F[10] AND !F[11] AND !F[12] AND !F[13] AND !F[14] AND !F[15] AND !F[16]),JMP LBL[98] ;
  17:   ;
  18:  F[1]=(OFF) ;
  19:  !Ze zasobniku 1 ;
  20:  IF (F[10] AND !F[11] AND !F[12] AND !F[13] AND !F[14] AND !F[15] AND !F[16]),CALL ZPET1 ;
  21:  IF (F[1]),JMP LBL[98] ;
  22:   ;
  23:  !Ze Stroje 2 ;
  24:  IF (!F[10] AND F[11] AND !F[12] AND !F[13] AND !F[14] AND !F[15] AND !F[16]),CALL ZPET3 ;
  25:  IF (F[1]),JMP LBL[98] ;
  26:   ;
  27:  !Ze Stroje 3 ;
  28:  IF (!F[10] AND !F[11] AND F[12] AND !F[13] AND !F[14] AND !F[15] AND !F[16]),CALL ZPET4 ;
  29:  IF (F[1]),JMP LBL[98] ;
  30:   ;
  31:  !Z Frezy 4 ;
  32:  IF (!F[10] AND !F[11] AND !F[12] AND F[13] AND !F[14] AND !F[15] AND !F[16]),CALL ZPET6 ;
  33:  IF (F[1]),JMP LBL[98] ;
  34:   ;
  35:  !Z Vylozeni ;
  36:  IF (!F[10] AND !F[11] AND !F[12] AND !F[13] AND F[14] AND !F[15] AND !F[16]),CALL ZPET7 ;
  37:  IF (F[1]),JMP LBL[98] ;
  38:   ;
  39:  !Ze zasobniku 2 ;
  40:  IF (!F[10] AND !F[11] AND !F[12] AND !F[13] AND !F[14] AND F[15] AND !F[16]),CALL ZPET8 ;
  41:  IF (F[1]),JMP LBL[98] ;
  42:   ;
  43:  !Z orientace ;
  44:  IF (!F[10] AND !F[11] AND !F[12] AND !F[13] AND !F[14] AND !F[15] AND F[16]),CALL ZPET9 ;
  45:  IF (F[1]),JMP LBL[98] ;
  46:   ;
  47:  JMP LBL[100] ;
  48:   ;
  49:  LBL[98] ;
  50:  F[1]=(OFF) ;
  51:  UFRAME_NUM=0 ;
  52:  UTOOL_NUM=1 ;
  53:  PR[90]=JPOS    ;
  54:  PR[90,2]=(-50)    ;
  55:  PR[90,3]=10    ;
  56:J PR[90] 100% FINE    ;
  57:   ;
  58:  LBL[99] ;
  59:   ;
  60:  !Vyhozeni trubek ;
  61:J PR[1] 100% FINE    ;
  62:   ;
  63:J P[1] 100% FINE    ;
  64:  WAIT   1.00(sec) ;
  65:   ;
  66:  LBL[97] ;
  67:   ;
  68:J PR[2] 100% FINE    ;
  69:  COL DETECT OFF ;
  70:   ;
  71:  F[10]=(OFF) ;
  72:  F[11]=(OFF) ;
  73:  F[12]=(OFF) ;
  74:  F[13]=(OFF) ;
  75:  F[14]=(OFF) ;
  76:  F[15]=(OFF) ;
  77:  F[16]=(OFF) ;
  78:   ;
  79:  CALL INIT    ;
  80:   ;
  81:  !Neznama pozice ;
  82:  LBL[100] ;
/POS
P[1]{
   GP1:
	UF : 0, UT : 1,	
	J1=    30.000 deg,	J2=   -50.000 deg,	J3=    10.000 deg,
	J4=     -.000 deg,	J5=   -10.000 deg,	J6=    90.000 deg
};
/END
