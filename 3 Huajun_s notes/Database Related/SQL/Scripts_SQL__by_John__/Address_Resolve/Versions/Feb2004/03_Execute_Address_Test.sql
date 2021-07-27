	set echo		off;
	set serveroutput	on	size 99999;
--	===================================================================================
--	set controls after @executions
--	===================================================================================
--	PREPARATION
--	Decide:	Rule
--	Decide:	SQL   Input		appl_  or  form_  or  addr_ 
--	Decide	Table Input		adrResult /	adrResult_Input
--	Truncate	Table			gis_objects		reuse storage;
--	===================================================================================
--	Update REC_SEQ in original adrResult_Input

--	Execute when following error occurs:  "ORA-01403: no data found"

	select 'Populate Rec_Seq in adrResult_Input' " " from dual;
--	@c:\deacutis\scripts\address_resolve\13_App_Update_RecSeq.sql

	select 'Alterations' " " from dual;
--	@c:\deacutis\scripts\address_resolve\31_AdrAlter.sql;

	select 'Scrub Address' " " from dual;

--	===================================================================================

	drop synonym	temp_syn;

	create synonym	temp_syn		for garland.adrResult_Input;		--  SPECIFY
--	create synonym	temp_syn		for garland.adrResult;			--  SPECIFY

--	===================================================================================
--	@c:\deacutis\scripts\address_resolve\rules\Rule_Safe_Full.sql;
	@c:\deacutis\scripts\address_resolve\rules\Rule_Norm_Full.sql;
--	@c:\deacutis\scripts\address_resolve\rules\Rule_Norm_Parse.sql;
--	@c:\deacutis\scripts\address_resolve\rules\Rule_Norm_Name.sql;
--	@c:\deacutis\scripts\address_resolve\rules\Rule_Norm_Street.sql;
--	@c:\deacutis\scripts\address_resolve\rules\Rule_Risk_Name.sql;	
--	@c:\deacutis\scripts\address_resolve\rules\Rule_Risk_Street.sql;	
--	@c:\deacutis\scripts\address_resolve\rules\Rule_Trial.sql;
--	===================================================================================

declare

	Tracker_Mode		number		:= 02;
	Tracked_Focus		varchar2(40)	:= 'test';
	Tracker_Focus		varchar2(40)	:= '';
	Tracker_Level		varchar2(40)	:= '';

	do_MANUAL			number	:= 01		;	--  1 = manual selections below
										--  0 = rec_seq from adrResult

	do_QUERY_MANUAL		number	:= 077	;	--  manual

	do_QUERY_SEQ		number	:= 089635	;	-- rec_seq
--	do_QUERY_SEQ		number	:= 057388	;	-- rec_seq

	do_QUERY1			number	:= 0		;
	do_QUERY2			number	:= 0		;

	spec_insert			number	:= 01;
	spec_seq			number	:= 0;

--	---------------------------------------------------------------------------------------
	this_seq			number;

	addr_num			varchar2(80);
	addr_pfx			varchar2(80);
	addr_name			varchar2(80);
	addr_type			varchar2(80);
	addr_sfx			varchar2(80);
	addr_code1			varchar2(80);
	addr_unit1			varchar2(80);
	addr_code2			varchar2(80);
	addr_unit2			varchar2(80);

	form_pfx			varchar2(80);
	form_name			varchar2(80);
	form_type			varchar2(80);
	form_sfx			varchar2(80);
	form_code1			varchar2(80);
	form_unit1			varchar2(80);
	form_code2			varchar2(80);
	form_unit2			varchar2(80);

	gis_key			varchar2(80);
	audit				varchar2(80);
	audit_right			varchar2(80);
	audit_seq			number;
	verify_code			number;

begin

	if	do_manual > 0			then
		do_query1	:= do_query_manual;
	else
		do_query1	:= do_query_seq;
	end if;

	if	do_query2 = 0			then
		do_query2 := do_query1;
	end if;

	dbms_output.put_line (' ');


<<process_queries>>


for	q in do_query1..do_query2			loop

	this_seq	:= q;									-- nov 2003

	audit_seq	:= null;

	if	do_manual > 0				then				-- dec 2004
		null;

	elsif	this_seq > 0				then

--		CHOOSE INPUT ADDRESS
--		---------------------------------------------------------------------------------------------

		select appl_num, appl_pfx, appl_name, appl_type, appl_sfx, appl_code1, appl_unit1, appl_code2, appl_unit2
--		select addr_num, form_pfx, form_name, form_type, form_sfx, form_code1, form_unit1, form_code2, form_unit2
--		select addr_num, addr_pfx, addr_name, addr_type, addr_sfx, addr_code1, addr_unit1, addr_code2, addr_unit2

--		---------------------------------------------------------------------------------------------

		into	 addr_num, addr_pfx, addr_name, addr_type, addr_sfx, addr_code1, addr_unit1, addr_code2, addr_unit2
--		---------------------------------------------------------------------------------------------

		from	 garland.temp_syn			i
		where	 i.rec_seq = this_seq;						-- nov 2003

--		---------------------------------------------------------------------------------------------

		audit_seq	:= this_seq;						-- nov 2003

		goto	execute_query;
	end if;

	if	q = 0					then
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
--		addr_num	:= '101';
		addr_pfx	:= '';
		addr_name	:= 'street b';
		audit_right	:= '';

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

	elsif	q = 077					then
		addr_num	:= '301';
		addr_pfx	:= '';
		addr_name	:= 'rail';
		addr_type	:= '';
		addr_sfx	:= '';
		addr_code1	:= '';
		addr_unit1	:= '';
		addr_code2	:= '';
		addr_unit2	:= '';
		audit_right	:= '';

--	-------------------------------------------------------------------------

	else	goto	initialize_query;

--	-------------------------------------------------------------------------

	end if;


<<Execute_Query>>


	dbms_output.put_line (' ');
	dbms_output.put_line (lpad(q,5)||' *************************************************************');

	dbms_output.put_line ( '	' ||
	addr_num   ||' / '|| addr_pfx	  ||'	/ '  || addr_name  ||' / '|| addr_type ||' / '|| addr_sfx ||'	...'||
	addr_code1 ||' / '|| addr_unit1 ||' ... '|| addr_code2 ||' / '|| addr_unit2	);

	garland.Resolve_Address.Query_Driver 
--	garland.Resolve_Address_TEST.Query_Driver 

	(
		addr_num,	 addr_pfx,	 addr_name,	 addr_type,	addr_sfx,	
		addr_code1,	 addr_unit1, addr_code2, addr_unit2,	

				 form_pfx,	 form_name,	 form_type,	form_sfx,	
		form_code1,	 form_unit1, form_code2, form_unit2,	

		verify_code, gis_key,	 audit,		

		spec_insert,
		spec_seq 	

--		,Tracker_Mode ,Tracker_Focus ,Tracked_Focus
	);


	dbms_output.put_line ( '	' ||
	addr_num   ||' / '|| form_pfx	  ||'	/ '  || adr_string_cleaner(form_name)  ||' / '|| 
	form_type  ||' / '|| form_sfx   ||'	...' ||
	form_code1 ||' / '|| form_unit1 ||' ... '|| form_code2 ||' / '|| form_unit2	
	);

	dbms_output.put_line ( '	' ||
	addr_num   ||' / '|| addr_pfx	  ||'	/ '  || adr_string_cleaner(addr_name)  ||' / '|| 
	addr_type  ||' / '|| addr_sfx ||'	...'||
	addr_code1 ||' / '|| addr_unit1 ||' ... '|| addr_code2 ||' / '|| addr_unit2	
	);

	dbms_output.put_line ( '	' ||
	'verify=' || verify_code ||'  ' || audit);

	dbms_output.put_line ( '	'   ||
	'seq='|| audit_seq  || '    key=' || gis_key);

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

--	===================================================================================
--	@c:\deacutis\scripts\address_resolve\31_AdrAlter.sql;
--	@c:\deacutis\scripts\address_resolve\reports\quality_control\QC_Parse_Sample.sql;
--	@c:\deacutis\scripts\address_resolve\reports\quality_control\QC_Street_Sample.sql;
--	@c:\deacutis\scripts\address_resolve\50_Base_Report.sql;
--	@c:\deacutis\scripts\address_resolve\51_Name_Report.sql;
--	@c:\deacutis\scripts\address_resolve\package\Show_Sample.sql;   -- adrResult vc
--	select text from user_source where name = 'ADR_RESOLVE_RULES';
--	===================================================================================
