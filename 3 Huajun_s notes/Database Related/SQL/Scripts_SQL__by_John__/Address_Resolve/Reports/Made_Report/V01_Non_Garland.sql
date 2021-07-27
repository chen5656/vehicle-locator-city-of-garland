
	select	--+ rule
			distinct

			rpad('Non Garland',16)		" "
--			rpad('Bad Street' ,16)		" "


			,rpad(do_alias,   15)		" "
			,rpad(do_name,    01)		" "
--			,chr(10)	" "


			,rpad(appl_num,   10)		" "
			,rpad(appl_pfx,   05)		" "
			,rpad(appl_name,  30)		" "
			,rpad(appl_type,  06)		" "
			,rpad(appl_sfx,   05)		" "

--			,rpad(appl_code1, 05)		" "
--			,rpad(appl_unit1, 08)		" "
--			,rpad(appl_code2, 05)		" "
--			,rpad(appl_unit2, 08)		" "
--			,chr(10)	" "

--			,rpad(' ',		16)		" "			--	either
--			,rpad(addr_num,   10)		" "
--			,rpad(addr_pfx,   05)		" "
--			,rpad(addr_name,  30)		" "
--			,rpad(addr_type,  06)		" "
--			,rpad(addr_sfx,   05)		" "
--			,rpad(addr_code1, 05)		" "
--			,rpad(addr_unit1, 08)		" "
--			,rpad(addr_code2, 05)		" "
--			,rpad(addr_unit2, 08)		" "
--			,chr(10)	" "

			,rpad(rec_key,    20)		" "
--			,rpad(rec_seq,    15)		" "
--			,lpad(verify_code,02)		" "

	from		garland.adrResult
	where		verify_code =  01

--	and		nvl(do_alias,' ')	>= 'A'
--	order by	rpad(addr_name,30)
	;


---------------- --------------- - ---------- ----- ------------------------------ ------ ----- --------------------
Non Garland                        1                ADMINISTRATIVE USE                          87550
Non Garland                        1017             RIDGE WAY                      AL           66095
Non Garland                        1018             RIDGE WAY                      AL           66108
Non Garland                        1021             RIDGE WAY                      AL           66096
Non Garland                        1022             RIDGE WAY                      AL           66107
Non Garland                        10430            MARKISON                       RD           87618
Non Garland                        10615      S     SANDEN                         BLVD         83178
Non Garland                        1101             GARDENGATE CIR                 AL           42280
Non Garland                        1101             RIDGE WAY                      AL           66097
Non Garland                        1102             GARDENGATE CIR                 AL           42212
Non Garland                        1102             RIDGE WAY                      AL           66106
Non Garland                        1105             GARDENGATE CIR                 AL           30540
Non Garland                        1105             RIDGE WAY                      AL           66098
Non Garland                        1106             RIDGE WAY                      AL           66105
Non Garland                        1109             RIDGE WAY                      AL           66099
Non Garland                        1110             GARDENGATE CIR                 AL           42213
Non Garland                        1110             RIDGE WAY                      AL           66104
Non Garland                        1113             GARDENGATE CIR                 AL           42268
Non Garland                        1113             RIDGE WAY                      AL           66100
Non Garland                        1114             GARDENGATE CIR                 AL           42214
Non Garland                        1114             RIDGE WAY                      AL           66103
Non Garland                        1117             GARDENGATE CIR                 AL           42267
Non Garland                        1117             RIDGE WAY                      AL           66101
Non Garland                        1118             GARDENGATE CIR                 AL           42215
Non Garland                        1118             RIDGE WAY                      AL           66102
Non Garland                        1121             GARDENGATE CIR                 AL           42266
Non Garland                        1122             GARDENGATE CIR                 AL           42216
Non Garland                        1125             GARDENGATE CIR                 AL           42265
Non Garland                        1126             GARDENGATE CIR                 AL           42217
Non Garland                        1129             GARDENGATE CIR                 AL           42263
Non Garland                        1130             GARDENGATE CIR                 AL           42218
Non Garland                        1134             GARDENGATE CIR                 AL           42219
Non Garland                        11477            PAGEMILL                       RD           80883
Non Garland                        11620            CHAIRMAN                       DR           84957
Non Garland                        11620            CHAIRMAN                       DR           84958
Non Garland                        11624            CHAIRMAN                       DR           84586
Non Garland                        117              FOURTEENTH                                  390
Non Garland                        1201             GARDENGATE CIR                 AL           42225
Non Garland                        1205             GARDENGATE CIR                 AL           42226
Non Garland                        1206             GARDENGATE CIR                 AL           42262
Non Garland                        1209             GARDENGATE CIR                 AL           42227
Non Garland                        1210             GARDENGATE CIR                 AL           42261
Non Garland                        1213             GARDENGATE CIR                 AL           42228
Non Garland                        1214             GARDENGATE CIR                 AL           42260
Non Garland                        12750            PERIMETER                      RD           86046
Non Garland                        1701             CASTLECREST                    DR           79346
Non Garland                        1705             CASTLECREST                    DR           79347
Non Garland                        1709             CASTLECREST                    DR           79348
Non Garland                        1710             CASTLECREST                    DR           79349
Non Garland                        1713             CASTLECREST                    DR           79350
Non Garland                        1714             CASTLECREST                    DR           79351
Non Garland                        1717             CASTLECREST                    DR           79352
Non Garland                        1718             CASTLECREST                    DR           79353
Non Garland                        1721             CASTLECREST                    DR           79354
Non Garland                        1722             CASTLECREST                    DR           79355
Non Garland                        1725             CASTLECREST                    DR           79356
Non Garland                        1726             CASTLECREST                    DR           79357
Non Garland                        1729             CASTLECREST                    DR           79358
Non Garland                        1733             CASTLECREST                    DR           79359
Non Garland                        2101             PINE CONE                      DR           79942
Non Garland                        2105             PINE CONE                      DR           79943
Non Garland                        2109             PINE CONE                      DR           79944
Non Garland                        2113             PINE CONE                      DR           79945
Non Garland                        2117             PINE CONE                      DR           79946
Non Garland                        2121             PINE CONE                      DR           79947
Non Garland                        2125             PINE CONE                      DR           79948
Non Garland                        2129             PINE CONE                      DR           79949
Non Garland                        2133             PINE CONE                      DR           79950
Non Garland                        2201             PINE CONE                      DR           79951
Non Garland                        2205             PINE CONE                      DR           79952
Non Garland                        2209             PINE CONE                      DR           79953
Non Garland                        2213             PINE CONE                      DR           79954
Non Garland                        2217             PINE CONE                      DR           79955
Non Garland                        2221             PINE CONE                      DR           79956
Non Garland                        2225             PINE CONE                      DR           79957
Non Garland                        2229             PINE CONE                      DR           79958
Non Garland                        2233             PINE CONE                      DR           79959
Non Garland                        2301             BARTONWOOD                     DR           79030
Non Garland                        2301             SPRUCE                         LN           80211
Non Garland                        2302             BARTONWOOD                     DR           79031
Non Garland                        2302             SPRUCE                         LN           80212
Non Garland                        2303             BARTONWOOD                     DR           79032
Non Garland                        2305             BARTONWOOD                     DR           79033
Non Garland                        2305             SPRUCE                         LN           80213
Non Garland                        2306             BARTONWOOD                     DR           79034
Non Garland                        2306             SPRUCE                         LN           80214
Non Garland                        2309             BARTONWOOD                     DR           79035
Non Garland                        2309             SPRUCE                         LN           80215
Non Garland                        2310             BARTONWOOD                     DR           79036
Non Garland                        2310             SPRUCE                         LN           80216
Non Garland                        2313             BARTONWOOD                     DR           79037
Non Garland                        2313             SPRUCE                         LN           80217
Non Garland                        2314             BARTONWOOD                     DR           79038
Non Garland                        2314             SPRUCE                         LN           80218
Non Garland                        2317             BARTONWOOD                     DR           79039
Non Garland                        2317             SPRUCE                         LN           80219
Non Garland                        2318             BARTONWOOD                     DR           79040
Non Garland                        2318             SPRUCE                         LN           80220
Non Garland                        2401             BARTONWOOD                     DR           79041
Non Garland                        2401             SPRUCE                         LN           80221
Non Garland                        2402             BARTONWOOD                     DR           79042
Non Garland                        2402             SPRUCE                         LN           80222
Non Garland                        2405             BARTONWOOD                     DR           79043
Non Garland                        2405             SPRUCE                         LN           80223
Non Garland                        2406             BARTONWOOD                     DR           79044
Non Garland                        2406             SPRUCE                         LN           80224
Non Garland                        2409             BARTONWOOD                     DR           79045
Non Garland                        2409             SPRUCE                         LN           80225
Non Garland                        2410             BARTONWOOD                     DR           79046
Non Garland                        2410             SPRUCE                         LN           80226
Non Garland                        2413             BARTONWOOD                     DR           79047
Non Garland                        2413             SPRUCE                         LN           80227
Non Garland                        2414             BARTONWOOD                     DR           79048
Non Garland                        2414             SPRUCE                         LN           80228
Non Garland                        2417             BARTONWOOD                     DR           79049
Non Garland                        2417             SPRUCE                         LN           80229
Non Garland                        2418             BARTONWOOD                     DR           79050
Non Garland                        2418             SPRUCE                         LN           80230
Non Garland                        3315             CARLA                          DR           3854
Non Garland                        3315             CARLA                          DR           88017
Non Garland                        355              BROOKVIEW-MDWCRK PK                         3471
Non Garland                        3801             DOWNS WAY                      AL           10568
Non Garland                        3802             DOWNS WAY                      AL           10517
Non Garland                        3805             DOWNS WAY                      AL           10569
Non Garland                        3806             DOWNS WAY                      AL           10516
Non Garland                        3809             DOWNS WAY                      AL           10570
Non Garland                        3810             DOWNS WAY                      AL           10515
Non Garland                        3813             DOWNS WAY                      AL           10571
Non Garland                        3814             DOWNS WAY                      AL           10514
Non Garland                        3818             DOWNS WAY                      AL           10513
Non Garland                        3822             DOWNS WAY                      AL           10512
Non Garland                        5201             NITA PEARSON                   DR           85995
Non Garland                        6600             DANRIDGE                       RD           55241
Non Garland                        6601             DANRIDGE                       RD           55237
Non Garland                        901              BOIS D'ARC                     CT           67072
Non Garland                        902              BOIS D'ARC                     CT           67077
Non Garland                        905              BOIS D'ARC                     CT           67071
Non Garland                        906              BOIS D'ARC                     CT           67078
Non Garland                        909              BOIS D'ARC                     CT           67070
Non Garland                        910              BOIS D'ARC                     CT           67079
Non Garland                        913              BOIS D'ARC                     CT           67069
Non Garland                        914              BOIS D'ARC                     CT           67080
Non Garland                        9830             CHARTWELL                      DR           86578
Non Garland      22$               10375            BROCKWOOD                      RD           83519
Non Garland      22$               1301             WILLOW WAY                     AL           30684
Non Garland      22$               1302             WILLOW WAY                     AL           30677
Non Garland      22$               1305             WILLOW WAY                     AL           30728
Non Garland      22$               1306             WILLOW WAY                     AL           30729
Non Garland      22$               1309             WILLOW WAY                     AL           30683
Non Garland      22$               1310             WILLOW WAY                     AL           30679
Non Garland      22$               1313             WILLOW WAY                     AL           30681
Non Garland      22$               1317             WILLOW WAY                     AL           30680
Non Garland      22$               1701             PARKSHIRE                      PL           79888
Non Garland      22$               1701             REGAL HAVEN                    CIR          79993
Non Garland      22$               1701             REGAL HAVEN                    PL           80037
Non Garland      22$               1702             MERRIHAVEN                     DR           79720
Non Garland      22$               1702             PARKSHIRE                      PL           79889
Non Garland      22$               1702             REGAL HAVEN                    CIR          79994
Non Garland      22$               1702             REGAL HAVEN                    PL           80038
Non Garland      22$               1705             PARKSHIRE                      PL           79890
Non Garland      22$               1705             REGAL HAVEN                    CIR          79995
Non Garland      22$               1705             REGAL HAVEN                    PL           80039
Non Garland      22$               1706             MERRIHAVEN                     DR           79721
Non Garland      22$               1706             PARKSHIRE                      PL           79891
Non Garland      22$               1706             REGAL HAVEN                    CIR          79996
Non Garland      22$               1706             REGAL HAVEN                    PL           80040
Non Garland      22$               1709             PARKSHIRE                      PL           79892
Non Garland      22$               1709             REGAL HAVEN                    CIR          79997
Non Garland      22$               1709             REGAL HAVEN                    PL           80041
Non Garland      22$               1710             MERRIHAVEN                     DR           79722
Non Garland      22$               1710             PARKSHIRE                      PL           79893
Non Garland      22$               1710             REGAL HAVEN                    CIR          79998
Non Garland      22$               1713             PARKSHIRE                      PL           79894
Non Garland      22$               1713             REGAL HAVEN                    CIR          79999
Non Garland      22$               1714             MERRIHAVEN                     DR           79723
Non Garland      22$               1714             PARKSHIRE                      PL           79895
Non Garland      22$               1717             PARKSHIRE                      PL           79896
Non Garland      22$               1718             MERRIHAVEN                     DR           79724
Non Garland      22$               1718             PARKSHIRE                      PL           79897
Non Garland      22$               1721             MERRIHAVEN                     DR           79725
Non Garland      22$               1721             PARKSHIRE                      PL           79898
Non Garland      22$               1722             MERRIHAVEN                     DR           79726
Non Garland      22$               1722             PARKSHIRE                      PL           79899
Non Garland      22$               1725             MERRIHAVEN                     DR           79727
Non Garland      22$               1726             MERRIHAVEN                     DR           79728
Non Garland      22$               1729             MERRIHAVEN                     DR           79729
Non Garland      22$               1730             MERRIHAVEN                     DR           79730
Non Garland      22$               1733             MERRIHAVEN                     DR           79731
Non Garland      22$               1801             PARKLANE                       CT           79878
Non Garland      22$               1802             PARKLANE                       CT           79879
Non Garland      22$               1805             PARKLANE                       CT           79880
Non Garland      22$               1806             PARKLANE                       CT           79881
Non Garland      22$               1809             PARKLANE                       CT           79882
Non Garland      22$               1810             PARKLANE                       CIR          79883
Non Garland      22$               1813             PARKLANE                       CT           79884
Non Garland      22$               1814             PARKLANE                       CT           79885
Non Garland      22$               1817             PARKLANE                       CT           79886
Non Garland      22$               1818             PARKLANE                       CT           79887
Non Garland      22$               1901             KNOB OAK                       DR           79619
Non Garland      22$               1901             PARKLANE                       CIR          79845
Non Garland      22$               1901             REGAL HAVEN                    DR           80000
Non Garland      22$               1902             PARKLANE                       CIR          79846
Non Garland      22$               1902             REGAL HAVEN                    DR           80001
Non Garland      22$               1904             PARKLANE                       CIR          79847
Non Garland      22$               1905             KNOB OAK                       DR           79620
Non Garland      22$               1905             PARKLANE                       CIR          79848
Non Garland      22$               1906             PARKLANE                       CIR          79849
Non Garland      22$               1906             REGAL HAVEN                    DR           80002
Non Garland      22$               1908             PARKLANE                       CIR          79850
Non Garland      22$               1909             KNOB OAK                       DR           79621
Non Garland      22$               1909             PARKLANE                       CIR          79851
Non Garland      22$               1909             REGAL HAVEN                    DR           80003
Non Garland      22$               1910             PARKLANE                       CIR          79852
Non Garland      22$               1910             REGAL HAVEN                    DR           80004
Non Garland      22$               1912             PARKLANE                       CIR          79853
Non Garland      22$               1913             KNOB OAK                       DR           79622
Non Garland      22$               1913             PARKLANE                       CIR          79854
Non Garland      22$               1913             REGAL HAVEN                    DR           80005
Non Garland      22$               1914             REGAL HAVEN                    CIR          80006
Non Garland      22$               1916             PARKLANE                       CIR          79855
Non Garland      22$               1917             PARKLANE                       CIR          79856
Non Garland      22$               1918             REGAL HAVEN                    DR           80007
Non Garland      22$               1920             PARKLANE                       CIR          79857
Non Garland      22$               1921             PARKLANE                       CIR          79858
Non Garland      22$               1922             REGAL HAVEN                    DR           80008
Non Garland      22$               1924             PARKLANE                       CIR          79859
Non Garland      22$               1925             PARKLANE                       PL           79860
Non Garland      22$               1926             REGAL HAVEN                    DR           80009
Non Garland      22$               1928             PARKLANE                       CIR          79861
Non Garland      22$               1929             PARKLANE                       CIR          79862
Non Garland      22$               1930             REGAL HAVEN                    DR           80010
Non Garland      22$               1932             PARKLANE                       CIR          79863
Non Garland      22$               1933             PARKLANE                       CIR          79864
Non Garland      22$               1936             PARKLANE                       CIR          79865
Non Garland      22$               1937             PARKLANE                       CIR          79866
Non Garland      22$               1940             PARKLANE                       CIR          79867
Non Garland      22$               1941             PARKLANE                       CIR          79868
Non Garland      22$               1942             PARKLANE                       CIR          79869
Non Garland      22$               1944             PARKLANE                       CIR          79870
Non Garland      22$               1945             PARKLANE                       CIR          79871
Non Garland      22$               1946             PARKLANE                       CIR          79872
Non Garland      22$               1948             PARKLANE                       CIR          79873
Non Garland      22$               1949             PARKLANE                       CIR          79874
Non Garland      22$               1950             PARKLANE                       CIR          79875
Non Garland      22$               1952             PARKLANE                       CIR          79876
Non Garland      22$               1953             PARKLANE                       CIR          79877
Non Garland      22$               2001             KNOB OAK                       DR           79623
Non Garland      22$               2002             HOLLY GLEN                     CIR          79518
Non Garland      22$               2002             REGAL HAVEN                    DR           80011
Non Garland      22$               2005             KNOB OAK                       DR           79624
Non Garland      22$               2006             HOLLY GLEN                     CIR          79519
Non Garland      22$               2006             REGAL HAVEN                    DR           80012
Non Garland      22$               2009             KNOB OAK                       DR           79625
Non Garland      22$               2010             HOLLY GLEN                     CIR          79520
Non Garland      22$               2010             REGAL HAVEN                    DR           80013
Non Garland      22$               2013             KNOB OAK                       DR           79626
Non Garland      22$               2014             HOLLY GLEN                     CIR          79521
Non Garland      22$               2014             REGAL HAVEN                    DR           80014
Non Garland      22$               2018             HOLLY GLEN                     CIR          79522
Non Garland      22$               2018             REGAL HAVEN                    CIR          80015
Non Garland      22$               2022             HOLLY GLEN                     CIR          79523
Non Garland      22$               2022             REGAL HAVEN                    DR           80017
Non Garland      22$               2026             HOLLY GLEN                     CIR          79524
Non Garland      22$               2026             REGAL HAVEN                    DR           80018
Non Garland      22$               2030             HOLLY GLEN                     CIR          79525
Non Garland      22$               2030             REGAL HAVEN                    DR           80019
Non Garland      22$               2102             HOLLY GLEN                     CIR          79526
Non Garland      22$               2102             REGAL HAVEN                    DR           80020
Non Garland      22$               2106             HOLLY GLEN                     CIR          79527
Non Garland      22$               2106             REGAL HAVEN                    DR           80021
Non Garland      22$               2110             HOLLY GLEN                     CIR          79528
Non Garland      22$               2110             REGAL HAVEN                    DR           80022
Non Garland      22$               2113             REGAL HAVEN                    DR           80023
Non Garland      22$               2114             HOLLY GLEN                     CIR          79529
Non Garland      22$               2114             REGAL HAVEN                    DR           80024
Non Garland      22$               2117             REGAL HAVEN                    DR           80025
Non Garland      22$               2118             HOLLY GLEN                     CIR          79530
Non Garland      22$               2118             REGAL HAVEN                    DR           80026
Non Garland      22$               2120             WHITE WATER                    BLVD         6208
Non Garland      22$               2122             HOLLY GLEN                     CIR          79531
Non Garland      22$               2122             REGAL HAVEN                    DR           80027
Non Garland      22$               2126             HOLLY GLEN                     CIR          79532
Non Garland      22$               2130             HOLLY GLEN                     DR           79533
Non Garland      22$               2134             HOLLY GLEN                     CIR          79534
Non Garland      22$               2201             REGAL HAVEN                    DR           80028
Non Garland      22$               2202             HOLLY GLEN                     CIR          79535
Non Garland      22$               2202             REGAL HAVEN                    DR           80029
Non Garland      22$               2202             SHERMAN                        RD           80129
Non Garland      22$               2202             SILVER MEADOWS                 DR           80163
Non Garland      22$               2205             REGAL HAVEN                    DR           80030
Non Garland      22$               2206             HOLLY GLEN                     CIR          79536
Non Garland      22$               2206             REGAL HAVEN                    DR           80031
Non Garland      22$               2206             SHERMAN                        RD           80130
Non Garland      22$               2206             SILVER MEADOWS                 DR           80164
Non Garland      22$               2209             SILVER MEADOWS                 DR           80165
Non Garland      22$               2210             HOLLY GLEN                     CIR          79537
Non Garland      22$               2210             REGAL HAVEN                    DR           80032
Non Garland      22$               2210             SHERMAN                        RD           80131
Non Garland      22$               2210             SILVER MEADOWS                 DR           80166
Non Garland      22$               2213             SILVER MEADOWS                 DR           80167
Non Garland      22$               2214             HOLLY GLEN                     CIR          79538
Non Garland      22$               2214             REGAL HAVEN                    DR           80033
Non Garland      22$               2214             SHERMAN                        RD           80132
Non Garland      22$               2214             SILVER MEADOWS                 DR           80168
Non Garland      22$               2217             SILVER MEADOWS                 DR           80169
Non Garland      22$               2218             HOLLY GLEN                     CIR          79539
Non Garland      22$               2218             REGAL HAVEN                    DR           80034
Non Garland      22$               2218             SHERMAN                        RD           80133
Non Garland      22$               2218             SILVER MEADOWS                 DR           80170
Non Garland      22$               2221             SILVER MEADOWS                 DR           80171
Non Garland      22$               2222             HOLLY GLEN                     CIR          79540
Non Garland      22$               2222             REGAL HAVEN                    DR           80035
Non Garland      22$               2222             SHERMAN                        RD           80134
Non Garland      22$               2222             SILVER MEADOWS                 DR           80172
Non Garland      22$               2225             SILVER MEADOWS                 DR           80173
Non Garland      22$               2226             HOLLY GLEN                     CIR          79541
Non Garland      22$               2226             REGAL HAVEN                    DR           80036
Non Garland      22$               2226             SHERMAN                        RD           80135
Non Garland      22$               2226             SILVER MEADOWS                 DR           80174
Non Garland      22$               2229             SILVER MEADOWS                 DR           80175
Non Garland      22$               2230             HOLLY GLEN                     CIR          79542
Non Garland      22$               2230             SHERMAN                        RD           80136
Non Garland      22$               2230             SILVER MEADOWS                 DR           80176
Non Garland      22$               2234             HOLLY GLEN                     CIR          79543
Non Garland      22$               2234             SHERMAN                        RD           80137
Non Garland      22$               2238             HOLLY GLEN                     CIR          79544
Non Garland      22$               2238             SHERMAN                        RD           80138
Non Garland      22$               2242             HOLLY GLEN                     CIR          79545
Non Garland      22$               2242             SHERMAN                        RD           80139
Non Garland      22$               2301             HOLLOW OAKS                    DR           79478
Non Garland      22$               2301             HOLLY GLEN                     CIR          79546
Non Garland      22$               2301             SILVER MEADOWS                 DR           80177
Non Garland      22$               2302             HOLLOW OAKS                    DR           79479
Non Garland      22$               2302             HOLLY GLEN                     CIR          79547
Non Garland      22$               2302             SHERMAN                        RD           80140
Non Garland      22$               2302             SILVER MEADOWS                 DR           80178
Non Garland      22$               2303             HOLLOW OAKS                    DR           79480
Non Garland      22$               2304             HOLLY GLEN                     CIR          79548
Non Garland      22$               2305             HOLLOW OAKS                    DR           79481
Non Garland      22$               2305             HOLLY GLEN                     CIR          79549
Non Garland      22$               2305             SILVER MEADOWS                 DR           80179
Non Garland      22$               2306             HOLLOW OAKS                    DR           79482
Non Garland      22$               2306             HOLLY GLEN                     CIR          79550
Non Garland      22$               2306             SHERMAN                        RD           80141
Non Garland      22$               2306             SILVER MEADOWS                 DR           80180
Non Garland      22$               2308             HOLLY GLEN                     CIR          79551
Non Garland      22$               2309             HOLLOW OAKS                    DR           79483
Non Garland      22$               2309             HOLLY GLEN                     CIR          79552
Non Garland      22$               2309             SILVER MEADOWS                 DR           80181
Non Garland      22$               2310             HOLLOW OAKS                    DR           79484
Non Garland      22$               2310             HOLLY GLEN                     CIR          79553
Non Garland      22$               2310             SHERMAN                        RD           80142
Non Garland      22$               2310             SILVER MEADOWS                 DR           80182
Non Garland      22$               2311             HOLLY GLEN                     CIR          79554
Non Garland      22$               2312             HOLLY GLEN                     CIR          79555
Non Garland      22$               2313             HOLLOW OAKS                    DR           79485
Non Garland      22$               2313             HOLLY GLEN                     CIR          79556
Non Garland      22$               2313             SILVER MEADOWS                 DR           80183
Non Garland      22$               2314             HOLLOW OAKS                    DR           79486
Non Garland      22$               2314             HOLLY GLEN                     CIR          79557
Non Garland      22$               2314             SHERMAN                        RD           80143
Non Garland      22$               2314             SILVER MEADOWS                 DR           80184
Non Garland      22$               2317             HOLLOW OAKS                    DR           79487
Non Garland      22$               2317             SILVER MEADOWS                 DR           80185
Non Garland      22$               2318             HOLLOW OAKS                    DR           79488
Non Garland      22$               2318             SHERMAN                        RD           80144
Non Garland      22$               2318             SILVER MEADOWS                 DR           80186
Non Garland      22$               2321             HOLLOW OAKS                    DR           79489
Non Garland      22$               2321             SILVER MEADOWS                 DR           80187
Non Garland      22$               2322             HOLLOW OAKS                    DR           79490
Non Garland      22$               2322             SHERMAN                        RD           80145
Non Garland      22$               2322             SILVER MEADOWS                 DR           80188
Non Garland      22$               2325             HOLLOW OAKS                    DR           79491
Non Garland      22$               2325             SILVER MEADOWS                 DR           80189
Non Garland      22$               2326             HOLLOW OAKS                    DR           79492
Non Garland      22$               2326             SHERMAN                        RD           80146
Non Garland      22$               2326             SILVER MEADOWS                 DR           80190
Non Garland      22$               2330             SHERMAN                        RD           80147
Non Garland      22$               2334             SHERMAN                        RD           80148
Non Garland      22$               2338             SHERMAN                        RD           80149
Non Garland      22$               2342             SHERMAN                        RD           80150
Non Garland      22$               2346             SHERMAN                        RD           80151
Non Garland      22$               2350             SHERMAN                        RD           80152
Non Garland      22$               2401             HOLLOW OAKS                    DR           79493
Non Garland      22$               2401             HOLLY GLEN                     CIR          79558
Non Garland      22$               2401             SILVER MEADOWS                 DR           80191
Non Garland      22$               2402             HOLLOW OAKS                    DR           79494
Non Garland      22$               2402             HOLLY GLEN                     CIR          79559
Non Garland      22$               2402             SILVER MEADOWS                 DR           80192
Non Garland      22$               2405             HOLLOW OAKS                    DR           79495
Non Garland      22$               2405             HOLLY GLEN                     CIR          79560
Non Garland      22$               2405             SILVER MEADOWS                 DR           80193
Non Garland      22$               2406             HOLLOW OAKS                    DR           79496
Non Garland      22$               2406             HOLLY GLEN                     CIR          79561
Non Garland      22$               2406             SILVER MEADOWS                 DR           80194
Non Garland      22$               2409             HOLLOW OAKS                    DR           79497
Non Garland      22$               2409             HOLLY GLEN                     CIR          79562
Non Garland      22$               2409             SILVER MEADOWS                 DR           80195
Non Garland      22$               2410             HOLLOW OAKS                    DR           79498
Non Garland      22$               2410             HOLLY GLEN                     CIR          79563
Non Garland      22$               2410             SILVER MEADOWS                 DR           80196
Non Garland      22$               2413             HOLLOW OAKS                    DR           79499
Non Garland      22$               2413             HOLLY GLEN                     CIR          79564
Non Garland      22$               2413             SILVER MEADOWS                 DR           80197
Non Garland      22$               2414             HOLLOW OAKS                    DR           79500
Non Garland      22$               2414             HOLLY GLEN                     CIR          79565
Non Garland      22$               2414             SILVER MEADOWS                 DR           80198
Non Garland      22$               2417             HOLLOW OAKS                    DR           79501
Non Garland      22$               2417             HOLLY GLEN                     CIR          79566
Non Garland      22$               2417             SILVER MEADOWS                 DR           80199
Non Garland      22$               2418             HOLLOW OAKS                    DR           79502
Non Garland      22$               2418             HOLLY GLEN                     CIR          79567
Non Garland      22$               2418             SILVER MEADOWS                 DR           80200
Non Garland      22$               2421             HOLLOW OAKS                    DR           79503
Non Garland      22$               2421             HOLLY GLEN                     CIR          79568
Non Garland      22$               2421             SILVER MEADOWS                 DR           80201
Non Garland      22$               2422             HOLLOW OAKS                    DR           79504
Non Garland      22$               2422             HOLLY GLEN                     CIR          79569
Non Garland      22$               2422             SILVER MEADOWS                 DR           80202
Non Garland      22$               2425             HOLLOW OAKS                    DR           79505
Non Garland      22$               2425             HOLLY GLEN                     CIR          79571
Non Garland      22$               2426             HOLLOW OAKS                    DR           79506
Non Garland      22$               2429             HOLLOW OAKS                    DR           79507
Non Garland      22$               2429             HOLLY GLEN                     CIR          79572
Non Garland      22$               2430             HOLLOW OAKS                    DR           79508
Non Garland      22$               2433             HOLLOW OAKS                    DR           79509
Non Garland      22$               2433             HOLLY GLEN                     CIR          79573
Non Garland      22$               2434             HOLLOW OAKS                    DR           79510
Non Garland      22$               2437             HOLLOW OAKS                    DR           79511
Non Garland      22$               2438             HOLLOW OAKS                    DR           79512
Non Garland      22$               2441             HOLLOW OAKS                    DR           79513
Non Garland      22$               2442             HOLLOW OAKS                    DR           79514
Non Garland      22$               2501             WOOD PARK                      DR           87452
Non Garland      22$               2501             WOOD PARK                      DR           87973
Non Garland      22$               2502             HOLLOW OAKS                    DR           79515
Non Garland      22$               2502             WOOD PARK                      DR           86727
Non Garland      22$               2502             WOOD PARK                      DR           86845
Non Garland      22$               2505             WOOD PARK                      DR           86726
Non Garland      22$               2505             WOOD PARK                      DR           86844
Non Garland      22$               2506             HOLLOW OAKS                    DR           79516
Non Garland      22$               2506             WOOD PARK                      DR           87144
Non Garland      22$               2506             WOOD PARK                      DR           87657
Non Garland      22$               2509             WOOD PARK                      DR           87240
Non Garland      22$               2509             WOOD PARK                      DR           87972
Non Garland      22$               2510             HOLLOW OAKS                    DR           79517
Non Garland      22$               2510             WOOD PARK                      DR           87131
Non Garland      22$               2510             WOOD PARK                      DR           87489
Non Garland      22$               2513             WOOD PARK                      DR           87017
Non Garland      22$               2513             WOOD PARK                      DR           87121
Non Garland      22$               2514             WOOD PARK                      DR           86430
Non Garland      22$               2514             WOOD PARK                      DR           86516
Non Garland      22$               2518             WOOD PARK                      DR           87698
Non Garland      22$               2521             WOOD PARK                      DR           86440
Non Garland      22$               2522             WOOD PARK                      DR           87092
Non Garland      22$               2522             WOOD PARK                      DR           87476
Non Garland      22$               2601             WOOD PARK                      DR           86450
Non Garland      22$               2601             WOOD PARK                      DR           86539
Non Garland      22$               2602             WOOD PARK                      DR           86648
Non Garland      22$               2602             WOOD PARK                      DR           86784
Non Garland      22$               2605             WOOD PARK                      DR           86402
Non Garland      22$               2605             WOOD PARK                      DR           86515
Non Garland      22$               2606             WOOD PARK                      DR           87132
Non Garland      22$               2606             WOOD PARK                      DR           87490
Non Garland      22$               2609             WOOD PARK                      DR           87617
Non Garland      22$               2609             WOOD PARK                      DR           88373
Non Garland      22$               2613             WOOD PARK                      DR           86396
Non Garland      22$               2614             WOOD PARK                      DR           86569
Non Garland      22$               2614             WOOD PARK                      DR           86866
Non Garland      22$               2617             WOOD PARK                      DR           86341
Non Garland      22$               2617             WOOD PARK                      DR           86398
Non Garland      22$               2618             WOOD PARK                      DR           87041
Non Garland      22$               2618             WOOD PARK                      DR           87455
Non Garland      22$               2621             WOOD PARK                      DR           86637
Non Garland      22$               2621             WOOD PARK                      DR           86689
Non Garland      22$               2621             WOOD PARK                      DR           88390
Non Garland      22$               2622             WOOD PARK                      DR           86368
Non Garland      22$               2622             WOOD PARK                      DR           86533
Non Garland      22$               2625             WOOD PARK                      DR           86571
Non Garland      22$               2625             WOOD PARK                      DR           86688
Non Garland      22$               2626             WOOD PARK                      DR           86431
Non Garland      22$               2626             WOOD PARK                      DR           87025
Non Garland      22$               2629             WOOD PARK                      DR           88092
Non Garland      22$               2630             WOOD PARK                      DR           88027
Non Garland      22$               2630             WOOD PARK                      DR           88472
Non Garland      22$               2633             WOOD PARK                      DR           87241
Non Garland      22$               2633             WOOD PARK                      DR           88015
Non Garland      22$               2634             WOOD PARK                      DR           87280
Non Garland      22$               2637             WOOD PARK                      DR           87042
Non Garland      22$               2637             WOOD PARK                      DR           87456
Non Garland      22$               2701             WOOD PARK                      DR           86362
Non Garland      22$               2702             WOOD PARK                      DR           88035
Non Garland      22$               2702             WOOD PARK                      DR           88488
Non Garland      22$               2705             WOOD PARK                      DR           87948
Non Garland      22$               2706             WOOD PARK                      DR           86870
Non Garland      22$               2706             WOOD PARK                      DR           87316
Non Garland      22$               2709             WOOD PARK                      DR           86556
Non Garland      22$               2709             WOOD PARK                      DR           86690
Non Garland      22$               2834             WOOD PARK                      DR           86878
Non Garland      22$               3601             FOREST GREEN                   DR           79327
Non Garland      22$               3601             MUSE                           CIR          79774
Non Garland      22$               3601             TOWNPARK                       DR           80308
Non Garland      22$               3602             MUSE                           CIR          79775
Non Garland      22$               3603             FOREST GREEN                   DR           79328
Non Garland      22$               3603             TOWNPARK                       DR           80309
Non Garland      22$               3605             FOREST GREEN                   DR           79329
Non Garland      22$               3605             MUSE                           CIR          79776
Non Garland      22$               3605             TOWNPARK                       DR           80310
Non Garland      22$               3606             MUSE                           CIR          79777
Non Garland      22$               3607             FOREST GREEN                   DR           79330
Non Garland      22$               3607             TOWNPARK                       DR           80311
Non Garland      22$               3609             FOREST GREEN                   DR           79331
Non Garland      22$               3609             MUSE                           CIR          79778
Non Garland      22$               3610             MUSE                           CIR          79779
Non Garland      22$               3613             FOREST GREEN                   DR           79332
Non Garland      22$               3613             MUSE                           CIR          79780
Non Garland      22$               3613             TOWNPARK                       DR           80312
Non Garland      22$               3614             FOREST GREEN                   DR           79333
Non Garland      22$               3614             MUSE                           CIR          79781
Non Garland      22$               3614             TOWNPARK                       DR           80313
Non Garland      22$               3615             FOREST GREEN                   DR           79334
Non Garland      22$               3615             TOWNPARK                       DR           80314
Non Garland      22$               3616             FOREST GREEN                   DR           79335
Non Garland      22$               3616             TOWNPARK                       DR           80315
Non Garland      22$               3617             FOREST GREEN                   DR           79336
Non Garland      22$               3617             MUSE                           CIR          79782
Non Garland      22$               3617             TOWNPARK                       DR           80316
Non Garland      22$               3618             FOREST GREEN                   DR           79337
Non Garland      22$               3618             MUSE                           CIR          79783
Non Garland      22$               3618             TOWNPARK                       PL           80317
Non Garland      22$               3619             FOREST GREEN                   DR           79338
Non Garland      22$               3619             TOWNPARK                       PL           80318
Non Garland      22$               3620             FOREST GREEN                   DR           79339
Non Garland      22$               3620             TOWNPARK                       PL           80319
Non Garland      22$               3621             FOREST GREEN                   DR           79340
Non Garland      22$               3621             MUSE                           CIR          79784
Non Garland      22$               3621             TOWNPARK                       PL           80320
Non Garland      22$               3622             FOREST GREEN                   DR           79341
Non Garland      22$               3622             MUSE                           CIR          79785
Non Garland      22$               3622             TOWNPARK                       PL           80321
Non Garland      22$               3624             FOREST GREEN                   DR           79342
Non Garland      22$               3624             TOWNPARK                       PL           80322
Non Garland      22$               3625             MUSE                           CIR          79786
Non Garland      22$               3626             MUSE                           CIR          79787
Non Garland      22$               3628             TOWNPARK                       PL           80323
Non Garland      22$               3629             MUSE                           CIR          79788
Non Garland      22$               3630             FOREST GREEN                   DR           79343
Non Garland      22$               3630             MUSE                           CIR          79789
Non Garland      22$               3630             TOWNPARK                       PL           80324
Non Garland      22$               3632             FOREST GREEN                   DR           79344
Non Garland      22$               3632             TOWNPARK                       PL           80325
Non Garland      22$               3633             MUSE                           CIR          79790
Non Garland      22$               3634             FOREST GREEN                   DR           79345
Non Garland      22$               3634             MUSE                           CIR          79791
Non Garland      22$               3637             MUSE                           CIR          79792
Non Garland      22$               3638             MUSE                           CIR          79793
Non Garland      22$               3641             MUSE                           CIR          79794
Non Garland      22$               3642             MUSE                           CIR          79795
Non Garland      22$               3645             MUSE                           CIR          79796
Non Garland      22$               3649             MUSE                           CIR          79797
Non Garland      22$               3653             MUSE                           CIR          79798
Non Garland      22$               3701             GREENDALE                      WAY          79419
Non Garland      22$               3702             GREENDALE                      WAY          79420
Non Garland      22$               3702             HIGHLAND                       WAY          79456
Non Garland      22$               3702             TERRACE                        PL           80273
Non Garland      22$               3703             GREENDALE                      WAY          79421
Non Garland      22$               3704             GREENDALE                      WAY          79422
Non Garland      22$               3704             HIGHLAND                       WAY          79457
Non Garland      22$               3704             TERRACE                        PL           80274
Non Garland      22$               3705             GREENDALE                      WAY          79423
Non Garland      22$               3706             GREENDALE                      WAY          79424
Non Garland      22$               3706             HIGHLAND                       WAY          79458
Non Garland      22$               3706             TERRACE                        PL           80275
Non Garland      22$               3707             GREENDALE                      WAY          79425
Non Garland      22$               3708             GREENDALE                      WAY          79426
Non Garland      22$               3709             GREENDALE                      WAY          79427
Non Garland      22$               3710             GREENDALE                      WAY          79428
Non Garland      22$               3710             HIGHLAND                       WAY          79459
Non Garland      22$               3710             TERRACE                        PL           80276
Non Garland      22$               3711             GREENDALE                      WAY          79429
Non Garland      22$               3712             GREENDALE                      WAY          79430
Non Garland      22$               3712             HIGHLAND                       WAY          79460
Non Garland      22$               3712             TERRACE                        PL           80277
Non Garland      22$               3714             HIGHLAND                       WAY          79461
Non Garland      22$               3714             TERRACE                        PL           80278
Non Garland      22$               3715             GREENDALE                      WAY          79431
Non Garland      22$               3715             TERRACE                        PL           80279
Non Garland      22$               3716             HIGHLAND                       WAY          79462
Non Garland      22$               3717             GREENDALE                      WAY          79432
Non Garland      22$               3717             HIGHLAND                       WAY          79463
Non Garland      22$               3717             TERRACE                        PL           80280
Non Garland      22$               3718             TERRACE                        PL           80281
Non Garland      22$               3719             GREENDALE                      WAY          79433
Non Garland      22$               3719             HIGHLAND                       WAY          79464
Non Garland      22$               3719             TERRACE                        PL           80282
Non Garland      22$               3720             HIGHLAND                       WAY          79465
Non Garland      22$               3720             TERRACE                        PL           80283
Non Garland      22$               3721             GREENDALE                      WAY          79434
Non Garland      22$               3721             HIGHLAND                       WAY          79466
Non Garland      22$               3721             TERRACE                        PL           80284
Non Garland      22$               3722             HIGHLAND                       WAY          79467
Non Garland      22$               3722             TERRACE                        PL           80285
Non Garland      22$               3723             HIGHLAND                       WAY          79468
Non Garland      22$               3723             TERRACE                        PL           80286
Non Garland      22$               3724             HIGHLAND                       WAY          79469
Non Garland      22$               3724             TERRACE                        PL           80287
Non Garland      22$               3725             HIGHLAND                       WAY          79470
Non Garland      22$               3725             TERRACE                        PL           80288
Non Garland      22$               3726             HIGHLAND                       WAY          79471
Non Garland      22$               3726             TERRACE                        PL           80289
Non Garland      22$               3727             HIGHLAND                       WAY          79472
Non Garland      22$               3731             TERRACE                        PL           80290
Non Garland      22$               3733             HIGHLAND                       WAY          79473
Non Garland      22$               3733             TERRACE                        PL           80291
Non Garland      22$               3735             HIGHLAND                       WAY          79474
Non Garland      22$               3735             TERRACE                        PL           80292
Non Garland      22$               3737             HIGHLAND                       WAY          79475
Non Garland      22$               3737             TERRACE                        PL           80293
Non Garland      22$               3739             HIGHLAND                       WAY          79476
Non Garland      22$               3739             TERRACE                        PL           80294
Non Garland      22$               5902             SHADYWOOD                      LN           84415
Non Garland      22$               5902             SHADYWOOD                      LN           84799
Non Garland      22$               5910             SHADYWOOD                      LN           86258
Non Garland      22$               5910             SHADYWOOD                      LN           86298
Non Garland      22$               601              TUDOR                          CT           80335
Non Garland      22$               601              VERNON                         CT           80370
Non Garland      22$               6014             SHADYWOOD                      LN           87147
Non Garland      22$               6014             SHADYWOOD                      LN           87591
Non Garland      22$               602              VERSAILLES                     CT           80387
Non Garland      22$               603              TUDOR                          CT           80336
Non Garland      22$               603              VERNON                         CT           80371
Non Garland      22$               604              VERSAILLES                     CT           80388
Non Garland      22$               605              TUDOR                          CT           80337
Non Garland      22$               605              VERNON                         CT           80372
Non Garland      22$               606              VERSAILLES                     CT           80389
Non Garland      22$               607              TUDOR                          CT           80338
Non Garland      22$               607              VERNON                         CT           80373
Non Garland      22$               608              VERSAILLES                     CT           80390
Non Garland      22$               609              TUDOR                          CT           80339
Non Garland      22$               609              VERNON                         CT           80374
Non Garland      22$               610              VERSAILLES                     CT           80391
Non Garland      22$               6106             SHADYWOOD                      LN           87213
Non Garland      22$               6106             SHADYWOOD                      LN           87516
Non Garland      22$               611              TUDOR                          CT           80340
Non Garland      22$               611              VERNON                         CT           80375
Non Garland      22$               6110             SHADYWOOD                      LN           86729
Non Garland      22$               6110             SHADYWOOD                      LN           86762
Non Garland      22$               6114             SHADYWOOD                      LN           86630
Non Garland      22$               6114             SHADYWOOD                      LN           86891
Non Garland      22$               612              VERSAILLES                     CT           80392
Non Garland      22$               613              TUDOR                          CT           80341
Non Garland      22$               613              VERNON                         CT           80376
Non Garland      22$               614              VERSAILLES                     CT           80393
Non Garland      22$               615              TUDOR                          CT           80342
Non Garland      22$               615              VERNON                         CT           80377
Non Garland      22$               616              VERSAILLES                     CT           80394
Non Garland      22$               617              TUDOR                          CT           80343
Non Garland      22$               617              VERNON                         CT           80378
Non Garland      22$               618              VERSAILLES                     CT           80395
Non Garland      22$               619              TUDOR                          CT           80344
Non Garland      22$               619              VERNON                         CT           80379
Non Garland      22$               6198             SHADYWOOD                      LN           87587
Non Garland      22$               620              VERSAILLES                     CT           80396
Non Garland      22$               6200             DEXHAM                         RD           55212
Non Garland      22$               621              TUDOR                          CT           80345
Non Garland      22$               621              VERNON                         CT           80380
Non Garland      22$               622              VERSAILLES                     CT           80397
Non Garland      22$               623              TUDOR                          CT           80346
Non Garland      22$               623              VERNON                         CT           80381
Non Garland      22$               624              VERSAILLES                     CT           80398
Non Garland      22$               625              TUDOR                          CT           80347
Non Garland      22$               625              VERNON                         CT           80382
Non Garland      22$               626              VERSAILLES                     CT           80399
Non Garland      22$               627              VERNON                         CT           80383
Non Garland      22$               628              VERSAILLES                     CT           80400
Non Garland      22$               629              TUDOR                          CT           80348
Non Garland      22$               629              VERNON                         CT           80384
Non Garland      22$               630              VERSAILLES                     CT           80401
Non Garland      22$               631              TUDOR                          CT           80349
Non Garland      22$               631              VERNON                         CT           80385
Non Garland      22$               632              VERSAILLES                     CT           80402
Non Garland      22$               633              TUDOR                          CT           80350
Non Garland      22$               633              VERNON                         CT           80386
Non Garland      22$               634              VERSAILLES                     CT           80403
Non Garland      22$               635              TUDOR                          CT           80351
Non Garland      22$               636              VERSAILLES                     CT           80404
Non Garland      22$               637              TUDOR                          CT           80352
Non Garland      22$               638              VERSAILLES                     CT           80405
Non Garland      22$               639              TUDOR                          CT           80353
Non Garland      22$               640              VERSAILLES                     CT           80406
Non Garland      22$               641              TUDOR                          CT           80354
Non Garland      22$               642              VERSAILLES                     CT           80407
Non Garland      22$               643              TUDOR                          CT           80355
Non Garland      22$               644              VERSAILLES                     CT           80408
Non Garland      22$               645              TUDOR                          CT           80356
Non Garland      22$               647              TUDOR                          CT           80357
Non Garland      22$               649              TUDOR                          CT           80358
Non Garland      22$               651              TUDOR                          CT           80359
Non Garland      22$               653              TUDOR                          CT           80360
Non Garland      22$               701              LOUVRE                         CT           79680
Non Garland      22$               702              ALHAMBRA                       CT           78963
Non Garland      22$               703              LOUVRE                         CT           79681
Non Garland      22$               704              ALHAMBRA                       CT           78964
Non Garland      22$               705              LOUVRE                         CT           79682
Non Garland      22$               706              ALHAMBRA                       CT           78965
Non Garland      22$               707              LOUVRE                         CT           79683
Non Garland      22$               708              ALHAMBRA                       CT           78966
Non Garland      22$               709              LOUVRE                         CT           79684
Non Garland      22$               710              ALHAMBRA                       CT           78967
Non Garland      22$               711              LOUVRE                         CT           79685
Non Garland      22$               712              ALHAMBRA                       CT           78968
Non Garland      22$               713              LOUVRE                         CT           79686
Non Garland      22$               714              ALHAMBRA                       CT           78969
Non Garland      22$               715              LOUVRE                         CT           79687
Non Garland      22$               716              ALHAMBRA                       CT           78970
Non Garland      22$               717              LOUVRE                         CT           79688
Non Garland      22$               718              ALHAMBRA                       CT           78971
Non Garland      22$               719              LOUVRE                         CT           79689
Non Garland      22$               720              ALHAMBRA                       CT           78972
Non Garland      22$               721              LOUVRE                         CT           79690
Non Garland      22$               722              ALHAMBRA                       CT           78973
Non Garland      22$               723              LOUVRE                         CT           79691
Non Garland      22$               724              ALHAMBRA                       CT           78974
Non Garland      22$               725              LOUVRE                         CT           79692
Non Garland      22$               726              ALHAMBRA                       CT           78975
Non Garland      22$               727              LOUVRE                         CT           79693
Non Garland      22$               728              ALHAMBRA                       CT           78976
Non Garland      22$               729              LOUVRE                         CT           79694
Non Garland      22$               730              ALHAMBRA                       CT           78977
Non Garland      22$               731              LOUVRE                         CT           79695
Non Garland      22$               732              ALHAMBRA                       CT           78978
Non Garland      22$               733              LOUVRE                         CT           79696
Non Garland      22$               735              LOUVRE                         CT           79697
Non Garland      22$               736              ALHAMBRA                       CT           78979
Non Garland      22$               737              LOUVRE                         CT           79698
Non Garland      22$               738              ALHAMBRA                       CT           78980
Non Garland      22$               739              LOUVRE                         CT           79699
Non Garland      22$               740              ALHAMBRA                       CT           78981
Non Garland      22$               741              LOUVRE                         CT           79700
Non Garland      22$               742              ALHAMBRA                       CT           78982
Non Garland      22$               743              LOUVRE                         CT           79701
Non Garland      22$               744              ALHAMBRA                       CT           78983
Non Garland      22$               745              LOUVRE                         CT           79702
Non Garland      22$               746              ALHAMBRA                       CT           78984
Non Garland      22$               747              LOUVRE                         CT           79703
Non Garland      22$               749              LOUVRE                         CT           79704
Non Garland      22$               750              ALHAMBRA                       CT           78985
Non Garland      22$               751              LOUVRE                         CT           79705
Non Garland      22$               752              ALHAMBRA                       CT           78986
Non Garland      22$               753              LOUVRE                         CT           79706
Non Garland      22$               754              ALHAMBRA                       CT           78987
Non Garland      22$               756              ALHAMBRA                       CT           78988
Non Garland      22$               758              ALHAMBRA                       CT           78989
Non Garland      22$               760              ALHAMBRA                       CT           78990
Non Garland      22$               762              ALHAMBRA                       CT           78991
Non Garland      22$               764              ALHAMBRA                       CT           78992
Non Garland      22$               768              ALHAMBRA                       CT           78993
Non Garland      22$               770              ALHAMBRA                       CT           78994
Non Garland      22$               772              ALHAMBRA                       CT           78995
Non Garland      22$               774              ALHAMBRA                       CT           78996
Non Garland      22$               776              ALHAMBRA                       CT           78997
Non Garland      22$               778              ALHAMBRA                       CT           78998
Non Garland      22$               780              ALHAMBRA                       CT           78999
Non Garland      22$               801              MOULIN                         CT           79737
Non Garland      22$               802              ALCAZAR                        CT           78943
Non Garland      22$               802              WINETTE                        CT           80588
Non Garland      22$               803              MOULIN                         CT           79738
Non Garland      22$               804              ALCAZAR                        CT           78944
Non Garland      22$               804              WINETTE                        CT           80589
Non Garland      22$               805              MOULIN                         CT           79739
Non Garland      22$               806              ALCAZAR                        CT           78945
Non Garland      22$               806              WINETTE                        CT           80590
Non Garland      22$               807              MOULIN                         CT           79740
Non Garland      22$               808              ALCAZAR                        CT           78946
Non Garland      22$               808              WINETTE                        CT           80591
Non Garland      22$               810              ALCAZAR                        CT           78947
Non Garland      22$               810              WINETTE                        CT           80592
Non Garland      22$               811              MOULIN                         CT           79741
Non Garland      22$               812              ALCAZAR                        CT           78948
Non Garland      22$               812              WINETTE                        CT           80593
Non Garland      22$               813              MOULIN                         CT           79742
Non Garland      22$               814              ALCAZAR                        CT           78949
Non Garland      22$               815              MOULIN                         CT           79743
Non Garland      22$               816              ALCAZAR                        CT           78950
Non Garland      22$               817              MOULIN                         CT           79744
Non Garland      22$               818              ALCAZAR                        CT           78951
Non Garland      22$               819              MOULIN                         CT           79745
Non Garland      22$               820              ALCAZAR                        CT           78952
Non Garland      22$               822              ALCAZAR                        CT           78953
Non Garland      22$               824              ALCAZAR                        CT           78954
Non Garland      22$               826              ALCAZAR                        CT           78955
Non Garland      22$               828              ALCAZAR                        CT           78956
Non Garland      22$               830              ALCAZAR                        CT           78957
Non Garland      22$               832              ALCAZAR                        CT           78958
Non Garland      22$               833              MOULIN                         CT           79746
Non Garland      22$               834              ALCAZAR                        CT           78959
Non Garland      22$               835              MOULIN                         CT           79747
Non Garland      22$               836              ALCAZAR                        CT           78960
Non Garland      22$               837              MOULIN                         CT           79748
Non Garland      22$               838              ALCAZAR                        CT           78961
Non Garland      22$               839              MOULIN                         CT           79749
Non Garland      22$               840              ALCAZAR                        CT           78962
Non Garland      22$               841              MOULIN                         CT           79750
Non Garland      22$               843              MOULIN                         CT           79751
Non Garland      22$               845              MOULIN                         CT           79752
Non Garland      22$               9939             ADLETA                         BLVD         78932
Non Garland      22$                                ADLETA                         BLVD         80662
Non Garland      22$                                FREEDOM PARK                                2976
Non Garland      22$                                LOTTIE WATSON                               5253

808 rows selected.


--	=================================================================================

	select count(*) "TOTAL"
	from	garland.adrResult
	where	verify_code = 01;

     TOTAL
----------
       808

1 row selected.



	spool off;
