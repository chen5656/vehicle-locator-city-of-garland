	set echo	off;
--	set termout	off;
	set fetchrows	999;

	spool	c:\deacutis\scripts\address_resolve\reports\Made_Report\V50_Good_Number.sql;

	select	--+ rule
			distinct
			'bad address' 			"good number"
			,rpad(v.verify_code,04)		" "	

			,lpad(v.addr_num,  06)		" "
			,rpad(v.addr_pfx,  01)		" "
			,rpad(v.addr_name, 20)		"final street"
			,rpad(v.addr_type, 04)		" "
			,rpad(v.addr_sfx,  01)		" "

			,'   '				" "
--			,rpad(v.rec_seq,  06)		"seq"
--			,rpad(v.rec_key,  20)		"key"

--			,rpad(v.form_pfx,  01)		" "
--			,rpad(v.form_name, 20)		"parsed street"
--			,rpad(v.form_type, 04)		" "
--			,rpad(v.form_sfx,  01)		" "


	from		garland.adrResult				v

--	from		garland.adrResult_Tax_Account		v



	where		trunc (v.verify_code, -1) = 50
	and		v.verify_code < 55

	order by	rpad(v.addr_name,20), rpad(v.addr_type,04), rpad(v.addr_pfx,01), lpad(v.addr_num,05)
	;


	select	'Good Number	'		"bad address"
			,count(*)			"     total"
	from		garland.adrResult
	where		trunc (verify_code, -1) = 50;

	spool off;
	set fetchrows;

