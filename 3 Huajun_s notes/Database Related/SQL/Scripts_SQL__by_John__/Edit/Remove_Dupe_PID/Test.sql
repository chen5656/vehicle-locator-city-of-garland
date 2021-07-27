
	set echo off;

	truncate table	plan_table;
	explain plan	set statement_id = 'aaa'	for

--	================================================================================

--	select count(*) 
--	select distinct mslink, council_id
--	from	cdrelpar		p
--	where	p.council_id =

	update cdrelpar		p
	set	 p.council_id =

--	================================================================================

(
	select	decode (council_id, null, p.council_id, council_id)
	from
(
	select	parcel_id, 
			max(council_id) 	council_id
	from
(
	select	parcel_id, council_id
	from		cdrelpar
	where		council_id > '0'
	and		parcel_id in
(
	select 	parcel_id
	from		cdrelpar
	group by	parcel_id
	having	count(*) > 1
)
)
	group by	parcel_id
	having	count (distinct  council_id) = 1
)
	where		parcel_id = p.parcel_id
)


--	----------------------------------	
--	minus
--	select	mslink, council_id	
--	from		cdrelpar
--	----------------------------------	
;

--	================================================================================

	select * from explain_plan;

	rollback;
