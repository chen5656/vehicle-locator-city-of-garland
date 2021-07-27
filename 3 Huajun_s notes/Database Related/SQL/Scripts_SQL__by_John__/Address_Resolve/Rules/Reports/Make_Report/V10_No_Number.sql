--	set echo	off;
	set fetchrows	999;

	spool	c:\deacutis\scripts\address_resolve\reports\Made_Report\V10_No_Number.sql;

	select	--+ rule
			distinct
			'no number   ' 			"good name"


			,lpad(v.addr_num,  05)		" "
			,rpad(v.addr_pfx,  01)		" "
			,rpad(v.addr_name, 20)		"final street"
			,rpad(v.addr_type, 04)		" "
			,rpad(v.addr_sfx,  01)		" "

--			,rpad(v.form_pfx,  01)		" "
--			,rpad(v.form_name, 20)		"parsed street"
--			,rpad(v.form_type, 04)		" "
--			,rpad(v.form_sfx,  01)		" "

			,rpad(v.rec_key,  20)		"key"
--			,rpad(v.rec_seq,  06)		"seq"
--			,rpad(v.verify_code,04)		" "	



	from		garland.adrResult		v

--	from		garland.adrResult_Tax_Account		v


	where		trunc (v.verify_code, -1) = 10
	and		v.verify_code < 55

	order by	rpad(v.addr_name,20), rpad(v.addr_type,04), rpad(v.addr_pfx,01), lpad(v.addr_num,05)
	;


	select	'no number	'		"good name"
			,count(*)			"     total"
	from		garland.adrResult
	where		trunc (verify_code, -1) = 10;

	spool off;
	set fetchrows;


