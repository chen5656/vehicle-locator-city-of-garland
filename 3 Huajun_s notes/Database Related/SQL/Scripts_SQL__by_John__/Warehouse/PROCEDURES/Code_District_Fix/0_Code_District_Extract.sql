--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
-- alter session	set nls_date_format = 'yyyymmdd hh24:mi:ss';  
--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into jdeacutis.plan_table for
--	=====================================================================

--	drop table garland.Code_District_Extract;

	create table garland.Code_District_Extract
		tablespace	gis_data
		nologging
	AS

Select distinct
	p.PARCEL_ID + 0				parcel_id,
	p.CODE_NUISANCE + 0			nuisance_district,
	n.INSPECTOR					nuisance_inspector,
	n.PHONE					nuisance_phone,
	p.CODE_RENTAL + 0				rental_district,
	r.INSPECTOR_name				rental_inspector,	
	r.inspector_PHONE				rental_phone,			
	decode(rp.parcel_id, null,0,1)	is_rental,
	ltrim(p.COUNCIL_ID) + 0			council_id,
	ltrim(P.POLICE_BEAT)+ 0			police_beat,
	ltrim(P.ZIP_CODE)   + 0			zip_code,
	P.PARCELID || '.000'			parcelid_old,
	P.CDBG					cdbg

From	gis.Parcel_Point				P,
	Garland.Code_Inspector			N,
	garland.Code_Inspector_EXTRACT	R
	,Garland.Rental_Properties_EXTRACT	RP

Where	p.code_nuisance	= n.inspect_area 
and	p.code_rental	= r.inspector_district	(+)
and	p.parcel_id		= rp.parcel_id		(+)
;

--	=====================================================================

	create index garland.code_district_extract_pid
		on	 garland.code_district_extract(parcel_id)
		tablespace gis_data
		nologging;

--	=====================================================================

	select count(*) total from garland.Code_District_Extract;

	select count(*) dupe_parcel from
	(
	select parcel_id 
	from	garland.Code_District_Extract
	group by parcel_id
	having count(*) > 1    
	);

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('GIS', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================