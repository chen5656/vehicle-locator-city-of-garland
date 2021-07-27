/*

	select '	' || column_name, rtrim(data_type) ||'('|| data_length ||'),'
	from	all_tab_columns
	where	table_name = 'CODEADDR'
	order by column_id;

	select count(*) from codeaddr;		--	96870

*/

--	=============================================================

	drop table		nsa_codeaddr;

	create table	nsa_codeaddr

	(
	ADDR_NUM			NUMBER(06),    
	ADDR_PFX			VARCHAR2(02),   
	ADDR_NAME			VARCHAR2(40),  
	ADDR_TYPE			VARCHAR2(04),   
	ADDR_SFX			VARCHAR2(02),   
	ADDR_CODE			VARCHAR2(10),   
	ADDR_UNIT			VARCHAR2(10),   

	VERIFY_CODE			NUMBER(02),
	PARCEL_ID			VARCHAR2(11),
	SEGMENT_ID			NUMBER(05),
	COUNCIL_DISTRICT     	VARCHAR2(01),   
	SUBDIV_ID			VARCHAR2(05),
	INSPECT_AREA		VARCHAR2(02),
	ADDR_ID            	VARCHAR2(374) 
	)

	tablespace		gis_data
	storage		(initial 2m  next 320k  pctincrease 0);

--	===============================================================
/*

	create unique index 	nsa_codeaddr_addr_id
			on		nsa_codeaddr(addr_id)
	tablespace		gis_data
	storage		(initial 2m  next 320k  pctincrease 0);

*/
--	===============================================================
