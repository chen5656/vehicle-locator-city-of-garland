--	=====================================================================
set termout		off;
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 99999;
set linesize	2000;
set pagesize	9999;

--	=====================================================================
--	Spool & Execute

	spool off
	spool	c:\deacutis\sde\EXECUTE.sql
	spool off
	spool	c:\deacutis\sde\EXECUTE.sql
--	-------------------------------------------------------------------

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into jdeacutis.plan_table for
--	=====================================================================

--	select count(*)
	select	g.Account ||';'|| d.ACCT ||';'|| 
		r.addr_Num ||';'|| r.addr_Pfx ||';'|| r.addr_Name ||';'|| r.addr_Type ||';'|| r.addr_Sfx ||';'||  
		g. owner_name ||';'|| y.net_taxable_value ||';'||
		r.Parcel_id ||';'|| r.Segment_id
	" "
	from	garland.GDS_ACCOUNT			G,
		garland.adrResult_TAX_GDS		R,
		garland.GDS_YEAR			Y,
		gis.DCAD_COMMERCIAL_2006		D

	where	g.pidn		= d.acct	
	and	g.account	= y.account + 0
	and	g.account	= r.rec_key (+)	

--	where	d.acct		 = g.pidn (+)
--	and	d.acct		= y.account(+)
--	and	g.account	= r.rec_key (+)	
	;

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('JDEACUTIS', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

--	-------------------------------------------------------------------
	spool off
	@c:\deacutis\sde\EXECUTE.sql
--	=====================================================================

set timing	on;



