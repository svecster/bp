/PROG  ZPET8
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Pom.vychozi 6";
PROG_SIZE	= 472;
CREATE		= DATE 22-11-12  TIME 19:27:24;
MODIFIED	= DATE 22-11-12  TIME 20:25:24;
FILE_NAME	= ZPET7;
VERSION		= 0;
LINE_COUNT	= 19;
MEMORY_SIZE	= 768;
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
   2:  UTOOL_NUM=5 ;
   3:   ;
   4:  DO[49]=ON ;
   5:   ;
   6:  PR[91]=LPOS    ;
   7:J PR[91] 100% FINE    ;
   8:   ;
   9:  PR[91,2]=(PR[91,2]-100) ;
  10:  PR[91,3]=(PR[91,3]-50) ;
  11:L PR[91] 100mm/sec FINE    ;
  12:   ;
  13:   ;
  14:  PR[91,2]=(PR[91,2]-300) ;
  15:  PR[91,3]=(PR[91,3]+400) ;
  16:L PR[91] 100mm/sec FINE    ;
  17:   ;
  18:  F[1]=(ON) ;
  19:  F[15]=(OFF) ;
/POS
/END
