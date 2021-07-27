	set echo	off;
	set timing	off;
--	===========================================================================

	truncate table	address_unit	reuse storage;

	alter table		address_unit	disable primary key;

--	===========================================================================
--	truncate table	garland.plan_table	reuse storage;
--	insert into	garland.plan_table (object_name,object_owner) values ( '' , '' );

--	alter rollback segment rb1 online;
--	commit;
--	set transaction use rollback segment rb1;

--	===========================================================================
--	explain plan set statement_id =	'aaa'		into garland.plan_table	for

	insert into	address_unit
	select	distinct
			r.addr_num,   r.addr_pfx,   r.addr_name,  r.addr_type,  r.addr_sfx,
			r.addr_code1, r.addr_unit1, r.addr_code2, r.addr_unit2,

			a.x_coord,
			a.y_coord,
			a.parcel_id

	from		garland.cdreladr				a,

			garland.temp_view				r
--			garland.adrResult				r
--			garland.adrResult_UMS_location	r	

	where		r.parcel_id		= a.parcel_id	
	and		r.addr_name		= a.addr_name
	and		r.addr_type		= a.addr_type
	and		r.addr_pfx		= a.addr_pfx
	and		r.addr_sfx		= a.addr_sfx
	and		r.addr_num		= a.addr_num 

	and		r.addr_code1		in ( 'APT', 'STE', 'BLDG')
	and		nvl(r.addr_unit1,' ')	not like '@%'
	and		nvl(r.addr_unit1,' ')	not like '&%'

	and		r.addr_unit1	> '!'
	and		rtrim(r.addr_code2) is null	

	order by	r.addr_name,  r.addr_type,  r.addr_pfx,	r.addr_sfx,	r.addr_num,   
			r.addr_code1, r.addr_unit1, r.addr_code2, r.addr_unit2;

--	===========================================================================
--	explain plan set statement_id =	'bbb'		into garland.plan_table	for

	insert into	address_unit

	select	distinct
			nvl(r.addr_num,   0 )	addr_num,   
			nvl(r.addr_pfx,  ' ')	addr_pfx,   
			nvl(r.addr_name, ' ')	addr_name,  
			nvl(r.addr_type, ' ')	addr_type,  
			nvl(r.addr_sfx,  ' ')	addr_sfx,
			nvl(r.addr_unit1,' ')	addr_code1,  
			' ', ' ', ' ',	

			a.x_coord,
			a.y_coord,
			a.parcel_id

	from		garland.cdreladr				a,

			garland.temp_view				r
--			garland.adrResult				r
--			garland.adrResult_UMS_location	r	

	where	r.parcel_id		= a.parcel_id	
	and	r.addr_name		= a.addr_name
	and	r.addr_type		= a.addr_type
	and	r.addr_pfx		= a.addr_pfx
	and	r.addr_sfx		= a.addr_sfx
	and	r.addr_num		= a.addr_num 

	and (	addr_unit1		like 'SPRIN%'	
	or	addr_unit1		like 'CLUB%'	
	or	addr_unit1		like 'SANI%'	
	or	addr_unit1		like 'SIGN%'	
	or	addr_unit1		like 'IRR%'	
		)

	and	r.addr_code1	not in ( 'APT', 'STE', 'BLDG')
	and	substr(addr_unit1,2,1) <>  '/'

	order by	3,4,2,5,1;

--	===========================================================================
--	explain plan set statement_id =	'ccc'		into garland.plan_table	for

	insert into	address_unit
	select	distinct
			r.addr_num,	  r.addr_pfx,   r.addr_name,  r.addr_type,  r.addr_sfx,

			rtrim (
			addr_unit1				||
			replace (addr_code2, '#')	|| ' '||
			addr_unit2	)					addr_code1,

			' ',' ',' ',

			a.x_coord,
			a.y_coord,
			a.parcel_id

	from		garland.cdreladr				a,

			garland.temp_view				r
--			garland.adrResult				r
--			garland.adrResult_UMS_location	r	

	where		r.parcel_id		= a.parcel_id	
	and		r.addr_name		= a.addr_name
	and		r.addr_type		= a.addr_type
	and		r.addr_pfx		= a.addr_pfx
	and		r.addr_sfx		= a.addr_sfx
	and		r.addr_num		= a.addr_num 

	and		substr(addr_unit1,2,1) = '/'

	and		length (rtrim (
			addr_unit1				||
			replace (addr_code2, '#')	|| ' '||
			addr_unit2	) ) 	<= 10

	order by	r.addr_name, r.addr_type, r.addr_pfx, r.addr_sfx, r.addr_num, addr_code1;  

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_constraint;
--	select * from garland.explain_column;
--	select * from garland.explain_analyze;
--	===========================================================================

	commit;
--	alter rollback segment rb1 offline;

--	===========================================================================

	@c:\deacutis\scripts\adrTable\address_unit\delete_address_unit.sql;

	@c:\deacutis\scripts\adrTable\address_unit\parse_address_unit.sql;

--	===========================================================================

	alter table		address_unit	enable primary key;

--	===========================================================================

	select count(*) "Total"	
	from	garland.address_unit;

	select distinct 
		 addr_bldg1 
--		,addr_unit1 
		,addr_bldg2
--		,addr_unit2
	from	garland.address_unit
	order by 1,2;

--	===========================================================================
/*

	select distinct	
		addr_bldg1, addr_unit1, 
		addr_bldg2, addr_unit2
	from	garland.address_unit
	order by 1,2,3,4;

--	--------------------------------------------------------

	select distinct
		 rpad(appl_code1,10) " " 
		,rpad(appl_unit1,10) " "
		,rpad(appl_code2,10) " " 
		,rpad(appl_unit2,10) " "
	from	temp_view
--	from	adrResult

--	where	substr(appl_code1,2,1) = '/'
--	or	substr(appl_unit1,2,1) = '/'
--	or	substr(appl_code2,2,1) = '/'
--	or	substr(appl_unit2,2,1) = '/'

	order by 1,2,3,4;
*/
--	===========================================================================
