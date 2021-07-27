	
	create or replace view	cdreladr_dupe_parcels		as

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'	for

	select	distinct
			p.parcel_id,
			addr_num,
			addr_pfx,
			addr_name,
			addr_type,
			addr_sfx,
			arcview_x,
			arcview_y

	from		cdreladr	a,
			cdrelpar	p

	where		a.parcel_id	= p.parcel_id
	and		a.parcel_id		in
(
	select	parcel_id
	from		cdreladr
	where		nvl (lower (rtrim (addr_status)), ' ') <> 'd'
	group by 	parcel_id
	having	count(*) > 1
)

--	order by	p.parcel_id,
--			a.addr_name,
--			a.addr_type,
--			a.addr_num,
--			a.addr_num
	;

--	@c:\deacutis\scripts\plans\exhibit.sql;

