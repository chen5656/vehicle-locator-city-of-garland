	set  echo	off;
--	======================================================================================================

--	@c:\deacutis\scripts\departments\utility_conversion\name\Build_Name_Cases_New.sql;

--	======================================================================================================

	select rpad(v.new_table,12) "new", rpad(m.tablename,12) "mge", rpad(m.entitynum,08) " ", rpad(m.nextocc,08) " "
	from	mscatalog		m,
		temp_view 		v
	where v.new_table = upper(m.tablename (+))
	order by 1;

--	======================================================================================================

	select rpad(v.old_table,12) "old", rpad(m.tablename,12) "mge", rpad(m.entitynum,08) " ", rpad(m.nextocc,08) " "
	from	mscatalog		m,
		temp_view 		v
	where v.old_table = upper(m.tablename (+))
	order by 1;

--	======================================================================================================

	select rpad(m.tablename,12) "mge", rpad(m.entitynum,08) " ", rpad(m.nextocc,08) " "
	from	mscatalog		m
	where	lower(tablename) like 'ut%'
	and	not exists
(
	select 'x'
	from	 garland.temp_view
	where	 new_table = upper(m.tablename)
	or	 old_table = upper(m.tablename)
)
	order by 1;

--	======================================================================================================
	set  echo	on;
