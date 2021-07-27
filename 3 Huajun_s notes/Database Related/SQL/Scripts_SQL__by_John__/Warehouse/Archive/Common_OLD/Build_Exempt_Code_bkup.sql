	set echo	off;
    set linesize	2000;
--	===========================================================================
--	Find Exemption Codes for each TAX Account
--	===========================================================================

	Truncate table	garland.GIS_Temp2;

--	===========================================================================

	create or replace view	garland.Temp_View2
(
	account,
	exempt1,
	exempt2,
	exempt3
)
	select	item01, item02, item03, item04 
	from		garland.GIS_Temp2;

--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	===========================================================================
	explain plan set statement_id =  'exempt'		into garland.plan_table	for

	insert --+ append
	into	 garland.Temp_View2

	select	T.account, A.exempt_code, B.exempt_code, null

	from		garland.GDS_Account		T,
			garland.GDS_Exemption		A,	
			garland.GDS_Exemption		B,
		(
			select
			decode (	sign( to_char(sysdate,'mm') - 02),  			--  VERIFY
					1,	to_char(sysdate,'yyyy'), 
						to_char(sysdate,'yyyy') - 01	)	tax_year
			from	Dual 
		)						D

	where		t.account		= a.account (+)
	and		t.account		= b.account (+)

	and		a.tax_year (+)	= d.tax_year
	and		b.tax_year (+)	= d.tax_year

	and		a.exempt_code (+)  in ( 'HS' )						--  REVISE
	and		b.exempt_code (+)	 in ( 'HS' )
	;

--	===========================================================================
	select * from garland.explain_plan;
--	select * from garland.explain_indexed;

	commit;
	alter rollback segment rb1 offline;
--	===========================================================================
	set echo	on;



