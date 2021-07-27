	set echo	off;

--	truncate table	plan_table;
--	explain plan	set statement_id = 'a'		for

--	=======================================================
--	check for nulls  (other than title record)
	
	select count(*) from adrResult
	where	do_alias is null or do_name is null or do_qual is null;
	
	select count(*) from adrResult
	where	addr_pfx  is null or addr_sfx  is null or addr_type is null
	or	addr_code is null or addr_unit is null;
	
	select count(*) from adrResult
	where	form_pfx  is null or form_sfx  is null or form_type is null
	or	form_code is null or form_unit is null;

--	=======================================================
--	does uncorrected parsed address really match cdreladr

--	select count(*)	
	select *
	from adrResult	r

	where verify_code 	= 55
	and nvl(do_qual, ' ') = ' '
	and nvl(do_name, ' ') = ' '
	and nvl(do_alias,' ') = ' '	
	and not exists
(
	select 'x'	from cdreladr
	where addr_num	= r.addr_num 
	and addr_name	= r.form_name 
	and addr_pfx	= r.form_pfx
	and addr_type	= r.form_type
	and addr_sfx	= r.form_sfx
);

--	=======================================================

--	select * from explain_plan;

--	=======================================================
	set echo	on;
