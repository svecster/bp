/PROG  ZPET4
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Pom.vychozi 3.1";
PROG_SIZE	= 532;
CREATE		= DATE 15-06-18  TIME 00:54:14;
MODIFIED	= DATE 22-11-13  TIME 14:17:36;
FILE_NAME	= ZPET2;
VERSION		= 0;
LINE_COUNT	= 21;
MEMORY_SIZE	= 952;
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
   2:  UTOOL_NUM=2 ;
   3:  PR[91]=LPOS    ;
   4:J PR[91] 100% FINE    ;
   5:   ;
   6:  IF (DI[15] AND !DI[16]),JMP LBL[1] ;
   7:  IF (!DI[15] AND DI[16]),JMP LBL[1] ;
   8:   ;
   9:  PR[91,3]=(PR[91,3]+40) ;
  10:  PR[91,1]=PR[91,1]-60    ;
  11:L PR[91] 100mm/sec FINE    ;
  12:   ;
  13:  LBL[1] ;
  14:   ;
  15:  PR[91,1]=(PR[91,1]-300) ;
  16:L PR[91] 100mm/sec FINE    ;
  17:  PR[91,3]=PR[91,3]+200    ;
  18:L PR[91] 100mm/sec FINE    ;
  19:   ;
  20:  F[1]=(ON) ;
  21:  F[12]=(OFF) ;
/POS
/END
