# Architektura robotického programu (FANUC)

## 1) Struktura programů a stanic
| Program | Funkce / stanice | UFRAME | UTOOL | Poznámka |
| --- | --- | --- | --- | --- |
| `MAIN` | Dispatcher, handshake s PLC a volba výrobního programu | n/a | n/a | Loops handshake DO14/DI14, skládá název ze `SR[24]+R[1]` a volá podprogram. |
| `BG1` | Background task pro příjem programu a délky trubky z PLC | n/a | n/a | Přenáší GI1→`R[1]` a GI2→`R[2]`, echo GO1/GO2. |
| `PROG30` | Hlavní výrobní cyklus (zásobník → vyrovnávací stanice → 5‑stroke → Shawer 2 → čištění kartáčem → odhrotování → výstup) | Více (1,2,3,4,5) | Více (5,6) | Nová část čištění/odhrotování integrována v sekci UF4/UT5. |
| `INIT` | Příprava I/O a chapadel | n/a | n/a | Spuštěno z PROG30 před cyklem. |
| `OPEN_CLOSE_GR_1/2` | Makra pro otevření/zavření chapadel | n/a | n/a | Volána z jiných programů podle potřeby. |

## 2) UFRAME a UTOOL – geometrie a stanice
| UFRAME | Použití | Programy |
| --- | --- | --- |
| 1 | Vstupní zásobník a návrat HOME | `PROG30` (zásobník, start/end) |
| 2 | Vyrovnávací stanice a 5‑stroke | `PROG30` |
| 3 | Shawer 2 | `PROG30` |
| 4 | Nová stanice mechanického čištění a pozicování pro odhrotování | `PROG30` |
| 5 | Výstupní dopravník / odkládací pozice | `PROG30` |

| UTOOL | Použití | Programy |
| --- | --- | --- |
| 5 | Standardní griper pro manipulaci, čištění kartáčem, odhrotování | `PROG30` (většina stanic + UF4 kartáč/odhrotování) |
| 6 | Alternativní orientace nástroje pro 5‑stroke a vkládání do Shawer 2 | `PROG30` (5‑stroke odběr, Shawer 2 vkládání) |

## 3) Registry R19, R21, R23 (trajektorie čištění)
| Registr | Nastavuje se | Čte se | Význam |
| --- | --- | --- | --- |
| `R[19]` | Ověřován v PROG30 (`WAIT` rozsah −2..2) | Přidává se do `PR[26,3]` | Ruční korekce/přítlak kartáče (Z offset) – kompenzace opotřebení ručně. |
| `R[21]` | Zadává operátor (není počítán v kódu) | Vzorce pro PR27–PR30 (posuny ±R21 v X/Y) | Poloměr/excentricita obdélníkové dráhy čištění (XY offset rohů). |
| `R[23]` | Zadává rychlost | Použit jako rychlost v mm/s pro kroky L/C v dráze čištění | Posuvová rychlost kartáčové dráhy. |

## 4) Group I/O GI/GO
| Signál | Mapa / název (podle kódu) | Použití v TP | Význam |
| --- | --- | --- | --- |
| GI[1] | Číslo programu | `BG1` (R1=GI1), `MAIN` (SR24+R1) | Výběr výrobního programu z PLC. |
| GI[2] | Délka trubky | `BG1` (R2=GI2), `PROG30` (R10=GI2, výšky) | Parametr trajektorie (Z výšky, validace 170–400 mm). |
| GI[3] | Index pozice v zásobníku | `PROG30` (R5=GI3 → PR14 offset) | Rozteč slotu vstupního zásobníku. |
| GO[1] | Echo čísla programu | `BG1` | Diagnostika/echo na PLC. |
| GO[2] | Echo délky trubky | `BG1` | Diagnostika/echo na PLC. |
| GO[3] | Stav obsluhované stanice | `PROG30` (6 zásobník, 2 5‑stroke, 3 Shawer, 4 čištění) | Informace PLC o aktuálním kroku. |

## 5) Digitální I/O – nová stanice
| Signál | Typ | Použití v programu | Význam |
| --- | --- | --- | --- |
| DO49 | DO | Otevírání griperu 1 (odběr, předání, odhrotování) | Uvolní/otevře čelist robota. |
| DO51 | DO | Otevírání griperu 2 | Druhý griper. |
| DO58 | DO | Pulse takt zásobníku | Posun vstupního zásobníku. |
| DO69 | DO | Požadavek sevření čelistí odhrotovače | Spuštění upnutí. |
| DO71 | DO | Pulse start odhrotování | Zahájení cyklu stroje. |
| DO73 | DO | Pulse pro cyklus/časování odhrotování | Potvrzení/časovač. |
| DO113 | DO | Zapnutí motoru kartáče | Aktivuje kartáč při čištění. |
| DI56 | DI | Stav lůžka bufferu | Volnost vyrovnávací stanice. |
| DI69 | DI | Připravenost čelistí odhrotovače | Stroj připraven k vložení. |
| DI71 | DI | Stav čelistí odhrotovače | Upnuto/odpnuto, potvrzuje DO69/DO71. |
| DI77 | DI | Přítomnost dílu v zásobníku | Spouští odběr. |

Pozn.: DI53/DI54/DI65/DI66… jsou v PROG30 také používány pro logiku stanic, ale zde jsou vypsány hlavní nové signály.

## 6) Shrnutí nové části (čištění + odhrotování)
- Obsluhuje ji `PROG30` v sekci UFRAME4 (kartáč) a následném předání do odhrotovače.
- Čištění kartáčem: `UFRAME_NUM=4`, `UTOOL_NUM=5`, trajektorie tvořena PR26–PR30 s korekcemi R19 (Z přítlak), R21 (XY excentricita), rychlost R23, kartáč spíná DO113. 
- Odhrotování: stále `UFRAME_NUM=4`, `UTOOL_NUM=5` při zakládání, využívá PR26 (Z offset) a PR21 (délka dílu). Signály DI69/DI71 potvrzují stav čelistí, DO69/DO71/DO73 řídí sevření a start stroje.
- Postup v PROG30 je implementován pořadím: zásobník → vyrovnávací stanice → 5‑stroke → Shawer 2 → čištění → odhrotování → výstup (UF5). Pokud není díl v griperu, sekce čištění/odhrotování je přeskočena (LBL[41]).

