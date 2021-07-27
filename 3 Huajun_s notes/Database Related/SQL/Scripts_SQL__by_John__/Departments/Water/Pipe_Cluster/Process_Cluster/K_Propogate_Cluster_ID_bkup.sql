--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
--	====================================================================
--	Propogate Cluster ID across Pipes having common Interior nodes 
--	===================================================================

	select sysdate || '***   Cluster ID Propogation   ***' " "	from dual;   

declare

	update_count	integer	:= 999;
	update_total	integer	:= 0;

begin

while update_count > 0	loop

	update garland.Water_IVR_Pipe_Work		T
	set	t.ClusterID =
(
	select s.Clusterid
	from	garland.Water_IVR_Pipe_Work		S
	where	s.NodeID1 = t.NodeID2
	and	upper(s.NodeType1) = 'I'
)
	where	t.ClusterID is null
	and	upper(t.NodeType2) = 'I'
;

	COMMIT;

	update_count	:= sql%rowcount;
	update_total	:= update_total + update_count;

	dbms_output.put_line ('Cluster ID Propogation Count = ' || update_count);

end loop;

	dbms_output.put_line ('Cluster ID Propogation Total = ' || update_total);

end;

--	====================================================================

