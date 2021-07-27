--	====================================================================================

	Need to put asbuilt_date into new utility tables
	Old backup  tables contain mslink & asbuilt_dates
	New utility tables contain mslink

--	====================================================================================


	x.	clone old/new table ref
		old = backup    new = new

	x.
		create temp_view (old_table, new_table, column_name)
	
		insert into gis_temp	(old table name, new table name, old column_name)

		from	old/new ref table
			cols

		where old column like '%BUILT%'


	x.	sql generator
		use  temp view

		alter table  <new table>  add <column name>   varchar2(10);


	x.	sql generator
		use temp_view

		set transaction for large rollback segment

		update <new table> n  set <column name> =
		(select <column name> from <old table> o where o.mslink = n.mslink);


