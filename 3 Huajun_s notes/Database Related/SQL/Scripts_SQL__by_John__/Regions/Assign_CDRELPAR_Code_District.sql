	set echo off;
--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = 'beat'	into garland.plan_table	for

	update garland.CDRELPAR		P
	set	code_inspect_area = 
(
	select	district
	from		garland.Code_District
	where		parcel_id = garland.convert_old_parcelid (p.parcel_id)
)
	where		translate (p.parcel_id, '/.0123456789', '/') is null;

--	select * from garland.explain_Plan;

--	=================================================================================

	select count(code_inspect_area)	from garland.cdrelpar;

	select distinct code_inspect_area	from garland.cdrelpar 
	order by lpad(code_inspect_area,2,'0');


--	=================================================================================

	savepoint	xxx;	
--	Rollback;
	Commit;

--	=================================================================================
/*	Code Districts

1 
2 
3 
4 
5 
6 
7 
8 
9 
10
21
22
23
24
25

*/
--	=================================================================================
	set echo on;

