	set echo	on;
--	=====================================================================
--	Compare & Correct Street table against Address & Centerline tables

--	NEW		Street table may need a new street name
--	WRONG		Street table may have a similar but mis-spelled street name
--	STREET	Street table may need a new street for an old street name

--	=====================================================================

--	********    I N S U R E   S T R E E T   B A C K U P   E X I S T S

--	=====================================================================

	variable	 use_centerline	varchar2(10);	
	variable	 do_new		varchar2(10);	
	variable	 do_wrong		varchar2(10);	
	variable	 do_street		varchar2(10);	

	execute	:use_centerline	:= '1';		--	yes
--	execute	:use_centerline	:= null;		--	no

	execute	:do_new		:= '1';		--	execute
	execute	:do_new		:= null;		--	suppress

	execute	:do_wrong		:= '1';		--	execute
	execute	:do_wrong		:= null;		--	suppress

	execute	:do_street		:= '1';		--	execute
	execute	:do_street		:= null;		--	suppress


	truncate table	garland.plan_table	reuse storage;

--	=====================================================================
/*
	truncate table	garland.gis_objects	reuse storage;

--	alter rollback segment rb1	online;
--	commit;
--	set transaction	use rollback segment  rb1;

	insert into garland.gis_objects (item01, item02, item03, item04, item05)
	select all *	
	from
(
	select adr_compress_name (addr_name, 01),
		 addr_name, addr_type, addr_pfx, addr_sfx
	from	 garland.cdreladr

	union
	select adr_compress_name (addr_name, 01),
		 addr_name, addr_type, addr_pfx, addr_sfx
	from	 garland.trvehrcl
	where	addr_name > :use_centerline
);

	commit;
--	alter rollback segment rb1	offline;
*/

--	=================================================================
--	Street View1

	drop view	temp_view1;

	create view	temp_view1		as
	select	addr_reduced,
			addr_name, addr_type, addr_pfx, addr_sfx
--	from		adrStreets
	from		adrStreet
	;

--	=================================================================
--	Address & Centerline View2

	drop view	temp_view2;

	create view temp_view2 
	(
			addr_reduced, 
			addr_name, addr_type, addr_pfx, addr_sfx
	)
	as select	item01, 
			item02, item03, item04, item05
	from		garland.gis_objects;

--	=================================================================
--	NEW NAME

	drop view	temp_view3;
	create view	temp_view3		as

--	explain plan set statement_id = 'show new'  for

	select	addr_reduced,
			addr_name, addr_type, addr_pfx, addr_sfx 
	from		temp_view2		v2
	where		not exists
(
	select 'x'
	from	temp_view1		v1
	where	v1.addr_reduced = v1.addr_reduced
);

--	------------------------------------------------------------------

	select distinct 'NEW NAME', addr_name 
	from temp_view3;

--	------------------------------------------------------------------

	explain plan set statement_id = 'insert name'  for

	insert into	garland.adrStreets
	select	addr_pfx, addr_name, addr_type, addr_sfx,
			0,								--  sequence

			adr_compress_name (addr_name, 06),
			adr_compress_name (addr_name, 04),
			addr_reduced,

			substr (addr_name, 1, instr(addr_name, adr_name_ending(addr_name)) - 1 ),
			adr_name_ending		(addr_name),	
			soundex			(addr_name),
			adr_permute_name		(addr_name,	'1')

	from		temp_view3
	where		addr_name > :do_new;

--	=================================================================
--	WRONG NAME

	drop view	temp_view3;
	create view	temp_view3		as

--	explain plan set statement_id = 'show wrong'  for

	select	v1.addr_reduced, 
			v1.addr_name  STR	,
			v2.addr_name  GOOD,  v2.addr_type, v2.addr_pfx, v2.addr_sfx
	from		temp_view1		v1,
			temp_view2		v2
	where	v1.addr_reduced	=  v2.addr_reduced
	and	v1.addr_name	<> v2.addr_name;

--	------------------------------------------------------------------

	select distinct 'WRONG NAME', STR, GOOD 
	from temp_view3;

--	------------------------------------------------------------------

	explain plan set statement_id = 'update name'  for

	update garland.adrStreets		s
	set	addr_name = 
(
		select	addr_name
		from		temp_view2
		where		addr_reduced = s.addr_reduced
		and		addr_name	<> s.addr_name
)
	where	addr_name > :do_wrong
	and exists
(
		select	'x'
		from		temp_view2
		where		addr_reduced = s.addr_reduced
		and		addr_name	<> s.addr_name
);

--	=================================================================
--	NEW STREET

	drop view	temp_view3;
	create view	temp_view3		as

--	explain plan set statement_id = 'show street'  for

	select	v2.addr_reduced  adr_reduced,
			v1.addr_name str_name,  v1.addr_type str_type, v1.addr_pfx str_pfx, v1.addr_sfx str_sfx,
			v2.addr_name adr_name,  v2.addr_type adr_type, v2.addr_pfx adr_pfx, v2.addr_sfx adr_sfx
	from		temp_view1		v1,
			temp_view2		v2

	where	v1.addr_name	=  v2.addr_name
	and not exists
(
	select 'x'
	from	 temp_view1		
	where	addr_name	=	v2.addr_name
	and	addr_type	=	v2.addr_type
	and	addr_pfx	=	v2.addr_pfx
	and	addr_sfx	=	v2.addr_sfx
);

--	------------------------------------------------------------------

	select 'NEW STREET', chr(10),
			rpad(str_pfx,02), rpad(str_name,20), rpad(str_type,04), rpad(str_sfx,02), chr(10),
			rpad(adr_pfx,02), rpad(adr_name,20), rpad(adr_type,04), rpad(adr_sfx,02), chr(10)
	from	temp_view3;

--	------------------------------------------------------------------

	explain plan set statement_id = 'insert street'  for

	insert into	garland.adrStreets
	select	adr_pfx, adr_name, adr_type, adr_sfx,
			0,								--  sequence

			adr_compress_name (adr_name, 06),
			adr_compress_name (adr_name, 04),
			adr_reduced,

			substr (adr_name, 1, instr(adr_name, adr_name_ending(adr_name)) - 1 ),
			adr_name_ending		(adr_name),	
			soundex			(adr_name),
			adr_permute_name		(adr_name,	'1')

	from		temp_view3
	where		adr_name > :do_street;

--	=================================================================

	select * from explain_plan;

--	=================================================================

	ROLLBACK;
	commit;

--	=================================================================


/*
--	=================================================================

	select	addr_name, addr_type, addr_pfx, addr_sfx
	from		temp_view2
	minus
	select	addr_name, addr_type, addr_pfx, addr_sfx
	from 		temp_view1

-------------------------------------------------------------------------------- ------- -------
                                                                                    cost    rows
-------------------------------------------------------------------------------- ------- -------
..Select.State................Show.New..........................................      35   65875
...Filter.......................................................................                
03..Table.Access..............Full..............Gis_Objects.....................      35   65875
....Index.....................Full.Scan.........Adrstreet_X_Reduced...Non-Unique      14    2363


..Select.State................Show.Street.......................................      45    2363
...Filter.......................................................................                
....Hash.Join...................................................................      45    2363
.....Index....................Fast.Full.Scan....Adrstreet_Pkey........Unique....       2    2363
04...Table.Access.............Full..............Gis_Objects.....................      35    3294
....Index.....................Unique.Scan.......Adrstreet_Pkey........Unique....       1       1


..Select.State................Show.Wrong........................................     111    1211
...Hash.Join....................................................................     111    1211
04..Table.Access..............Full..............Adrstreet.......................       4    2363
03..Table.Access..............Full..............Gis_Objects.....................      35   65875

-------------------------------------------------------------------------------- ------- -------

..Insert.State................Insert.Name.......................................      35    3294
...Filter.......................................................................                
05..Table.Access..............Full..............Gis_Objects.....................      35    3294
....Index.....................Full.Scan.........Adrstreet_X_Reduced...Non-Unique      14    2363


..Insert.State................Insert.Street.....................................      38     119
...Filter.......................................................................                
....Hash.Join...................................................................      38     119
.....Index....................Range.Scan........Adrstreet_Pkey........Unique....       2     119
06...Table.Access.............Full..............Gis_Objects.....................      35     165
....Index.....................Unique.Scan.......Adrstreet_Pkey........Unique....       1       1


..Update.State................Update.Name.......................................       3       6
...Update.......................................Adrstreets......................                
....Filter......................................................................                
01...Table.Access.............By.Index.Rowid....Adrstreets......................       3       6
......Index...................Range.Scan........Adrstreets_Pkey.......Unique....       2       6
05...Table.Access.............By.Index.Rowid....Gis_Objects.....................       2       2
......Index...................Range.Scan........Gis_Objects_X_Key.....Non-Unique       1       2
04.Table.Access...............By.Index.Rowid....Gis_Objects.....................       2       2
....Index.....................Range.Scan........Gis_Objects_X_Key.....Non-Unique       1       2

-------------------------------------------------------------------------------- ------- -------
*/
