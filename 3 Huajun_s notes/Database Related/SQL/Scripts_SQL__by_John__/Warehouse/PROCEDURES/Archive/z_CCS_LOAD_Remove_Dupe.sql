--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 99999;
set linesize	400;
set pagesize	999;
--	=====================================================================
--	Clean up CCS ADDRESS
--	Remove duplicates:     Address + Tax Owner + Ums Tenant
--	Keep the record with the highest Tax Id + Ums Id
--	Specify CCS_ADDRESS or CCS_ADDRESS_TEST    <<<<<<<<<<<<<<<<<<<<<<<
--	=====================================================================

--	=====================================================================

--	execute	garland.CCS_LOAD_Remove_Dupe;

	create or replace procedure garland.CCS_LOAD_Remove_Dupe	as

--	DECLARE

--	=====================================================================

	compile_only	integer := 0;
	delete_mode		integer := 01;
	print_max		integer := 0;

	bef_total		integer := 0;
	aft_total		integer := 0;
	dupe_total		integer := 0;
	delete_count	integer := 0;
	dupe_count		integer;
	prev_keys		varchar2(400);
	prev_ids		varchar2(400);

--	=========================================================================================

cursor Read_CCS_Keys	is

	select	
		addr_name  ||';'|| addr_type	||';'|| addr_prefix   ||';'|| addr_suffix ||';'|| addr_number ||'//'|| 
		tax_legal_desc ||';'|| tax_owner  ||';'|| ums_last_name ||';'|| ums_first_name	KEYS,
		address_id ||'.'|| tax_account ||'.'|| ums_id							IDS, 
		rowid														ROW_ID
	from	garland.CCS_ADDRESS_NEW
	where	ltrim(addr_unit) is null
	order by 1;

--	=========================================================================================
begin

	if	compile_only > 0	then
		return;
	end if;

	dbms_output.put_line ('-------');
	dbms_output.put_line ('CCS ADDRESS DUPE: Address // Tax Legal.Tax Owner.Ums Tenant ');

for	read in read_CCS_Keys			loop
	
	bef_total	:= bef_total + 01;

	if	read.keys = prev_keys		then
		dupe_count	:= dupe_count  + 01;

		if	dupe_count = 1		then
			dupe_total := dupe_total + 01;
			if	print_max > 0		then
				dbms_output.put_line ('------------------');
				dbms_output.put_line (prev_keys ||'//'|| prev_ids);
			end if;
		end if;

		print_max	:= print_max - 01;
		if	print_max > 0		then
			dbms_output.put_line (read.keys ||'//'|| read.ids);
		end if;

		if	delete_mode > 0		then
			delete from garland.CCS_ADDRESS_NEW  where rowid = read.row_id;
			delete_count := delete_count + 01;
		end if;

	else
		prev_keys 	:= read.keys;
		prev_ids 	:= read.ids;
		dupe_count	:= 0;
	end if;
		
end loop;

	COMMIT;

	select count(*) into aft_total from garland.ccs_address;

	dbms_output.put_line ( '-------');
	dbms_output.put_line ( 'Total Before:      '  || bef_total);
	dbms_output.put_line ( 'Total Dupe Occurs: '  || dupe_total);
	dbms_output.put_line ( 'Total Deletes:     '  || delete_count);
	dbms_output.put_line ( 'Total After:       '  || aft_total);
end;

