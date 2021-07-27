	set echo off;
    set linesize	2000;
--	========================================================================================================
--	if tax OWNER contains ADDR1 then replace ADDR1 with ADDR2

	select 'ADDR1 IN OWNER' " ", address_id, tax_id, tax_owner, tax_addr1, tax_addr2	
	from garland.CCS_ADDRESS
	where rtrim(tax_addr1) is not null
	and	ltrim(rtrim(tax_owner)) like '%' || ltrim(rtrim(tax_addr1)) || '%'
	and	address_id < 1111		and rownum < 11;

	update garland.CCS_ADDRESS
	set	tax_addr1 = tax_addr2,
		tax_addr2 = ' '
	where rtrim(tax_addr1) is not null
	and	ltrim(rtrim(tax_owner)) like '%' || ltrim(rtrim(tax_addr1)) || '%'
--	and address_id < 1111
	;

--	========================================================================================================
--	if tax ADDR1 is empty then transfer ADDR2 to ADDR1

	select '-ADDR1' " ", address_id, tax_id, tax_owner, tax_addr1, tax_addr2	
	from garland.CCS_ADDRESS
	where rtrim(tax_addr1) is null
	and	rtrim(tax_addr2) is not null
	and	address_id < 1111		and rownum < 11;


	update garland.CCS_ADDRESS
	set	tax_addr1 = tax_addr2,
		tax_addr2 = ' '
	where rtrim(tax_addr1) is null
	and	rtrim(tax_addr2) is not null
--	and address_id < 1111
	;

--	========================================================================================================
--	if tax OWNER contains "in care of" and ADDR2 is empty, then give ADDR1 to ADDR2 and "in care of" to ADDR1
--	LEAVE AS IS UNLESS COMPLAINTS ARE RAISED (JAN 2006)

/*

	select '%' " ", address_id, tax_id, tax_owner, tax_addr1, tax_addr2	from garland.ccs_ADDRESS
	where	instr(tax_owner, '%') > 0
	and	rtrim(tax_addr2) is null
	and	address_id < 1111		and rownum < 11;

	update garland.CCS_ADDRESS
	set	tax_addr2	= tax_addr1,
		tax_addr1	= substr (tax_owner,    instr(tax_owner, '%')),
		tax_owner	= substr (tax_owner, 1, instr(tax_owner, '%') - 01)
	where	instr(tax_owner, '%') > 0
	and	rtrim(tax_addr2) is null
	and	address_id < 1111
	;

--	--------------------------------------------------

	select 'C/O' " ", address_id, tax_id, tax_owner, tax_addr1, tax_addr2	
	from garland.CCS_ADDRESS
	where	instr(tax_owner, ' C/O') > 0
	and	rtrim(tax_addr2) is null
	and	address_id < 1111		and rownum < 11;

	update garland.CCS_ADDRESS
	set	tax_addr2	= tax_addr1,
		tax_addr1	= substr (tax_owner,    instr(tax_owner, ' C/O')),
		tax_owner	= substr (tax_owner, 1, instr(tax_owner, ' C/O') - 01)
	where	instr(tax_owner, ' C/O') > 0
	and	rtrim(tax_addr2) is null
	and	address_id < 1111
	;

*/
--	================================================================================
--	if tax OWNER & ADDR1 both contain same "in care of" , then remove "in care of" from tax OWNER
--	NOT A PROBLEM AFTER ABOVE CORRECTIONS ARE MADE

/*
	select '% %' " ", address_id, tax_id, tax_owner, tax_addr1, tax_addr2	
	from garland.CCS_ADDRESS
	where	instr(tax_owner, '%') > 0
	and	tax_owner like '%' || ltrim(rtrim(tax_addr1),'%')
	and	address_id < 1111		and rownum < 11;

	update garland.CCS_ADDRESS
	set	tax_owner	= rtrim(substr (tax_owner, 1, instr(tax_owner, '%') - 01))
	where	instr(tax_owner, '%') > 0
	and	tax_owner	like '%' || rtrim(tax_addr1)
	and	address_id < 1111
	;
--	--------------------------------------------------
	select 'CO CO' " ", address_id, tax_id, tax_owner, tax_addr1, tax_addr2	
	from garland.CCS_ADDRESS
	where	instr(tax_owner, ' C/O') > 0
	and	tax_owner	like '%' || rtrim(tax_addr1)
	and	address_id < 1111		and rownum < 11;

	update garland.CCS_ADDRESS
	set	tax_owner	= rtrim(substr (tax_owner, 1, instr(tax_owner, ' C/O') - 01))
	where	instr(tax_owner, ' C/O') > 0
	and	tax_owner	like '%' || rtrim(tax_addr1)
	and	address_id < 1111
	;

*/
--	================================================================================

--	select * from garland.CCS_ADDRESS
--	where	rtrim(tax_id) is not null
--	and	address_id < 111;

--	================================================================================

--	ROLLBACK;
	COMMIT;

--	========================================================================================================
