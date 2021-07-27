
--	display samples of before/after addresses for different verification codes

	set echo	off;
	set timing	off;
	set fetchrows	;

--	select 	count(*)				" "
--	/*
	select	
			 lpad (r.verify_code,3)		" "
			,lpad (a.addr_num,6)		"number"
			,a.addr_pfx				" "
			,a.addr_name			"street"
			,a.addr_type			" "
			,a.addr_sfx				" "
			,a.addr_code			" "
			,a.addr_unit			" "
			,chr(10)				" "
			,lpad (r.verify_code,2)		" "
			,lpad (r.addr_num,6)		"number"
			,r.addr_pfx				" "
			,r.addr_name			" "
			,r.addr_type			" "
			,r.addr_sfx				" "
			,r.addr_code			" "
			,r.addr_unit			" "
			,chr(10)				" "
--	*/

	from		adrResult		r,
			gis_app_addr	a

	where		r.rec_rowid	= a.rowid

	and		r.verify_code between 1 and 44

--	and		r.verify_code not in ( -1, 0, 55, 45)

	order by	r.verify_code, r.addr_name, r.addr_type, r.addr_pfx, r.addr_sfx, r.addr_num;

	set echo	on;
