--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';

--	================================================================
--	HOW WELL DOES CODE DISTRICT MATCH UP WITH ADDRESS

	select count(*) ADDRESS, count(distinct parcelid) PARCEL_ID
	from gis.address;

	select count(*) CODE, count(distinct parcel_id) PARCEL_ID
	from jdeacutis.code_district_external;

	select count(*) ADDRESS_AND_CODE
	from     (
	select parcel_id from jdeacutis.code_district_external
	intersect
	select lpad(parcelid,7,'0') ||'.000' from gis.address
	);

--	================================================================
--	DOES CDRELPAR CONTAIN ANY OF THE MISSING PARCELS

	select count(*) CODE_NOT_ADDRESS   from (
	select parcel_id from jdeacutis.code_district_external
	minus
	select lpad(parcelid,7,'0') ||'.000' from gis.address
	);

	select count(*) ADDRESS_NOT_CODE   from (
	select lpad(parcelid,7,'0') ||'.000' from gis.address
	minus
	select parcel_id from jdeacutis.code_district_external
	);

--	================================================================
--	HOW WELL POPULATED IS CCS_ADDRESSES

	select count(*)  ccs_empty_aid
	from garland.ccs_addresses_make 
	where address_id is null;

	select count(*) ccs_empty_code
	from garland.ccs_addresses_make 
	where inspector_dist is null;

--	================================================================
