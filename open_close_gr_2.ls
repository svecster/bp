/PROG  OPEN_CLOSE_GR_2	  Macro
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "OTEV.ZAVR. GR 2";
PROG_SIZE	= 328;
CREATE		= DATE 15-02-13  TIME 10:49:48;
MODIFIED	= DATE 15-02-13  TIME 10:52:46;
FILE_NAME	= OPEN_GR_;
VERSION		= 0;
LINE_COUNT	= 12;
MEMORY_SIZE	= 784;
PROTECT		= READ_WRITE;
TCD:  STACK_SIZE	= 0,
      TASK_PRIORITY	= 50,
      TIME_SLICE	= 0,
      BUSY_LAMP_OFF	= 0,
      ABORT_REQUEST	= 0,
      PAUSE_REQUEST	= 0;
DEFAULT_GROUP	= *,*,*,*,*;
CONTROL_CODE	= 00000000 00000000;
/APPL
/MN
   1:  IF (DO[51] AND DI[51]),JMP LBL[1] ;
   2:   ;
   3:  DO[51]=ON ;
   4:  WAIT (DI[51])    ;
   5:   ;
   6:  JMP LBL[2] ;
   7:   ;
   8:  LBL[1] ;
   9:  DO[51]=OFF ;
  10:  WAIT (!DI[51])    ;
  11:   ;
  12:  LBL[2] ;
/POS
/END
