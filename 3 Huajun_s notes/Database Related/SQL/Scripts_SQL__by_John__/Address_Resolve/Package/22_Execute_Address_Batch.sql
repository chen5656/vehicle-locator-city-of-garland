	set echo		off;
	set timing		off;
	set serveroutput	on	size 99999;
--	===================================================================================
--	RESOLVE_ADDRESS_TEST.sql

	Truncate Table	gis_verify_addr		reuse storage;

--	@c:\deacutis\scripts\address_resolve\rules\Rule_App_Full.sql;
	@c:\deacutis\scripts\address_resolve\rules\Rule_Risk_Name.sql;

--	@c:\deacutis\scripts\address_resolve\user_exits\Code_Unparsed_exit.sql;
	@c:\deacutis\scripts\address_resolve\user_exits\01_Default_Unparsed_exit.sql;
	@c:\deacutis\scripts\address_resolve\user_exits\01_Default_Parsed_exit.sql;

--	@c:\deacutis\scripts\address_resolve\31_AdrAlter.sql;

--	@c:\deacutis\scripts\address_resolve\reports\quality_control\QC_Parse_Sample.sql;
--	@c:\deacutis\scripts\address_resolve\reports\quality_control\QC_Street_Sample.sql;
--	@c:\deacutis\scripts\address_resolve\50_Base_Report.sql;
--	@c:\deacutis\scripts\address_resolve\51_Name_Report.sql;
--	@c:\deacutis\scripts\address_resolve\package\Show_Sample.sql;   -- adrResult vc
--	select text from user_source where name = 'TST_RESOLVE_RULES';
--	===================================================================================
	set timing		on;

declare

	spec_insert			number	:= 0;
	spec_seq			number	:= '';

	spec_trace			number	:= '';
	spec_show			number	:= '';
	spec_focus			varchar2(80):= '';

	do_batch			number	:= 01;

	addr_num			varchar2(10);
	addr_pfx			varchar2(10);
	addr_name			varchar2(80);
	addr_type			varchar2(10);
	addr_sfx			varchar2(10);
	addr_code1			varchar2(20);
	addr_unit1			varchar2(20);
	addr_code2			varchar2(20);
	addr_unit2			varchar2(20);

	verify_code			number;
	gis_key			varchar2(80);
	audit				varchar2(80);
	audit_right			varchar2(80);

	do_seq			number	:= 0;
	do_query1			number	:= 0;
	do_query2			number	:= 0;

begin

	if	do_batch > 0			then
		garland.Resolve_Address.Batch_Driver;
		return;
	end if;

	if	do_query2 = 0			then
		do_query2 := do_query1;
	end if;

	dbms_output.put_line (' ');


<<process_queries>>

for	q in do_query1..do_query2			loop

	if	do_seq > 0					then
		select appl_num, appl_pfx, appl_name, appl_type, appl_sfx, appl_code1, appl_unit1, appl_code2, appl_unit2
		into	 addr_num, addr_pfx, addr_name, addr_type, addr_sfx, addr_code1, addr_unit1, addr_code2, addr_unit2
		from	 garland.gis_app_rowid		a,
			 garland.adrResult_Local	l
		where	 a.row_seq = do_seq
		and	 a.row_id  = l.rowid;

		do_seq := -1;
		goto	execute_query;
	end if;

	if	q = 0
	or	do_seq < 0					then
		exit;

	elsif	q = 0					then
		addr_name	:= '';
		addr_num	:= '';
		addr_pfx	:= '';
		addr_type	:= '';
		addr_sfx	:= '';
		addr_code1	:= '';
		addr_unit1	:= '';
		addr_code2	:= '';
		addr_unit2	:= '';
		audit_right	:= '';

--	-------------------------------------------------------------------------

	elsif	q = 01					then
		addr_name	:= '217 5TH AVE';
		audit_right	:= '	53     NTH  n.Mt.....  Srt Sat;';

	elsif	q = 02					then
		addr_name	:= '217 N FIFHT CIR';
		audit_right	:= '	52  C     npMt.....';

	elsif	q = 03					then
		addr_name	:= '217 S 5 CIR';
		audit_right	:= '	52     NTH  npMt.....';

	elsif	q = 04					then
		addr_name	:= 'PARK';
		addr_num	:= '921';
		addr_type	:= 'CIR';
		addr_sfx	:= 'E';
		audit_right	:= '	55     spull  .........   	4300219.000';


	elsif	q = 011					then
		addr_name	:= '217A NO. COUNTY CUB EAST #4';
		audit_right	:= '	43  C     npM.s.ukv  Scp;Sat;';

	elsif	q = 012					then
		addr_name	:= '1234 MOLLER PK N #A 12';
		audit_right	:= '	25     PULL  n.Mtscu.v';


--	-------------------------------------------------------------------------


--	-------------------------------------------------------------------------

	end if;


<<execute_query>>

	if	addr_name is null			then
		goto	initialize_query;
	end if;	

	dbms_output.put_line (lpad(q,3)||' *************************************************************');

	dbms_output.put_line ( '	' ||
	addr_num   ||' / '|| addr_pfx	  ||'	/ '  || addr_name  ||' / '|| addr_type ||' / '|| addr_sfx ||'	...'||
	addr_code1 ||' / '|| addr_unit1 ||' ... '|| addr_code2 ||' / '|| addr_unit2	);

	garland.Resolve_Address.Query_Driver
	(
		addr_num,	 addr_pfx,	 addr_name,	 addr_type,	addr_sfx,	
		addr_code1,	 addr_unit1, addr_code2, addr_unit2,	
		verify_code, gis_key,	 audit,		

		spec_insert, spec_seq, 
		spec_trace,  spec_show, spec_focus	
	);

	dbms_output.put_line ( '	' ||
	addr_num   ||' / '|| addr_pfx	  ||'	/ '  || addr_name  ||' / '|| addr_type ||' / '|| addr_sfx ||'	...'||
	addr_code1 ||' / '|| addr_unit1 ||' ... '|| addr_code2 ||' / '|| addr_unit2	);

	dbms_output.put_line ( '	' ||
	verify_code ||'  '|| audit ||'	'|| gis_key);

	dbms_output.put_line ( audit_right );


<<initialize_query>>

	addr_name		:= null;
	addr_num		:= null;
	addr_pfx		:= null;
	addr_type		:= null;
	addr_sfx		:= null;

	addr_code1		:= null;
	addr_unit1		:= null;
	addr_code2		:= null;
	addr_unit2		:= null;

	verify_code		:= null;
	gis_key		:= null;
	audit			:= null;
	audit_right		:= null;

end loop;

	dbms_output.put_line ('    *************************************************************');
	
end;
