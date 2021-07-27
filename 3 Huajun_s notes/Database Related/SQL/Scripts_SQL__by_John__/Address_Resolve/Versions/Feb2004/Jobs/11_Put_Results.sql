	set echo 	off;
	set timing	on;
--	===================================================================================
	Select '*** Put adrResult to Extract ***  ' " ", 
			to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;
--	===================================================================================
--	describe application 	

	COMMENT on table	garland.adrResult_Extract is	'CODEADDR Nov 2004';		-- CHANGE

--	====================================================================================
--	Load adrResult into adrResult_Extract
--	====================================================================================

	Truncate table	garland.adrResult_Extract	reuse storage;

--	alter rollback segment	rb1			online;
--	commit;
--	set transaction	use rollback segment	rb1;

	insert /*+ append */ 	into garland.adrResult_Extract	
	select * 			from garland.adrResult;		

	commit;
--	alter rollback segment	rb1			offline;

	analyze table	garland.adrResult_Extract		compute statistics;

--	===================================================================================
	set echo	on;
	set timing	off;

