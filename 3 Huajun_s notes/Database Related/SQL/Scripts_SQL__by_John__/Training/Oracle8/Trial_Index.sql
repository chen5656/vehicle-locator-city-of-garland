
--	==================================================================================
GIS ORACLE 8 - EXPERIMENTS

	BIT MAP INDEXED	TABLE		nsa_dcad_res	subdiv_id
	REVERSE INDEXED 	TABLE		us_states		name
	INDEX ORGANIZED 	TABLE		adrgap		address
	PARTITIONED 	TABLE		nsa_dcad_resid	subdiv_id
	clusters

	HISTOGRAM		COLUMN	adrname		addr_name	(60)

--	==================================================================================
--	==================================================================================

HISTOGRAM
---------

	analyze table	trvehrcl	compute statistics for columns addr_name size 60;
	analyze table	trvehrcl	compute statistics;			--	removes histogram

	select	substr(addr_name,1,1),						--	display name distribution
			count(*)
	from		trvehrcl
	group by	substr(addr_name,1,1);


	explain plan	set statement_id = 'test1'	for
	select * from trvehrcl	where addr_name = 'COLONY';			--	uses index

	explain plan	set statement_id = 'test2'	for
	select * from trvehrcl	where addr_name = 'ZION';			--	uses index

	select count(*) "TRVEHRCL" from trvehrcl;					--	7091

	select table_name, column_name, num_distinct, num_buckets, num_nulls, density
 	from user_tab_col_statistics	where table_name = 'TRVEHRCL';

TABLE_NAME                     COLUMN_NAME                    NUM_DISTIN NUM_BUCKET NUM_NULLS  DENSITY   
------------------------------ ------------------------------ ---------- ---------- ---------- ----------
TRVEHRCL                       MSLINK                               7091          1          0 .000141024
TRVEHRCL                       MAPID                                   2          1          0         .5
TRVEHRCL                       CLINE_ID                                0          1       7091 .000141024
TRVEHRCL                       BRANCH_NO                             707          1        416 .001414427
TRVEHRCL                       SECTION_NO                             13          1        416 .076923077
TRVEHRCL                       NUM_LANES                               0          1       7091 .000141024
TRVEHRCL                       FR_COORD                             6537          1        554 .000152975
TRVEHRCL                       TO_COORD                             6537          1        554 .000152975
TRVEHRCL                       CLINE_LENGTH                         6641          1        450  .00015058
TRVEHRCL                       ST_NAME                               909          1         70  .00110011
TRVEHRCL                       COUNCIL_DISTRICT                       12          1        623 .083333333
TRVEHRCL                       BOND_PROJ                               0          1       7091 .000141024
TRVEHRCL                       ADDR_NUM                              521          1        485 .001919386
TRVEHRCL                       ADDR_PFX                                5          1        104         .2
TRVEHRCL                       ADDR_NAME                            1966         60         37 .001916049
TRVEHRCL                       ADDR_TYPE                              16          1          0      .0625
TRVEHRCL                       ADDR_SFX                                4          1        104        .25
TRVEHRCL                       ADDR_LEFT_FROM                        222          1          0 .004504505
TRVEHRCL                       ADDR_LEFT_TO                         1092          1          0 .000915751
TRVEHRCL                       ADDR_RGHT_FROM                        218          1          0 .004587156
TRVEHRCL                       ADDR_RGHT_TO                          882          1          0 .001133787
TRVEHRCL                       PILOT                                   1          1       6400          1
TRVEHRCL                       SOURCE                                  2          1       6469         .5
TRVEHRCL                       NOTCARRIED                              0          1       7091 .000141024
TRVEHRCL                       ADDR_LO                               143          1          0 .006993007
TRVEHRCL                       ADDR_HI                               882          1          0 .001133787


--	==================================================================================
--	==================================================================================

BITMAP INDEX
------------

	select count(*) from nsa_dcad_res;						--	59558
	select count( distinct subdiv_id)	from nsa_dcad_res;		--	721

	drop index	nsa_dcad_res_bx_subdiv;		
	create bitmap index	nsa_dcad_res_bx_subdiv		
			on		nsa_dcad_res    (subdiv_id)
		tablespace		gisindx
		storage		( initial 160k  next 32k   pctincrease 0 ); 


	select rpad (segment_name,30) "BITMAP", bytes, extents from user_seegments 
	where segment_name = 'NSA_DCAD_RES_BIT_SUBDIV';

	BITMAP                         BYTES      EXTENTS   
	------------------------------ ---------- ----------
	NSA_DCAD_RES_BIT_SUBDIV            163840          4
	
	v$parameter 272 = optimizer mode = choose	

	select * from nsa_dcad_res		--	full scan except for goal = first_rows
	where	subdiv_id = 1234;

	select 
--+	index_combine ( nsa_dcad_res )
	all * 
	from nsa_dcad_res
	where	subdiv_id = 1234;

__SELECT_STATE____________test_____________________________________________158
01_TABLE_ACCESS___________BY_INDEX_ROWID___NSA_DCAD_RES_________________ANALYZED
____BITMAP_CONVE__________TO_ROWIDS_____________________________________________
_____BITMAP_INDEX_________FULL_SCAN________NSA_DCAD_RES_BIT_SUBDIV______________


--	==================================================================================
--	==================================================================================

REVERSE KEY INDEX
-----------------

	desc us_states;
	Column Name                    Null?    Type
	------------------------------ -------- ----
	ABBRV                                   VARCHAR2(2)
	NAME                                    VARCHAR2(20)

	create index us_states_rx_name
		 on	 us_states (name) 	reverse
		tablespace	gisindx
		storage 	(initial 32k  next 32k pctincrease 0);

	select * from us_states	where	name = 'TEXAS';	--	full scan except for goal = first_rows

	select 
--+	index ( us_states  us_states_rx_name )
	all * 
	from  us_states
	where	name = 'TEXAS';

__SELECT_STATE____________test________________________________________________
01_TABLE_ACCESS___________BY_INDEX_ROWID___US_STATES____________________ANALYZED
____INDEX_________________RANGE_SCAN_______US_STATES_RX_NAME__________NON-UNIQUE


--	==================================================================================
--	==================================================================================

INDEX ORGANIZED TABLE
---------------------

	drop table		adrgap;
	create table	adrgap
	(
		addr_num			number(06),
		addr_pfx			varchar2(02),
		addr_name			varchar2(20),
		addr_type			varchar2(04),
		addr_sfx			varchar2(02),

		primary key	( addr_name, addr_type, addr_pfx, addr_sfx, addr_num )
	)
		organization  index
		tablespace	gis_data
		storage	( initial 104K  next 32K  pctincrease 0 );

	select table_name, tablespace_name, initial_extent, next_extent,iot_type, buffer_pool  
 	from tabs where table_name = 'ADRGAP';
	TABLE_NAME                     TABLESPACE_NAME                INITIAL_EX NEXT_EXTEN IOT_TYPE     BUFFER_
	------------------------------ ------------------------------ ---------- ---------- ------------ -------
	ADRGAP                                                                              IOT                 

	select table_name, index_name, index_type, generated, tablespace_name
	from ind where table_name = 'ADRGAP';
	TABLE_NAME                     INDEX_NAME                     INDEX_TYPE   G TABLESPACE_NAME               
	------------------------------ ------------------------------ ------------ - ------------------------------
	ADRGAP                         SYS_IOT_TOP_2578               IOT - TOP    Y GIS_DATA                      

	select table_name, initial_extent, next_extent 
 	from ind where table_name = 'ADRGAP';
	TABLE_NAME                     INITIAL_EX NEXT_EXTEN
	------------------------------ ---------- ----------
	ADRGAP                             106496      32768


	select * from adrgap;
	__SELECT_STATE____________test________________________________________________
	___INDEX__________________FULL_SCAN________SYS_IOT_TOP_2578___________UNIQUE____


--	==================================================================================
--	==================================================================================

PARTITIONED TABLES
------------------

	ORA-00439: feature not enabled: Partitioning

	v$parameter 278 = partition view enabled = false

	create table		nsa_dcad_resid
	tablespace gis_date, storage (initial 1m next 1m pctincrease 0 ),
	partition by range	(subdiv_id)
	(
	partition	nsa_dcad_resid0	values less than (10000), 
	partition	nsa_dcad_resid1	values less than (20000),
	partition	nsa_dcad_resid2	values less than (30000),
	partition	nsa_dcad_resid3	values less than (40000),
	partition	nsa_dcad_resid4	values less than (50000),
	partition	nsa_dcad_resid5	values less than (60000),
	partition	nsa_dcad_resid6	values less than (70000)
	)
	as	select * from nsa_dcad_res;


--	==================================================================================
--	==================================================================================

	truncate table	plan_table;
	explain plan	set statement_id = 'test'	for

	@c:\deacutis\scripts\plans\exhibit.sql;

--	==================================================================================


