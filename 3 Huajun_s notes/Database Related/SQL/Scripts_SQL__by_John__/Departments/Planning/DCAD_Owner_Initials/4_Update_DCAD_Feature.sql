--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
--	=====================================================================
--	Set DCAD_2007_Parcels  Owner  Initials = Extracted Initials  (Temp_View of GIS_Objects)

--	select owner_name, owner_initials from gis.dcad_2007_parcels where rownum < 111;
--	=====================================================================

DECLARE

	compile_only		integer := 01;

	total_update		integer := 0;

cursor	read_Merge	is

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'a'	into jdeacutis.plan_table for
--	=====================================================================

	select	a.rowid Drowid,  b.rowid Trowid, b.Initials
	from	gis.DCAD_2007_Parcels		A,
		garland.Temp_View		B
	where	a.acct = b.account;

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

BEGIN

	if	compile_only > 0	then
		return;
	end if;

for	read in read_Merge	loop

	update	gis.DCAD_2007_Parcels		D
	set	d.owner_initials =
(
	select	t.initials
	from	garland.Temp_View		T
	where	t.rowid = read.Trowid
)
	where	d.rowid = read.Drowid;

	total_update := total_update + 01;

end loop;

	COMMIT;

	dbms_output.put_line ('TOTAL UPDATES ' || total_update );

END;

