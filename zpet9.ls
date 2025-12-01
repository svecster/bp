/PROG  ZPET9
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Pom.vychozi 7";
PROG_SIZE	= 470;
CREATE		= DATE 22-11-12  TIME 20:26:22;
MODIFIED	= DATE 22-11-13  TIME 14:57:18;
FILE_NAME	= ZPET8;
VERSION		= 0;
LINE_COUNT	= 18;
MEMORY_SIZE	= 770;
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
   2:  UTOOL_NUM=5 ;
   3:   ;
   4:  DO[49]=ON ;
   5:   ;
   6:  PR[91]=LPOS    ;
   7:L PR[91] 2000mm/sec FINE    ;
   8:   ;
   9:  PR[91,1]=(PR[91,1]-150) ;
  10:L PR[91] 100mm/sec FINE    ;
  11:   ;
  12:  PR[91,1]=PR[91,1]-200    ;
  13:  PR[91,2]=(PR[91,2]+200) ;
  14:  PR[91,3]=(PR[91,3]+300) ;
  15:L PR[91] 100mm/sec FINE    ;
  16:   ;
  17:  F[1]=(ON) ;
  18:  F[16]=(OFF) ;
/POS
/END
