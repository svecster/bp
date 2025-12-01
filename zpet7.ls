/PROG  ZPET7
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Pom.vychozi 5";
PROG_SIZE	= 520;
CREATE		= DATE 15-06-18  TIME 01:06:56;
MODIFIED	= DATE 22-11-13  TIME 14:27:50;
FILE_NAME	= ZPET6;
VERSION		= 0;
LINE_COUNT	= 23;
MEMORY_SIZE	= 932;
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
   1:  UFRAME_NUM=5 ;
   2:  UTOOL_NUM=2 ;
   3:  PR[91]=LPOS    ;
   4:J PR[91] 100% FINE    ;
   5:   ;
   6:  IF (DI[15] AND !DI[16]),JMP LBL[1] ;
   7:  IF (!DI[15] AND DI[16]),JMP LBL[1] ;
   8:   ;
   9:  PR[91,2]=(PR[91,2]-200) ;
  10:L PR[91] 100mm/sec FINE    ;
  11:   ;
  12:  JMP LBL[2] ;
  13:   ;
  14:  LBL[1] ;
  15:   ;
  16:  PR[91,2]=((-180)) ;
  17:  PR[91,3]=((-500)) ;
  18:L PR[91] 100mm/sec FINE    ;
  19:   ;
  20:  LBL[2] ;
  21:   ;
  22:  F[1]=(ON) ;
  23:  F[14]=(OFF) ;
/POS
/END
