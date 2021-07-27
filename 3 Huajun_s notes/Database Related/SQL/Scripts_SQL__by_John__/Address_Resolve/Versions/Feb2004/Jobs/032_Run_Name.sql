	set echo	off;
	select '*** Name Run ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

--	=======================================================================================================
  
	@c:\deacutis\scripts\address_resolve\rules\Rule_Norm_Name.sql;
--  	@c:\deacutis\scripts\address_resolve\rules\Rule_Risk_Name.sql;
--  	@c:\deacutis\scripts\address_resolve\rules\Rule_Safe_Name.sql;


	@c:\deacutis\scripts\address_resolve\jobs\08_Main_Run.sql;


	@c:\deacutis\scripts\address_resolve\51_Name_Report.sql;

	@c:\deacutis\scripts\address_resolve\alterations\00_Make\0_Make_Name_Alters.sql;


--	=======================================================================================================
	select '*** Finish Name Run ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;
	set echo	on;
