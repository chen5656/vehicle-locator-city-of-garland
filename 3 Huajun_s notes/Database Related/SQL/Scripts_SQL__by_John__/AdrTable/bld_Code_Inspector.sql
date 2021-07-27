--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
-- alter session	set nls_date_format = 'yyyymmdd hh24:mi:ss';  
--	=====================================================================



--	POPULATE INSPECTORS USING GENERAL.CODE_NUISANCE AND GENERAL.CODE_RENTAL



--	=====================================================================
--	INSERT SCRIPT FOR CURRENT CODE INSPECTORS
/*	

	select	'	truncate table	garland.code_inspector    reuse storage;' 
			|| chr(10) " " from dual
 
	union all

	select * from (
	select
	'	insert into garland.code_inspector values ('''		||
	inspect_area ||''','''|| inspector ||''','''|| inspector_id ||''','''|| 
	phone 	 ||''','''|| apt_count ||''');'		" "
	from	garland.code_inspector
	order by lpad(inspect_area,4,'0')
	)

	union all
	select 	chr(10) || '	commit;'	" " from dual
	;

*/
--	==========================================================================================
--	TEMPORARY 
/*
	truncate table garland.code_inspector  reuse storage;

	insert into garland.code_inspector
	select inspector_district, inspector_name, '', inspector_phone, ''
	from garland.code_inspector_extract;
	
	select * from garland.code_inspector;
	
	commit;
*/
--	==========================================================================================
--	rebuild Code_Inspector table
--	=====================================================================
/*

	truncate table	garland.code_inspector    reuse storage;

	insert into garland.code_inspector values ('1','Josh Prewitt','',	'(972) 485-6400','');
	insert into garland.code_inspector values ('2','Tommy Cobb','',	'(972) 485-6418','');
	insert into garland.code_inspector values ('3','Ila Bryant','',	'(972) 485-6419','');
	insert into garland.code_inspector values ('4','Obed Balderas','','(972) 485-6413','');
	insert into garland.code_inspector values ('5','Lupe Campa','',	'(972) 485-6421','');
	insert into garland.code_inspector values ('6','Noe Torres','',	'(972) 485-6400','');
	insert into garland.code_inspector values ('7','Tyrone Walls','',	'(972) 485-6427','');
	insert into garland.code_inspector values ('8','Rudy Morales','',	'(972) 485-6412','');
	insert into garland.code_inspector values ('9','Christina Jasso','','(972) 485-6416','');
	insert into garland.code_inspector values ('10','Abner Avila','',	'(972) 485-6431','');

	insert into garland.code_inspector values ('21','Kurt Romero','',	'(972) 485-6422','');
	insert into garland.code_inspector values ('22','Jim Averre','',	'(972) 485-6409','');
	insert into garland.code_inspector values ('23','Shawn Weinstein','','(972) 485-6415','');
	insert into garland.code_inspector values ('24','Jason Wilhite','','(972) 485-6400','');

	commit;

	select * from garland.code_inspector order by lpad(inspect_area,4,'0');
*/
--	=====================================================================

