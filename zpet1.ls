/PROG  ZPET1
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Pom.vychozi 1";
PROG_SIZE	= 318;
CREATE		= DATE 14-11-28  TIME 12:10:52;
MODIFIED	= DATE 14-12-15  TIME 02:01:20;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 12;
MEMORY_SIZE	= 774;
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
   1:  UFRAME_NUM=1 ;
   2:  UTOOL_NUM=4 ;
   3:  PR[91]=LPOS    ;
   4:J PR[91] 100% FINE    ;
   5:   ;
   6:  PR[91,2]=PR[91,2]+100    ;
   7:  PR[91,3]=PR[91,3]+100    ;
   8:L PR[91] 100mm/sec FINE    ;
   9:   ;
  10:  LBL[1] ;
  11:  F[1]=(ON) ;
  12:  F[10]=(OFF) ;
/POS
/END
