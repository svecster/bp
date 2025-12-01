/PROG  ZPET2
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Pom.vychozi 2.1";
PROG_SIZE	= 432;
CREATE		= DATE 14-11-28  TIME 12:11:14;
MODIFIED	= DATE 22-11-12  TIME 21:18:14;
FILE_NAME	= ZPET1;
VERSION		= 0;
LINE_COUNT	= 15;
MEMORY_SIZE	= 876;
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
   1:  UFRAME_NUM=2 ;
   2:  UTOOL_NUM=1 ;
   3:  PR[91]=LPOS    ;
   4:J PR[91] 100% FINE    ;
   5:   ;
   6:  IF (DI[15] AND !DI[16]),JMP LBL[1] ;
   7:  IF (!DI[15] AND DI[16]),JMP LBL[1] ;
   8:  PR[91,3]=(PR[91,3]+50) ;
   9:L PR[91] 100mm/sec FINE    ;
  10:  LBL[1] ;
  11:  PR[91,1]=PR[91,1]-400    ;
  12:L PR[91] 100mm/sec FINE    ;
  13:   ;
  14:  F[1]=(ON) ;
  15:  F[11]=(OFF) ;
/POS
/END
