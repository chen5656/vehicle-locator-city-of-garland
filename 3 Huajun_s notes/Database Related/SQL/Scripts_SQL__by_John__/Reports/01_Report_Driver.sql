	set echo	off;
	set termout	off;	

--	=======================================================================================
--	generate spooled ASCII reports
--	=======================================================================================

--	=======================================================================================
--	build Police Dime Report for loading to Excel

	spool	c:\deacutis\report\police_dime_report.txt;
	@c:\deacutis\scripts\reports\police_dime_ascii.sql;
	spool	off;

--	=======================================================================================

	set echo	on;
	set termout	on;	
