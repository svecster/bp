/PROG  TEST1
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 486;
CREATE		= DATE 17-05-24  TIME 21:05:20;
MODIFIED	= DATE 17-05-24  TIME 22:09:30;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 23;
MEMORY_SIZE	= 898;
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
   1:  TIMER[2]=STOP ;
   2:  R[47]=TIMER[2]    ;
   3:  TIMER[2]=START ;
   4:   ;
   5:  TIMER[1]=STOP ;
   6:  R[48]=TIMER[1]    ;
   7:  TIMER[1]=RESET ;
   8:  TIMER[1]=START ;
   9:   ;
  10:  IF R[47]>=27000,JMP LBL[2] ;
  11:  R[49]=R[49]+1    ;
  12:   ;
  13:  R[51]=3600/R[48]    ;
  14:  R[51]=R[51]*7.5    ;
  15:  R[52]=R[49]/R[51]    ;
  16:  R[52]=R[52]*100    ;
  17:  JMP LBL[3] ;
  18:   ;
  19:  LBL[2] ;
  20:  TIMER[2]=RESET ;
  21:  R[49]=1    ;
  22:  R[53]=R[52]    ;
  23:  LBL[3] ;
/POS
/END
