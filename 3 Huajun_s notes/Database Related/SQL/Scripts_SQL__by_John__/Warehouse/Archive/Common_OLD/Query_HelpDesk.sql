set linesize 2000;
set pagesize 200;
alter session set nls_date_format = 'yyyy-mm-dd';


	  select * 
	  from gis.address
	  where  streetname = 'GARLAND'
	  and	 streetprefix = 'S'
--	  and	 streetnum = 2529
	  order by streetnum;
	  
	  
	  select *
	  from	 garland.gds_account
	  where	 addr_name like '%GARLAND%'
--	  and	 addr_num = 2925
	  order by addr_num;

	  
	  select *
	  from	 garland.common_tax
	  where	 tax_addr_name = 'GARLAND'
	  and	 tax_addr_pfx = 'S'
--	  and	 tax_addr_num = 2529
	  order by tax_addr_num;

	select *
	from	garland.adrResult_tax_gds
	where	addr_name = 'GARLAND'
	and	addr_num = 2925;

