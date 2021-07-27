	set echo		off;
	set timing		on;
	set serveroutput	on;
--	==================================================================================================
--	extract nsa_code_inspect
--	==================================================================================================

--	drop synonym	syn_gis_table;
--	create synonym	syn_gis_table		for GARLAND.NSA_CODE_INSPECT;
--	truncate table	GARLAND.NSA_CODE_INSPECT	reuse storage;
--	analyze table	GARLAND.NSA_CODE_INSPECT	compute statistics;

--	==================================================================================================
declare

	do_compile_only		number	:= 0;

	spec_input			number	:= 40000;			--	max input size
	spec_file			number	:= 50000;			--	max file  size

	spec_year			char(4)	:= '1999';
--	spec_year			char(4)	:= null;

--	spec_lo_date		date		:= to_date ( 'JAN 01 2000', 'mon dd yyyy');
--	spec_hi_date		date		:= to_date ( 'DEC 31 2000', 'mon dd yyyy');
	spec_lo_date		date		:= null;
	spec_hi_date		date		:= null;

--	==================================================================================================
/*
cursor	read_code_info		is

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for

	select	--+	rowid(i)	first_rows		driving_site (i)
--	select	--+	rowid(i)	first_rows		index_asc(c)

		lpad (i.case_number, 07, '0')				case_number,			
		i.inspection_date,					
		i.case_closed_date,				

		lpad  (a.address_number, 05, '0')			addr_num,		
		rtrim (a.address_prefix)				addr_pfx,			
		rtrim (a.address_name)					addr_name,				
		rtrim (a.address_type,  ' ,')				addr_type,			
		rtrim (a.address_suffix,' ,')				addr_sfx,
		null,								unit_code,
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

	from	 inspection@cdep.world		i
		,codeaddr@cdep.world		a
		,case_violation@cdep.world	v
--		,citation@cdep.world		t
--		,complaint@cdep.world		c

	where (to_char (i.inspection_date, 'yyyy') = spec_year
	or	i.inspection_date	between spec_lo_date and spec_hi_date )

	and	i.addr_id	  	= a.addr_id
	and	i.case_number 	= v.case_number;

--	select * from explain_plan;

	CODE		read_code_info%rowtype;

*/
--	==================================================================================================

begin

	select least (spec_file - count(*), spec_input)
	into	 spec_input
	from	 syn_gis_table;

	if	do_compile_only > 0		then
		return;
	end if;


--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for

	insert
--+	append	driving_site (i)
	into	syn_gis_table

	select
--+  	all_rows	driving_site (i)	

		i.case_number,			
		i.inspection_date,					
		i.case_closed_date,				

		a.address_number,		
		a.address_prefix,			
		a.address_name,				
		a.address_type,			
		a.address_suffix,
		null,						--	unit code
		a.address_suppl#,
		a.zip_code,						

		null, null,					--	citation issue & comply date

		v.action,			
		i.follow_up_action,		
		v.status,						
		v.code_id,	
		v.violation_id,				
		v.violation,

		i.inspector_initials,
		null, null,					--	legal1, legal2
		null,						--	inspect area
		a.council_district,
		null,	null, null, null, null,		--	subdiv, nsa, parcel, segment, verify
		null						--	instigator

	from	 inspection@cdep.world		i
		,codeaddr@cdep.world		a
		,case_violation@cdep.world	v

	where (to_char (i.inspection_date, 'yyyy') = spec_year
	or	i.inspection_date	between spec_lo_date and spec_hi_date )

	and	i.addr_id	  	= a.addr_id
	and	i.case_number 	= v.case_number

	and	rownum < spec_input + 1
	;


--	select * from explain_plan;

	commit;

end;


--	==================================================================================================
/* 

BUILD NSA_CODE_INSPECT	1999		tuesday   may 22 15:05
total inspect = 28053
total extract = 34694
total insert  = 34694

*/
--	==================================================================================================


