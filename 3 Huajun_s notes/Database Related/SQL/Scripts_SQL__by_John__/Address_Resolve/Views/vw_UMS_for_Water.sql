	set echo off;
--	=========================================================
--	adrResult_User = UMS Location
--	=========================================================

	create or replace	view	garland.adrResult_User		As

	Select
		l.location_no			rec_key,
		null					rec_rowid,

		ltrim(rtrim(house_no))		addr_num,
		rtrim(street_pfx_dir)		addr_pfx,
		rtrim(street_nm)			addr_name,
		rtrim(street_nm_sfx)		addr_type,
		rtrim(street_sfx_dir)		addr_sfx,

		rtrim(sec_addr_id)		addr_code1,
		rtrim(sec_addr_range)		addr_unit1,
		null					addr_code2,
		null					addr_unit2

	from	sfg.um00250t@umsrep.world		X,	-- crossref
		sfg.um00100m@umsrep.world		L,	-- location
		sfg.um00140t@umsrep.world		S	-- install service

	where	x.location_no = l.location_no
	and	x.location_no = s.location_no
	and	x.service_seq = s.serv_seq

	and	x.effective_dt	in
(
	select max(effective_dt)
	from	sfg.um00250t@umsrep.world
	where	location_no	 = x.location_no
)							

	and	ltrim(l.city)	like 'G%'
	and	s.service_tp	= 'WTR'

	and	l.location_stat	= 'ACT'
--	and	x.service_stat	= 'CUTON'

	and	rtrim		(l.sec_addr_id)		is null
	and	rtrim(ltrim	(l.sec_addr_range))	is null


	and	street_nm not like 'FLOATING%'
	and	street_nm not like 'FIRE HYDRANT%'
	and	translate (house_no, '/1234567890 ', '/') is null		-- TEMPORARY
	;

--	=================================================================================
