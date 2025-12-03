/PROG  PROG30
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Vyroba 8.5 <370m";
PROG_SIZE	= 8893;
CREATE		= DATE 22-11-11  TIME 20:21:22;
MODIFIED	= DATE 25-08-25  TIME 14:42:52;
FILE_NAME	= PROG10;
VERSION		= 0;
LINE_COUNT	= 345;
MEMORY_SIZE	= 9305;
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
   1:  !HOME ? ; ! Úvodní kontrola polohy, program startuje s očekávaným návratem v blízkosti HOME.
   2:  WAIT (DO[7] AND !DO[13] AND DI[15] AND DI[16])    ; ! Čeká na PLC start, vypnutou simulaci a potvrzení obou chapadel, aby bylo bezpečné začít cyklus.
   3:J PR[2] 20% FINE    ; ! Přesun do referenční HOME pozice pro jistotu před cyklem.
   4:   ; ! Oddělující řádek pro čitelnost.
   5:  CALL INIT    ; ! Spuštění přípravy I/O a chapadel – sjednocení výstupů před výrobou.
   6:   ; ! Oddělení bloků logiky.
   7:  UFRAME_NUM=1 ; ! Nastavení rámce pro manipulaci u vstupních stanic.
   8:  UTOOL_NUM=5 ; ! Volba standardního nástroje pro uchopování trubek.
   9:J P[1] 100% CNT100    ; ! Rychlý přesun do výchozí pozice nad zásobníkem.
  10:   ; ! Prázdný řádek pro přehlednost.
  11:  !Novy cyklus ; ! Komentář hlavičky opakované smyčky.
  12:  LBL[100] ; ! Začátek hlavní výrobní smyčky.
  13:   ; ! Oddělovač.
  14:  UFRAME_NUM=1 ; ! Volí souřadný systém vstupního zásobníku.
  15:  UTOOL_NUM=5 ; ! Používá hlavní chapadlo pro manipulaci.
  16:J P[11] 100% CNT80    ; ! Přejezd k čekací pozici u zásobníku.
  17:   ; ! Oddělovač.
  18:  !Greifer OK? ; ! Kontrola připravenosti chapadel.
  19:  WAIT (DI[15] AND DI[16])    ; ! Čeká na potvrzení obou griperů před další manipulací.
  20:   ; ! Oddělovač.
  21:  !Delka trubky OK? ; ! Blok validace vstupu od PLC.
  22:  LBL[1] ; ! Smyčka pro ověření délky.
  23:  R[10]=GI[2]    ; ! Načtení délky trubky z GI od PLC.
  24:  IF (R[10]<170 OR R[10]>400),JMP LBL[1] ; ! Opakování čtení, dokud délka není v rozsahu 170–400 mm.
  25:   ; ! Oddělovač.
  26:  !Kontrola neni dil ; ! Ověření, že není upnutý předchozí kus.
  27:  WAIT (!DI[50] AND !DI[52])    ; ! Čeká na uvolnění obou čelistí.
  28:  DO[49]=ON ; ! Aktivuje otevření chapadla 1 pro příjem dílu.
  29:  DO[51]=ON ; ! Aktivuje otevření chapadla 2.
  30:  WAIT (DI[49] AND DI[51])    ; ! Ověří, že obě chapadla jsou skutečně otevřená.
  31:   ; ! Oddělovač.
  32:  !****************** ; ! Začátek sekce vstupního zásobníku 2.
  33:  !Vstupni zasobnik 2 ; ! Titulek stanice.
  34:  !****************** ; ! Titulek stanice.
  35:   ; ! Oddělovač.
  36:  !Takt puls ; ! Impuls pro posun zásobníku.
  37:  DO[58]=PULSE,0.5sec ; ! Vysílá půlsekundový takt na zásobník.
  38:   ; ! Oddělovač.
  39:  WAIT (DI[77] OR DI[53])    ; ! Čeká na přítomnost dílu nebo detekci prázdného zásobníku.
  40:  IF (DI[53]),JMP LBL[20] ; ! Pokud není díl, přeskočí na další stanici.
  41:   ; ! Oddělovač.
  42:  GO[3]=6 ; ! Informuje PLC o obsluze stanice vstupní zásobník.
  43:   ; ! Oddělovač.
  44:  PR[14,1]=0    ; ! Nuluje offset X pro posuv po zásobníku.
  45:  PR[14,2]=0    ; ! Nuluje offset Y.
  46:  PR[14,3]=0    ; ! Nuluje offset Z.
  47:  PR[14,4]=0    ; ! Nuluje rotaci W.
  48:  PR[14,5]=0    ; ! Nuluje rotaci P.
  49:  PR[14,6]=0    ; ! Nuluje rotaci R.
  50:   ; ! Oddělovač.
  51:  R[5]=GI[3]    ; ! Načte index pozice dílu v zásobníku.
  52:   ; ! Oddělovač.
  53:  PR[14,1]=R[5]*(-38)    ; ! Vypočítá posuv v ose X podle slotu zásobníku (rozteč 38 mm).
  54:   ; ! Oddělovač.
  55:  UFRAME_NUM=1 ; ! Nastaví rámec zásobníku pro následující pohyby.
  56:  UTOOL_NUM=5 ; ! Použije griper pro odebírání.
  57:J P[46] 100% CNT70 TB   0.00sec,DO[115]=ON Tool_Offset,PR[14]    ; ! Přijede nad díl se zapnutím vakuového/IO signálu DO115 pro bezpečné přiblížení.
  58:   ; ! Oddělovač.
  59:   ; ! Oddělovač pro čitelnost.
  60:L P[48] 2000mm/sec CNT80 Tool_Offset,PR[14]    ; ! Přesun do mezipolohy nad dílem s offsetem slotu.
  61:L P[47] 1000mm/sec FINE TB    .05sec,DO[77]=ON Tool_Offset,PR[14]    ; ! Přesné dosednutí na díl a aktivace upnutí DO77.
  62:   ; ! Oddělovač.
  63:  DO[49]=OFF ; ! Zavře chapadlo 1 pro uchopení.
  64:  WAIT (DI[50])    ; ! Ověří, že chapadlo je skutečně zavřené.
  65:   ; ! Oddělovač.
  66:L P[52] 1000mm/sec CNT50 Tool_Offset,PR[14]    ; ! Odjíždí z místa odběru se zvedáním.
  67:L P[53] 1500mm/sec CNT80 Tool_Offset,PR[14]    ; ! Pokračuje k výjezdové trajektorii.
  68:L P[54] 2000mm/sec CNT100 TB   0.00sec,DO[115]=OFF Tool_Offset,PR[14]    ; ! Opouští zásobník a vypíná pomocný signál.
  69:  LBL[20] ; ! Přeskok, pokud zásobník neměl díl.
  70:J P[2] 100% CNT100 TB   0.00sec,DO[77]=OFF    ; ! Návrat do bezpečné pozice a vypnutí uchopení.
  71:   ; ! Oddělovač.
  72:  !***************** ; ! Sekce vyrovnávací stanice.
  73:  !Vyrovnavaci stanice ; ! Titulek.
  74:  !***************** ; ! Titulek.
  75:   ; ! Oddělovač.
  76:  UFRAME_NUM=2 ; ! Přepnutí na rámec vyrovnávací stanice.
  77:  UTOOL_NUM=5 ; ! Použití hlavního chapadla.
  78:   ; ! Oddělovač.
  79:J P[45] 100% CNT80    ; ! Přesun k bufferu.
  80:  IF (DI[53] AND DI[49]),JMP LBL[30] ; ! Pokud není díl nebo je griper obsazen, přeskočí vkládání.
  81:   ; ! Oddělovač.
  82:  WAIT DI[56]=OFF    ; ! Čeká, až je lůžko volné.
  83:   ; ! Oddělovač.
  84:  !Zalozeni do luzka ; ! Vkládací sekvence.
  85:L P[27] 2000mm/sec CNT50 TB    .50sec,DO[116]=ON    ; ! Najetí nad lůžko s otevřením zarážky DO116.
  86:L P[16] 1000mm/sec CNT20    ; ! Přesun blíž k lůžku.
  87:L P[7] 1000mm/sec FINE TB    .20sec,DO[49]=ON    ; ! Přesný dosed a otevření chapadla pro položení dílu.
  88:  //DO[49]=ON ; ! Starý ruční příkaz ponechán pro referenci.
  89:  WAIT DI[49]=ON    ; ! Ověření, že chapadlo je otevřené.
  90:  WAIT    .50(sec) ; ! Krátké prodlení pro dosednutí.
  91:   ; ! Oddělovač.
  92:  PR[13,1]=0    ; ! Nulování korekčního offsetu rotace.
  93:  PR[13,2]=0    ; ! Nulování Y.
  94:  PR[13,3]=0    ; ! Nulování Z.
  95:  PR[13,4]=0    ; ! Nulování W.
  96:  PR[13,5]=0    ; ! Nulování P.
  97:  PR[13,6]=0    ; ! Nulování R.
  98:   ; ! Oddělovač.
  99:  PR[13,6]=R[9]    ; ! Přidá natočení podle seřízení z R9.
 100:   ; ! Oddělovač.
 101:L P[55] 1500mm/sec FINE Tool_Offset,PR[13]    ; ! Jemný přesun pro dorovnání rotace trubky.
 102:  DO[49]=OFF ; ! Zavře chapadlo po dorovnání.
 103:  WAIT DI[50]=ON    ; ! Ověří zavření.
 104:   ; ! Oddělovač.
 105:L P[56] 1000mm/sec CNT30 Tool_Offset,PR[13]    ; ! Odjezd s korekcí.
 106:L P[57] 2000mm/sec CNT100    ; ! Vyjetí do bezpečí.
 107:J P[58] 100% CNT100 TB    .50sec,DO[116]=OFF    ; ! Zavření zarážky a přechod k další sekci.
 108:   ; ! Oddělovač.
 109:  LBL[30] ; ! Přeskok, pokud se vkládání neprovádělo.
 110:   ; ! Oddělovač.
 111:  !TOOL_OFFSET pro UTOOL 1 ; ! Inicializace offsetu pro hlavní nástroj.
 112:  PR[21,1]=0    ; ! Nulování X pro další stanice.
 113:  PR[21,2]=0    ; ! Nulování Y.
 114:  PR[21,3]=0    ; ! Nulování Z.
 115:  PR[21,4]=0    ; ! Nulování W.
 116:  PR[21,5]=0    ; ! Nulování P.
 117:  PR[21,6]=0    ; ! Nulování R.
 118:  !TOOL_OFFSET pro UTOOL 2 ; ! Zrcadlení pro druhý nástroj.
 119:  PR[22]=PR[21]    ; ! Kopíruje nulový offset do PR22.
 120:   ; ! Oddělovač.
 121:  !Upinac 6 Pripraven? ; ! Kontrola stroje 5-stroke.
 122:  WAIT (DI[51] AND !DI[52])    ; ! Čeká na otevřené čelisti stroje.
 123:   ; ! Oddělovač.
 124:  !***************** ; ! Sekce 5-stroke.
 125:  !5-stroke ; ! Titulek stanice.
 126:  !***************** ; ! Titulek stanice.
 127:   ; ! Oddělovač.
 128:  GO[3]=2 ; ! Hlášení PLC, že obsluhujeme 5-stroke.
 129:   ; ! Oddělovač.
 130:  !Vyjmuti trubky  ; ! Začátek vyjmutí z 5-stroke.
 131:   ; ! Oddělovač.
 132:  UFRAME_NUM=2 ; ! Použití rámce stanice 5-stroke.
 133:  UTOOL_NUM=6 ; ! Přepnutí na speciální nástroj/úhel pro uchopení.
 134:J P[20] 100% CNT100    ; ! Rychlý přesun k nadjezdové poloze.
 135:J P[18] 100% CNT50    ; ! Přiblížení k odběru.
 136:  WAIT (DI[61])    ; ! Čeká, až stroj otevře a je připraven k odběru.
 137:L P[4] 2000mm/sec CNT10 TB    .05sec,DO[111]=ON    ; ! Pomalý vjezd s aktivací signálu DO111 pro stroj.
 138:L P[5] 1500mm/sec FINE    ; ! Přesné uchopení trubky.
 139:   ; ! Oddělovač.
 140:  IF (DI[62] AND !DI[64]),JMP LBL[21] ; ! Pokud už jsou čelisti rozepnuté, přeskočí otevírání.
 141:  DO[51]=OFF ; ! Zavře chapadlo 2 pro uvolnění stroje.
 142:  WAIT (DI[52])    ; ! Ověří zavření.
 143:  DO[62]=ON ; ! Požádá stroj o otevření čelistí.
 144:  WAIT (DI[62] AND !DI[64])    ; ! Čeká na potvrzení otevření.
 145:  DO[62]=OFF ; ! Vypne požadavek.
 146:  LBL[21] ; ! Pokračování vyjmutí.
 147:   ; ! Oddělovač.
 148:L P[6] 500mm/sec CNT10 TB   0.00sec,DO[63]=PULSE,1.0sec    ; ! Vyjmutí trubky s pulsem DO63 (rozezpírávací funkce).
 149:L P[8] 1000mm/sec CNT100    ; ! Odjezd se zvedáním.
 150:L P[30] 2000mm/sec CNT100 TB    .05sec,DO[111]=OFF    ; ! Opouští stroj a vypíná signál DO111.
 151:   ; ! Oddělovač.
 152:  !Vlozeni trubky ; ! Následuje založení zpět po opracování.
 153:  WAIT (DI[62] AND !DI[64])    ; ! Potvrzení, že čelisti jsou otevřené.
 154:   ; ! Oddělovač.
 155:  !Vypocet delky ; ! Výpočet pracovní výšky podle délky GI2.
 156:  PR[21,3]=345-R[2]    ; ! Nastaví Z bodu na základě délky trubky.
 157:   ; ! Oddělovač.
 158:  !Korekce st.1 C ; ! Přidává korekci R17.
 159:  WAIT R[17]>=(-2) AND R[17]<=2    ; ! Ověří, že korekce je v bezpečí.
 160:  PR[24]=PR[21]    ; ! Kopíruje základní bod do korekčního.
 161:  PR[24,3]=PR[24,3]+R[17]    ; ! Aplikuje jemnou korekci Z.
 162:   ; ! Oddělovač.
 163:  UFRAME_NUM=2 ; ! Pracuje stále v rámci 5-stroke.
 164:  UTOOL_NUM=5 ; ! Vrací standardní nástroj pro vložení.
 165:J P[12] 100% CNT50    ; ! Přesun k nájezdu.
 166:L P[3] 2000mm/sec CNT50 TB    .05sec,DO[111]=ON Tool_Offset,PR[21]    ; ! Najetí k čelistem se signálem pro stroj.
 167:L P[13] 1500mm/sec CNT50 Tool_Offset,PR[21]    ; ! Další přiblížení.
 168:L P[14] 500mm/sec FINE Tool_Offset,PR[24]    ; ! Dosednutí s korekcí R17 pro přesnost.
 169:   ; ! Oddělovač.
 170:  IF (!DI[50]),JMP LBL[22] ; ! Pokud není díl v griperu, přeskočí uvolnění stroje.
 171:  !Kontakt? ; ! Kontrola dosednutí.
 172:  WAIT (DI[63])    ; ! Čeká na potvrzení kontaktu stroje.
 173:  DO[64]=ON ; ! Požádá stroj o sevření.
 174:  WAIT (DI[64] AND !DI[62])    ; ! Čeká na zavření čelistí.
 175:  DO[49]=ON ; ! Otevírá griper robota pro předání dílu.
 176:  WAIT (DI[49])    ; ! Ověření otevření.
 177:  DO[64]=OFF ; ! Uvolní požadavek sevření.
 178:  LBL[22] ; ! Pokračování po vkládce.
 179:  DO[61]=ON ; ! Signalizuje stroji odjezd.
 180:  WAIT (!DI[61])    ; ! Čeká, až stroj potvrdí dokončení.
 181:  DO[61]=OFF ; ! Vypne signál.
 182:   ; ! Oddělovač.
 183:L P[25] 2000mm/sec CNT50    ; ! Odjezd z pracovní zóny.
 184:J P[15] 100% CNT100 TB   0.00sec,DO[111]=OFF    ; ! Návrat k bezpečné pozici, vypne strojní signál.
 185:   ; ! Oddělovač.
 186:  !***************** ; ! Sekce Shawer 2.
 187:  !Shawer 2 ; ! Titulek stanice.
 188:  !***************** ; ! Titulek.
 189:   ; ! Oddělovač.
 190:  GO[3]=3 ; ! Informuje PLC, že se obsluhuje Shawer 2.
 191:   ; ! Oddělovač.
 192:  !Vyjmuti trubky SHAWER 2 ; ! Začátek odběru z brusky.
 193:   ; ! Oddělovač.
 194:  UFRAME_NUM=3 ; ! Přepíná na rámec stanice Shawer 2.
 195:  UTOOL_NUM=5 ; ! Používá standardní chapadlo.
 196:  //J P[9] 100% FINE    ; ! Původní nadjezd ponechán zakomentovaný.
 197:J P[33] 100% CNT80    ; ! Přejezd k odběru.
 198:J P[34] 100% CNT50 TB    .05sec,DO[112]=ON    ; ! Přiblížení a aktivace signálu DO112.
 199:L P[35] 2000mm/sec FINE    ; ! Precizní nájezd na díl.
 200:   ; ! Oddělovač.
 201:  IF (DI[66] AND !DI[68]),JMP LBL[31] ; ! Pokud jsou čelisti už otevřené, přeskočí otevření stroje.
 202:  DO[49]=OFF ; ! Zavře chapadlo 1 pro uvolnění dílu.
 203:  WAIT (DI[50])    ; ! Ověří zavření.
 204:  DO[66]=ON ; ! Požádá stroj o otevření čelistí.
 205:  WAIT (DI[66] AND !DI[68])    ; ! Čeká na otevření.
 206:  DO[66]=OFF ; ! Vypne požadavek.
 207:  LBL[31] ; ! Pokračování odběru.
 208:   ; ! Oddělovač.
 209:L P[36] 400mm/sec CNT10    ; ! Pomalý výběr z čelistí.
 210:L P[37] 1000mm/sec CNT100    ; ! Odjezd od stroje.
 211:L P[44] 2000mm/sec CNT100 TB   0.00sec,DO[67]=PULSE,1.0sec    ; ! Odjezd s pulsem DO67 (vzduch/čištění sedla).
 212:L P[31] 2000mm/sec CNT80 TB    .05sec,DO[112]=OFF    ; ! Návrat k nadjezdu, vypnutí signálu stroje.
 213:   ; ! Oddělovač.
 214:  !Vlozeni trubky SHAWER 2 ; ! Příprava pro založení dalšího dílu.
 215:  WAIT (DI[66] AND !DI[68])    ; ! Čeká na otevřené čelisti.
 216:   ; ! Oddělovač.
 217:  !Korekce st.2 C ; ! Korekce výšky pro Shawer 2.
 218:  WAIT R[18]>=(-2) AND R[18]<=2    ; ! Validace korekce.
 219:  PR[25]=PR[22]    ; ! Kopíruje základní bod.
 220:  PR[25,3]=PR[25,3]+R[18]    ; ! Přidá Z korekci z R18.
 221:   ; ! Oddělovač.
 222:   ; ! Oddělovač.
 223:  UFRAME_NUM=3 ; ! Stále rámec Shawer 2.
 224:  UTOOL_NUM=6 ; ! Přepíná na alternativní nástroj pro vkládání.
 225:J P[38] 100% CNT50    ; ! Přesun k nájezdu.
 226:L P[39] 2000mm/sec CNT100 TB    .05sec,DO[112]=ON    ; ! Přiblížení se signálem.
 227:L P[32] 1500mm/sec CNT100    ; ! Další přiblížení.
 228:L P[40] 1000mm/sec CNT50    ; ! Jemnější pohyb.
 229:L P[41] 500mm/sec FINE    ; ! Precizní založení.
 230:   ; ! Oddělovač.
 231:  IF (!DI[52]),JMP LBL[32] ; ! Pokud není díl v griperu, přeskočí uvolnění.
 232:  !Kontakt? ; ! Kontrola dosednutí.
 233:  WAIT (DI[67])    ; ! Čeká na potvrzení od stroje.
 234:  DO[68]=ON ; ! Požádá stroj o sevření.
 235:  WAIT (DI[68] AND !DI[66])    ; ! Čeká na zavření čelistí.
 236:  DO[51]=ON ; ! Otevírá griper 2 pro předání.
 237:  WAIT (DI[51])    ; ! Ověření otevření.
 238:  DO[68]=OFF ; ! Vypíná požadavek sevření.
 239:  LBL[32] ; ! Pokračování po vkládce.
 240:  DO[65]=ON ; ! Signalizuje stroji odjezd.
 241:  WAIT (!DI[65])    ; ! Čeká na potvrzení.
 242:  DO[65]=OFF ; ! Ukončuje signalizaci.
 243:   ; ! Oddělovač.
 244:L P[42] 2000mm/sec CNT50    ; ! Odjezd z pracovního prostoru.
 245:J P[43] 100% CNT80 TB    .05sec,DO[112]=OFF    ; ! Návrat na bezpečný bod a vypnutí signálu.
 246:   ; ! Oddělovač.
 247:   ; ! Oddělovač.
 248:  !***************** ; ! Začátek nové části – čištění kartáčem (mnou navrženo pro BP).
 249:  !Cisteni ; ! Titulek stanice čištění.
 250:  !***************** ; ! Titulek.
 251:   ; ! Oddělovač.
 252:  GO[3]=4 ; ! Oznamuje PLC obsluhu stanice čištění.
 253:   ; ! Oddělovač.
 254:  UFRAME_NUM=4 ; ! Používá lokální rámec kartáče pro přesnou geometrii.
 255:  UTOOL_NUM=5 ; ! Standardní griper – drží trubku při čištění.
 256:   ; ! Oddělovač.
 257:  !Korekce st.3 A ; ! Korekce výšky kartáče (vědomě bez automatické kompenzace opotřebení).
 258:  WAIT R[19]>=(-2) AND R[19]<=2    ; ! Validuje ruční korekci Z (kartáč se dříve rozpadne než by se opotřebil).
 259:  PR[26]=PR[21]    ; ! Vychází z referenčního bodu dílu.
 260:  PR[26,3]=PR[26,3]+R[19]    ; ! Přidává výškovou korekci kartáče R19.
 261:   ; ! Oddělovač.
 262:J P[17] 100% CNT100    ; ! Přejezd k nájezdu stanice čištění.
 263:J P[19] 100% CNT100    ; ! Další bezpečný bod před trajektorií kartáče.
 264:   ; ! Oddělovač.
 265:   ; ! Oddělovač.
 266:  IF ((!DI[50] AND DI[49])),JMP LBL[41] ; ! Pokud nemáme díl v griperu, přeskočíme čištění.
 267:   ; ! Oddělovač.
 268:J P[21] 100% CNT70 TB    .05sec,DO[113]=ON Tool_Offset,PR[21]    ; ! Najetí k náběhu kartáče, zapíná DO113 (motor kartáče).
 269:   ; ! Oddělovač.
 270:  !Korekce levy bod ; ! Výpočet rohů obdélníkové dráhy dle R21.
 271:  PR[27]=PR[26]    ; ! Levý roh vychází ze základního bodu.
 272:  PR[27,1]=100-R[21]    ; ! Posun X vlevo podle ruční korekce R21.
 273:   ; ! Oddělovač.
 274:  !Korekce horni bod ; ! Druhý roh pro horní hranu.
 275:  PR[28]=PR[26]    ; ! Vychází z PR26.
 276:  PR[28,2]=100-R[21]    ; ! Posun Y nahoru, korekce R21.
 277:   ; ! Oddělovač.
 278:  !Korekce pravy bod ; ! Třetí roh obdélníku.
 279:  PR[29]=PR[26]    ; ! Kopie základního bodu.
 280:  PR[29,1]=(-100)+R[21]    ; ! Posun X doprava, kompenzace R21.
 281:   ; ! Oddělovač.
 282:  !Korekce spodni bod ; ! Čtvrtý roh dráhy.
 283:  PR[30]=PR[26]    ; ! Kopie základního bodu.
 284:  PR[30,2]=(-100)+R[21]    ; ! Posun Y dolů, kompenzace R21.
 285:   ; ! Oddělovač.
 286:   ; ! Oddělovač.
 287:L P[22] 2000mm/sec CNT50 Tool_Offset,PR[21]    ; ! Přechod na start dráhy.
 288:L P[23] R[23]mm/sec CNT100 Tool_Offset,PR[27]    ; ! Zahájení čištění do prvního rohu rychlostí z R23.
 289:C P[24] Tool_Offset,PR[28]
    :  P[28] R[23]mm/sec CNT100 Tool_Offset,PR[29]    ; ! Kruhové interpolace mezi rohy pro plynulé obkroužení kartáče.
 290:C P[49] Tool_Offset,PR[30]
    :  P[50] R[23]mm/sec CNT100 Tool_Offset,PR[27]    ; ! Dokončení obdélníku, stále s rychlostí R23.
 291:   ; ! Oddělovač.
 292:L P[59] 2000mm/sec CNT50 Tool_Offset,PR[21]    ; ! Odjezd z kartáče.
 293:J P[60] 100% CNT100 Tool_Offset,PR[21]    ; ! Rychlý návrat k bezpečné pozici, kartáč zůstává zapnutý pro deburr.
 294:   ; ! Oddělovač.
 295:   ; ! Oddělovač.
 296:  !***************** ; ! Začátek mnou navrženého odhrotování.
 297:  !Odhrotovani ; ! Titulek deburring stanice.
 298:  !***************** ; ! Titulek.
 299:   ; ! Oddělovač.
 300:  WAIT DI[69]=ON    ; ! Čeká na připravené čelisti odhrotovače.
 301:   ; ! Oddělovač.
 302:   ; ! Oddělovač.
 303:J P[61] 100% CNT100 Tool_Offset,PR[21]    ; ! Přesun k nadjezdu nad čelistmi s offsetem dílu.
 304:L P[62:nad celisti] 2000mm/sec CNT0 Tool_Offset,PR[21]    ; ! Sjezd nad čelisti v UFRAME4/UTOOL5.
 305:L P[63:do celisti] 1000mm/sec FINE Tool_Offset,PR[26]    ; ! Vkládání dílu do čelistí s korekcí R19 v PR26.
 306:   ; ! Oddělovač.
 307:  !Upnout celisti ; ! Spouští upnutí odhrotovací jednotky.
 308:  DO[69]=ON ; ! Požadavek sevření čelistí.
 309:  WAIT (!DI[69] AND DI[71])    ; ! Čeká na potvrzení sevření (DI71) a uvolnění signálu připravenosti.
 310:  DO[69]=OFF ; ! Vypíná požadavek po potvrzení.
 311:   ; ! Oddělovač.
 312:  !Odepnout gripper robota ; ! Uvolnění dílu z robota.
 313:  DO[49]=ON ; ! Otevírá chapadlo 1.
 314:  WAIT (DI[49])    ; ! Ověří otevření.
 315:   ; ! Oddělovač.
 316:  !Start hrotovani ; ! Spuštění cyklu odhrotování.
 317:  DO[71]=PULSE,1.0sec ; ! Impuls start pro stroj (DO71), nový krok BP.
 318:  WAIT (!DI[71])    ; ! Čeká na odpadnutí signálu – stroj převzal díl.
 319:   ; ! Oddělovač.
 320:   ; ! Oddělovač.
 321:  !Odjezd ; ! Odjezd robota na bezpečí po spuštění stroje.
 322:  DO[73]=PULSE,0.5sec ; ! Impuls pro spuštění cyklu odhrotování/časování.
 323:L P[64] 2000mm/sec CNT50 Tool_Offset,PR[21]    ; ! Odjezd z čelistí.
 324:J P[65] 100% CNT80 TB   0.00sec,DO[113]=OFF Tool_Offset,PR[21]    ; ! Rychlý návrat, vypnutí kartáče DO113 po dokončení sekce.
 325:   ; ! Oddělovač.
 326:  LBL[41] ; ! Bypass, pokud se čištění/odhrotování neprovádí.
 327:   ; ! Oddělovač.
 328:  UFRAME_NUM=5 ; ! Přepnutí na výstupní rámec dopravníku.
 329:  UTOOL_NUM=5 ; ! Standardní griper pro odložení dílu.
 330:   ; ! Oddělovač.
 331:J P[26] 100% CNT100    ; ! Přesun k odkládacímu bodu na dopravník.
 332:   ; ! Oddělovač.
 333:  !Konec cyklu ; ! Ukončovací logika jednoho kusu.
 334:  IF (DI[54]),JMP LBL[50] ; ! Pokud PLC hlásí konec šarže, jdi do HOME.
 335:   ; ! Oddělovač.
 336:   ; ! Oddělovač.
 337:  JMP LBL[100] ; ! Jinak opakuj cyklus.
 338:   ; ! Oddělovač.
 339:  LBL[50] ; ! Konec šarže.
 340:   ; ! Oddělovač.
 341:  UFRAME_NUM=1 ; ! Rámec pro návrat domů.
 342:  UTOOL_NUM=2 ; ! Bezpečný nástroj pro HOME.
 343:J P[29] 20% CNT100    ; ! Přesun k mezi-bodu HOME.
 344:  !HOME ; ! Komentář k návratu.
 345:J PR[2] 20% FINE    ; ! Finální HOME pozice pro bezpečný konec.
/POS
P[1]{
   GP1:
	UF : 1, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =   389.381  mm,	Y =   -16.356  mm,	Z =  1582.094  mm,
	W =    22.984 deg,	P =    10.860 deg,	R =    20.222 deg
};
P[2]{
   GP1:
	UF : 1, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =   446.298  mm,	Y =  -125.311  mm,	Z =   344.420  mm,
	W =  -154.943 deg,	P =     1.209 deg,	R =  -168.942 deg
};
P[3]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -125.716  mm,	Y =     4.815  mm,	Z =   -32.703  mm,
	W =   -90.213 deg,	P =      .021 deg,	R =   -90.074 deg
};
P[4]{
   GP1:
	UF : 2, UT : 6,		CONFIG : 'N U T, 0, 0, 0',
	X =  -143.584  mm,	Y =    22.756  mm,	Z =    18.310  mm,
	W =    89.409 deg,	P =     -.005 deg,	R =    90.057 deg
};
P[5]{
   GP1:
	UF : 2, UT : 6,		CONFIG : 'N U T, 0, 0, 0',
	X =  -143.419  mm,	Y =    22.590  mm,	Z =   -33.391  mm,
	W =    90.211 deg,	P =     -.017 deg,	R =    88.929 deg
};
P[6]{
   GP1:
	UF : 2, UT : 6,		CONFIG : 'N U T, 0, 0, 0',
	X =  -141.740  mm,	Y =     4.099  mm,	Z =   -31.164  mm,
	W =    90.211 deg,	P =     -.017 deg,	R =    88.929 deg
};
P[7]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =  -274.012  mm,	Y =  -428.422  mm,	Z =  -178.308  mm,
	W =   178.640 deg,	P =    -1.463 deg,	R =    96.920 deg
};
P[8]{
   GP1:
	UF : 2, UT : 6,		CONFIG : 'N U T, 0, 0, 0',
	X =  -281.401  mm,	Y =    11.802  mm,	Z =    -6.403  mm,
	W =    90.211 deg,	P =     -.017 deg,	R =    88.930 deg
};
P[9]{
   GP1:
	UF : 3, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X = -1388.820  mm,	Y =  -878.227  mm,	Z =   -31.397  mm,
	W =   -90.239 deg,	P =     -.585 deg,	R =   161.718 deg
};
P[11]{
   GP1:
	UF : 1, UT : 5,	
	J1=   -63.455 deg,	J2=   -12.555 deg,	J3=   -22.794 deg,
	J4=   -30.823 deg,	J5=    36.532 deg,	J6=   114.591 deg
};
P[12]{
   GP1:
	UF : 2, UT : 5,	
	J1=    16.255 deg,	J2=   -32.122 deg,	J3=   -18.016 deg,
	J4=      .452 deg,	J5=   -72.031 deg,	J6=   -92.895 deg
};
P[13]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -110.054  mm,	Y =    23.601  mm,	Z =   -33.708  mm,
	W =   -90.326 deg,	P =     -.083 deg,	R =   -89.499 deg
};
P[14]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =   -90.832  mm,	Y =    22.390  mm,	Z =   -33.067  mm,
	W =   -90.326 deg,	P =     -.083 deg,	R =   -89.499 deg
};
P[15]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -494.266  mm,	Y =    29.948  mm,	Z =     5.705  mm,
	W =   -90.214 deg,	P =      .017 deg,	R =   -91.068 deg
};
P[16]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =  -274.240  mm,	Y =  -428.734  mm,	Z =  -167.226  mm,
	W =   178.640 deg,	P =    -1.462 deg,	R =    96.920 deg
};
P[17]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X = -1813.986  mm,	Y =   639.891  mm,	Z =   404.747  mm,
	W =  -111.166 deg,	P =   -38.099 deg,	R =    76.425 deg
};
P[18]{
   GP1:
	UF : 2, UT : 6,	
	J1=    15.377 deg,	J2=   -14.376 deg,	J3=   -21.566 deg,
	J4=      .494 deg,	J5=   -67.670 deg,	J6=     -.935 deg
};
P[19]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -681.418  mm,	Y =   686.753  mm,	Z =   403.122  mm,
	W =   -83.614 deg,	P =   -14.647 deg,	R =   -36.407 deg
};
P[20]{
   GP1:
	UF : 2, UT : 6,	
	J1=   -16.284 deg,	J2=   -25.800 deg,	J3=    -5.329 deg,
	J4=    15.510 deg,	J5=   -44.632 deg,	J6=   -16.282 deg
};
P[21]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -431.990  mm,	Y =   213.091  mm,	Z =   175.412  mm,
	W =   -90.232 deg,	P =    -2.071 deg,	R =   -90.752 deg
};
P[22]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -241.049  mm,	Y =   209.866  mm,	Z =   182.158  mm,
	W =   -90.232 deg,	P =    -2.071 deg,	R =   -90.753 deg
};
P[23]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -240.807  mm,	Y =   211.820  mm,	Z =   236.268  mm,
	W =   -90.232 deg,	P =    -2.071 deg,	R =   -90.753 deg
};
P[24]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -241.266  mm,	Y =   162.122  mm,	Z =   286.438  mm,
	W =   -90.232 deg,	P =    -2.071 deg,	R =   -90.754 deg
};
P[25]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -175.126  mm,	Y =    24.001  mm,	Z =     4.512  mm,
	W =   -90.214 deg,	P =      .017 deg,	R =   -91.068 deg
};
P[26]{
   GP1:
	UF : 5, UT : 5,	
	J1=   -69.974 deg,	J2=   -22.799 deg,	J3=   -12.777 deg,
	J4=   -19.257 deg,	J5=     9.991 deg,	J6=    47.165 deg
};
P[27]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =  -342.505  mm,	Y =  -436.976  mm,	Z =  -168.858  mm,
	W =   178.639 deg,	P =    -1.462 deg,	R =    96.920 deg
};
P[28]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -240.323  mm,	Y =   113.730  mm,	Z =   233.784  mm,
	W =   -90.232 deg,	P =    -2.071 deg,	R =   -90.754 deg
};
P[29]{
   GP1:
	UF : 1, UT : 2,		CONFIG : 'F U T, 0, 0, 0',
	X =    62.911  mm,	Y =  -118.419  mm,	Z =  1345.870  mm,
	W =    63.834 deg,	P =   -64.706 deg,	R =   -45.826 deg
};
P[30]{
   GP1:
	UF : 2, UT : 6,		CONFIG : 'N U T, 0, 0, 0',
	X =  -598.488  mm,	Y =    23.521  mm,	Z =   -29.471  mm,
	W =    90.212 deg,	P =     -.017 deg,	R =    88.930 deg
};
P[31]{
   GP1:
	UF : 3, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -432.243  mm,	Y =   -14.738  mm,	Z =   -16.589  mm,
	W =   -90.001 deg,	P =      .000 deg,	R =   -90.906 deg
};
P[32]{
   GP1:
	UF : 3, UT : 6,		CONFIG : 'N U T, 0, 0, 0',
	X =  -158.788  mm,	Y =   -21.982  mm,	Z =   -14.604  mm,
	W =    90.001 deg,	P =     -.000 deg,	R =    90.161 deg
};
P[33]{
   GP1:
	UF : 3, UT : 5,	
	J1=   116.626 deg,	J2=   -51.522 deg,	J3=    -2.455 deg,
	J4=      .479 deg,	J5=   -87.201 deg,	J6=   -84.281 deg
};
P[34]{
   GP1:
	UF : 3, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -134.372  mm,	Y =    -2.433  mm,	Z =    16.695  mm,
	W =   -90.001 deg,	P =      .000 deg,	R =   -90.906 deg
};
P[35]{
   GP1:
	UF : 3, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =   -59.682  mm,	Y =    -3.614  mm,	Z =   -16.594  mm,
	W =   -90.001 deg,	P =      .000 deg,	R =   -90.906 deg
};
P[36]{
   GP1:
	UF : 3, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =   -56.352  mm,	Y =   -20.684  mm,	Z =   -16.595  mm,
	W =   -90.001 deg,	P =      .000 deg,	R =   -90.906 deg
};
P[37]{
   GP1:
	UF : 3, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -114.041  mm,	Y =   -19.772  mm,	Z =   -16.594  mm,
	W =   -90.001 deg,	P =      .000 deg,	R =   -90.906 deg
};
P[38]{
   GP1:
	UF : 3, UT : 6,	
	J1=   112.433 deg,	J2=   -51.034 deg,	J3=    -6.639 deg,
	J4=      .455 deg,	J5=   -82.984 deg,	J6=    10.948 deg
};
P[39]{
   GP1:
	UF : 3, UT : 6,		CONFIG : 'N U T, 0, 0, 0',
	X =  -209.908  mm,	Y =   -22.125  mm,	Z =   -14.603  mm,
	W =    90.001 deg,	P =     -.000 deg,	R =    90.161 deg
};
P[40]{
   GP1:
	UF : 3, UT : 6,		CONFIG : 'N U T, 0, 0, 0',
	X =  -147.245  mm,	Y =    -1.615  mm,	Z =   -14.630  mm,
	W =    90.003 deg,	P =     -.003 deg,	R =    90.161 deg
};
P[41]{
   GP1:
	UF : 3, UT : 6,		CONFIG : 'N U T, 0, 0, 0',
	X =  -141.967  mm,	Y =    -1.765  mm,	Z =   -14.700  mm,
	W =    90.013 deg,	P =     -.004 deg,	R =    90.146 deg
};
P[42]{
   GP1:
	UF : 3, UT : 6,		CONFIG : 'N U T, 0, 0, 0',
	X =  -151.490  mm,	Y =    -5.546  mm,	Z =    26.869  mm,
	W =    90.001 deg,	P =     -.000 deg,	R =    90.162 deg
};
P[43]{
   GP1:
	UF : 3, UT : 6,		CONFIG : 'N U T, 0, 0, 0',
	X =  -467.424  mm,	Y =    -6.437  mm,	Z =    85.842  mm,
	W =    90.001 deg,	P =     -.000 deg,	R =    90.162 deg
};
P[44]{
   GP1:
	UF : 3, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -234.267  mm,	Y =   -17.870  mm,	Z =   -16.592  mm,
	W =   -90.001 deg,	P =      .000 deg,	R =   -90.906 deg
};
P[45]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =  -541.203  mm,	Y =  -464.452  mm,	Z =   -38.265  mm,
	W =   178.639 deg,	P =    -1.463 deg,	R =    96.920 deg
};
P[46]{
   GP1:
	UF : 1, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =   695.674  mm,	Y =    95.781  mm,	Z =   -80.671  mm,
	W =  -169.873 deg,	P =    16.640 deg,	R =   151.400 deg
};
P[47]{
   GP1:
	UF : 1, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =   794.890  mm,	Y =   240.507  mm,	Z =  -166.436  mm,
	W =  -170.296 deg,	P =    16.885 deg,	R =   151.400 deg
};
P[48]{
   GP1:
	UF : 1, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =   777.984  mm,	Y =   209.956  mm,	Z =  -160.470  mm,
	W =  -169.873 deg,	P =    16.640 deg,	R =   151.400 deg
};
P[49]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -239.920  mm,	Y =   159.114  mm,	Z =   183.872  mm,
	W =   -90.232 deg,	P =    -2.071 deg,	R =   -90.754 deg
};
P[50]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -242.239  mm,	Y =   212.226  mm,	Z =   237.080  mm,
	W =   -90.232 deg,	P =    -2.071 deg,	R =   -90.754 deg
};
P[52]{
   GP1:
	UF : 1, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =   786.369  mm,	Y =   254.137  mm,	Z =  -120.800  mm,
	W =  -169.873 deg,	P =    16.639 deg,	R =   151.400 deg
};
P[53]{
   GP1:
	UF : 1, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =   767.364  mm,	Y =   215.343  mm,	Z =  -120.630  mm,
	W =  -179.765 deg,	P =    16.639 deg,	R =   151.400 deg
};
P[54]{
   GP1:
	UF : 1, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =   666.268  mm,	Y =   266.537  mm,	Z =   258.506  mm,
	W =  -179.765 deg,	P =    16.639 deg,	R =   151.400 deg
};
P[55]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =  -273.653  mm,	Y =  -428.000  mm,	Z =  -198.531  mm,
	W =   178.649 deg,	P =    -1.450 deg,	R =    96.911 deg
};
P[56]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =  -274.152  mm,	Y =  -428.684  mm,	Z =  -174.065  mm,
	W =   178.781 deg,	P =    -1.562 deg,	R =    96.911 deg
};
P[57]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =  -346.126  mm,	Y =  -431.564  mm,	Z =  -156.520  mm,
	W =   178.781 deg,	P =    -1.563 deg,	R =    91.911 deg
};
P[58]{
   GP1:
	UF : 2, UT : 5,		CONFIG : 'F U T, 0, 0, 0',
	X =  -549.259  mm,	Y =  -407.578  mm,	Z =    11.443  mm,
	W =   178.640 deg,	P =    -1.462 deg,	R =    96.920 deg
};
P[59]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -242.007  mm,	Y =   214.084  mm,	Z =   288.526  mm,
	W =   -90.232 deg,	P =    -2.071 deg,	R =   -90.754 deg
};
P[60]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -394.508  mm,	Y =    61.988  mm,	Z =   268.410  mm,
	W =   -90.232 deg,	P =    -2.071 deg,	R =   -90.754 deg
};
P[61]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -388.210  mm,	Y =  -143.762  mm,	Z =   213.774  mm,
	W =   -90.128 deg,	P =     -.348 deg,	R =   -88.165 deg
};
P[62:"nad celisti"]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -121.847  mm,	Y =  -135.231  mm,	Z =   213.181  mm,
	W =   -90.128 deg,	P =     -.348 deg,	R =   -88.165 deg
};
P[63:"do celisti"]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -131.512  mm,	Y =  -136.427  mm,	Z =   169.789  mm,
	W =   -90.128 deg,	P =     -.348 deg,	R =   -88.165 deg
};
P[64]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -163.660  mm,	Y =  -133.101  mm,	Z =   317.456  mm,
	W =   -90.128 deg,	P =     -.348 deg,	R =   -88.166 deg
};
P[65]{
   GP1:
	UF : 4, UT : 5,		CONFIG : 'N U T, 0, 0, 0',
	X =  -422.342  mm,	Y =   327.703  mm,	Z =   405.575  mm,
	W =   -72.103 deg,	P =   -20.175 deg,	R =   -41.817 deg
};
/END
