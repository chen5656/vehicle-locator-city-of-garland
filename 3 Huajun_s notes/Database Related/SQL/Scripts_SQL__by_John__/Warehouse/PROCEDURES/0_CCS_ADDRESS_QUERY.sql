--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;

--	=====================================================================
--	does GIS.TAX.UMS occur multiple time
--	Dupes=2 occurs 3 times

	select counter adr_tax_ums, count(*) total from
	(
		select 
			address_id, tax_account, ums_id,
			count(*) counter
		from garland.ccs_address
		group by address_id, tax_account, ums_id
		having count(*) > 1
	)
	group by counter;

--	=====================================================================
--	does ADR.LGL.OWN.TEN have multiple GIS.TAX.UMS   
--	No

	select counter adr_lgl_own_ten, count(*) total from
	(
		select 
			count(*) counter,
			addr_name, addr_type, addr_prefix, addr_suffix, addr_number, 
			tax_legal_desc, tax_owner, ums_first_name, ums_last_name 
		from garland.ccs_address
		group by	addr_name, addr_type, addr_prefix, addr_suffix, addr_number, 
				tax_legal_desc, tax_owner, ums_first_name, ums_last_name 
		having count(distinct address_id||'.'||tax_account||'.'||ums_id) > 1         
	)
	group by counter;

--	=====================================================================
