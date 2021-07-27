	set echo off;
	set timing	on;
--	===========================================================================
--	expand ums_keys to include sanitation size for asset_no
--	===========================================================================

	TRUNCATE table	garland.gis_temp4		reuse storage;	--	UMS_Keys_Sanitation

--	===========================================================================
--	truncate table	garland.plan_table	reuse storage;
--	insert into		garland.plan_table (object_name,object_owner) values ( 'UM00100M' , '' );

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	explain plan set statement_id = 'ums sani keys'	into garland.plan_table	for
--	===========================================================================

	insert 
	into		garland.ums_keys_sanitation

	select	--+	use_hash (l,k)	ordered
--			count(*)

			distinct
			k.location_no,
			k.account_no,
			k.service_seq,
			k.person_no,

			k.service_type,
			k.parcel_id,
			l.asset_no,
			rpad(jdeacutis.ums_attrib_value	('SW','FL', l.asset_no, 'SIZE'),05),
			rpad(jdeacutis.ums_fa_value		('UM','IA', l.asset_no, 'XFACT', 'UM', sysdate, 'SHARE'),03),
			k.many_acct_locns,
			k.many_locn_accts,
			k.many_locn_servs

	from		sfg.um00100M@umsp.world		l,			--	Location
			garland.ums_keys			k

	where		k.location_no	= l.location_no

	and		k.location_no	between 01 and 01111		--	TEST
	;

--	===========================================================================
	commit;
	alter rollback segment rb1 offline;

--	===========================================================================
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
--	===========================================================================

	analyze table	garland.gis_temp4		compute statistics;

	select * from garland.ums_keys_sanitation	where rownum < 11;

	select count(*) from garland.ums_keys_sanitation;

--	===========================================================================
--	===========================================================================
	set echo	on;
	set timing	off;
