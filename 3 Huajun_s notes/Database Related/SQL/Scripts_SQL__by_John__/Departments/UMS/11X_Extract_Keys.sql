	set echo 	off;
	set timing	on;
--	===================================================================

--	TRUNCATE table	garland.ums_keys		reuse storage;		--	<<<<<<<=================

--	===================================================================
--	specify service type 

	variable	 serv_type	varchar2(5);

	execute	:serv_type	:= 'EL';						--	<<<<<<<=================

--	service types	
--		'EL'		electric	
--		'WTR'		water
--		'SWR'		sewer
--		'STM'		storm water
--		'SWRSD'	sanitation

--	=======================================================================================
--	truncate table	plan_table		reuse storage;
--	insert into	garland.plan_table (object_name,object_owner) values ( 'UM00250T' , '' );
--	insert into	garland.plan_table (object_name,object_owner) values ( 'UM00140T' , '' );
--	insert into	garland.plan_table (object_name,object_owner) values ( 'UM00200M' , '' );
--	=======================================================================================

	alter rollback segment	rb1			online;
	commit;
	set transaction use rollback segment	rb1;

	explain plan	set statement_id = 'keys'		for

	insert 	--+ append
	into garland.ums_keys

	select	--+	ordered	full(x)	full(s)	full(a)	use_merge (a)

--			count(*)

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

	and		rtrim(s.service_tp) = :serv_type

--	and		x.location_no	between 1 and 1000		--	TEST

--	and		x.location_no	= l.rec_key				--	filter per previous run
	;


	commit;
	alter rollback segment	rb1		offline;

--	=======================================================
	select * from garland.explain_plan;
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

	select * from garland.explain_analyze;
	select * from garland.explains_analyze;
--	=======================================================

--	analyze table ums_keys			estimate statistics;

	select * from garland.ums_keys	where rownum < 11;

	select count(*) "TOTAL"			from garland.ums_keys;

--	=======================================================
	set echo	on;
	set timing	off;

