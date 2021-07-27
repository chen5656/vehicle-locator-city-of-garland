	set echo	off;
--	set termout	off;
	set fetchrows	999;

	spool	c:\deacutis\scripts\address_resolve\reports\Made_Report\V40_Good_Range.sql;

	select	--+ rule
			distinct

			'bad number' 			"bad number"
--			'good range' 			"bad number"
			,'   '				" "

			,rpad(v.rec_key,  20)		"key"
--			,rpad(v.rec_seq,  06)		"seq"
--			,rpad(v.verify_code,04)		" "	

			,lpad(v.addr_num,  06)		" "
			,rpad(v.addr_pfx,  01)		" "
			,rpad(v.addr_name, 20)		"final street"
			,rpad(v.addr_type, 04)		" "
			,rpad(v.addr_sfx,  01)		" "


--			,rpad(v.form_pfx,  01)		" "
--			,rpad(v.form_name, 20)		"parsed street"
--			,rpad(v.form_type, 04)		" "
--			,rpad(v.form_sfx,  01)		" "


--	from		garland.adrResult		v

	from		garland.adrResult_Tax_Account		v



	where		trunc (v.verify_code, -1) = 40

	order by	rpad(v.addr_name,20), rpad(v.addr_type,04), rpad(v.addr_pfx,01), lpad(v.addr_num,05)
	;


	select	'good range	'		"bad number"
			,count(*)			"     total"
	from		garland.adrResult
	where		trunc (verify_code, -1) = 40;

	spool off;
	set fetchrows;
