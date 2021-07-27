--	=====================================================================
	select * from viewer.me;
--	BEGIN  SERVER USER  SERVER USER  SERVER USER  SERVER USER  SERVER USER  SERVER USER  END;
set	TIMING		ON;
set	sqlblanklines	on;
set	serveroutput	on	size 99999;
set	linesize		1000;
set	pagesize		50000;
--	execute jdeacutis.show_table_column	('common_gis common_tax common_ums common_address_keys', 'garland', '');
--	execute jdeacutis.show_source		('ccs_link_keys', 'garland', '');
--	execute jdeacutis.show_error		('ccs_link_keys', 'garland', '');
--	execute jdeacutis.show_view		('', '', '');
--	execute jdeacutis.show_index_column	('', '', '');
--	EXECUTE jdeacutis.TEST_PROC;
--	CREATE or replace procedure jdeacutis.TEST_PROC  as
--	DECLARE
--	=====================================================================
--	Build COMMON_ADDRESS_KEYS  from Common_GIS, Common_TAX, Common_UMS
--	=====================================================================

	select 'garland.CCS_LINK_KEYS  ' ||to_char(sysdate,'hh24:mi:ss') 	" " from dual;

--	exec jdeacutis.show_column_values ( 'garland.common_address_keys', 0);

--	=====================================================================
/*

	select count(*) TOTAL, count(distinct gis_key) GIS, count(distinct tax_key) TAX, count(distinct ums_key) UMS
	from	garland.common_address_keys;

	select count(*), count(distinct address_id)  GIS 						from garland.common_GIS;
	select count(*), count(distinct tax_key)TAX, count(distinct tax_account) ACCT		from garland.common_TAX;
	select count(*), count(distinct location_no) UMS 						from garland.common_UMS;

	select trunc(record_seq, -6), count(*) from garland.ccs_address_NEW group by trunc(record_seq, -6);
	select record_seq, count(*) from garland.ccs_address_NEW group by record_seq having count(*) > 1;

*/
--	=====================================================================

--	EXECUTE	garland.CCS_LINK_KEYS;

--	CREATE or replace procedure garland.CCS_LINK_KEYS	as

	DECLARE

--	=====================================================================
	compile_only		integer	:= 0;
	do_insert			integer	:= 01;
	do_print			integer	:= 00;

	total_input			integer	:= 0;
	total_accept		integer	:= 0;
	total_dupe			integer	:= 0;
	total_insert		integer	:= 0;
	title				varchar2(100);
	script			varchar2(100);
--	=====================================================================

cursor  READ_GIS_TAX_UMS		is

	select DISTINCT * from

(
	select
		g.rowid		GIS,
		t.rowid		TAX,
		u.rowid		UMS,
		'GIS'			Source

	from	garland.Common_GIS			G,
		garland.Common_TAX		T,
		garland.Common_UMS		U

	where	g.addr_name		= t.tax_addr_name	(+)
	and	g.addr_type		= t.tax_addr_type	(+)
	and	g.addr_pfx		= t.tax_addr_pfx	(+)
	and	g.addr_sfx		= t.tax_addr_sfx	(+)
	and	g.addr_num		= t.tax_addr_num	(+)

	and	t.tax_addr_name		= u.addr_name	(+)
	and	t.tax_addr_type		= u.addr_type	(+)
	and	t.tax_addr_pfx		= u.addr_pfx	(+)
	and	t.tax_addr_sfx		= u.addr_sfx	(+)
	and	t.tax_addr_num		= u.addr_num	(+)

--	and	g.addr_name		= u.addr_name	(+)
--	and	g.addr_type		= u.addr_type	(+)
--	and	g.addr_pfx		= u.addr_pfx	(+)
--	and	g.addr_sfx		= u.addr_sfx	(+)
--	and	g.addr_num		= u.addr_num	(+)

	order by	g.addr_name,  g.addr_type, g.addr_pfx,  g.addr_sfx, g.addr_num,
			t.legal_desc, t.tax_owner, u.last_name, u.first_name,
			g.address_id, t.tax_account, u.account_no
)

	UNION ALL

	select * from
(
	select
		null			GIS,
		t.rowid		TAX,
		u.rowid		UMS,
		'TAX'			Source

	from	garland.Common_TAX	T,
		garland.Common_UMS	U

	where	t.tax_addr_name	= u.addr_name	(+)
	and	t.tax_addr_type	= u.addr_type	(+)
	and	t.tax_addr_pfx	= u.addr_pfx	(+)
	and	t.tax_addr_sfx	= u.addr_sfx	(+)

--	/chg/ JUL 2010
--	and	t.tax_addr_num		= u.addr_num		(+)
	and	nvl(t.tax_addr_num,0)	= nvl(u.addr_num(+),0)

--	AND	ltrim(T.TAX_ADDR_NUM,'0') IS NULL

	and not exists
(
	select 0
	from	garland.Common_GIS		G
	where	g.addr_name		= t.tax_addr_name
	and	g.addr_type		= t.tax_addr_type
	and	g.addr_pfx		= t.tax_addr_pfx
	and	g.addr_sfx		= t.tax_addr_sfx

--	/chg/ JUL 2010
--	and	g.addr_num		= t.tax_addr_num
	and	nvl(g.addr_num,0)	= nvl(t.tax_addr_num,0)
)
	order by	t.tax_addr_name, t.tax_addr_type, t.tax_addr_pfx, t.tax_addr_sfx, t.tax_addr_num,
			t.legal_desc,  t.tax_owner, u.last_name, u.first_name,
			t.tax_account, u.account_no
)


--	sept 2012

	UNION ALL

(

	select
		g.rowid		GIS,
		null		TAX,
		u.rowid		UMS,
		'UMS'			Source

	from	garland.Common_GIS		G,
		garland.Common_UMS		U

	where	g.addr_name		= u.addr_name
	and	g.addr_type		= u.addr_type
	and	g.addr_pfx		= u.addr_pfx
	and	g.addr_sfx		= u.addr_sfx
	and	g.addr_num		= u.addr_num
	and not exists
(
	select	0
	from	garland.Common_TAX	T

	where	t.tax_addr_name	= u.addr_name
	and	t.tax_addr_type	= u.addr_type
	and	t.tax_addr_pfx	= u.addr_pfx
	and	t.tax_addr_sfx	= u.addr_sfx
)

);


--	=====================================================================

	GIS		garland.Common_GIS%rowtype;
	TAX		garland.Common_TAX%rowtype;
	UMS		garland.Common_UMS%rowtype;

	GISS		garland.Common_GIS%rowtype;
	TAXX		garland.Common_TAX%rowtype;
	UMSS		garland.Common_UMS%rowtype;

	type	adr_type	is record
(
	addressid			number(8,0),

--	MAY 2011
	parcelid			varchar2(11),
--	parcelid			number(8,0),

	streetnum			number(8,0),
	streetprefix		varchar2(02),
	streetname			varchar2(30),
	streettype			varchar2(04),
	streetsuffix		varchar2(02)
);
	ADR		adr_type;
	ADRR		adr_type;

--	=====================================================================
BEGIN

	if	compile_only > 0		then
		return;
	end if;

	title := '***  CCS LINK COMMON KEYS';  dbms_output.put_line(title);

	if	do_insert > 0		then
		script := 'Truncate table garland.Common_Address_Keys  reuse storage';
		execute immediate (script);
	end if;


--	=============================================================================
--	APR 2009

	update	garland.Common_GIS
	set		addr_type	= nvl(addr_type,' '),
			addr_pfx	= nvl(addr_pfx, ' '),
			addr_sfx	= nvl(addr_sfx, ' ');
	COMMIT;

	update	garland.Common_UMS
	set		addr_type	= nvl(addr_type,' '),
			addr_pfx	= nvl(addr_pfx, ' '),
			addr_sfx	= nvl(addr_sfx, ' ');
	COMMIT;

	update	garland.Common_TAX
	set		tax_addr_type	= nvl(tax_addr_type,' '),
			tax_addr_pfx	= nvl(tax_addr_pfx, ' '),
			tax_addr_sfx	= nvl(tax_addr_sfx, ' ');
	COMMIT;

--	=============================================================================

	GISS	:= null;
	TAXX	:= null;
	UMSS	:= null;
	ADRR	:= null;

for	READ in Read_GIS_TAX_UMS	Loop

	total_input := total_input + 01;

	if	read.GIS is null		then
		GIS	:= null;
	else
		select *	into GIS	from garland.Common_GIS	where rowid = read.GIS;
	end if;

	if	read.TAX is null		then
		TAX	:= null;
	else	
		select *	into TAX	from garland.Common_TAX	where rowid = read.TAX;
	end if;

	if	read.UMS is null		then
		UMS	:= null;
	else
		select *	into UMS	from garland.Common_UMS	where rowid = read.UMS;
	end if;

	if	read.Source = 'GIS'	then
		adr.streetname	:=	gis.addr_name;
		adr.streettype	:=	gis.addr_type;
		adr.streetprefix	:=	gis.addr_pfx;
		adr.streetsuffix	:=	gis.addr_sfx;
		adr.streetnum	:=	gis.addr_num;
		adr.addressid	:=	gis.address_id;
		adr.parcelid	:=	gis.parcel_id;
	else
		adr.streetname	:=	tax.tax_addr_name;
		adr.streettype	:=	tax.tax_addr_type;
		adr.streetprefix	:=	tax.tax_addr_pfx;
		adr.streetsuffix	:=	tax.tax_addr_sfx;
		adr.streetnum	:=	tax.tax_addr_num;
		adr.addressid	:=	null;
		adr.parcelid	:=	null;
	end if;

	if	adr.streetname		= adrr.streetname
	and	adr.streettype		= adrr.streettype
	and	adr.streetprefix	= adrr.streetprefix
	and	adr.streetsuffix	= adrr.streetsuffix
	and	adr.streetnum		= adrr.streetnum

	and	nvl(tax.legal_desc	,' ')		= nvl(taxx.legal_desc	,' ')
	and	nvl(tax.tax_owner	,' ')		= nvl(taxx.tax_owner	,' ')
	and	nvl(ums.last_name	,' ')		= nvl(umss.last_name	,' ')
	and	nvl(ums.first_name	,' ')		= nvl(umss.first_name	,' ')		then
		total_dupe	:= total_dupe + 01;
	else
		total_accept := total_accept + 01;

		if	do_insert > 0						then
			total_insert := total_insert + 01;

			INSERT into garland.Common_Address_Keys
			(
				 addr_num
				,addr_pfx
				,addr_name
				,addr_type
				,addr_sfx

				,source
				,parcel_id
				,sequence

				,gis_key
				,tax_key
				,ums_key

				,UMS_PREM
				,UMS_CUST
				,UMS_ACCT
			)
			Select
				adr.streetnum, adr.streetprefix, adr.streetname, adr.streettype, adr.streetsuffix,  		
				read.source,   adr.parcelid,    0, 

				nvl(adr.addressid, 0), 
				nvl(tax.Tax_KEY,0),  
				nvl(ums.account_no,0), 

				nvl(ums.LOCATION_NO,0), 
				nvl(ums.PERSON_NO,0), 
				nvl(ums.ACCOUNT_NO_NOW,0)
			from dual;

		end if;

		if	do_print > 0
		and	ums.account_no is null	then
			do_print := do_print - 01;
			dbms_output.put_line 
			(	adr.streetnum	||' '||adr.streetprefix||' '||adr.streetname ||' '||adr.streettype ||' '||adr.streetsuffix
				||' /Source AID TAX UMSLocn UMSAcct/   '||read.source
				||' '||adr.addressid||' '||tax.tax_account||' '||ums.location_no||'/'||ums.account_no	);
		end if;
	end if;

	GISS	:= GIS;
	TAXX	:= TAX;
	UMSS	:= UMS;
	ADRR	:= ADR;
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

--	=============================================================================
/*
--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	=====================================================================


	UNION ALL

(

	select
		g.rowid		GIS,
		null		TAX,
		u.rowid		UMS,
		'UMS'			Source

	from	garland.Common_GIS		G,
		garland.Common_UMS		U

	where	g.addr_name		= u.addr_name
	and	g.addr_type		= u.addr_type
	and	g.addr_pfx		= u.addr_pfx
	and	g.addr_sfx		= u.addr_sfx
	and	g.addr_num		= u.addr_num
	and not exists
(
	select	0
	from	garland.Common_TAX	T

	where	t.tax_addr_name	= u.addr_name
	and	t.tax_addr_type	= u.addr_type
	and	t.tax_addr_pfx	= u.addr_pfx
	and	t.tax_addr_sfx	= u.addr_sfx
)

);


--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================
*/
--	=============================================================================
