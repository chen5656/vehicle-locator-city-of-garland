
	set echo		off;
	set fetchrows;

	set fetchrows;

--	==============================================================

--	analyze table	nsa_codeaddr_1st		compute statistics;

--	truncate table	plan_table;
--	explain plan	set statement_id = 'aa'	for
	
	select
--	use_merge 	(a b)
			 lpad(a.addr_num,6)
			,a.addr_pfx
			,a.addr_name
			,a.addr_type
			,a.addr_sfx
			,a.addr_code
			,a.addr_unit
			,chr(10)
			,lpad(b.addr_num,5)
			,b.addr_pfx
			,b.addr_name
			,b.addr_type
			,b.addr_sfx
			,b.addr_code
			,b.addr_unit

	from		nsa_codeaddr_1st		a,
			jdeacutis.nsa_codeaddr	b

	where		a.addr_id = b.addr_id
	and		b.verify_code is not null

	order by	a.addr_name, a.addr_num;

--	select * from explain_plan;

--	==============================================================
--	truncate table	plan_table;
--	explain plan	set statement_id = 'aaa'	for

	select * 
	from jdeacutis.nsa_codeaddr
	where	addr_id in
(
	select rec_key
	from adrResult_codeaddr

	where	verify_code = 55
	and (	addr_code > ' '
	or	addr_unit > ' '	)
);

--	select * from explain_plan;

--	==============================================================

	select count(*)				--	5857
	from	jdeacutis.nsa_codeaddr;


	select count(*)				--	1028
	from	adrResult			r,
		jdeacutis.nsa_codeaddr	c
	where	r.rec_key = c.addr_id
	and	r.verify_code = 45;


	select count(*)				--	1028
	from	adrResult			r,
		jdeacutis.nsa_codeaddr	c
	where	r.rec_key = c.addr_id
	and	r.verify_code = 45
	and	nvl(c.council_district,' ') < '1' ;


	select count(*)				--	616
	from	adrResult			r,
		jdeacutis.nsa_codeaddr	c
	where	r.rec_key = c.addr_id
	and	r.verify_code = 45
	and	nvl(c.council_district,' ') < '1' 
	and 	(nvl(c.addr_code,' ') > ' '	or nvl(c.addr_unit,' ') > ' ')
	;

--	==============================================================

	select count(*)			--	709
	from	adrResult
	where verify_code  = 45
	and	segment_id > 0
	and	segment_id in
(
	select r.segment_id
	from  adrResult		r,
		trvehrcl_region	t
	where	r.segment_id = t.segment_id
	and	r.verify_code = 45
	and	t.council_id  > '0'

	minus

	select segment_id
	from	trvehrcl_region
	group by segment_id
	having count(distinct council_id) > 1
);

--	======================================================================================
--	display adrresult_codeaddr with multiple council ids within segment id

	select count(*)
	from adrresult_codeaddr
	where segment_id in
(
	select segment_id
	from adrresult_codeaddr
	where	verify_code = 45

	intersect

	select tr.segment_id
--		 ,tr.COUNCIL_ID
	from   trvehrcl_region	TR,
(
	select segment_id, 
		count(*) " "
	from	trvehrcl_region
	where	nvl(COUNCIL_ID, ' ') > ' '	
	group by 	segment_id
	having	count(distinct COUNCIL_ID) > 1
)	
	VW
	where	TR.segment_id = VW.segment_id
);

--	======================================================================================
--	may delete all records with rec_seq >= 12225
--	they are all duplicates of rec_seq <= 215


--	find largest rec seq < 12000 with duplicated rec key

	select max(rec_seq)			--	215
	from	adrresult_codeaddr
	where	rec_seq < 12000
	and rec_key in
(
	select rec_key
	from	adrresult_codeaddr
	group by rec_key
	having count(*) > 1
);

--	find lowest rec_seq > 12000 with duplicated rec key

	select min(rec_seq)			--	12225
	from	adrresult_codeaddr
	where	rec_seq > 12000
	and rec_key in
(
	select rec_key
	from	adrresult_codeaddr
	group by rec_key
	having count(*) > 1
);


--	find all duplicated rec keys with rec seq between 216 and 12000

	select rec_seq				--	none
	from	adrresult_codeaddr
	where	rec_seq between 216 and 12000
	and rec_key in
(
	select rec_key
	from	adrresult_codeaddr
	group by rec_key
	having count(*) > 1
);


--	look for all rec_seq >= 12225 whose keys are not duplicated

	select rec_seq				--	none
	from adrresult_codeaddr	
	where rec_seq >= 12225
	minus
	select rec_seq
	from adrresult_codeaddr
	where rec_key in
(
	select rec_key
	from	adrresult_codeaddr
	group by rec_key
	having count(*) > 1
);

--	======================================================================================
--	display CodeAddr table columns

	select column_name, data_type, data_length
	from	 all_tab_columns@cdep.world
	where	 table_name = 'CODEADDR'
	order by	column_id;

--	======================================================================================
--	display CodeAddr index columns

	select distinct table_name, index_name, column_position, rpad(column_name,25) " "
	from	all_ind_columns@cdep.world
	where table_name = 'CODEADDR';

--	======================================================================================
--	display CodeAddr table characteristics

	select * 
	from	dba_segments@cdep.world
	where	segment_name = 'NSA_CODEADDR';


--	======================================================================================
--	display CodeAddr sample

--	select	count(*)
--	/*
	select
			address_number,
			address_prefix,
			address_name,
			address_type,
			address_suffix,
			address_sullp_type,
			address_suppl#,
			council_district
--	*/			
	from	codeaddr@cdep.world

	where	rownum < 111

--	and	address_suffix > '0'
	and	address_suppl# > '0'
--	and	address_sullp_type > '0'
	;

--	======================================================================================
	truncate table	plan_table;

	explain plan	set statement_id = 'aaa'	for
		select	council_id
		from		trvehrcl_region
		where		segment_id = 1111;

	explain plan	set statement_id = 'bbb'	for
		select p.council_id
		from  cdrelpar				p,
	(
		select t.parcel_id, t.cog_acct
		from	tax_abstract			t
		where	rpad (ltrim ('addr name', 'COG '), 15, '0') = t.cog_acct
	)	VW
	
		where	p.council_id > '0'
		and	p.parcel_id = vw.parcel_id;


	explain plan	set statement_id = 'ccc'		for
		update jdeacutis.NSA_CODEADDR
		set 	addr_name	= 'test'
		where	rowid = '1111';

	select * from explain_plan;
--	=================================================================================

	set echo on;

--	======================================================================================

when forbid = if part range
VERIFY CODE                         total
------------------------------ ----------
-1: invalid format                   1109
00: invalid name                      166
01: accept  initial                    22
14: partial name                      147
15: full    name                      349
24: partial orphan                     29
25: full    orphan                    282
33: wrong   block                       4
34: partial block                      32
35: unique  block                      37
42: mixed   range                       1
43: wrong   range                      39
44: partial range                      86
45: full    range                    1028
51: poor    address                     2
53: wrong   address                    40
54: partial address                    53
55: full    address                  8798

when forbid = if part range
ALTERED                             total
------------------------------ ----------
                                    11107
1ap;                                   76
1at                                    16
1at;                                  275
1at;2ap;                                4
1ct;                                  288
1rp;                                   97
1rt;                                   43
1rt;1at                                 4
1rt;2at;                               11
2ap                                     5
2ap;                                  138
2ap;2at;                                1
2at;                                   48
3ap;                                   42
3ap;3as;                                1
3as;                                    3
3at;                                    4
3cp;                                    5
3ct;                                   52
3rp;                                    4

when forbid = never
VERIFY CODE                         total
------------------------------ ----------
-1: invalid format                   1109
00: invalid name                      166
01: accept  initial                    22
14: partial name                      147
15: full    name                      349
24: partial orphan                     29
25: full    orphan                    282
33: wrong   block                       4
34: partial block                      32
35: unique  block                      37
42: mixed   range                       1
43: wrong   range                      39
44: partial range                      86
45: full    range                    1028
51: poor    address                     2
54: partial address                    53
55: full    address                  8838

when forbid = never
ALTERED                             total
------------------------------ ----------
                                    11071
1ap;                                   76
1at                                    16
1at;                                  275
1at;2ap;                                4
1ct;                                  288
1rp;                                   97
1rt;                                   43
1rt;1at                                 4
1rt;2at;                               11
2ap                                     5
2ap;                                  134
2ap;2at;                                1
2ap;3cp;                                2
2ap;3rp;                                1
2ap;3rp;3ct;                            1
2at;                                   48
3ap;                                   42
3ap;3as;                                1
3as;                                    3
3at;                                    4
3cp;                                   19
3ct;                                   74
3rp;                                    4

--	======================================================================================

CHANGE          number PF         name                                     type sf         
--------------- ------ ---------- ---------------------------------------- ---- ---------- 
changed prefix  212    S          3RD                                      ST              
                212    N          THIRD                ST             
changed prefix  220    S          3RD                                      ST              
                220    N          THIRD                ST             
changed prefix  104    E          AVENUE G                                                 
                104    W          AVENUE G                            
changed prefix  108    E          AVENUE G                                                 
                108    W          AVENUE G                            
changed prefix  2224   E          BUCKINGHAM                               RD              
                2224   W          BUCKINGHAM           RD             
changed prefix  118    W          CENTERVILLE                              RD              
                118    E          CENTERVILLE          RD             
changed prefix  226    W          CENTERVILLE                              RD              
                226    E          CENTERVILLE          RD             
changed prefix  1021   W          CENTERVILLE                              RD              
                1021   E          CENTERVILLE          RD             
changed prefix  1122   E          CENTERVILLE                              RD              
                1122   W          CENTERVILLE          RD             
changed prefix  1122   E          CENTERVILLE                              RD              
                1122   W          CENTERVILLE          RD             
changed prefix  1122   E          CENTERVILLE                              RD              
                1122   W          CENTERVILLE          RD             
changed prefix  1122   E          CENTERVILLE                              RD              
                1122   W          CENTERVILLE          RD             
changed prefix  1122   E          CENTERVILLE                              RD              
                1122   W          CENTERVILLE          RD             
changed prefix  1502   S          FIRST                                    ST              
                1502   N          FIRST                ST             
changed prefix  1816   N          FIRST                                    ST              
                1816   S          FIRST                ST             
changed prefix  2013   N          FIRST                                    ST              
                2013   S          FIRST                ST             
changed prefix  1325   W          I30                                      FRWY            
                1325   E          I30                  FRWY           
changed prefix  630    E          IH 30                                                    
                630    W          I30                  FRWY           
changed prefix  723    W          MILLER                                   RD              
                723    E          MILLER               RD             
changed prefix  101               PURDUE                                   DR              
                101    N          PURDUE               DR             
changed prefix  105               PURDUE                                   DR              
                105    N          PURDUE               DR             
21 rows selected.


REMOVE          number PF         name                                     type sf         
--------------- ------ ---------- ---------------------------------------- ---- ---------- 
removed prefix  2706              5TH                                      ST              
                2706              FIFTH                CIR            
removed prefix  203    W          APOLLO                                   RD              
                203               APOLLO               RD             
removed prefix  204    W          APOLLO                                   RD              
                204               APOLLO               RD             
removed prefix  2941   W          APOLLO                                   RD              
                2941              APOLLO               RD             
removed prefix  106    N          BELTLINE                                 RD              
                106               BELT LINE            RD             
removed prefix  1101   N          BELTLINE                                 RD              
                1101              BELT LINE            RD             
removed prefix  701    N          BELTLINE                                 RD              
                701               BELT LINE            RD             
removed prefix  114    E          BRAZOS                                   ST              
                114               BRAZOS               ST             
removed prefix  220    E          CASCADE                                  DR              
                220               CASCADE              DR             
removed prefix  2826   E          CENTERVILLE                              RD              
                2826              CENTERVILLE          RD             
removed prefix  1504   W          DENT                                     ST              
                1504              DENT                 ST             
removed prefix  1801   S          GARLAND                                  AVE             
                1801              GARLAND              AVE            
removed prefix  117               KINGSBRIDGE                              DR              
                117               KINGSBRIDGE          DR             
removed prefix  115    E          LAKE                                     DR              
                115               LAKE                 DR             
removed prefix  128    E          LAKE                                     DR              
                128               LAKE                 DR             
removed prefix  131    E          LAKE                                     DR              
                131               LAKE                 DR             
removed prefix  132    E          LAKE                                     DR              
                132               LAKE                 DR             
removed prefix  144    E          LAKE                                     DR              
                144               LAKE                 DR             
removed prefix  148    E          LAKE                                     DR              
                148               LAKE                 DR             
removed prefix  105    S          SECOND                                   ST              
                105               SECOND               ST             
removed prefix  220    S          SECOND                                   ST              
                220               SECOND               ST             
removed prefix  601    E          WALNUT                                   CIR             
                601               WALNUT CIRCLE EAST                  
removed prefix  634    E          WALNUT                                   CIR             
                634               WALNUT CIRCLE EAST                  
removed prefix  1700   W          WAY AVE                                  AVE             
                1700              WEST WAY             AVE            
removed prefix  1705   W          WAY AVE                                  AVE             

                1705              WEST WAY             AVE            
removed prefix  1709   W          WAY AVE                                  AVE             
                1709              WEST WAY             AVE            
removed prefix  1716   W          WAY AVE                                  AVE             
                1716              WEST WAY             AVE            
removed prefix  1717   W          WAY AVE                                  AVE             
                1717              WEST WAY             AVE            
removed prefix  1737   W          WAY AVE                                  AVE             
                1737              WEST WAY             AVE            
removed prefix  1741   W          WAY AVE                                  AVE             
                1741              WEST WAY             AVE            
removed prefix  1745   W          WAY AVE                                  AVE             
                1745              WEST WAY             AVE            
removed prefix  1749   W          WAY AVE                                  AVE             
                1749              WEST WAY             AVE            
removed prefix  1753   W          WAY AVE                                  AVE             
                1753              WEST WAY             AVE            
removed prefix  1757   W          WAY AVE                                  AVE             
                1757              WEST WAY             AVE            
removed prefix  1801   W          WAY AVE                                  AVE             
                1801              WEST WAY             AVE            
removed prefix  1805   W          WAY AVE                                  AVE             
                1805              WEST WAY             AVE            
removed prefix  1809   W          WAY AVE                                  AVE             
                1809              WEST WAY             AVE            
removed prefix  1813   W          WAY AVE                                  AVE             
                1813              WEST WAY             AVE            
removed prefix  1817   W          WAY AVE                                  AVE             
                1817              WEST WAY             AVE            
removed prefix  1905   W          WAY AVE                                  AVE             
                1905              WEST WAY             AVE            
removed prefix  1909   W          WAY AVE                                  AVE             
                1909              WEST WAY             AVE            
removed prefix  1913   W          WAY AVE                                  AVE             
                1913              WEST WAY             AVE            
removed prefix  1917   W          WAY AVE                                  AVE             
                1917              WEST WAY             AVE            
removed prefix  1921   W          WAY AVE                                  AVE             
                1921              WEST WAY             AVE            
removed prefix  1925   W          WAY AVE                                  AVE             
                1925              WEST WAY             AVE            
removed prefix  2005   W          WAY AVE                                  AVE             
                2005              WEST WAY             AVE            
removed prefix  2008   W          WAY AVE                                  AVE             
                2008              WEST WAY             AVE            
removed prefix  2013   W          WAY AVE                                  AVE             
                2013              WEST WAY             AVE            
removed prefix  2100   W          WAY AVE                                  AVE             
                2100              WEST WAY             AVE            
removed prefix  2101   W          WAY AVE                                  AVE             
                2101              WEST WAY             AVE            
removed prefix  2104   W          WAY AVE                                  AVE             
                2104              WEST WAY             AVE            
removed prefix  2105   W          WAY AVE                                  AVE             
                2105              WEST WAY             AVE            
removed prefix  2108   W          WAY AVE                                  AVE             
                2108              WEST WAY             AVE            
removed prefix  2109   W          WAY AVE                                  AVE             
                2109              WEST WAY             AVE            
removed prefix  2113   W          WAY AVE                                  AVE             
                2113              WEST WAY             AVE            
removed prefix  2117   W          WAY AVE                                  AVE             
                2117              WEST WAY             AVE            
removed prefix  2121   W          WAY AVE                                  AVE             
                2121              WEST WAY             AVE            
removed prefix  2301   W          WAY AVE                                  AVE             
                2301              WEST WAY             AVE            
removed prefix  2305   W          WAY AVE                                  AVE             
                2305              WEST WAY             AVE            
removed prefix  2309   W          WAY AVE                                  AVE             
                2309              WEST WAY             AVE            
removed prefix  2401   W          WAY AVE                                  AVE             
                2401              WEST WAY             AVE            
removed prefix  2405   W          WAY AVE                                  AVE             
                2405              WEST WAY             AVE            
removed prefix  2409   W          WAY AVE                                  AVE             
                2409              WEST WAY             AVE            
63 rows selected.

--	=======================================================================================

COUNT(*)  
----------
     12224
1 row selected.
COUNT(*)  
----------
      5857
1 row selected.
Statement processed.
 
CODEADDR update		nov 13 2001  14:10
 
minimum verify	45
total gis input	9921
total reject	7
total app input	3534
total commit	3534
total rollback	0
 
updated parcel	2451
updated council	3095
updated suffix	0
 
parcel   council	2174
segment  council	921
abstract council	0

--	=======================================================================================