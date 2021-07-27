	set echo		on;
	set serveroutput	on;
--	=================================================================================

--	analyze table	garland.phone_Verizon		compute statistics;
--	analyze table	garland.phone_SBC			compute statistics;
--	analyze table	garland.CDRELADR			compute statistics;

--	=================================================================================

	drop synonym	garland.temp_syn;
	create synonym	garland.temp_syn		for garland.Phone_VERIZON;

--	=================================================================================

--	drop synonym	garland.temp_syn;
--	create synonym	garland.temp_syn		for garland.Phone_SBC;

--	=================================================================================

declare

	compile_only	integer := 0;
	total_update	integer := 0;
	this_parcelid	number  := 0;
	this_count		number  := 0;
	this_zip_code	varchar2(10);
	this_table		varchar2(30);


cursor  READ_PHONE	is

	select parcel_id parcelid, rowid row_id  from garland.Temp_Syn;

begin

	if	compile_only > 0		then
		return;
	end if;

for read in READ_PHONE		loop

	if	read.parcelid > this_parcelid		then
		this_parcelid := read.parcelid;
		
		select min(zip_code), count(zip_code)
		into	this_zip_code,
			this_count
		from	garland.cdrelpar
		where parcel_id_new = this_parcelid;

--		dbms_output.put_line ( this_zip_code ||'.'|| this_count); 
	end if;

	if	this_count > 0
	and	this_zip_code > '75000'		then
		update garland.Temp_Syn
		set	zip_code	= this_zip_code
		where	rowid		= read.row_id;
		
		total_update := total_update + 01;
	end if;

end loop;

	Commit;

	select table_name
	into	 this_table
	from	 all_synonyms
	where	 synonym_name = 'TEMP_SYN'
	and	 owner = 'GARLAND';

	dbms_output.put_line ('Total Zip Codes assigned for ' || this_table || ':   ' || total_update);

	select count(*) into this_count from garland.Temp_Syn;
	dbms_output.put_line ('Total Records ' || this_count );

end;
