--	=====================================================================
	select * from viewer.me;
	BEGIN  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  END;
set	TIMING		OFF;
set	sqlblanklines	on;
set	serveroutput	on	size 99999;
set	linesize		1000;
set	pagesize		0000;
--	execute jdeacutis.show_table_column	('', '', '');
--	execute jdeacutis.show_source		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_error		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_view		('', '', '');
--	execute jdeacutis.show_index_column	('', '', '');
--	SELECT  to_char(sysdate,'Mon dd,yyyy hh24:mi')||'  ***  ' " "  from dual;
--	EXECUTE jdeacutis.TEST_PROC;
--	CREATE or replace procedure jdeacutis.TEST_PROC  as
--	DECLARE
--	=====================================================================	
--	================================================================

set echo off;

/*
select count(*) from
(
SELECT * FROM gis.address_gis
minus
SELECT * FROM gis.address_sde
)
;

select '  , ' ||column_name
from  all_tab_columns
where table_name = 'ADDRESS'
order by column_id;
*/



select count(*) from
(
select
  ' '
  , ADDRESSID
  , STREETNUM
  , STREETLABEL
  , STREETPREFIX
  , STREETNAME
  , STREETTYPE
  , STREETSUFFIX
  , BUILDING
  , UNIT
  , ZIPCODE
  , ZIPPLUS
  , STATUS
  , PARCELID
  , ROADID
  , STREETID
  , XCOORD
  , YCOORD
  , CREATED
from sde.address_plan
MINUS
select
  ' '
  , ADDRESSID
  , STREETNUM
  , STREETLABEL
  , STREETPREFIX
  , STREETNAME
  , STREETTYPE
  , STREETSUFFIX
  , BUILDING
  , UNIT
  , ZIPCODE
  , ZIPPLUS
  , STATUS
  , PARCELID
  , ROADID
  , STREETID
  , XCOORD
  , YCOORD
  , CREATED
from gis.address_gis
);

--	================================================================
