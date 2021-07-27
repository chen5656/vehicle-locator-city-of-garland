
--	display app addresses per gis_app_rowid


	select --+ rule 

		r.row_seq, a.*

	from	gis_app_rowid	r,
		gis_app_addr	a
	
	where	a.rowid = r.row_id

	and	r.row_seq < 111

	order by r.row_seq;

