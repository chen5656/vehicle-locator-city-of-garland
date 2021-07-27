--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	execute	garland.CCS_LOAD_IDENTIFIER;

--	create or replace procedure garland.CCS_LOAD_IDENTIFIER	AS

	DECLARE

--	=====================================================================

	compile_only	integer	:= 0;

	total_insert	integer	:= 0;
	total_active	integer	:= 0;
	total_inactive	integer	:= 0;
	total_assign	integer	:= 0;

	title			varchar2(100);
	heading		varchar2(100);
	script		varchar2(100);

cursor Read_New_Identifier	is

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	=====================================================================
	select * from 
	(
		select a.rowid	ADR_rowid, 
			 k.rowid	ID_rowid
		from	garland.CCS_ADDRESS_NEW		A,
			garland.CCS_IDENTIFIER_NEW	K
	
		where	a.addr_name		= k.addr_name	(+)
		and	a.addr_type		= k.addr_type	(+)
		and	a.addr_prefix	= k.addr_prefix	(+)
		and	a.addr_suffix	= k.addr_suffix	(+)
		and	a.addr_number	= k.addr_number	(+)
	
		and	nvl(a.tax_legal_desc,	' ')	= nvl(k.tax_legal_desc	(+), ' ')
		and	nvl(a.tax_owner,		' ')	= nvl(k.tax_owner 	(+), ' ')
		and	nvl(a.ums_last_name,	' ')	= nvl(k.ums_last_name	(+), ' ')
		and	nvl(a.ums_first_name,	' ')	= nvl(k.ums_first_name	(+), ' ')
		and	a.addr_name not like 'DIRECTION%'
	)
	where	ID_RowID is null;

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

cursor Read_Assign_Record_Seq		is

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	=====================================================================
	select k.rowid	ID_rowid, 
		 a.rowid	ADR_rowid, 
		 k.CCS_ID

	from	garland.CCS_IDENTIFIER_NEW	K,
		garland.CCS_ADDRESS_NEW		A

	where	k.addr_name		= a.addr_name
	and	k.addr_type		= a.addr_type
	and	k.addr_prefix	= a.addr_prefix
	and	k.addr_suffix	= a.addr_suffix
	and	k.addr_number	= a.addr_number

	and	nvl(k.tax_legal_desc,	' ')	= nvl(a.tax_legal_desc,	' ')
	and	nvl(k.tax_owner,		' ')	= nvl(a.tax_owner,	' ')
	and	nvl(k.ums_last_name,	' ')	= nvl(a.ums_last_name,	' ')
	and	nvl(k.ums_first_name,	' ')	= nvl(a.ums_first_name,	' ')
	and	a.addr_name not like 'DIRECTION%'
	;

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

cursor Read_Identifier_Status		is

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	=====================================================================
	select k.rowid	ID_rowid, 
		 a.rowid	ADR_rowid,
		 k.active,
		 k.inactive,
		 a.address_id,
		 a.tax_account,
		 a.ums_id
	from	garland.CCS_IDENTIFIER_NEW	K,
		garland.CCS_ADDRESS_NEW		A	
	where	k.ccs_id = a.record_seq (+);

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

BEGIN
	if	compile_only > 0		then
		return;
	end if;

for	read in  Read_New_Identifier	loop

	insert into garland.CCS_IDENTIFIER_NEW
	(
		CCS_ID,

		ADDR_NUMBER,
		ADDR_PREFIX,
		ADDR_NAME,
		ADDR_TYPE,
		ADDR_SUFFIX,

		TAX_LEGAL_DESC,
		TAX_OWNER,
		UMS_LAST_NAME,
		UMS_FIRST_NAME,

		GIS_ID,	
		TAX_ID,	
		UMS_ID,	

		ACTIVE,
		INACTIVE
	)
		select

		garland.CCS_Identifier_Seq.nextval,

		ADDR_NUMBER,
		ADDR_PREFIX,
		ADDR_NAME,
		ADDR_TYPE,
		ADDR_SUFFIX,

		TAX_LEGAL_DESC,
		TAX_OWNER,
		UMS_LAST_NAME,
		UMS_FIRST_NAME,

		ADDRESS_ID,
		TAX_ACCOUNT,
		UMS_ID,

		sysdate,
		null

		from	garland.CCS_ADDRESS_NEW
		where	rowid = read.ADR_rowid; 

		total_insert := total_insert + 01;
end loop;

	COMMIT;

	dbms_output.put_line ( 'Total Identifier Inserts ' || total_insert);

--	=====================================================================
--	Assign CCS_ID to Record_Sequence
--	=====================================================================

for	read in Read_Assign_Record_Seq	loop

	update garland.CCS_ADDRESS_NEW
	set	record_seq	= read.CCS_ID
	where	rowid		= read.ADR_rowid;

	total_assign := total_assign + 01;

end loop;

	COMMIT;

	dbms_output.put_line ( 'Total Record Sequences =' || total_assign);


--	=====================================================================
--	CCS_ADDRESS.record_seq == CCS_IDENTIFIER.ccs_id
--	set Inactive to sysdate if CCS_IDENTIFIER.ccs_id does not match CCS_ADDRESS (Record_Seq) 
--	and CCS_IDENTIFIER.Inactive is null (has not already been set)
--	else set Inactive to null if CCS.IDENTIFIER.ccs_id matches CCS_ADDRESS.Record_Seq
--	=====================================================================

for	read in Read_Identifier_Status	loop
	
	if	read.ADR_rowid is null
	and	read.Inactive  is null		then	
		
		update garland.CCS_Identifier_NEW
		set	Inactive = sysdate
		where	rowid = read.ID_rowid;

		total_inactive := total_inactive + 01;

	elsif	read.ADR_rowid is not null
	and	read.Inactive  is not null	then
		
		update garland.CCS_Identifier_NEW
		set	Inactive	= null,
			Active	= sysdate,
			GIS_ID	= read.address_id,
			TAX_ID	= read.tax_account,
			UMS_ID	= read.ums_id
		where	rowid = read.ID_rowid;

		total_active := total_active + 01;

	end if;

end loop;

	COMMIT;

	dbms_output.put_line ('Total Identifiers Inactivated: ' || total_inactive);
	dbms_output.put_line ('Total Identifiers Activated: '	  || total_active);
--	=====================================================================

	script := 'analyze table garland.CCS_IDENTIFIER_NEW	compute statistics';
	execute immediate script;

END;

--	=====================================================================
--	=====================================================================
--	=====================================================================
/*
	select count(*) from
(
	select decode(l.record_seq||j.inactive, null,sysdate, 
		 decode(l.record_seq, null,j.inactive, null))	
	from	garland.CCS_IDENTIFIER_NEW		J,
(
	select a.record_seq, k.rowid row_id
	from	garland.CCS_IDENTIFIER_NEW		K,
		garland.CCS_ADDRESS_NEW			A	
	where	k.ccs_id = a.record_seq (+)
)								L
	where	J.rowid = I.rowid
	and	J.rowid = L.row_id
);
*/
--	=====================================================================

