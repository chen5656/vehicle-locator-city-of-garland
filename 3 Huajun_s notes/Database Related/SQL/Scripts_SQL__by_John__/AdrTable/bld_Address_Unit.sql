	set echo	off;
--	===========================================================================
--	desc address_unit;
--	desc adrResult_Census_Unit;


--	===========================================================================
--	add Census_Units  to Address_Units

--	alter rollback segment rb1 online;
--	commit;
--	set transaction use rollback segment rb1;

--	select count(*) from

	insert into address_unit
(
	select addr_num, addr_pfx, addr_name, addr_type, addr_sfx, addr_code1, addr_unit1,
		 ' ',' ',	null,null,	null
	from	garland.adrResult_Census_Unit
	where	rec_seq <> 16951			-- 833 Rockledge Dr  Apt FRNT_OF

	minus

	select rtrim(addr_num), addr_pfx, addr_name, addr_type, addr_sfx, addr_bldg1, addr_unit1,
		 ' ',' ',	null,null,  null
	from	garland.address_unit
);


--	ROLLBACK;
	commit;
--	alter rollback segment rb1 offline;

--	=========================================================================
--	define view on temp table to contain adrResult_Census_Units

	create or replace view	garland.temp_view
	(	addr_name, addr_type, addr_pfx, addr_sfx, addr_num,
		addr_code1, addr_unit1, parcel_id)
	as	select item01, item02, item03, item04, item05, 
			 item06, item07, item08
	from	garland.gis_objects;

--	=========================================================================
--	load adrResult Census Units

	truncate table	garland.gis_objects	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

	insert into garland.temp_view
	select addr_name,  addr_type,  addr_pfx, addr_sfx, addr_num,
		 addr_code1, addr_unit1, 
		 max(parcel_id)
	from	garland.adrResult_Census_Unit
	group by	addr_name, addr_type, addr_pfx, addr_sfx, addr_num,
		 	addr_code1, addr_unit1
	; 

--	ROLLBACK;
	commit;
	alter rollback segment rb1 offline;


--	=========================================================================
--	update Census Units with adrResult Census Unit Parcel ID

	truncate table	plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	explain plan	set statement_id = 'xxx'   for

	update garland.address_unit		u
	set	parcel_id =
(
	select parcel_id
	from	garland.temp_view			v
	where	v.addr_name		= u.addr_name
	and	v.addr_type		= u.addr_type
	and	v.addr_pfx		= u.addr_pfx
	and	v.addr_sfx		= u.addr_sfx
	and	v.addr_num		= u.addr_num
	and	v.addr_code1	= u.addr_bldg1
	and	v.addr_unit1	= u.addr_unit1
)
	where exists
(
	select 'x'
	from	garland.temp_view			v
	where	v.addr_name		= u.addr_name
	and	v.addr_type		= u.addr_type
	and	v.addr_pfx		= u.addr_pfx
	and	v.addr_sfx		= u.addr_sfx
	and	v.addr_num		= u.addr_num
	and	v.addr_code1	= u.addr_bldg1
	and	v.addr_unit1	= u.addr_unit1
);

--	ROLLBACK;
	commit;
	alter rollback segment rb1 offline;

--	select * from explain_plan;


--	=========================================================================
	set echo	on;


--	===========================================================================
/*	Find oversized address column values

	select
		max(length(addr_name)),
		max(length(addr_type)),
		max(length(addr_pfx)),
		max(length(addr_sfx)),
		max(length(addr_code1)),
		max(length(rtrim(addr_unit1)))

	from	garland.adrResult_Census_Unit;

	select *
	from	garland.adrResult_Census_Unit
	where length(addr_unit1) = 11;

*/

--	===========================================================================

	select count(*) from garland.address_unit;

--	===========================================================================
	set echo	on;

