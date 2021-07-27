	set echo	off;	
--	=================================================================================
--	Create Common Address Keys  table
--	=================================================================================

	drop table		garland.Common_Address_Keys;

	create table	garland.Common_Address_Keys
	(
		addr_num			number(08,0),
		addr_pfx			varchar2(02),
		addr_name			varchar2(30),
		addr_type			varchar2(04),
		addr_sfx			varchar2(02),

		Source			varchar2(05),
		Parcel_ID			varchar2(11),
		Sequence			number(08,0),

		GIS_Key			number(08,0),
		TAX_Key			number(08,0),
		UMS_Key			number(08,0)
	)

		tablespace		gis_data
		nologging
		pctfree		05;

--	=================================================================================

	create index	garland.Common_Address_Keys_Name
		on		garland.Common_Address_Keys(addr_name)

		tablespace		gis_index
		nologging
		pctfree		05;

--	=================================================================================

