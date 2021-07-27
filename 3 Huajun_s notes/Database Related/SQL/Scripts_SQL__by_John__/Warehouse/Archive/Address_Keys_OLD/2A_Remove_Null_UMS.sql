	set echo 		off;
	set serveroutput	on;
--	=======================================================================================
--	Purge Common Address Keys of null UMS keys
--	If GIS & TAX keys correspond to UMS key, then delete GIS & TAX keys with null UMS key.
--	=======================================================================================

declare

	compile_only	integer	:= 0;
	do_delete		integer	:= 0;
	delete_count	integer	:= 0;

	gis_id		number;
	tax_id		number;

cursor	Read_Common_Key		is

	select gis_key, tax_key, ums_key, rowid row_id
	from	garland.COMMON_ADDRESS_KEYS
	where (gis_key, tax_key)   in
(
	select gis_key, tax_key
	from	garland.COMMON_ADDRESS_KEYS
	group by gis_key, tax_key
	having count(*) > 1
)
	order by 1, 2, 3;

begin

	if	compile_only > 0		then
		return;
	end if;

for	read in Read_Common_Key		loop

	if	read.gis_key	= gis_id
	and	read.tax_key	= tax_id
	and	read.ums_key	is null		then
		
		delete_count := delete_count + 01;

		if	do_delete > 0			then
			delete from	garland.COMMON_ADDRESS_KEYS
			where rowid = read.row_id;
		end if;

	end if;

	gis_id := read.gis_key;
	tax_id := read.tax_key;

end loop;

	dbms_output.put_line ( 'Total UMS Deletes: ' || delete_count);

end;
