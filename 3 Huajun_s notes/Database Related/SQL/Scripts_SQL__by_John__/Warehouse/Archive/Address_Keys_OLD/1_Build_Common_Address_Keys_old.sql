	set echo	off;
--	=================================================================================
--	Obtain all addresses (valid & invalid) from GIS, TAX, UMS, & CODE
--	Store source application keys for GIS, TAX, UMS with each address
--	=================================================================================

	select to_char(sysdate,'Mon dd,yyyy  hh24:mi:ss') "BEGIN TIME " from dual;

--	=================================================================================
	truncate table	garland.plan_table	reuse storage;
--	=================================================================================

--	truncate table	garland.Extract1_Address_Keys		reuse storage;
	truncate table	garland.GIS_Temp1				reuse storage;

--	=================================================================================
--	explain plan set statement_id = '1-GIS'		into garland.plan_table	for

--	OBTAIN GIS ADDRESSES

	insert --+	append
	into	garland.Extract1_Address_Keys
(
	addr_name, addr_num, addr_type, addr_pfx, addr_sfx, addr_code, addr_bldg, addr_unit, 
	GIS_key, Parcel_ID, Source
)
	select
	DISTINCT
	addr_name, addr_num, addr_type, addr_pfx, addr_sfx, ' ', ' ', ' ',
	mslink, parcel_id, 'GIS'
	from	garland.cdreladr
	where	addr_num > 0
	and	addr_num not between 9000 and 9999
	and	rtrim(unit_type) is null
	and	rtrim(unit_num)  is null
	;

--	=================================================================================
	commit;		

--	truncate table	garland.Extract2_Address_Keys		reuse storage;
	truncate table	garland.GIS_Temp2				reuse storage;

--	=================================================================================
--	explain plan set statement_id = '2-TAX'		into garland.plan_table	for

	insert --+	append
	into	garland.Extract2_Address_Keys
(
	addr_name, addr_num, addr_type, addr_pfx, addr_sfx, addr_code, addr_bldg, addr_unit, 
	GIS_key, TAX_key, Parcel_ID, Source
)
	select							--	OBTAIN TAX ADDRESSES THAT MATCH GIS
		a.addr_name, a.addr_num, a.addr_type, a.addr_pfx, a.addr_sfx, ' ', ' ', ' ',
		a.GIS_key, r.rec_key, a.Parcel_ID, Source
	from	garland.Extract1_Address_Keys		A,
		garland.adrResult_TAX_GDS		R
	where	a.addr_name		= r.addr_name	(+)
	and	a.addr_type		= r.addr_type	(+)
	and	a.addr_pfx		= r.addr_pfx	(+)
	and	a.addr_sfx		= r.addr_sfx	(+)
	and	a.addr_bldg		= r.addr_code1	(+)
	and	a.addr_unit		= r.addr_unit1	(+)
	and	a.addr_num		= ltrim(r.addr_num (+),'0')	
	UNION ALL						--	OBTAIN TAX ADDRESSES THAT DON'T MATCH GIS
	select
		r.addr_name, r.addr_num, r.addr_type, r.addr_pfx, r.addr_sfx, ' ', ' ', ' ',
		null, r.rec_key, null, 'TAX'
	from	garland.adrResult_TAX_GDS		R
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
	commit;		

--	truncate table	garland.Extract1_Address_Keys		reuse storage;
	truncate table	garland.GIS_Temp1				reuse storage;

--	=================================================================================
--	explain plan set statement_id = '3-UMS'		into garland.plan_table	for

--	OBTAIN UMS ADDRESSES THAT MATCH GIS OR TAX

	insert --+	append
	into	garland.Extract1_Address_Keys
(
	addr_name, addr_num, addr_type, addr_pfx, addr_sfx, addr_code, addr_bldg, addr_unit, 
	GIS_key, TAX_key, UMS_key, Parcel_ID, Source
)
	select
	DISTINCT
		a.addr_name, a.addr_num, a.addr_type, a.addr_pfx, a.addr_sfx, ' ', ' ', ' ',
		a.GIS_key, a.TAX_key, r.rec_key, a.Parcel_ID, Source

	from	garland.Extract2_Address_Keys		A,
		garland.adrResult_UMS_Location	R,
		garland.Basic_UMS				U		-- Oct 26 2005

	where	a.addr_name		= r.addr_name	(+)
	and	a.addr_type		= r.addr_type	(+)
	and	a.addr_pfx		= r.addr_pfx	(+)
	and	a.addr_sfx		= r.addr_sfx	(+)
	and	a.addr_bldg		= r.addr_code1	(+)
	and	a.addr_unit		= r.addr_unit1	(+)
	and	a.addr_num		= ltrim(r.addr_num (+),'0')	

	and	to_number(r.rec_key)	= u.location_no (+)
	;

	Commit;

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
