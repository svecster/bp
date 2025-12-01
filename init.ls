/PROG  INIT
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Inicializace";
PROG_SIZE	= 424;
CREATE		= DATE 14-11-28  TIME 11:58:16;
MODIFIED	= DATE 14-12-15  TIME 02:58:56;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 18;
MEMORY_SIZE	= 724;
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
   1:  !Init vystupu ;
   2:  FOR R[20]=52 TO 80 ;
   3:  DO[R[20]]=OFF ;
   4:  ENDFOR ;
   5:   ;
   6:   ;
   7:  !Init upinacu ;
   8:  DO[49]=ON ;
   9:  DO[51]=ON ;
  10:  WAIT    .50(sec) ;
  11:  WAIT (DI[49] AND DI[51])    ;
  12:  DO[49]=OFF ;
  13:  DO[51]=OFF ;
  14:  WAIT    .50(sec) ;
  15:  WAIT (!DI[49] AND !DI[51] AND !DI[50] AND !DI[52])    ;
  16:  DO[49]=ON ;
  17:  DO[51]=ON ;
  18:  WAIT (DI[49] AND DI[51])    ;
/POS
/END
