
--	DUPLICATE PARCEL IDS ON CDRELPAR

--	show all duplicate parcel id's on cdrelpar
--	and corresponding addresses if one exists


--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for


	select	p.parcel_id, p.mslink
			,addr_num ,addr_pfx ,addr_name ,addr_type ,addr_sfx 
--			,unit_type ,unit_num

	from		cdreladr		a,
			cdrelpar		p

	where		p.parcel_id = a.parcel_id (+)
	and		p.parcel_id in
(
	select 	parcel_id
	from		cdrelpar
	group by	parcel_id
	having	count(*) > 1
)
	order by parcel_id, mslink, addr_name, addr_type, addr_pfx, addr_num;


--	select * from explain_plan;
--	select * from explain_indexed;
--	select * from explain_analyze;


