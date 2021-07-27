	set echo off;
--	====================================================================
--	see Sample runs at the bottom
--	====================================================================

--	drop function	garland.Convert_ParcelID_11_7;


	create or replace function	garland.Convert_Old_ParcelID	(Parcel_ID  varchar2)

						Return  Number
	As
		ParcelID		varchar2(20);
		Parcel_X		varchar2(20);
		Parcel_9		number;
		locate		binary_integer;

	begin
		parcelid	:= parcel_id;	
		parcelid	:= translate (parcelid, ',/-_', '........');

		locate	:= instr(parcelid, '.');
		if	locate > 0			then	
			parcel_x	:= substr(parcelid, 1, locate - 1);
		else
			parcel_x	:= parcelid;
		end if;

		if	parcel_x like '4A%'	then
			parcel_x	:= replace (parcel_x, '4A', '89');
		end if;

		if	translate (parcel_x, '/1234567890', '/') is null	then
			parcel_9	:= parcel_x;
		else
			parcel_9	:= -1;
		end if;
		
		return parcel_9;
	end;

--	====================================================================
/*

	select rpad(garland.convert_parcelid_11_7 ('1234567.000')	,80)	from dual;
	select rpad(garland.convert_parcelid_11_7 ('1234567/000')	,80)	from dual;
	select rpad(garland.convert_parcelid_11_7 ('1234567')		,80)	from dual;
	select rpad(garland.convert_parcelid_11_7 ('12345')		,80)	from dual;
	select rpad(garland.convert_parcelid_11_7 ('012345.00')	,80)	from dual;
	select rpad(garland.convert_parcelid_11_7 ('12345678')	,80)	from dual;

	select rpad(garland.convert_parcelid_11_7 ('4A12345.000')	,80)	from dual;
	select rpad(garland.convert_parcelid_11_7 ('4A1234567.000')	,80)	from dual;
	select rpad(garland.convert_parcelid_11_7 ('4A1234.')		,80)	from dual;
	select rpad(garland.convert_parcelid_11_7 ('114A123.000')	,80)	from dual;

*/
--	====================================================================

