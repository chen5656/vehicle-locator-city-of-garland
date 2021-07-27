--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
--	=====================================================================
--	"Dem Bones"

--	This update Hinges on the RowID from the Join(J) query
--	The Join rowid connects to the update(U) table
--	The Join rowid connects to the outer join(O) table
--	The Join query makes use of the null/non-null column in the outer join
--	=====================================================================

--	========================================================================
	truncate table	jdeacutis.plan_table	reuse storage;
	explain plan set	statement_id = 'a'	into jdeacutis.plan_table for
--	=====================================================================

	update garland.CCS_IDENTIFIER		U
	set	inactive =
(
	select decode(o.record_seq, null,sysdate, null)
	from	garland.CCS_IDENTIFIER		J,
(
	select k.rowid row_id, a.record_seq 
	from	garland.CCS_IDENTIFIER		K,
		garland.CCS_ADDRESS		A	
	where	k.ccs_id = a.record_seq (+)
)							O
	where	j.rowid = u.rowid
	and	j.rowid = o.row_id
);

--	=====================================================================
	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

/*                                                                                      cost       rows
-------------------------------------------------------------------------------- ---------- ----------
..Update.State................A.................................................         69     70,895
...Update.......................................Ccs_Identifier..................
01..Table.Access..............Full..............Ccs_Identifier..................         69     70,895
....Nested.Loops..............Outer.............................................          3          1
.....Nested.Loops...............................................................          2          1
04....Table.Access............By.User.Rowid.....Ccs_Identifier..................          1          1
02....Table.Access............By.User.Rowid.....Ccs_Identifier..................          1          1
.....Index....................Range.Scan........Ccs_Address_Recseq....Non-Unique          1          1
*/
