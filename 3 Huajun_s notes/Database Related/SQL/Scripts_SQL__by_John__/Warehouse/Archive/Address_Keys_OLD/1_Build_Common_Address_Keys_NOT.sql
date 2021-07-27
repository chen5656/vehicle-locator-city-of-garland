	******************************************************************************************
--	******************************************************************************************
--	******************************************************************************************

--	OBTAIN UMS ADDRESSES THAT DON'T MATCH GIS OR TAX
--	SUPPRESS
	
	UNION ALL

	select
		r.addr_name, r.addr_num, r.addr_type, r.addr_pfx, r.addr_sfx, ' ', ' ', ' ',
		null, null, r.rec_key, null, 'UMS' 
	from	garland.adrResult_UMS_Location	R
	where not exists
(
	select 'x'
	from	garland.Extract2_Address_Keys		A

	where	a.addr_name		= r.addr_name	
	and	a.addr_type		= r.addr_type	
	and	a.addr_pfx		= r.addr_pfx	
	and	a.addr_sfx		= r.addr_sfx	
	and	a.addr_bldg		= r.addr_code1	
	and	a.addr_unit		= r.addr_unit1	
	and	a.addr_num		= ltrim(r.addr_num,'0')	
)

	and	ltrim(r.addr_num) > 0
	and	ltrim(r.addr_num) not between 9000 and 9999
	and	rtrim(r.addr_code1) is null
	and	rtrim(r.addr_unit1) is null

	;

--	=================================================================================
	Commit;

--	SUPPRESS

--	truncate table	garland.Extract2_Address_Keys	reuse storage;
--	truncate table	garland.GIS_Temp2			reuse storage;

--	=================================================================================
--	=================================================================================
--	=================================================================================
--	explain plan set statement_id = '4_CODE'		into garland.plan_table	for

--	OBTAIN CODE ADDRESSES THAT MATCH GIS OR TAX OR UMS
--	SUPPRESS


	insert --+	append
	into	garland.Extract2_Address_Keys
(
	addr_name, addr_num, addr_type, addr_pfx, addr_sfx, addr_code, addr_bldg, addr_unit, 
	GIS_key, TAX_key, UMS_key, Parcel_ID, Source 
)
	select
		a.addr_name, a.addr_num, a.addr_type, a.addr_pfx, a.addr_sfx, ' ', ' ', ' ',
		a.GIS_key, a.TAX_key, UMS_key, a.Parcel_ID, Source 

	from	garland.Extract1_Address_Keys		A,
		garland.adrResult_CodeAddr		R

	where	a.addr_name		= r.addr_name	(+)
	and	a.addr_type		= r.addr_type	(+)
	and	a.addr_pfx		= r.addr_pfx	(+)
	and	a.addr_sfx		= r.addr_sfx	(+)
	and	a.addr_bldg		= r.addr_code1	(+)
	and	a.addr_unit		= r.addr_unit1	(+)
	and	a.addr_num		= ltrim(r.addr_num (+),'0')	


--	OBTAIN CODE ADDRESSES THAT DON'T MATCH GIS OR TAX OR UMS

	UNION

	select
		r.addr_name, r.addr_num, r.addr_type, r.addr_pfx, r.addr_sfx, ' ', ' ', ' ',
		null, null, null, null, 'CODE' 

	from	garland.adrResult_CodeAddr		R
	where not exists
(
	select 'x'
	from	garland.Extract1_Address_Keys		A

	where	a.addr_name		= r.addr_name	
	and	a.addr_type		= r.addr_type	
	and	a.addr_pfx		= r.addr_pfx	
	and	a.addr_sfx		= r.addr_sfx	
	and	a.addr_bldg		= r.addr_code1	
	and	a.addr_unit		= r.addr_unit1	
	and	a.addr_num		= ltrim(r.addr_num,'0')	
)

	and	ltrim(r.addr_num) > 0
	and	ltrim(r.addr_num) not between 9000 and 9999
	and	rtrim(r.addr_code1) is null
	and	rtrim(r.addr_unit1) is null
	;



--	=================================================================================

--	select * from garland.explain_Plan;
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;

	Commit;

--	=================================================================================

	select to_char(sysdate, 'Mon dd,yyyy  hh24:mi:ss')  "END TIME " from dual;

--	=================================================================================
	set echo	on;

