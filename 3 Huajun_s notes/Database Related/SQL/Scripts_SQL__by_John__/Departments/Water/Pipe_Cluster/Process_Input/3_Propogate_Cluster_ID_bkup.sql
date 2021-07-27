--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
-- alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
-- select sysdate from dual;	
--	====================================================================
--	Propogate Cluster ID across pipes have common interior nodes (positive)
--	===================================================================
--	Node Types
--		'V'		Valve			external node
--		'v'		Dead End		external node
--		'D'		Dangle		interior node
--	====================================================================

declare

	update_total	integer	:= 0;
	update_count	integer	:= 0;

begin

while update_count > 0	loop

	update garland.Water_IVR_Pipe_Work		P
	set	p.clusterID =
(
	select pp.clusterid
	from	garland.Water_IVR_Pipe_Work	PP
	where	pp.nodeID1 = p.nodeID2
	and	pp.nodeID1 > 0
)
	where	p.clusterID is null
	and	0 < any (p.nodeID1, p.nodeID2)
;

	COMMIT;

	update_count	:= sql%rowcount;
	update_total	:= update_total + update_count;

end loop;

	dbms_output.put_line ('Total Cluster ID assignments = ' || update_total);

end;

--	====================================================================
