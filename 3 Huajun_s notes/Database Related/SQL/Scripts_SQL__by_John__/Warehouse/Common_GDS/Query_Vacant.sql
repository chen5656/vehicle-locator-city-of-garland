	set echo	off;
--	=======================================================================================
--	Show all "bad number" tax addresses for 
--	=======================================================================================

--	select count(*)

--	select 
--		rpad(r.rec_key,12)   " ", rpad(a.acct_use,10) " ", 
--		rpad(r.addr_num, 05) " ", rpad(r.addr_pfx, 02) " ",
--		rpad(r.addr_name,20) " ", rpad(r.addr_type,04) " ", rpad(r.addr_sfx,02) " "


	select r.rec_key   ||';'|| a. acct_use ||';'||  r.addr_num ||';'||  r.addr_pfx ||';'||  
		 r.addr_name ||';'|| r.addr_type ||';'||  r.addr_sfx		

	" "
	from	garland.adrResult		r,
		garland.GDS_Account	a

	where	r.rec_key = a.account

	and 	nvl(acct_use,' ') not like 'C%'
	and	nvl(acct_use,' ') not like 'D%' 


--	and (	nvl(acct_use,' ') like 'C%'
--	or	nvl(acct_use,' ') like 'D%' ) 


	and r.verify_code between 20 and 49;


--	=======================================================================================
	set echo	on;
