	set echo	off;
--	=================================================================================
	spool	c:\deacutis\scripts\address_resolve\reports\Made_ASCII\V00_Non_Address.sql;

	select	'key,num,prefix,name,type,suffix,bldg1,unit1,bldg2,unit2' " " from dual
	union all

	select	--+ rule

			rec_key	    		||';'||

			appl_num			||';'||
			appl_pfx	   		||';'||
			appl_name	  		||';'||
			appl_type	  		||';'||
			appl_sfx	   		||';'||

			appl_code1	 		||';'||
			appl_unit1	 		||';'||
			appl_code2	 		||';'||
			appl_unit2	 		||';'||
			' '	" "

	from
(	select distinct	
		appl_name,  appl_type,  appl_pfx,   appl_sfx,   appl_num, rec_key, verify_code,
		appl_code1, appl_unit1, appl_code2, appl_unit2
	from	garland.adrResult	
	order by	appl_name, appl_type, appl_pfx, appl_sfx, appl_num
)

	where		verify_code =  0

	and not exists
(
	select 'x'
	from garland.adrStreets
	where addr_name = rtrim(appl_name)
);

	spool	off;
--	=================================================================================
