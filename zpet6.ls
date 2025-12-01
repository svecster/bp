/PROG  ZPET6
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Pom.vychozi 4";
PROG_SIZE	= 366;
CREATE		= DATE 15-06-18  TIME 01:03:44;
MODIFIED	= DATE 22-11-13  TIME 14:31:32;
FILE_NAME	= ZPET3;
VERSION		= 0;
LINE_COUNT	= 12;
MEMORY_SIZE	= 690;
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
   1:  UFRAME_NUM=4 ;
   2:  UTOOL_NUM=2 ;
   3:  PR[91]=LPOS    ;
   4:J PR[91] 100% FINE    ;
   5:   ;
   6:  PR[91,1]=PR[91,1]-200    ;
   7:L PR[91] 100mm/sec FINE    ;
   8:  PR[91,3]=PR[91,3]+150    ;
   9:L PR[91] 100mm/sec FINE    ;
  10:   ;
  11:  F[1]=(ON) ;
  12:  F[13]=(OFF) ;
/POS
/END
