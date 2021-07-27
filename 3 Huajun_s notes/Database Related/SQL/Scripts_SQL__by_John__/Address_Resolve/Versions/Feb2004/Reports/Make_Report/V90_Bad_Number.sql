	set echo	off;
--	set termout	off;
	set fetchrows;
--	=============================================================================================

--	spool	c:\deacutis\scripts\address_resolve\reports\Made_Report\V90_Bad_Number.sql;


	select	'Bad Number	'		"bad number"
			,count(*)			"     total"
	from		garland.adrResult
	where		trunc (verify_code, -1) between 20 and 40;

--	=============================================================================================

	select	--+ rule
			distinct

			'bad number ' 			"bad number"


			,'   '				" "
			,rpad(v.rec_key,  15)		"key"
--			,rpad(v.rec_seq,  06)		"seq"
--			,rpad(v.verify_code,04)		" "	

			,lpad(v.addr_num,  06)		" "
			,rpad(v.addr_pfx,  01)		" "
			,rpad(v.addr_name, 20)		"address"
			,rpad(v.addr_type, 04)		" "
			,rpad(v.addr_sfx,  01)		" "


--			,lpad(rtrim(ltrim(v.appl_num)),06)	" "
--			,rpad(v.appl_pfx,  01)			" "
--			,rpad(v.appl_name, 20)			"original"
--			,rpad(v.appl_type, 04)			" "
--			,rpad(v.appl_sfx,  01)			" "


	from		garland.adrResult				v
--	from		garland.adrResult_UMS_Location	v


	where		trunc (v.verify_code, -1) between 20 and 40

	and not exists		
(
	select 'x'
	from	 garland.cdrelADR
	where	 addr_name	= v.addr_name
	and	 addr_num	= v.addr_num
)

	order by	rpad(v.addr_name,20), rpad(v.addr_type,04), rpad(v.addr_pfx,01), lpad(v.addr_num,06);

--	=============================================================================================

--	spool off;

--	=============================================================================================
	set echo	off;
	set fetchrows;
--	set termout	off;



