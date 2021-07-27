	set echo	off
	set termout	off;
--	================================================

	spool	c:\deacutis\extract\Water_Loc_Ser_Co.txt

	select
		'location_no,serial_no,company_cd,addr_num,addr_pfx,addr_name,addr_type,addr_sfx,addr_bldg,addr_unit'
		from dual;

	select 
		location_no		||','||
		serial_no		||','||
		company_cd		||','||

		addr_num		||','||
		addr_pfx		||','||
		addr_name		||','||
		addr_type		||','||
		addr_sfx		||','||
		addr_bldg		||','||
		addr_unit
	from
(
	select distinct
		location_no,	
		serial_no,	
		company_cd,	
		addr_num,	
		addr_pfx,	
		addr_name,	
		addr_type,	
		addr_sfx,	
		addr_bldg,	
		addr_unit
	from	garland.Temp_View
	order by addr_name, addr_type, addr_pfx, addr_sfx, addr_num, location_no, serial_no 
);

	spool off;

--	================================================
	set echo	on;
	set termout	on;
