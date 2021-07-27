	set echo 		off;
    set linesize	2000;
	set stoponerror	on;
--	======================================================================
--	Job series to rebuild Common_UMS table
--	used by CCS_ADDRESSES  (Code Compliance Address view)
--	======================================================================

--		R E V I S I O N   R E Q U I R E D	


	select 'BUILD BASIC UMS ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;
--	@c:\deacutis\scripts\warehouse\common\common_ums\1_BUILD_BASIC_UMS.sql


	select 'UPDATE BASIC ADDRESS ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;
	@c:\deacutis\scripts\warehouse\common\common_ums\2_UPDATE_BASIC_ADDRESS.sql


	select 'BUILD REJECTION KEY ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;
	@c:\deacutis\scripts\warehouse\Common\common_ums\3_BUILD_REJECTION_KEY.sql


	select 'BUILD COMMON UMS ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;
	@c:\deacutis\scripts\warehouse\Common\common_ums\4_BUILD_COMMON_UMS.sql


--	======================================================================
--	select 'REMOVE EMPTY OCCUPANT ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;
--	@c:\deacutis\scripts\warehouse\Common\REMOVE_EMPTY_OCCUPANT.sql
--	======================================================================
/*

	select * from user_dependencies  where name = 'CCS_ADDRESSES';

	select column_name, data_type, column_id from all_tab_columns 
	where owner = 'GARLAND' and table_name = 'COMMON_UMS'
	minus

	select column_name, data_type, column_id from all_tab_columns 
	where owner = 'JDEACUTIS' and table_name = 'COMMON_UMS'

--	minus
--	select column_name, data_type, column_id from all_tab_columns 
--	where owner = 'GARLAND' and table_name = 'COMMON_UMS'
	;
*/

--	======================================================================
