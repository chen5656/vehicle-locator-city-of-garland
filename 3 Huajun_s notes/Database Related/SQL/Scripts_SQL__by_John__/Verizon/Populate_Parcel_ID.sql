	set echo 		off;
	set serveroutput	on	size 9999;
--	==================================================================
--	Push adrResult Parcel ID into Verizon_Info Parcel ID
--	Join adrResult Rec_Key = Verizon Phone 
--	==================================================================
/*
	drop synonym	garland.temp_syn1;
	create synonym	garland.temp_syn1		for garland.adrResult_VERIZON;
	drop synonym	garland.temp_syn2;
	create synonym	garland.temp_syn2		for garland.phone_VERIZON;
*/
--	==================================================================

	drop synonym	garland.temp_syn1;
	create synonym	garland.temp_syn1		for garland.adrResult_VERIZON_SBC;
	drop synonym	garland.temp_syn2;
	create synonym	garland.temp_syn2		for garland.phone_SBC;

--	==================================================================

declare

	compile_only	integer	:= 0;
	update_count	integer	:= 0;


cursor	read_Verizon_GIS		is

	select * from garland.temp_syn1 where verify_code = 55;

begin

	if	compile_only > 0		then
		return;
	end if;

for	read in Read_Verizon_GIS	loop

	update garland.temp_syn2
	set	parcel_id = garland.Convert_Old_Parcelid(read.Parcel_ID)
	where	phone = read.rec_key;

	update_count := update_count + 01;

end loop;

	Commit;

	dbms_output.put_line ( 'Total Updates: ' || update_count);

end;

