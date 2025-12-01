/PROG  ZPET5
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Pom.vychozi 3.2";
PROG_SIZE	= 360;
CREATE		= DATE 15-06-18  TIME 00:54:40;
MODIFIED	= DATE 15-06-18  TIME 00:55:08;
FILE_NAME	= ZPET4;
VERSION		= 0;
LINE_COUNT	= 12;
MEMORY_SIZE	= 684;
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
   1:  UFRAME_NUM=3 ;
   2:  UTOOL_NUM=1 ;
   3:  PR[91]=LPOS    ;
   4:J PR[91] 100% FINE    ;
   5:   ;
   6:  PR[91,1]=((-350)) ;
   7:L PR[91] 100mm/sec FINE    ;
   8:  PR[91,3]=PR[91,3]+150    ;
   9:L PR[91] 100mm/sec FINE    ;
  10:   ;
  11:  F[1]=(ON) ;
  12:  F[14]=(OFF) ;
/POS
/END
