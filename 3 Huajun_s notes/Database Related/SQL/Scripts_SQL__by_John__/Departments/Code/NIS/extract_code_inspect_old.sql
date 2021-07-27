
--	extract nsa_code_inspect

	set echo		off;
	set timing		on;
	set serveroutput	on;

--	==================================================================================================
--	SPECIFY
--			OUTPUT TABLE NAME		(normally nsa_code_inspect)
--			SPEC YEAR or DATE RANGE
--	==================================================================================================

	drop synonym	syn_gis_table;
	create synonym	syn_gis_table		for GARLAND.NSA_CODE_INSPECT;


	truncate table	GARLAND.NSA_CODE_INSPECT	reuse storage;


--	analyze table	GARLAND.NSA_CODE_INSPECT	compute statistics;

--	==================================================================================================

declare

	spec_year			char(4)	:= '1999';
--	spec_year			char(4)	:= null;

--	spec_lo_date		date		:= to_date ( 'JAN 01 2000', 'mon dd yyyy');
--	spec_hi_date		date		:= to_date ( 'DEC 31 2000', 'mon dd yyyy');
	spec_lo_date		date		:= null;
	spec_hi_date		date		:= null;

	do_insert			number	:= 01;
	do_compile_only		number	:= 0;

	prev_case_number		number	:= 0;

	fetch_total			number	:= 0;
	inspect_total		number	:= 0;
	insert_total		number	:= 0;

--	==================================================================================================

cursor	read_code_inspect		is

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for

	select	--+	index_asc (i  inspection_pk)

		case_number,
		rowid				inspect_rowid
	from	inspection@cdep.world	i

	where	i.case_number > prev_case_number
	and	rownum < 2

	and (	to_char (i.inspection_date, 'yyyy') = spec_year
	or	i.inspection_date	between spec_lo_date and spec_hi_date );

--	select * from explain_plan;

	INSP		read_code_inspect%rowtype;

--	==================================================================================================

cursor	read_code_info		is

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for

	select	--+	rowid(i)	first_rows

		lpad (i.case_number, 07, '0')				case_number,			
		i.inspection_date,					
		i.case_closed_date,				

		lpad  (a.address_number, 05, '0')			addr_num,		
		rtrim (a.address_prefix)				addr_pfx,			
		rtrim (a.address_name)					addr_name,				
		rtrim (a.address_type,  ' ,')				addr_type,			
		rtrim (a.address_suffix,' ,')				addr_sfx,
		rtrim (ltrim (a.address_suppl#), ' ,') 		unit_num,
		a.zip_code,						

		lpad (v.action, 02, '0')				action,			
		lpad (i.follow_up_action, 02, '0')			follow_up,		
		v.status,						
		to_char (to_number (v.code_id), '09')		code_id,	

		rtrim (v.violation_id)					violation_id,				
		rtrim (v.violation)					violation,
	
		i.inspector_initials,
		a.council_district				

	from	inspection@cdep.world		i,
		case_violation@cdep.world	v,
		codeaddr@cdep.world		a

	where	i.rowid		= insp.inspect_rowid
	and	i.addr_id	  	= a.addr_id
	and	i.case_number 	= v.case_number
	;

--	select * from explain_plan;

	CODE		read_code_info%rowtype;

--	==================================================================================================

cursor	read_citation		is

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'	for

	select	citation_issue_date,
			citation_comply_date
	from		citation@cdep.world

	where		case_number	= code.case_number
	and		citation_number = 
		(	
			select	max (citation_number)
			from		citation@cdep.world
			where		case_number = code.case_number
		);

--	select * from explain_plan;

	CIT		read_citation%rowtype;

--	==================================================================================================

begin

	if	do_compile_only > 0		then
		return;
	end if;

loop

	open	read_code_inspect;
	fetch	read_code_inspect		into insp;
	exit when	read_code_inspect%notfound
		or	read_code_inspect%notfound is null;
	close	read_code_inspect;

	inspect_total	:= inspect_total + 01;
	prev_case_number	:= insp.case_number;

	open	read_code_info;

loop

	fetch	read_code_info		into code;
	exit when	read_code_info%notfound
		or	read_code_info%notfound is null;

	fetch_total		:= fetch_total + 01;

	open	read_citation;
	fetch	read_citation		into cit;
	if	read_citation%notfound
	or	read_citation%notfound is null		then
		cit := null;
	end if;
	close	read_citation;


if	do_insert > 0		then

	insert into	syn_gis_table				values
	(
		code.case_number,			
		code.inspection_date,					
		code.case_closed_date,				

		code.addr_num,		
		code.addr_pfx,			
		code.addr_name,				
		code.addr_type,			
		code.addr_sfx,
		null,								--	unit code
		code.unit_num,
		code.zip_code,						

		cit.citation_issue_date,
		cit.citation_comply_date,

		code.action,			
		code.follow_up,		
		code.status,						
		code.code_id,	
		code.violation_id,				
		code.violation,
		code.inspector_initials,

		null,								--	inspect area
		code.council_district,
		null, null,							--	legal1, legal2
		null,	null, null, null, null				--	subdiv, nsa, parcel, segment, verify
	);

	insert_total := insert_total + 01;

end if;

end loop;

	commit;

	close	read_code_info;

end loop;

	commit;
	
	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( 'BUILD NSA_CODE_INSPECT		' || to_char (sysdate, 'day mon dd hh24:mi'));	
	dbms_output.put_line ( 'total inspect = ' || inspect_total	);	
	dbms_output.put_line ( 'total extract = ' || fetch_total	);	
	dbms_output.put_line ( 'total insert  = ' || insert_total	);	

end;




--	==================================================================================================
/* 

BUILD NSA_CODE_INSPECT	1999		tuesday   may 22 15:05
total inspect = 28053
total extract = 34694
total insert  = 34694

*/
--	==================================================================================================
