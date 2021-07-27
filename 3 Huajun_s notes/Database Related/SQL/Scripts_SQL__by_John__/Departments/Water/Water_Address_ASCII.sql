	set echo	off;
	set termout off;
	
	spool  c:\deacutis\extract\water_address.txt;

	select
	rec_key			||','||
	addr_num			||','||
	addr_pfx			||','||
	addr_name			||','||
	addr_type			||','||
	addr_sfx			||','||
	addr_unit1			
	" "
	from garland.adrresult_ums_location
	order by addr_name, addr_type, addr_pfx, addr_sfx, addr_num; 

	spool off;
	set termout on;
