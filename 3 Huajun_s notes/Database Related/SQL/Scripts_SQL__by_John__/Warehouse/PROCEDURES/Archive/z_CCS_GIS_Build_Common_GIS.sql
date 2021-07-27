--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	using	ADDRESS and ROAD

--	=====================================================================

--	execute	garland.CCS_GIS_Build_Common_GIS;

	create or replace procedure garland.CCS_GIS_Build_Common_GIS	AS

--	DECLARE

--	=====================================================================

	compile_only	integer	:= 0;

	total_processed	integer	:= 0;
	title			varchar2(100);
	heading		varchar2(100);

BEGIN
	if	compile_only > 0		then
		return;
	end if;

--	=================================================================================
	title := '*** BUILD COMMON GIS   ';  dbms_output.put_line(title);
--	=================================================================================

	DBMS_UTILITY.EXEC_DDL_STATEMENT ('Truncate table garland.Common_GIS reuse storage');

	insert --+ append
	into	 garland.Common_GIS
	(
		 addr_num
		,addr_pfx
		,addr_name
		,addr_type
		,addr_sfx
		,address_id
		,parcel_id
		,block_id
		,road_id
	)
	select --+ use_hash(x)
		a.streetnum,
		a.streetprefix,
		a.streetname,
		a.streettype,
		a.streetsuffix,
		a.addressid,
		a.parcelid,
		b.block_id,
		r.roadid
	from
		sde.ADDRESS_SDE		A,
		sde.ROAD_SDE		R,
		garland.BLOCK		B
	where	a.streetprefix		= b.addr_pfx	(+)
	and	a.streetname		= b.addr_name	(+)
	and	a.streettype		= b.addr_type	(+)
	and	a.streetsuffix		= b.addr_sfx	(+)
	and	trunc(a.streetnum, -2)	= b.addr_block	(+)
	and	b.addr_pfx			= r.streetprefix	(+)
	and	b.addr_name			= r.streetname	(+)
	and	b.addr_type			= r.streettype	(+)
	and	b.addr_sfx			= r.streetsuffix	(+)
	and	b.addr_block	between trunc(r.rangelo (+),-2)  and trunc(r.rangehi (+), -2)
	and	a.streetnum		 > 0
	and	a.streetnum		 not between 9000 and 9999
	and	rtrim(a.unit)  	is null
	and	rtrim(a.building) is null
	;

	total_processed:= sql%rowcount;
	dbms_output.put_line ( 'Total Inserts=' || total_processed);

	COMMIT;

	DBMS_UTILITY.EXEC_DDL_STATEMENT ('Analyze table garland.Common_GIS compute statistics');

END;

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	=====================================================================
--	explain plan set	statement_id = 'a'	into jdeacutis.plan_table for
--	=====================================================================
--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

