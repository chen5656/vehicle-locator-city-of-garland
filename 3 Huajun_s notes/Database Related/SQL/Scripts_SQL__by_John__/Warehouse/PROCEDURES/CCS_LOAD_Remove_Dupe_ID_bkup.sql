--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

declare

	compile_only		integer := 01;
	total_input			integer := 0;
	total_delete		integer := 0;
	total_update		integer := 0;

	this_Record_Seq		integer;

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	=====================================================================

cursor  Get_Dupe_Record_Seq	is

	select A.*,
		 A.rowid 	ADDR_rowid,  
		 I.rowid	IDEN_rowid
	from	garland.ccs_address_new		A,
		garland.ccs_identifier_new	I
	where	a.record_seq = i.ccs_id	
	and	a.record_seq   in
(
	select record_seq
	from	garland.ccs_address_new
	group by record_seq
	having count(*) > 1
)					
	order by a.record_seq, a.address_id, a.tax_id, a.ums_id, a.parcel_id;

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

begin

	if	compile_only > 0		then
		return;
	end if;

for	READ in Get_Dupe_Record_Seq	loop
	total_input := total_input + 01;

	if	this_Record_Seq = read.Record_Seq		then
		total_delete := total_delete + 01;

		Delete from garland.CCS_Address_NEW
		where	rowid = read.ADDR_rowid;

	elsif	this_Record_Seq < read.Record_Seq		then
		total_update := total_update + 01;

		update garland.CCS_Identifier_NEW
		set	gis_id	= read.address_id,
			tax_id	= read.tax_id,
			ums_id	= read.ums_id
		where	rowid = read.IDEN_rowid;

		this_Record_Seq := read.Record_Seq;
	end if;

end loop;

	COMMIT;

	dbms_output.put_line ( '-----');
	dbms_output.put_line ( 'Total Input:  '	|| total_input);
	dbms_output.put_line ( 'Total Update: '	|| total_update);
	dbms_output.put_line ( 'Total Delete: '	|| total_delete);
end;


