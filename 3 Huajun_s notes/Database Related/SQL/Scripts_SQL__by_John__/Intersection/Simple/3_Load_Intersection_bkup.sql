--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
-- set pagesize	74;
-- set pagesize	57;
-- alter session set nls_date_format = 'yyyymmdd hh24:mi:ss';  

--	===========================================================================================
--	backup current Intersection

--	drop table 		jdeacutis.Intersection;
--	create table	jdeacutis.Intersection tablespace gis_data nologging
--				as select * from garland.Intersection;

--	===========================================================================================

	select 'INTERSECTION SEQUENCE ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;

	drop	sequence		garland.Adr_Work_Seq;
	create sequence		garland.Adr_Work_Seq
	start with		01
	increment by	001
	minvalue		001
	maxvalue		999999
	nocache				-- buffer size
--	cache			01		-- buffer size
	nocycle				-- not wrap from max to min
	order					-- 1st come 1st serve
	;

--	===========================================================================================
	select 'LOAD INTERSECTION TABLE ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;

	TRUNCATE table	GARLAND.INTERSECTION	reuse storage;

	insert --+ append
	into	 garland.Intersection
(
		addr1_name,
		addr1_type,
		addr1_pfx,
		addr1_sfx,
		addr1_block,

		addr2_name,
		addr2_type,
		addr2_pfx,
		addr2_sfx,
		addr2_block,

		node_id,
		intersect_id 
)

	select
		strname1,
		strtype1,
		strpre1,
		strsuf1,
		strblok1,

		strname2,
		strtype2,
		strpre2,
		strsuf2,
		strblok2,

		Node_ID,
		Intersect_Type || garland.Adr_Work_Seq.nextval

	from	garland.Temp_View4;

	COMMIT;

--	===========================================================================================

	analyze table garland.Intersection  compute statistics;

--	===========================================================================================

	select * from garland.intersection where rownum < 11;

--	===========================================================================================
