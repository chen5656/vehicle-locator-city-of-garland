	set echo	off;
--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

--	===========================================================================
	spool	c:\deacutis\extract\TXU_Area.dat
--	===========================================================================
--	explain plan set statement_id =  'put'	into garland.plan_table	for

	select	a.parcel_id ||','|| g.item01
--	select	count(*)

	from		garland.GIS_Objects			g,
			garland.cdrelADR				a,
			garland.adrREsult_UMS_Location	u

	where		a.mslink	= to_number(u.segment_id)
	and		u.rec_key	= g.item01
	and		a.parcel_id  is not null;

--	===========================================================================
	spool off;
--	===========================================================================
	set echo	on;

