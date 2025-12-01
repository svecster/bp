/PROG  MAIN
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Hlavni program";
PROG_SIZE	= 360;
CREATE		= DATE 14-10-22  TIME 21:10:52;
MODIFIED	= DATE 15-06-17  TIME 23:33:16;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 14;
MEMORY_SIZE	= 808;
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
   1:  !MAIN Vyber programu ;
   2:   ;
   3:  !Neni simulace I/O ;
   4:  WAIT (!DO[13])    ;
   5:   ;
   6:  LBL[1] ;
   7:  DO[14]=ON ;
   8:  WAIT (DI[14])    ;
   9:  DO[14]=OFF ;
  10:  WAIT (!DI[14])    ;
  11:  !Nazev programu ;
  12:  SR[25]=SR[24]+R[1]    ;
  13:  CALL SR[25]    ;
  14:  JMP LBL[1] ;
/POS
/END
