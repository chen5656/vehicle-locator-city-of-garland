--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================
--	Build COMMON_ADDRESS_KEYS  from Common_GIS, Common_TAX, Common_UMS
--	=====================================================================

--	execute	garland.CCS_LINK_Common_Keys;

--	create or replace procedure garland.CCS_LINK_Common_Keys	as

	DECLARE

--	=====================================================================

	compile_only		integer	:= 0;
	do_insert			integer	:= 01;
	do_print			integer	:= 00;

	total_input			integer	:= 0;
	total_accept		integer	:= 0;
	total_insert		integer	:= 0;
	title				varchar2(100);
	script			varchar2(100);

cursor  READ_GIS_TAX_UMS		is

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	=====================================================================

	select * from
(
	select 
		G.addr_name,
		G.addr_type,
		G.addr_pfx,
		G.addr_sfx,
		G.addr_num,
		T.legal_desc		TAX_Legal,
		T.tax_owner			TAX_Owner,
		U.last_name			UMS_Last_Name,
		U.first_name		UMS_First_Name,
		G.Address_ID		GIS_ID,
		G.Parcel_ID			Parcel_ID,
		T.Tax_Account		TAX_ID,
		U.Account_No		UMS_ID,
		'GIS'				Source

	from	garland.Common_GIS	G,
		garland.Common_TAX	T,
		garland.Common_UMS	U

	where	g.addr_name		= t.tax_addr_name	(+)
	and	g.addr_type		= t.tax_addr_type	(+)
	and	g.addr_pfx		= t.tax_addr_pfx	(+)
	and	g.addr_sfx		= t.tax_addr_sfx	(+)
	and	g.addr_num		= t.tax_addr_num	(+)

	and	g.addr_name		= u.addr_name	(+)
	and	g.addr_type		= u.addr_type	(+)
	and	g.addr_pfx		= u.addr_pfx	(+)
	and	g.addr_sfx		= u.addr_sfx	(+)
	and	g.addr_num		= u.addr_num	(+)

	UNION ALL

	select * from
(
	select
		T.tax_addr_name		addr_name,
		T.tax_addr_type		addr_type,
		T.tax_addr_pfx		addr_pfx,
		T.tax_addr_sfx		addr_sfx,
		T.tax_addr_num		addr_num,
		T.legal_desc		TAX_Legal,
		T.tax_owner			TAX_Owner,
		U.last_name			UMS_Last_Name,
		U.first_name		UMS_First_Name,
		NULL				GIS_ID,
		NULL				PARCEL_ID,
		T.Tax_Account		TAX_ID,
		U.Account_No		UMS_ID,
		'TAX'				Source

	from	garland.Common_TAX	T,
		garland.Common_UMS	U
	where	t.tax_addr_name		= u.addr_name	(+)
	and	t.tax_addr_type		= u.addr_type	(+)
	and	t.tax_addr_pfx		= u.addr_pfx	(+)
	and	t.tax_addr_sfx		= u.addr_sfx	(+)
	and	t.tax_addr_num		= u.addr_num	(+)

	and not exists 
(
	select 'x' 
	from	garland.Common_GIS	G
	where	g.addr_name		= t.tax_addr_name	
	and	g.addr_type		= t.tax_addr_type	
	and	g.addr_pfx		= t.tax_addr_pfx	
	and	g.addr_sfx		= t.tax_addr_sfx	
	and	g.addr_num		= t.tax_addr_num	
))
)

--	WHERE SOURCE = 'TAX'	

	order by	addr_name,addr_type,addr_pfx,addr_sfx,addr_num, 
			tax_legal,tax_owner, ums_last_name,ums_first_name,
			gis_id, tax_id, ums_id;

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

	PREV		Read_GIS_TAX_UMS%rowtype;

--	=====================================================================
BEGIN

	if	compile_only > 0		then
		return;
	end if;

	title := '***  CCS LINK COMMON KEYS';  dbms_output.put_line(title);

--	=============================================================================

	if	do_insert > 0		then
		script := 'Truncate table garland.Common_Address_Keys reuse storage';
		execute immediate (script);
	end if;

--	=============================================================================

	PREV := NULL;

for	READ in Read_GIS_TAX_UMS	Loop

	total_input := total_input + 01;

	if	read.addr_name			= prev.addr_name
	and	read.addr_type			= prev.addr_type
	and	read.addr_pfx			= prev.addr_pfx
	and	read.addr_sfx			= prev.addr_sfx
	and	read.addr_num			= prev.addr_num
	and	nvl(read.tax_legal,' ')		= nvl(prev.tax_legal,' ')
	and	nvl(read.tax_owner,' ')		= nvl(prev.tax_owner,' ')
	and	nvl(read.ums_last_name, ' ')	= nvl(prev.ums_last_name, ' ')
	and	nvl(read.ums_first_name,' ')	= nvl(prev.ums_first_name,' ')	then
		null;

	else
		total_accept := total_accept + 01;

		if	do_insert > 0								then
			total_insert := total_insert + 01;

			insert into garland.Common_Address_Keys	Values
			(
				read.addr_num, read.addr_pfx, read.addr_name, read.addr_type, read.addr_sfx,  		
				read.source, read.parcel_id,  0, 
				read.gis_id, read.tax_id, read.ums_id
			);
		end if;

		do_print := do_print - 01;
		if	do_print > 0		then
			dbms_output.put_line 
			(	read.addr_num||' '||read.addr_pfx||' '||read.addr_name||' '||read.addr_type||' '||read.addr_sfx
				||' '||read.source||' '||read.gis_id||' '||read.tax_id||' '||read.ums_id	);
		end if;

	end if;

	PREV := READ;

end loop;

	COMMIT;
	
	dbms_output.put_line ( 'Input  total = ' || total_input);
	dbms_output.put_line ( 'Accept total = ' || total_accept);
	dbms_output.put_line ( 'Insert total = ' || total_insert);

--	=============================================================================

--	script := 'Analyze table garland.Common_Address_Keys compute statistics';
--	execute immediate (script);

--	=============================================================================

END;

