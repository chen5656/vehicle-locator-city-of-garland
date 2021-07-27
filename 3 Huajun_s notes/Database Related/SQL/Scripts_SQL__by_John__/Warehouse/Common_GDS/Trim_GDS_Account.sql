	set echo	off;
--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;			-- insure transaction
	set transaction use rollback segment rb1;

--	===========================================================================
	explain plan set statement_id = '111 '		into garland.plan_table	for

	update  garland.gis_temp4
	set

	ITEM01 =  ltrim(rtrim(ITEM01)),                                                
	ITEM02 =  ltrim(rtrim(ITEM02)),                                                
	ITEM03 =  ltrim(rtrim(ITEM03)),                                                
	ITEM04 =  ltrim(rtrim(ITEM04)),                                                
	ITEM05 =  ltrim(rtrim(ITEM05)),                                                
	ITEM06 =  ltrim(rtrim(ITEM06)),                                                
	ITEM07 =  ltrim(rtrim(ITEM07)),                                                
	ITEM08 =  ltrim(rtrim(ITEM08)),                                                
	ITEM09 =  ltrim(rtrim(ITEM09)),                                                
	ITEM10 =  ltrim(rtrim(ITEM10)),                                                
	ITEM11 =  ltrim(rtrim(ITEM11)),                                                
	ITEM12 =  ltrim(rtrim(ITEM12)),                                                
	ITEM13 =  ltrim(rtrim(ITEM13)),                                                
	ITEM14 =  ltrim(rtrim(ITEM14)),                                                
	ITEM15 =  ltrim(rtrim(ITEM15)),                                                
	ITEM16 =  ltrim(rtrim(ITEM16)),                                                
	ITEM17 =  ltrim(rtrim(ITEM17)),                                                
	ITEM18 =  ltrim(rtrim(ITEM18)),                                                
	ITEM19 =  ltrim(rtrim(ITEM19)),                                                
	ITEM20 =  ltrim(rtrim(ITEM20)),                                                
	ITEM21 =  ltrim(rtrim(ITEM21)) 
	;

--	===========================================================================
--	explain plan set statement_id = '222 '		into garland.plan_table	for

	update temp_view1		set

	owner_name  = replace(replace(replace( OWNER_NAME,  rpad(' ',4),' '), rpad(' ',3),' '), rpad(' ',2),' '),
	owner_addr1 = replace(replace(replace( OWNER_ADDR1, rpad(' ',4),' '), rpad(' ',3),' '), rpad(' ',2),' '),
	owner_addr2 = replace(replace(replace( OWNER_ADDR2, rpad(' ',4),' '), rpad(' ',3),' '), rpad(' ',2),' '),
	owner_addr3 = replace(replace(replace( OWNER_ADDR3, rpad(' ',4),' '), rpad(' ',3),' '), rpad(' ',2),' '),

	legal1  = replace(replace(replace( LEGAL1, rpad(' ',4),' '), rpad(' ',3),' '), rpad(' ',2),' '),
	legal2  = replace(replace(replace( LEGAL2, rpad(' ',4),' '), rpad(' ',3),' '), rpad(' ',2),' '),
	legal3  = replace(replace(replace( LEGAL3, rpad(' ',4),' '), rpad(' ',3),' '), rpad(' ',2),' '),
	legal4  = replace(replace(replace( LEGAL4, rpad(' ',4),' '), rpad(' ',3),' '), rpad(' ',2),' ')
	;
	
--	===========================================================================
--	insert into garland.plan_table(object_owner, object_name)values('GARLAND', '');

--	select * from garland.explain_plan;
--	select * from garland.explain_analyze;
--	select * from garland.explain_indexed;
--	select * from garland.explain_constraint;
--	select * from garland.explain_index;
--	select * from garland.explain_table;
--	select * from garland.explain_column;
--	select * from garland.explain_column order by 2,3,4;  -- by column name

	savepoint	xxx;		-- insure rollback
--	ROLLBACK;
	Commit;

	alter rollback segment rb1 offline;
--	===========================================================================
	set echo	on;



