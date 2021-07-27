	set echo	off;
--	set timing	on;
--	=================================================================================
--	Obtain the Location Number and Address for each Water Serial Number
--	=================================================================================

	create or replace view	garland.Temp_View2	AS
(
	select
		item01	serial_no,	
		item02	location_no,

		item03	addr_num,
		item04	addr_pfx,
		item05	addr_name,
		item06	addr_type,
		item07	addr_sfx,
		item08	addr_bldg,
		item09	addr_unit,

		item10	company_id
	
	from	garland.GIS_Temp2
);

--	=================================================================================

	truncate table	garland.GIS_Temp2		reuse storage;		-- temp_view2

--	=================================================================================

--	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id = ' '		into garland.plan_table		for

--	=================================================================================

--	select 	count(*)	from

	insert	--+ append
	into		garland.Temp_View2

(
	select	lpad(rtrim(lm.serial_no),8,'0') serial_no,
			lm.location_no,

			ltrim(rtrim(a.house_no)),
			rtrim(a.street_pfx_dir),
			rtrim(a.street_nm),
			rtrim(a.street_nm_sfx),
			rtrim(a.street_sfx_dir),
			rtrim(a.sec_addr_id),
			rtrim(a.sec_addr_range),

			null

	from		sfg.um00100m@umsrep.world		A,
(
	select	distinct
			m.serial_no,  l.location_no	

	from		sfg.um00160t@umsrep.world		L,
			sfg.um00300m@umsrep.world		M

	where		l.meter_no		= m.meter_no
	and		m.service_purpose = 'WA'
	and		l.pull_dt		is null
)								LM

	where	a.location_no	= lm.location_no

	and	street_nm		> '0'
	and	length(street_nm) >= 2
	and	street_nm not like 'FIRE %'

	and	rtrim(a.sec_addr_id)    is null
	and	rtrim(a.sec_addr_range) is null
)	;


	Commit;

--	=================================================================================


	select count(*) 	"TOTAL"							from garland.temp_view2;

	select count(distinct serial_no ||'.'|| location_no)  "METERLOCN"	from garland.temp_view2;

	select count(distinct serial_no)   "METER"				from garland.temp_view2;

	select count(distinct location_no) "LOCATION"				from garland.temp_view2;


--	=================================================================================
--	select * from garland.explain_Plan;
--	execute  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;
--	=================================================================================
	set echo	on;
	set timing	off;
