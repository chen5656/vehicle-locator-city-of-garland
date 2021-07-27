--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
--	=====================================================================

--	select * from jdeacutis.dcad_external where rownum < 11; 

--	select * from GIS.DCAD_2007_Parcels where rownum < 11; 

--	===============================================================================

	create or replace view garland.Temp_View	as
	select	
		item01		account,
		item02		owner_name,
		item03		owner_names,
		item04		initials
    	from	garland.GIS_Objects; 		   		   		   			  

--	===============================================================================

	truncate table	garland.GIS_Objects	reuse storage;

--	===============================================================================

	insert into garland.Temp_View (account, owner_name, owner_names)
	select	
		ltrim(rtrim(acct,		'"'),'"'),
		ltrim(rtrim(owner_name, '"'),'"'),
		ltrim(rtrim(replace(owner_name,'&'), '"'),'"')
	from	gis.DCAD_2007_PARCELS
	;

--	===============================================================================
/*
	insert into garland.Temp_View (account, owner_name)
	select	ltrim(rtrim(account_num,'"'),'"'),
			ltrim(rtrim(owner_name, '"'),'"')
	from	jdeacutis.DCAD_External
	;
*/
--	===============================================================================	
	
	select 
		rpad(account,	20)	account,  
		rpad(owner_name,	30)	owner_name, 
		rpad(owner_names,	30)	owner_names, 
		rpad(initials,	08)	initials
	from   garland.Temp_View
	where  rownum < 11; 
	
	COMMIT;
	Rollback;

--	===============================================================================
	