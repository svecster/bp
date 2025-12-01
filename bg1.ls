/PROG  BG1
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "PLC1";
PROG_SIZE	= 242;
CREATE		= DATE 14-10-31  TIME 20:14:14;
MODIFIED	= DATE 17-05-24  TIME 21:49:48;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 6;
MEMORY_SIZE	= 590;
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
   1:  !Cislo programu ;
   2:  R[1]=GI[1]    ;
   3:  GO[1]=R[1] ;
   4:  !Delka trubky ;
   5:  R[2]=GI[2]    ;
   6:  GO[2]=R[2] ;
/POS
/END
