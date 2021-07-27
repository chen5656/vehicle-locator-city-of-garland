--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	1000;
set pagesize	9999;
--	alter session	set nls_date_format = 'yyyymmdd';  
--	=====================================================================

--	NOT CREATED NOR MAINTAINED YET	MAY 11 2007

--	=====================================================================


	create table garland.Address_Region
(
	addressid		number(10,0),
	parcelid		number(10,8),
	streetnumber	number(06,0),
	streetprefix	varchar2(02),
	streetname		varchar2(20),
	streettype		varchar2(04),
	streetsuffix	varchar2(02),
	streetlabel		varchar2(40),
	zip_code		varchar2(05),
	council		varchar2(02)
	code_nuisance	varchar2(02),
	code_rental		varchar2(03),
)
	tablespace		gis_data
	nologging;


