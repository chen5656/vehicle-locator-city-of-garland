	set echo	off;
	spool	c:\deacutis\scripts\address_resolve\reports\Made_ASCII\V01_Non_Garland.sql;
--	=======================================================================================

	select	'key,num,prefix,name,type,suffix' " " from dual
	union all

	select	--+ rule
			rec_key 		||';'||
			appl_num  		||';'||
			form_pfx  		||';'||
			form_name 		||';'||
			form_type 		||';'||
			form_sfx  		||';'||
			'   '		" "
	from	
(	select distinct	
		 form_name, form_type, form_pfx, form_sfx, appl_num, rec_key, verify_code 
	from	 garland.adrResult	
	order by form_name, form_type, form_pfx, form_sfx, appl_num
)

	where		verify_code = 01

	and not exists
(
	select 'x'
	from garland.adrStreets
	where addr_name = rtrim(form_name)
);


--	=======================================================================================
	spool 	off;
	set echo	on;


