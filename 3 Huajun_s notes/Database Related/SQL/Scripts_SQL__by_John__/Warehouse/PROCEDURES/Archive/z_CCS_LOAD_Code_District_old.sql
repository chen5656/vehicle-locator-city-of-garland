--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
--	=====================================================================
--	EXCEPTIONS

--	PID=6800200  7120 Wynn Joyce is rental / 1730 Wynn Joyce is not rental

--	=====================================================================

--	execute	garland.CCS_LOAD_CODE_DISTRICT;

	create or replace procedure garland.CCS_LOAD_CODE_DISTRICT		as

--	DECLARE

--	=====================================================================

	compile_only	integer	:= 0;

	total_processed	integer	:= 0;
	title			varchar2(100);
	heading		varchar2(100);
	script		varchar2(2000);

BEGIN
	if	compile_only > 0		then
		return;
	end if;

--	=====================================================================
	title := 'SET CODE DISTRICT  ';
	dbms_output.put_line(title);
--	=====================================================================

--	=====================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = '111'	into garland.plan_table	for
--	=====================================================================

	update garland.ccs_address		C
--	update garland.ccs_address_copy	C
	set	inspector_dist =
(
	select min(decode(is_rental, 1,rental_district, nuisance_district))
	from	garland.code_district		D
	where	d.parcel_id = substr(c.parcel_id,1,7) + 0
)
	where	translate(c.parcel_id,'123456789','000000000') = '0000000.000'
--	and c.inspector_dist is null
	and exists
(
	select '*'
	from	garland.code_district		D
	where	d.parcel_id = substr(c.parcel_id,1,7) + 0
)	;

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'Update total = ' || total_processed);

	COMMIT;

--	=====================================================================
--	select * from garland.explain_Plan;
--	insert into   garland.plan_table (object_owner, object_name) values ('GARLAND', '');
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Analyze;
--	=====================================================================

END;

--	=====================================================================
/*

	select count(*) total from garland.CCS_Address;

	select count(address_id) addressid from garland.CCS_Address;

	select count(parcel_id) parcelid from garland.Code_District;

	select count(inspector_dist) districts from garland.CCS_Address;

	select inspector_dist, count(*) ccs_dist_old
	from garland.CCS_address
	group by inspector_dist;

	select inspector_dist, count(*) ccs_dist_new
	from garland.CCS_address_copy
	group by inspector_dist;

	select nuisance_district, count(*) code_nuis
	from garland.code_district
	group by nuisance_district;

	select rental_district, count(*) code_rent
	from garland.code_district
	group by rental_district;

*/
--	=====================================================================

