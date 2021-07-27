	set echo		off;
	set termout		off;
	set charwidth	160;
--	=======================================================
	spool	c:\deacutis\extract\Sani_Revenue_Com.txt;
--	=======================================================

--	truncate table	garland.plan_table;
--	insert into 	garland.plan_table (object_name, object_owner) values ( '' , 'SFG' );

--	explain plan	set statement_id = 'sani asset'	into garland.plan_table		for

	select	'account;location;service;size;date;revenue;num;pfx;name;type;sfx;parcel;'	" "
	from	dual		" "
	union	all

	select 
		k.account_no	||';'||
		k.location_no	||';'||
		k.service_type	||';'||
		k.asset_no		||','||
		k.asset_size	||';'||
		k.asset_share	||';'||
		to_char(d.bill_date, 'mm/dd/yyyy')	||';'||
		d.revenue		||';'||

		r.addr_num		||';'||
		r.addr_pfx		||';'||
		r.addr_name		||';'||
		r.addr_type		||';'||
		r.addr_sfx		||';'||
--		r.addr_code1	||';'||
--		r.addr_unit1	||';'||
		r.parcel_id		||';'||

		' '			" "

	from	garland.ums_keys_sanitation		K,
		garland.adrResult_UMS_Location	R,
(
		select	location_no,
				account_no,
				service_seq,
				bill_date,
				detail_amt			revenue
		from	 	garland.ums_detail
)								D
	where	k.location_no	= r.rec_key
	and	k.location_no	= d.location_no
	and	k.account_no	= d.account_no
	and	k.service_seq	= d.service_seq
	and	k.many_locn_accts + k.many_locn_servs = 0

	and not exists				--	select commercial only (non-residential)
(
	select 'x'	
	from	 garland.nsa_dcad_res
	where	 parcel_id	= r.parcel_id
);

--	======================================================================

--	select * from garland.explain_plan;
--	select * from garland.explain_remote;

--	select * from garland.explain_indexed;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_constraint;
--	select * from garland.explain_column;

--	select * from garland.explains_indexed;
--	select * from garland.explains_table;
--	select * from garland.explains_index;
--	select * from garland.explains_constraint;
--	select * from garland.explains_column;

--	select * from garland.explain_analyze;
--	select * from garland.explains_analyze;
--	======================================================================
	set echo	on;
	set termout	on;

	spool		off;


