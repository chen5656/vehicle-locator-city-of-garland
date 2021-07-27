	set echo off;
--	====================================================================

	TRUNCATE table	garland.UMS_Keys		reuse storage;

--	====================================================================

--	truncate table	garland.plan_table;
--	insert into		garland.plan_table (object_name,object_owner) values ( 'UM00250T' , '' );
--	insert into		garland.plan_table (object_name,object_owner) values ( 'UM00140T' , '' );
--	insert into		garland.plan_table (object_name,object_owner) values ( 'UM00200M' , '' );

--	====================================================================

--	explain plan	set statement_id = 'keys'	into garland.plan_table for

	insert 	--+ append
	into 		garland.ums_keys

	select	--+	ordered	full(x)	full(s)	full(a)	use_merge (a)

			distinct
			x.location_no,
			x.account_no,
			x.service_seq,
			a.person_no,
			rtrim(s.service_tp),
			0,0,0,				--	"many" indicators
			rpad(' ', 11)			--	parcel_id

	from
			sfg.um00250T@umsrep.world			x,		--	account location service
			sfg.um00140T@umsrep.world			s,		--	installed service
			sfg.um00200M@umsrep.world			a		--	account
--			,garland.adrResult_UMS_Location	l		--	utility location adrResolve

	where		x.account_no	= a.account_no
	and		x.location_no	= s.location_no
	and		x.service_seq	= s.serv_seq

--	and		rtrim(s.service_tp) = :serv_type			--  SPECIFY  <<<<<<<<<<<<<<<<<<<<<
	and		rtrim(s.service_tp) in ('WTR', 'SWR')


--	and		x.location_no	between 1 and 1000		--	TEST
--	and		x.location_no	= l.rec_key				--	filter per previous UMS run	
	;


	commit;

--	====================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_constraint;
--	select * from garland.explain_column;
--	====================================================================

	analyze table garland.ums_keys	compute statistics;

	select * from garland.ums_keys	where rownum < 11;

	select count(*) "TOTAL"			from garland.ums_keys;

--	====================================================================
	set echo	on;
	set timing	off;


