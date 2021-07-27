--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	=====================================================================

--	execute	garland.BUILD_ALIAS_ABC

--	create or replace procedure garland.BUILD_ALIAS_ABC		AS

	DECLARE

--	=====================================================================

	compile_only	integer	:= 01;

	total_processed	integer	:= 0;
	title			varchar2(100);
	heading		varchar2(100);
	script		varchar2(2000);

BEGIN
	if	compile_only > 0		then
		return;
	end if;

	select 'ALIAS ABC  '||to_char(sysdate,'Mon dd hh24:mi') into heading from dual; 
	dbms_output.put_line(heading);
                                                                                                                                                                                           
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	insert into garland.adrAlias_Insert_vw	values (  0, 999999, 0, '9',   'B'
	,'*'  ,'BALSOM FIR'                      ,'*'   ,'*' 
	,''   ,'BALSAM FIR'                      ,''    ,'' 
	);
	insert into garland.adrAlias_Insert_vw	values (  0, 999999, 0, '9',   'B'
	,'*'  ,'FREEMONT'                        ,'*'   ,'*' 
	,''   ,'FREMONT'                         ,''    ,'' 
	);
	insert into garland.adrAlias_Insert_vw	values (  0, 999999, 0, '9',   'B'
	,'*'  ,'GARRETT'                         ,'*'   ,'*' 
	,''   ,'GARRET'                          ,''    ,'' 
	);
	insert into garland.adrAlias_Insert_vw	values (  0, 999999, 0, '9',   'B'
	,'*'  ,'GLEN MEADOWS'                    ,'*'   ,'*' 
	,''   ,'GLEN MEADOW'                     ,''    ,'' 
	);
	insert into garland.adrAlias_Insert_vw	values (  0, 999999, 0, '9',   'B'
	,'*'  ,'ROLLINGHILLS'                    ,'*'   ,'*' 
	,''   ,'ROLLINGHILL'                     ,''    ,'' 
	);
	insert into garland.adrAlias_Insert_vw	values (  0, 999999, 0, '9',   'B'
	,'*'  ,'SHINECOCK HILLS'                 ,'*'   ,'*' 
	,''   ,'SHINNECOCK HILLS'                ,''    ,'' 
	);
	insert into garland.adrAlias_Insert_vw	values (  0, 999999, 0, '9',   'B'
	,'*'  ,'STONEHEINGE'                     ,'*'   ,'*' 
	,''   ,'STONEHENGE'                      ,''    ,'' 
	);
	insert into garland.adrAlias_Insert_vw	values (  0, 999999, 0, '9',   'B'
	,'*'  ,'WYKES'                           ,'*'   ,'*' 
	,''   ,'WYKE'                            ,''    ,'' 
	);
	insert into garland.adrAlias_Insert_vw	values (  0, 999999, 0, '9',   'C'
	,'*'  ,'APPALACIA'                       ,'*'   ,'*' 
	,''   ,'APPALACHIA'                      ,''    ,'' 
	);
--	insert into garland.adrAlias_Insert_vw	values (  0, 999999, 0, '9',   'C'
--	,'*'  ,'CRESTED'                         ,'*'   ,'*' 
--	,''   ,'CRESTED COVE'                    ,''    ,'' 
--	);


	COMMIT;

END;
