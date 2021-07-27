	set echo		off;
	set termout		off;
	set charwidth	160;

	spool	c:\deacutis\extract\Sani_Revenue_Com.txt;
--	=======================================================

--	analyze table	garland.gis_temp3		compute statistics;
--	insert into plan_table (object_name, object_owner) values (upper( ' ' ),	'GARLAND');

--	truncate table	garland.plan_table;
--	explain plan	set statement_id = 'sani asset'	into garland.plan_table		for


	select
		'account;location;parcel_id;num;pfx;name;sfx;code;unit;revenue;asset_no;type;set_dt;perc;mult;'
	||	'mon;tue;wed;thu;fri;sat;sun;size;can;owner;busi'
	from	dual		" "
	union all

	select 
		k.account_no	||';'||
		k.location_no	||';'||
		r.parcel_id		||';'||
		r.addr_num		||';'||
		r.addr_pfx		||';'||
		r.addr_name		||';'||
		r.addr_sfx		||';'||
		r.addr_code1	||';'||
		r.addr_unit1	||';'||
		d.revenue		||';'||

		a.asset_no		||';'||
		a.asset_type	||';'||
		a.set_date		||';'||
		a.percentage	||';'||
		a.multiplier	||';'||
		a.mon			||';'|| 
		a.tue			||';'|| 
		a.wed			||';'|| 
		a.thu			||';'|| 
		a.fri			||';'|| 
		a.sat			||';'||
		a.sun			||';'||
		a.sizes		||';'||
		a.container_no	||';'||
		a.owned		||';'||
		a.business		||';'||
		' '			" "

	from	garland.ums_keys				K,
		garland.adrResult_UMS_Location	R,
		garland.sani_asset_view			A,
(
		select	location_no,
				account_no,
				service_seq,
				sum(detail_amt)		revenue
		from	 	garland.ums_detail
		group by	location_no,
				account_no,
				service_seq
)								D

	where	k.location_no	= a.location_no (+)
	and	k.location_no	= r.rec_key

	and	k.location_no	= d.location_no
	and	k.account_no	= d.account_no
	and	k.service_seq	= d.service_seq

	and	k.many_locn_accts + k.many_locn_servs = 0

	and not exists
(
	select 'x'
	from	 nsa_dcad_res
	where	 parcel_id	= r.parcel_id
);


--	======================================================================
--	select * from garland.explain_remote;
--	select * from garland.explain_plan;
--	select * from garland.explain_analyze;
--	select * from garland.explain_indexed;
--	select * from garland.explain_constraint;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_cost;
--	======================================================================
	set termout	on;
	set echo	on;

	spool		off;


