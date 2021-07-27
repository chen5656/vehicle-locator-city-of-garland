--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 99999;
set linesize	800;
set pagesize	9999;
--	=====================================================================
--	MARK UMS DUPLICATE ADDRESS

--	Initially Parent_ID = Location_ID during Build Common UMS
--	Set Parent_ID = max Location_No for duplicated address
--	If  Parent_ID <> Location ID then the record will be ignored
--	=====================================================================

DECLARE

	compile_only		integer := 0;
	do_print			integer := 1000;
	total_update		integer := 0;
	counter			integer := 0;

	UMS				garland.common_ums%rowtype;

--	=====================================================================
cursor	READ_DUPE_ADDRESS		is

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	=====================================================================

	select	UMS.rowid		ums_rowid,
			ADR.location_no
	from		garland.Common_UMS	UMS,
(
	select 
		max(location_no)	location_no,
		addr_name,
		addr_num,
		addr_type,
		addr_pfx,
		addr_sfx
	from		garland.Common_UMS
	group by	addr_name, addr_type, addr_pfx, addr_sfx, addr_num 
	having	count(*) > 1
)							ADR

	where	ums.addr_name	= adr.addr_name
	and	ums.addr_num	= adr.addr_num
	and	ums.addr_type	= adr.addr_type
	and	ums.addr_pfx	= adr.addr_pfx
	and	ums.addr_sfx	= adr.addr_sfx

--	AND	ROWNUM < 11
	order by	ums.addr_name, ums.addr_type, ums.addr_pfx, ums.addr_sfx, ums.addr_num ;

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

--	=====================================================================
BEGIN

	if	compile_only > 0	then
		return;
	end if;

for	read in READ_DUPE_ADDRESS		loop

	if	do_print > 0		then
		do_print := do_print - 01;
		select * into UMS from garland.Common_UMS where rowid = read.UMS_rowid;
		dbms_output.put_line('DUPE ADDRESS: '||rpad(ums.location_no,8)||' -- '||
			ums.addr_num||' '||ums.addr_pfx||' '||ums.addr_name||' '||ums.addr_type||' '||ums.addr_sfx); 
	end if;

	update  garland.Common_UMS
	set	parent_id = read.location_no
	where	rowid = read.ums_rowid;

	total_update := total_update + 01;

end loop;

	ROLLBACK;

--	COMMIT;

	dbms_output.put_line ( '-----');
	dbms_output.put_line ( 'TOTAL UPDATE: ' || total_update);

END;

--	=====================================================================

