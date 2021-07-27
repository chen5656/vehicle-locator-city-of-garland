	set echo off;
    set linesize	2000;
--	========================================================================================
--	check some previous problem addresses 

	select addr_number, addr_name, ums_last_name 
    from garland.ccs_address	where addr_name = 'WHITEOAK' and addr_number = 1602;	

	select addr_number, addr_name, rpad(tax_owner,20) tax_owner, rpad(tax_addr1,30) tax_addr1 
    from garland.ccs_address	where addr_name = 'SHILOH' and addr_number = 102;

  
--	========================================================================================    
    
