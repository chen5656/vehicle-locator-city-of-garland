--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	Assign Parent ID to newly added CCS_IDENTIFIER

--	=====================================================================
--	ISSUES
--		bldg / unit
--		and	a.active	between b.active and b.inactive
--	=====================================================================

--	execute	garland.CCS_LOAD_PARENT_ID

--	create or replace procedure garland.CCS_LOAD_PARENT_ID	AS

	DECLARE

--	=====================================================================

	compile_only	integer	:= 01;
	do_update		integer	:= 0;
	do_print		integer	:= 050;

	is_eof		integer	:= 0;
	total_input		integer	:= 0;
	total_parent	integer	:= 0;
	total_child		integer	:= 0;
	total_update	integer	:= 0;
	is_not_inactive	varchar2(10):0 '99999999';

	this_rowid		rowid;
	this_id		integer;
	this_parent		integer;
	occur			integer;
	score1		integer;
	score2		integer;
	score3		integer;
	score4		integer;
	this_score		varchar2(10);
	best_score		varchar2(10);
	prior_date		varchar2(10);

	title			varchar2(100);
	script		varchar2(100);

--	=====================================================================

cursor Read_Address_Legal	is

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	=====================================================================

	select * from
(
	select
		a.ccs_id						aft_id,
		b.ccs_id						bef_id,
		01							bef_adr,
		decode(b.tax_legal, a.tax_legal,1, 0)	bef_lgl,
		a.rowid						aft_rowid
		b.rowid						bef_rowid,
	from	garland.CCS_Identifier_New	A,
		garland.CCS_Identifier_New	B

	where	a.addr_name		= b.addr_name
	and	a.addr_type		= b.addr_type
	and	a.addr_prefix	= b.addr_prefix
	and	a.addr_suffix	= b.addr_suffix
	and	a.addr_number	= b.addr_number

	and	prior_date	between b.active and b.inactive
	and	a.ccs_id	> b.ccs_id 
	and	a.inactive	= is_not_inactive
	and	a.ccs_parent is null

	UNION ALL
					
	select
		a.ccs_id			aft_id,
		b.ccs_id			bef_id,
		00				bef_adr,
		01				bef_lgl,
		a.rowid			aft_rowid
		b.rowid			bef_rowid,
	from	garland.CCS_Identifier_New	A,
		garland.CCS_Identifier_New	B

	where	b.tax_legal	 	= a.tax_legal

	and (	a.addr_name		<> b.addr_name
	or	a.addr_type		<> b.addr_type
	or	a.addr_prefix	<> b.addr_prefix
	or	a.addr_suffix	<> b.addr_suffix
	or	a.addr_number	<> b.addr_number )

	and	prior_date	between b.active and b.inactive
	and	a.ccs_id	> b.ccs_id 
	and	a.inactive	= is_not_inactive
	and	a.ccs_parent is null
)
	order by aft_id;

	READ	Read_Address_Legal%rowtype;

	BEF	garland.CCS_Identifier_New%rowtype;
	AFT	garland.CCS_Identifier_New%rowtype;

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

	title := 'CCS LOAD PARENT ID';  dbms_output.put (title);

	select max(time) into prior_date from (
	select active time from garland.CCS_Identifier_New		
	UNION ALL 
	select inactive time from garland.CCS_Identifier_New);

	select max(time) into prior_date from (
	select active time from garland.CCS_Identifier_New	where active   < prior_date
	UNION ALL 
	select inactive time from garland.CCS_Identifier_New)	where inactive < prior_date);

	open	Read_Address_Legal;
	fetch	Read_Address_Legal	into READ;

	if	Read_Address_Legal%found then
		total_input	:= 1;
		select * into AFT	from garland.CCS_Identifier_New	where rownum = read.aft_rowid;
		this_rowid	:= read.aft_rowid;
		this_id	:= read.aft_id;
		best_score	:= ' ';
		occur		:= 0;
		aft.tax_owner		:= nvl(aft.tax_owner,' ');
		aft.ums_last_name		:= nvl(aft.ums_last_name, ' ');
		aft.ums_first_name	:= nvl(aft.ums_first_name,' ');
	else
		return;
	end if;

	dbms_output.put_line ('-----');

LOOP

	select * into BEF	from garland.CCS_Identifier_New	where rownum = read.bef_rowid;

	score_1 := read.bef_adr + read.bef_lgl;
	if nvl(bef.tax_owner,' ')	 = aft.tax_owner 			then score2 = 1; else score2 = 0; end if;
	if nvl(bef.ums_last_name, ' ') = aft.ums_last_name		then score3 = 1; else score3 = 0; end if;
	if nvl(bef.ums_first_name,' ') = aft.ums_first_name		then score4 = 1; else score4 = 0; end if;

	this_score := score1 || score2 || score3 || score4;

	if	best_score  < this_score  		then
		best_score	:= this_score;
		occur		:= 01;
	elsif	best_score  = this_score  		then
		occur 	:= occur + 01;
	end if;

	if	do_print > 0	then
		dbms_output.put_line (	'aftid: ' ||read.aft_id|| ' befid: '||read.bef_id|| ' this: '||this_score||
						' best: ' ||best_score ||' occur: ' ||occur );
	end if;

	fetch	Read_Address_Legal		into READ;
	if	Read_Address_Legal%notfound	then
		is_eof := 01;
	else
		total_input	:= total_input + 01;
	end if;

	if	this_id < read.aft_id
	or	is_eof = 1				then

		if	occur = 1			then
			total_child	:= total_child + 01;
			this_parent := bef.ccs_id;
		else
			total_parent:= total_parent + 01;
			this_parent := 0;
		end if;

		if	do_update > 0		then
			total_update:= total_update + 01;
			update garland.CCS_Identifier_New
			set	ccs_parent = this_parent
			where	rowid = this_rowid;
		end if;

		if	do_print > 0		then
			dbms_output.put_line ('ccs id: ' ||this_id|| ' ccs parent: '||this_parent||' '||this_rowid );
			dbms_output.put_line ( '-----' );
		end if;

		exit when is_eof = 1;

		select * into AFT	from garland.CCS_Identifier_New	where rownum = read.aft_rowid;
		this_rowid	:= read.aft_rowid;
		this_id	:= read.aft_id;
		best_score	:= ' ';
		occur		:= 0;
		aft.tax_owner		:= nvl(aft.tax_owner,' ');
		aft.ums_last_name		:= nvl(aft.ums_last_name, ' ');
		aft.ums_first_name	:= nvl(aft.ums_first_name,' ');
	end if;

	do_print := do_print - 01;
END LOOP;

	close	Read_Address_Legal;

	COMMIT;

	dbms_output.put_line ( '-----' );
	dbms_output.put_line ( 'Input  CCS Addr Legal = ' || total_input);
	dbms_output.put_line ( 'Assign CCS Parent ID  = ' || total_parent);
	dbms_output.put_line ( 'Assign CCS Child  ID  = ' || total_child);
	dbms_output.put_line ( 'Update CCS Identifier = ' || total_update);

END;

--	=====================================================================
/*

*/
--	=====================================================================


