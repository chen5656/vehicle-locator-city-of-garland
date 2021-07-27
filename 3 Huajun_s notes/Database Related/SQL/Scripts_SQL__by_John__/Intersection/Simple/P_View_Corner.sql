	set echo off;
--	===========================================================================================

	select 'CORNER VIEW  ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;

--	===========================================================================================

	create or replace view	garland.Temp_View1		as

	select

		item01		Addr1_Name,
		item02		Addr1_Type,
		item03		Addr1_Pfx,
		item04		Addr1_Sfx,
		item05		Addr1_Blok,

		item06		Addr2_Name,
		item07		Addr2_Type,
		item08		Addr2_Pfx,
		item09		Addr2_Sfx,
		item10		Addr2_Blok,

		item11		Mode_id,

		item12		Junction1,
		item13		Junction2,

		item14		X1_Vector,
		item15		Y1_Vector,
		item16		X2_Vector,
		item17		Y2_Vector,
	
		item18		Vector_Product

	from	garland.GIS_Temp1;

--	===========================================================================================
	set echo on;
