/PROG  ZPET3
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Pom.vychozi 2.2";
PROG_SIZE	= 514;
CREATE		= DATE 15-06-18  TIME 00:48:48;
MODIFIED	= DATE 22-11-13  TIME 14:15:42;
FILE_NAME	= ZPET2;
VERSION		= 0;
LINE_COUNT	= 19;
MEMORY_SIZE	= 942;
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
   2:  UTOOL_NUM=2 ;
   3:  PR[91]=LPOS    ;
   4:J PR[91] 100% FINE    ;
   5:   ;
   6:  IF (DI[15] AND !DI[16]),JMP LBL[1] ;
   7:  IF (!DI[15] AND DI[16]),JMP LBL[1] ;
   8:  PR[91,3]=(PR[91,3]+40) ;
   9:  PR[91,1]=PR[91,1]-60    ;
  10:L PR[91] 100mm/sec FINE    ;
  11:  LBL[1] ;
  12:   ;
  13:  PR[91,1]=PR[91,1]-400    ;
  14:L PR[91] 100mm/sec FINE    ;
  15:  PR[91,3]=PR[91,3]+200    ;
  16:L PR[91] 100mm/sec FINE    ;
  17:   ;
  18:  F[1]=(ON) ;
  19:  F[11]=(OFF) ;
/POS
/END
