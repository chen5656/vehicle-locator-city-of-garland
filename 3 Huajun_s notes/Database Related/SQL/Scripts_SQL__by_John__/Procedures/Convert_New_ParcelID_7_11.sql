	set echo off;
--	====================================================================
--	See Sample test runs at the bottom
--	====================================================================

--	drop function	garland.Convert_ParcelID_7_11;

	create or replace function	garland.Convert_New_ParcelID	(Parcel_ID  Number)
	
						Return  Varchar2

	As
		ParcelID	varchar2(20);
		Parcel_9	number;
		Parcel_X	varchar2(20);
		width		binary_integer;

	begin
		parcelid	:= parcel_id;
		width		:= length(parcelid);

		if	parcelid like '89%'	then
			parcel_x	:= '4A' || substr(parcelid,3,5) || '.000';

		elsif	width <= 7			then
			parcel_x	:= lpad(parcelid, 07, '0') || '.000';
		else
			parcel_x	:= parcelid;
		end if;


		return	parcel_x;
	end;

--	====================================================================
/*

	select garland.convert_parcelid_7_11 (1234567)	from dual;
	select garland.convert_parcelid_7_11 (12345)	from dual;
	select garland.convert_parcelid_7_11 (0012345)	from dual;
	select garland.convert_parcelid_7_11 (12345678)	from dual;

	select garland.convert_parcelid_7_11 (8912345)	from dual;
	select garland.convert_parcelid_7_11 (891234)	from dual;
	select garland.convert_parcelid_7_11 (89123456)	from dual;
	select garland.convert_parcelid_7_11 (1189123)	from dual;

*/
--	====================================================================
