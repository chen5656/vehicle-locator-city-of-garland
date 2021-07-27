	set echo	off;
--	================================================================
--	Alternative strategy

--	Add new Block Control records directly to Block_Control table
--	Update  Block Control records directly on Block_Control table

--	================================================================

--	A2

--	truncate table	garland.Block_Control	reuse storage;


	create or replace	view	garland.Block_Control_vw

	as select * 	from  garland.Block_Control;

