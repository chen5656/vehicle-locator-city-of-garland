	set echo		off;
	set timing		off;
--	======================================================================

--	build app Rowid reference table (to enhance mass update processing)

	select '*** build App RowID ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

--	=========================================================================================================

	@C:\deacutis\scripts\departments\water\tap_and_pipe\E_PIPE_NEAR_TAP_VIEW.sql

--	=========================================================================================================

	truncate table	garland.gis_app_rowid	reuse storage;

--	=========================================================================================================
--	truncate table	garland.plan_table		reuse storage;
--	explain plan  	set statement_id = 'xxx'	into garland.plan_table	for
--	=========================================================================================================

	insert into		garland.gis_app_rowid

	select	rownum,
			rec_rowid
	from	
(
	select	tap_id,
			pipe_id,
			rowid			rec_rowid
	from		garland.Temp_View3
	order by	1,2
);

	commit;

--	======================================================================

--	select * from garland.explain_plan;

	analyze table	garland.gis_app_rowid	compute statistics;

--	======================================================================


