
	select	--+ rule
			distinct

			rpad('Non Address',17)		" "
--			rpad('Bad Street', 17)		" "


--			,rpad(ltrim(appl_num),08)	" "
--			,rpad(' ',10)			" "

			,rpad(appl_pfx,   05)		" "
			,rpad(appl_name,  30)		" "
			,rpad(appl_type,  06)		" "
			,rpad(appl_sfx,   05)		" "

--			,rpad(appl_code1, 05)		" "
--			,rpad(appl_unit1, 08)		" "
--			,rpad(appl_code2, 05)		" "
--			,rpad(appl_unit2, 08)		" "
--			,chr(10)	" "


			,rpad(rec_key,    20)		"record key"
--			,lpad(rec_seq,    08)		" "
--			,rpad(do_alias,   15)		" "
--			,chr(10)	" "

	from		garland.adrResult		r


	where		verify_code =  0

	and not exists
(
	select 'x'
	from garland.adrStreets
	where addr_name = rtrim(r.addr_name)
)


--	order by	rpad(addr_name,30)
	;

                                                                    record key
----------------- ----- ------------------------------ ------ ----- --------------------
Non Address             ANNEX                                       421
Non Address             BALLFIELD #1                                483
Non Address             BALLFIELDS                                  2881
Non Address             BALLFIELDS                                  4298
Non Address             BALLFIELDS                                  5388
Non Address             BIRCHWOOD @ NW HWY                          6395
Non Address             BOBBIE @ NORMAN GRV                         5389
Non Address             BROADWAY/COLONEL                            6651
Non Address             CARTER COMPLEX-BALLF                        3023
Non Address             CARTER COMPLEX-IRRIG                        3020
Non Address             CARTER COMPLEX-PARK                         3022
Non Address             CENTERVILLE/NW HWY                          3751
Non Address             CLARA BARTON/WALNUT                         5453
Non Address             COLLINS & JUPITER                           3933
Non Address             CONCESS STND                                4226
Non Address             CONCESS STND                                4327
Non Address             CONCESS STND                                7347
Non Address             CONCESSION #4                               492
Non Address             CORNELL @ YALE                              5261
Non Address             COUNTRY CLB/EAGL PAS                        7017
Non Address             DIAMOND OAK/BUCKINGH                        67894
Non Address             FIELD #1                                    524
Non Address             FIELD #5                                    501
Non Address             FIRST & RR CROSSING                         4270
Non Address             FLANIGAN @ BRAND                            14786
Non Address             FOOTBALL FIELD                              4286
Non Address             FOREST LANE/MARION                          1658
Non Address             FOREST/JUPITER POSITION #1                  80656
Non Address             FOREST/JUPITER POSITION #2                  80657
Non Address             FOREST/JUPITER POSITION #3                  80658
Non Address             FOREST/JUPITER POSITION #4                  80659
Non Address             FOREST/JUPITER POSITION #5                  80660
Non Address             GCSF TOWER                                  4036
Non Address             GEN PK & RRM                                3492
Non Address             GRANGER CTR                                 417
Non Address             HWY 190 @ BRAND                             13440
Non Address             HWY 78 @ BEN DAVIS                          13439
Non Address             HWY 78 @ CASTLE                             4029
Non Address             HWY @ BUCKINGHAM                            4304
Non Address             IRRIGATION                                  295
Non Address             KELSO & LOCUST GROVE                        3744
Non Address             LAWRENCE AT SHILOH                          7141
Non Address             MCCALLUM/O'HENRY                            4961
Non Address             MEDIAN/HIGHGATE PL                          61246
Non Address             MUIRFIELD & N GARLAND                       13391
Non Address             MUIRFIELD & STONE MT                        12966
Non Address             NINTH & AVENUE A                            20
Non Address             NINTH & AVENUE A                            21
Non Address             NO STAR PARK                                4263
Non Address             O'SHANNON @ BRAND                           14787
Non Address             PLAYGROUND                                  1786
Non Address             PLEASANT VLY/MILES                          55235
Non Address             R CTR & POOL                                4857
Non Address             REC CENTER                                  2674
Non Address             REC CENTER                                  2747
Non Address             REC CENTER                                  4266
Non Address             RR XING @ 2999 MCCRE                        6311
Non Address             RR XING @ E CENTERVI                        3816
Non Address             RR XING @ E MILLER                          1283
Non Address             RR XING @ N GARLAND                         347
Non Address             RR XING @ W AVENUE F                        14424
Non Address             RR XING @ W KINGSLEY                        1899
Non Address             RR XING @ WALNUT                            219
Non Address             RR XING @WOOD/LONNEC                        5897
Non Address             RR XING @WOOD/MERRIT                        5896
Non Address             RT 2 BOX 202A BRAND                         13398
Non Address             RT 2 BOX 230                                4594
Non Address             RT 2 BOX 230                                4721
Non Address             RT 2 BOX 79B B DAVIS                        13696
Non Address             SIXTH & GARLAND                             179
Non Address             SPRINGPARK @WELLESLE                        4870
Non Address             SPRINGPARK @WOODS CT                        68090
Non Address             SWIM POOL                                   3085
Non Address             SWIM POOL                                   3141
Non Address             TENNIS COURT                                3173
Non Address             TENNIS CTR                                  1962
Non Address             TENNIS CTS                                  4074
Non Address             TENNIS CTS                                  4083
Non Address             VALLEY CRK & ROWLETT                        26265
Non Address             WINTERS PARK-SOCCER                         4479
Non Address             ZION & BAYBERRY                             3729
Non Address       S     GARLAND @ INWOOD               AVE          575
Non Address       S     GARLAND @ INWOOD               AVE          597
Non Address       W     AVENUE C @ SANTE                            568

84 rows selected.


--	=================================================================================

	select count(*) "TOTAL"
	from	garland.adrResult
	where	verify_code = 0;

     TOTAL
----------
        99

1 row selected.



--	=================================================================================
	spool	off;
