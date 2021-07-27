	where		rec_seq > 0;						-- jan 2004
	     		           *
ERROR at line 3:
ORA-00911: invalid character



   CATEGORY      Total
-- -------- ----------
00 Unknown          15
01 Poor            258
03 Wrong           113
04 Partial          67
05 Full          82904

5 rows selected.


VERIFY CODE                         Total
------------------------------ ----------
00: non address                        84
01: non garland                       804
10: valid   name                       15
11: poor    name                        1
14: partial name                        9
15: full    name                       58
21: poor    orphan                     37
24: partial orphan                     46
25: full    orphan                    197
31: poor    block                       4
33: wrong   block                       6
34: partial block                       5
35: full    block                    1905
51: poor    address                   216
53: wrong   address                   107
54: partial address                     7
55: full    address                 80744

17 rows selected.


LONE UNITS
----------
         0

1 row selected.


ALIAS RENAMES
-------------
            0

1 row selected.


NAME CHANGE                         total
------------------------------ ----------
name corrections                     1877

1 row selected.


AUDIT                               total
------------------------------ ----------
Aap;                                  109
Aap;Aat;                                2
Aas;                                    6
Aat;                                   24
Bap;                                    2
Bas;                                    6
Bat;                                    1
Sap                                     1
Sap Srt Sat                             1
Sap;                                    1
Sat                                   157
Sat Aap;                                4
Sat;                                    5
Srt                                   131
Srt Sat                               254
Srt Sat;                                1

16 rows selected.


PARTIAL      numb   pf name                 type sf
------------ ------ -- -------------------- ---- --
partial         909    CENTERVILLE          RD
partial         705    COLGATE
partial         205    DAUGHERTY            DR
partial         730    OATES                RD
partial         113    SIXTH                ST
partial         125    STATE                ST

6 rows selected.


WRONG        numb   pf name                 type sf
------------ ------ -- -------------------- ---- --
wrong          1114    ATLANTA              CIR
wrong           111 E  AVENUE A
wrong           515 W  AVENUE B
wrong           101 E  AVENUE D
wrong           308 E  AVENUE D
wrong           208 N  BARNES               DR
wrong           425 N  BARNES               DR
wrong           457 N  BARNES               DR
wrong           901 E  BELT LINE            RD
wrong          1111 E  BELT LINE            RD
wrong          3517    BOBBIE               CT
wrong           901 W  BRAND                RD
wrong          2406    BROOK CREST          DR
wrong          2410    BROOK CREST          DR
wrong          2414    BROOK CREST          DR
wrong          2418    BROOK CREST          DR
wrong          2422    BROOK CREST          DR
wrong          2426    BROOK CREST          DR
wrong          2430    BROOK CREST          DR
wrong          2434    BROOK CREST          DR
wrong           550 E  CAMPBELL             RD
wrong           226 E  CENTERVILLE          RD
wrong           305 E  CENTERVILLE          RD
wrong           104 W  CENTERVILLE          RD
wrong           118 W  CENTERVILLE          RD
wrong          1102 W  CENTERVILLE          RD
wrong          7010    CLEAR SPRINGS        CIR
wrong          7018    CLEAR SPRINGS        CIR
wrong          2318    CLUB CREEK           CT
wrong          3414    COLUMBIA             BLVD
wrong          1226 N  COUNTRY CLUB         RD
wrong          1806 S  COUNTRY CLUB         RD
wrong          1818 S  COUNTRY CLUB         RD
wrong           511 N  FIFTH                ST
wrong          1201 N  FIFTH                ST
wrong          2714 S  FIFTH                ST
wrong          2722 S  FIFTH                ST
wrong          2726 S  FIFTH                ST
wrong          1914 S  FIRST                ST
wrong          3609    GALAXIE              DR
wrong           405 N  GARLAND              AVE
wrong          6730 N  GARLAND              AVE
wrong          2801 S  GARLAND              AVE
wrong          2817 S  GARLAND              AVE
wrong           140 N  GARLAND              RD
wrong          2510 S  GLENBROOK            DR
wrong          2526 S  GLENBROOK            DR
wrong           914 E  I30                  FRWY
wrong           918 E  I30                  FRWY
wrong           930 E  I30                  FRWY
wrong           175 W  I30                  FRWY
wrong           325 W  I30                  FRWY
wrong           122 S  INTERNATIONAL        RD
wrong           126 S  INTERNATIONAL        RD
wrong          2218 S  JUPITER              RD
wrong           114 N  KIRBY                ST
wrong          3302    LARIAT               LN
wrong          1806    MILL POND            RD
wrong          1826    MILL POND            RD
wrong          1201 E  MILLER               RD
wrong          1434    MORRISON             DR
wrong          1458    MORRISON             DR
wrong           222 W  MUIRFIELD            RD
wrong           302 W  MUIRFIELD            RD
wrong          2625    NATIONAL             DR
wrong          2638    NATIONAL             PL
wrong           115 S  NINTH                ST
wrong           406 N  PLANO                RD
wrong           409 N  PURDUE               DR
wrong           418    RIDGEGATE            DR
wrong           422    RIDGEGATE            DR
wrong           426    RIDGEGATE            DR
wrong           430    RIDGEGATE            DR
wrong           434    RIDGEGATE            DR
wrong          2719    RIVIERA              DR
wrong          1501    SAVANNAH             DR
wrong          1503    SAVANNAH             DR
wrong          1505    SAVANNAH             DR
wrong          1507    SAVANNAH             DR
wrong          1509    SAVANNAH             DR
wrong          1117    SOUTHGATE            CIR
wrong          1016    STONEWALL            ST
wrong          1026    STONEWALL            ST
wrong           120 N  THIRD                ST
wrong          5015    VERA CRUZ            DR
wrong          2510    WALNUT               PKWY
wrong           521 E  WALNUT               ST
wrong           406 S  YALE                 DR

88 rows selected.


no rows selected


POOR         numb   pf name                 type sf
------------ ------ -- -------------------- ---- --
poor            110 N  BELT LINE            RD
poor            114 N  BELT LINE            RD
poor            202 N  BELT LINE            RD
poor            206 N  BELT LINE            RD
poor            210 N  BELT LINE            RD
poor            222 N  BELT LINE            RD
poor            302 N  BELT LINE            RD
poor            306 N  BELT LINE            RD
poor            310 N  BELT LINE            RD
poor           1500 E  STATE HIGHWAY 66     HWY

10 rows selected.



----------------------------------------------------------------------


1 row selected.


                   key        num   pf name                 type sf
------------------ ---------- ----- -- -------------------- ---- -- ------ --
Wrong Verify Code  82503       1409 E  BRAND                RD      10     55
Wrong Verify Code  13468       3637    CASTLE               DR      10     55
Wrong Verify Code  13470       3637    CASTLE               DR      10     55
Wrong Verify Code  87421       2501    CHESTERFIELD         RD      10     55
Wrong Verify Code  59           102    EAST SIDE OF SQUARE          10     55
Wrong Verify Code  12           108    EAST SIDE OF SQUARE          10     55
Wrong Verify Code  61           114    EAST SIDE OF SQUARE          10     55
Wrong Verify Code  70620        916 N  JUPITER              RD      10     55

8 rows selected.

