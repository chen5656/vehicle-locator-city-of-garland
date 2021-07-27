	set echo off;
--	==============================================================================

--	@c:\deacutis\scripts\departments\water\tap_and_pipe\A_VIEWS.sql


--	@c:\deacutis\scripts\departments\water\tap_and_pipe\D_BUILD_PIPE.sql


--	@c:\deacutis\scripts\departments\water\tap_and_pipe\E_PIPE_NEAR_TAP


	set timing on;
	@c:\deacutis\scripts\departments\water\tap_and_pipe\F_MEASURE_PROXIMITY.sql
	set timing off;


	@c:\deacutis\scripts\departments\water\tap_and_pipe\G_PIPE_NEAREST_TAP.sql


	@c:\deacutis\scripts\departments\water\tap_and_pipe\S_SUMMARY_REPORT.sql


--	@c:\deacutis\scripts\departments\water\tap_and_pipe\Q_QUERY_EXTRACT.sql

--	==============================================================================
	set echo on;

