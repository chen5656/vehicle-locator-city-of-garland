	set echo 		off;
	set serveroutput	on;
	set timing		on;
--	=================================================================================
--	POPULATE PIPE GROUP
--	If Pipe 1 belongs to a Group and the connected Pipe 2 does not
--	then enroll Pipe 2 into the Group
--	=================================================================================

declare

	do_compile			integer	:= 0;

	output_count		integer	:= 01;
	output_prev			integer	:= 0;
	output_total		integer	:= 0;
	output_increase		integer	:= 0;

begin

	if	do_compile > 0			then
		return;
	end if;

	select count(*)
	into	 output_total
	from	 garland.View_Pipe_Group;

	dbms_output.put_line (	lpad(output_count,2) ||  '  Pipe Group Increase: ' || lpad(output_increase,6) || 
					'   Total: ' || lpad(output_total,6)  );

	output_prev	:= output_total;

loop

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table		for
--	=================================================================================

	insert into	 garland.View_Pipe_Group
	select distinct
		p.Pipe2_ID,
		g1.Group_ID	

	from	garland.View_Pipe_Pair		P,
		garland.View_Pipe_Group		G1

	where	p.Pipe1_ID = g1.Pipe_ID		
	and not exists
	(
		select 'x'
		from	garland.View_Pipe_Group		G2
		where	g2.Pipe_ID	= p.Pipe2_ID		
		and	g2.Group_ID	= g1.Group_ID
	);

--	=================================================================================
--	select * from garland.explain_Plan;
--	=================================================================================

	Commit;

	output_count := output_count + 01;
	if	output_count > 99			then
		dbms_output.put_line (	'Pipe Group Generator is LOOPING' );
		exit;
	end if;

	output_prev	:= output_total;

	select count(*)
	into	 output_total
	from	 garland.View_Pipe_Group;

	output_increase := output_total - output_prev;

	dbms_output.put_line (	lpad(output_count,2) ||  '  Pipe Group Increase: ' || lpad(output_increase,6) || 
					'   Total: ' || lpad(output_total,6)  );

	exit when	output_increase = 0;

			
end loop;

	DBMS_UTILITY.EXEC_DDL_STATEMENT ( 'analyze table garland.gis_TEMP3  compute statistics' );

end;


