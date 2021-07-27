--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

	select * from all_sequences where sequence_name like '%CCS_IDENTIFIER%';

	select count(*) CCS_ADDR_OLD  from garland.ccs_address;
	select count(*) CCS_ADDR_NEW  from garland.ccs_address_new;

	select count(*) CCS_IDEN_OLD  from garland.ccs_identifier;
	select count(*) CCS_IDEN_NEW  from garland.ccs_identifier_new;

--	=====================================================================

--	how many nulls in address

	select count(*) CCS_ADDR_NULLS from garland.ccs_address_new
	where addr_type is null or addr_prefix is null or addr_suffix is null;

	select count(*) CCS_IDEN_NULLS from garland.ccs_identifier_new
	where addr_type is null or addr_prefix is null or addr_suffix is null;

--	how many UNASSIGNED RECORD_SEQ

	select count(*) UNASSIGNED
	from garland.ccs_address_new
	where record_seq is null
	or record_seq < 1
	;
   
--	how many DUPE RECORD_SEQ

	select A.record_seq, A.* 
	from garland.ccs_address_new	A
	where record_seq in
	(
	select record_Seq
	from garland.ccs_address_new
	group by record_seq
	having count(*) > 1
	);

--	does CCS_ID = RECORD_SEQ   

	select count(*) CCS_RECSEQ   from (
	select record_seq from garland.ccs_address_new
	intersect
	select ccs_id from garland.ccs_identifier_new
	);

--	how many GIS only
	select count(*)  GIS_ONLY
	from garland.ccs_address_new
	where tax_id is null
	and   ums_id is null;

--	how many TAX only
	select count(*)  TAX_ONLY
	from garland.ccs_address_new
	where address_id is null
	and   ums_id is null;

   
--	how many DUPE IDENTIFIER Addresses

	select counter Address_Dupes, count(*) Cases
	from
(
	select count(*) counter
	from garland.ccs_identifier_new	
	group by addr_name, addr_number, addr_type, addr_prefix, addr_suffix
	having count(*) > 1
)	
	group by counter
	order by 1;

--	=====================================================================
/*

--	research CCS ADDRESS
	select 'CCS ADDRESS' " ", A.record_seq, A.*
	from garland.ccs_address_new		A
	where addr_name = ''
	and   addr_number in ( )
	order by addr_name, addr_number
	;

--	research CCS IDENTIFIER
	select 'CCS IDENTIFIER' " ", I.*
	from garland.ccs_identifier_new	I
	where addr_name = ''
	and   addr_number in ( )
	order by addr_name, addr_number
	;


--	research CCS_ADDRESS_MAKE
	select count(*) ADDRESS_MAKE
	from
		garland.Common_Address_Keys	K,
		garland.Common_Record_Seq	S,
		garland.Common_GIS		G,
		garland.Common_TAX		T,	
		garland.Common_UMS		U,	
		garland.Code_District		C		-- mar 12 2006
	where	k.gis_key			= g.address_id	  (+)
	and	k.tax_key			= t.tax_account	  (+)
	and	k.ums_key			= u.location_no	  (+)
	and	g.parcel_id			= lpad(c.parcel_id  (+),7,'0') || '.000'
	and	s.gis_key			= nvl(k.gis_key,0)
	and	s.tax_key			= nvl(k.tax_key,0)
	and	s.ums_key			= nvl(k.ums_key,0)

	and	k.addr_name = 'SHILOH'
	and	k.addr_num  = 102
	;

*/
--	=====================================================================

