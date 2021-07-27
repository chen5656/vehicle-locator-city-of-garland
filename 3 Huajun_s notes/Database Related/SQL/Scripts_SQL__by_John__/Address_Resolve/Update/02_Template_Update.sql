	set echo	off;
	set timing	on;
--	====================================================================
--	Update address info on XXXX  using adrResult
--	====================================================================

--	alter rollback segment	rb1	 		online;
--	commit;
--	set transaction use 	rollback segment	rb1;

--	====================================================================

	truncate table	garland.plan_table	reuse storage;
	explain plan	set statement_id = 'REGION UPDATE'		for


	update  garland.temp_view1	u
	set
(
--	-------------------------------------------------

	 u.addr_num
	,u.addr_pfx
	,u.addr_name
	,u.addr_type
	,u.addr_sfx

--	,u.addr_code1
	,u.addr_unit1

	,u.parcel_id
	,u.address_id
	,u.verify_code


--	-------------------------------------------------
)
	=	
(
--	-------------------------------------------------
	select

	 r.addr_num
	,r.addr_pfx
	,r.addr_name
	,r.addr_type
	,r.addr_sfx

--	,r.addr_code1
	,r.addr_unit1

	,r.parcel_id
	,r.segment_id
	,r.verify_code


--	select count(*)						--  T E S T

--	----------------------------------------------------------------

	from		garland.adrResult		r

--			,garland.temp_view1	u		--  T E S T

	where		r.rec_key = rtrim(u.rec_key)

	
--	and exists							--  T E S T
 )	where exists

 (
	select	'x'
	from		garland.adrResult	
	where		rec_key = rtrim(u.rec_key)

--	----------------------------------------------------------------
--	Has change occurred in application table since extract ?

	and		nvl(appl_name,' ')	= upper(nvl(rtrim(u.addr_name),' '))
	and		nvl(appl_type,' ')	= upper(nvl(rtrim(u.addr_type),' '))
	and		nvl(appl_pfx, ' ')	= upper(nvl(rtrim(u.addr_pfx), ' '))
	and		nvl(appl_sfx, ' ')	= upper(nvl(rtrim(u.addr_sfx), ' '))
	and		appl_num			= u.addr_num

--	----------------------------------------------------------------
--	Specify Update Filter

	and		verify_code	> 0

--	----------------------------------------------------------------
);

	select * from explain_plan;

--	========================================================================

--	Rollback;
	commit;
--	alter rollback segment	RB1		offline;

--	========================================================================
	set echo	on;
	set timing	off;

