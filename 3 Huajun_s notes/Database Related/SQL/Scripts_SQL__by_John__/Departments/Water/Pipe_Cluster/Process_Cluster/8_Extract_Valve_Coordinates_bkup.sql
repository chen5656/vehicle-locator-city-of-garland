--	===================================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';
--	===================================================================================

--	SEE  SDE\EXTRACT\EXTRACT_SDE_COORDINATES

--	===================================================================================
--	Extract point feature coordinates
--	===================================================================================

--	===================================================================================
--	This is the output table view

--	TRUNCATE table	gis.FEATURE_COORDINATES		reuse storage;

--	===================================================================================

declare

	compile_only	integer	:= 0;
	total_insert	integer	:= 0;
   
	feature_class	varchar2(40)	:= 'WTVA';
	feature_table	varchar2(40)	:= 'WATER_VALVE';
	utility_id		varchar2(40)	:= 'VALVE_ID';
	script		varchar2(2000);

begin

	if	compile_only > 0	then
		return;
	end if;
   
	select
	'  create or replace view jdeacutis.Temp_View as '				||
	' select ''' ||feature_class|| ''' feature_class, ' ||utility_id|| ' utility_id, feature_id, '	|| 
	' round(eminx) x1, round(eminy) y1, round(emaxx) x2, round(emaxy) y2, null referid, 0 lengths'	||
	' from gis.' ||table_name|| ' T, gis.' ||layer|| ' F where t.shape = f.fid'
	into Script		from sde.showtable where table_name = feature_table;

	EXECUTE IMMEDIATE Script;

--	dbms_output.put_line (Script);

	insert into gis.feature_coordinates select * from jdeacutis.Temp_View;

	Commit;

	select count(*) into total_insert from gis.feature_coordinates where featureclass = feature_class;
	dbms_output.put_line ( 'TOTAL INSERTS ' || total_insert );

end;
