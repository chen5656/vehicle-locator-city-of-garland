	set echo	off;
	set timing	off;
	set termout	on;
--	===================================================================================

	@c:\deacutis\scripts\address_resolve\reports\quality_control\qc_name.sql;

--	===================================================================================

	@c:\deacutis\scripts\address_resolve\reports\make_report\N1_Type_A_Name.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\N2_Type_B_Name.sql;

--	@c:\deacutis\scripts\address_resolve\reports\make_report\N3_Type_C_Name.sql;


--	===================================================================================

	select distinct 
		rpad('Type C',  11)  			"correction",  
		rpad(nvl(form_name,appl_name), 25)  "invalid name", 
		rpad(addr_name, 25)  			"corrected name",
		rpad(addr_unit1,10)  			"unit1"
	from	 garland.adrResult	where do_name = 'C';

	select rpad('Type C',11) "correction", count(*) "total" 
	from	 garland.adrResult	where do_name = 'C';

--	===================================================================================

	@c:\deacutis\scripts\address_resolve\reports\make_report\N5_Alien_Name.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\N4_Alias_Name.sql;

--	===================================================================================

--	@c:\deacutis\scripts\address_resolve\reports\make_report\V00_Non_Address.sql;
--	@c:\deacutis\scripts\address_resolve\reports\make_report\V01_Non_Garland.sql;
--	@c:\deacutis\scripts\address_resolve\reports\make_report\V03_Non_Complete.sql;
--	@c:\deacutis\scripts\address_resolve\reports\make_report\V02_Non_Correct.sql;

	select distinct 'Non Address  ' " "  
		,rpad(appl_name,30)	"appl" 
		,decode (r.addr_num,  null, ' ', '['|| r.addr_num ||']')	"street number"
		,decode (rpad(r.do_parse,01), '!', rpad(do_parse,20), ' ')	"parse fail"

--		,do_parse			"parse"
		,do_alias			"alias"
--		,do_name			"name"
--		,appl_num			"appl"	,appl_code1	"code1 " ,appl_unit1	"unit1 " 
--		,addr_num			"form"	,form_code1	"code1 " ,form_unit1	"unit1 " 
--		,addr_num			"addr"	,addr_code1	"code1 " ,addr_unit1	"unit1 " 
--		,rec_seq 			"seq"
--		,rec_key 			"key"

	from	garland.adrResult		r,
		garland.adrStreets	s

	where	r.addr_name = s.addr_name (+)
	and	verify_code = 0
--	and	appl_name  < 'A'
	and	rownum < 1111
	order by 2;	

	select 'Non Address  ' " ", count(*) "total"  
	from	garland.adrResult
	where	verify_code = 0;

	select distinct 'Non Garland  ' " "  
		,rpad(addr_name,20)	"appl" 
--		,do_parse			"parse"
--		,do_alias			"alias"
--		,do_name			"name"
--		,appl_num			"appl"	,appl_code1	"code1 " ,appl_unit1	"unit1 " 
--		,addr_num			"form"	,form_code1	"code1 " ,form_unit1	"unit1 " 
--		,addr_num			"addr"	,addr_code1	"code1 " ,addr_unit1	"unit1 " 
--		,rec_seq 			"seq"
--		,rec_key 			"key"
	from	garland.adrResult
	where	verify_code = 1
--	and	rownum < 111
	order by 2;	


	select 'Non Garland  ' " ", count(*) "total"  
	from	garland.adrResult
	where	verify_code = 1;


	select s.addr_name "Non Garland Error"
	from	garland.adrResult		r,
		garland.adrStreets	s
	where	r.addr_name = s.addr_name
	and	r.do_alias	like '%$%';

--	===================================================================================

--	select rpad('-',70,'-') from dual;

--	===================================================================================

