	set echo	off;

	spool	c:\deacutis\scripts\address_resolve\reports\Made_ASCII\V24_Partial_Street.sql;
--	=======================================================================================

	select	'key;number;prefix;name;type;suffix;pfx;nam;typ;sfx;verify' " " from dual
	union all

	select
			rec_key 		||';'||
			addr_num  		||';'||
			addr_pfx  		||';'||
			addr_name 		||';'||
			addr_type 		||';'||
			addr_sfx  		||';'||
			form_pfx  		||';'||
			form_name		||';'||
			form_type		||';'||
			form_sfx		||';'||
			verify_code

	" "	 from	
(	select distinct	
		 addr_name, addr_type, addr_pfx, addr_sfx, addr_num, rec_key, verify_code, 
		 form_name, form_type, form_pfx, form_sfx
	from	 garland.adrResult	
	order by addr_name, addr_type, addr_pfx, addr_sfx, addr_num
)

	where		verify_code = 24
	;

--	=======================================================================================
	spool 	off;
	set echo	on;





