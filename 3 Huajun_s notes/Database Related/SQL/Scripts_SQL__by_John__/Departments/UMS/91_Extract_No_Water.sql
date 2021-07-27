	set echo off;
--	===================================================================================
--	truncate table	garland.plan_table;
--	explain plan	set statement_id = 'a'	into garland.plan_table		for
--	===================================================================================

--	===================================================================================
--	A)	how many locations with an installed water meter do not have an account	
--	B)	extract the locations with verified address
--	C)	extract the locations with unverified address
--	===================================================================================


--	A)
--	select count(*)		from sfg.um00140t@umsrep.world			--	1200
--	where	 service_tp = 'WTR'
--	and	 metered_yn = 'T'
--	and	 location_no 	in


--	B)
	select rec_key  ||','|| parcel_id ||','|| 
		 addr_num ||' '|| form_pfx  ||' '|| form_name ||' '|| form_type ||' '|| form_sfx
	from	 garland.adrResult_ums_location
	where	 verify_code > 50
	and	 rec_key in

(
	select location_no	from sfg.um00140t@umsrep.world
	where	 service_tp = 'WTR'
	and	 metered_yn	= 'T'

	minus

	select location_no	from sfg.um00250t@umsrep.world
	where	 account_no > 0
);




--	C)
	select rtrim(location_no)    ||','|| 
		 ltrim(rtrim(house_no))||' '|| rtrim(street_pfx_dir)  ||' '|| rtrim(street_nm) ||' '|| 
		 rtrim(street_nm_sfx)  ||' '|| rtrim(street_sfx_dir)
	from	 sfg.um00100m@umsrep.world
	where	 location_no	in

(
(
	select rtrim(location_no)	
	from	 sfg.um00140t@umsrep.world
	where	 service_tp = 'WTR'
	and	 metered_yn	= 'T'

	minus

	select rtrim(location_no)
	from	 sfg.um00250t@umsrep.world
	where	 account_no > 0
)

	minus

	select rec_key
	from	 garland.adrResult_ums_location
	where	 verify_code > 50
);


--	======================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_analyze;
--	select * from garland.explain_indexed;
--	select * from garland.explain_constraint;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_cost;
--	select * from garland.explain_remote;
--	======================================================================

--	select table_name	from all_tab_columns@umsrep.world
--	where	 column_name in ( 'SERVICE_TP', 'SERV_TP' );

	set echo on;

