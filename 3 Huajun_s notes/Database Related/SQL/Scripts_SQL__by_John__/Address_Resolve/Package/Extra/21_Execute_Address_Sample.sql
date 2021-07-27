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

	drop synonym	temp_syn;

	create synonym	temp_syn		for garland.adrResult_Input;		--  SPECIFY
--	create synonym	temp_syn		for garland.adrResult;			--  SPECIFY

--	===================================================================================
--	@c:\deacutis\scripts\address_resolve\rules\Rule_App_Full.sql;
--	@c:\deacutis\scripts\address_resolve\rules\Rule_App_Parse.sql;
	@c:\deacutis\scripts\address_resolve\rules\Rule_Risk_Name.sql;	
--	@c:\deacutis\scripts\address_resolve\rules\Rule_App_Street.sql;
--	@c:\deacutis\scripts\address_resolve\rules\Rule_App_Front.sql;
--	@c:\deacutis\scripts\address_resolve\rules\Rule_App_Back.sql;
--	@c:\deacutis\scripts\address_resolve\rules\Rule_Trial.sql;
--	===================================================================================

declare
	spec_TRACE			number	:= 0		;	-- standard = 01
	spec_SHOW			number	:= 0111	;	-- standard = 111
	spec_FOCUS			varchar2(80):= 'out'	;	-- show name

	do_BATCH			number	:= 0		;	--  YES / NO
	do_SEQ			number	:= 0		;	--  YES / NO
--	else do manual queries below	

--	do_query1			number	:= 067746	;	--  SEQ
--	do_query2			number	:= 0		;

	do_query1			number	:= 070	;	--  MANUAL
	do_query2			number	:= 080	;	

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

	verify_code			number;
	gis_key			varchar2(80);
	audit				varchar2(80);
	audit_right			varchar2(80);
	audit_seq			number;

	spec_insert			number	:= 0;
	spec_seq			number	:= 0;

	this_seq			number;

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

	this_seq	:= q;									-- nov 2003

	audit_seq	:= null;

	if	do_seq > 0					
	and	this_seq > 0				then

--		CHOOSE INPUT ADDRESS
--		---------------------------------------------------------------------------------------------

--		select appl_num, appl_pfx, appl_name, appl_type, appl_sfx, appl_code1, appl_unit1, appl_code2, appl_unit2
--		select addr_num, form_pfx, form_name, form_type, form_sfx, form_code1, form_unit1, form_code2, form_unit2
		select addr_num, addr_pfx, addr_name, addr_type, addr_sfx, addr_code1, addr_unit1, addr_code2, addr_unit2

--		---------------------------------------------------------------------------------------------

		into	 addr_num, addr_pfx, addr_name, addr_type, addr_sfx, addr_code1, addr_unit1, addr_code2, addr_unit2
--		---------------------------------------------------------------------------------------------

		from	 garland.temp_syn			i
		where	 i.rec_seq = this_seq;						-- nov 2003

--		---------------------------------------------------------------------------------------------

		audit_seq	:= this_seq;						-- nov 2003

		do_seq	:= -1;
		goto	execute_query;
	end if;

	exit when	do_seq > 0;				-- feb 2004

	if	q = 0
	or	do_seq < 0				then
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

	elsif	q = 077					then
		addr_num	:= '5301';
		addr_pfx	:= '';
		addr_name	:= 'side';
		addr_type	:= 'sq';
		addr_sfx	:= 'e';
		addr_code1	:= '';
		addr_unit1	:= '';
		addr_code2	:= '';
		addr_unit2	:= '';
		audit_right	:= '';

--	-------------------------------------------------------------------------

	else	goto	initialize_query;

--	-------------------------------------------------------------------------

	end if;


<<execute_query>>

	dbms_output.put_line (' ');
	dbms_output.put_line (lpad(q,5)||' *************************************************************');

	dbms_output.put_line ( '	' ||
	addr_num   ||' / '|| addr_pfx	  ||'	/ '  || addr_name  ||' / '|| addr_type ||' / '|| addr_sfx ||'	...'||
	addr_code1 ||' / '|| addr_unit1 ||' ... '|| addr_code2 ||' / '|| addr_unit2	);

	garland.Resolve_Address.Query_Driver 
	(
		addr_num,	 addr_pfx,	 addr_name,	 addr_type,	addr_sfx,	
		addr_code1,	 addr_unit1, addr_code2, addr_unit2,	

				 form_pfx,	 form_name,	 form_type,	form_sfx,	
		form_code1,	 form_unit1, form_code2, form_unit2,	

		verify_code, gis_key,	 audit,		

		spec_insert, spec_seq, 
		spec_trace,  spec_show, spec_focus	
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
