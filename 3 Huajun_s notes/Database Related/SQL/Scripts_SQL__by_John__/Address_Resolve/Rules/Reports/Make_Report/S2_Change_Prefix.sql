	set echo	off;
--	set termout	off;
	set fetchrows	999;

--	===================================================================================================

	spool	c:\deacutis\scripts\address_resolve\reports\Made_Report\S2_Change_Prefix.sql;

	select	distinct
			'change prefix'			"Street Change"

			,lpad(v.addr_num,  06)		" "
			,rpad(v.form_pfx,  01)		" "
			,rpad(v.addr_name, 20)		"address"
			,rpad(v.form_type, 04)		" "
			,rpad(v.form_sfx,  01)		" "

			,' ==> '				" "

			,rpad(v.addr_pfx,  06)		"change "
--			,rpad(v.addr_name, 20)		" "
			,rpad(v.addr_type, 04)		" "
			,rpad(v.addr_sfx,  01)		" "

			,'   '				" "
--			,rpad(v.rec_key,	  20)		"key"
--			,rpad(v.do_alias,   05)		"alias"	
--			,rpad(v.do_qual,    16)		"audit"	
--			,lpad(v.verify_code,03)		"ver"	

	from		garland.adrResult		v

	where		v.do_qual like	'%cp%'
	or		v.do_qual like	'%rp__ap%'

	order by	rpad(v.addr_name,20), rpad(v.form_type,04), rpad(v.form_pfx,01), rpad(v.form_sfx,01)
	;

	spool off;
	set fetchrows;

