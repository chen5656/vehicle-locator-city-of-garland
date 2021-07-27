--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================
--	Update Address info in Basic UMS with scrubbed address info
--	=====================================================================

--	execute	garland.SCRUB_ADDRESS_Fix_AdrResult;

	create or replace procedure garland.SCRUB_ADDRESS_Fix_AdrResult	as

--	DECLARE

--	=====================================================================

	compile_only	integer	:= 0;

	total_processed	integer	:= 0;
	title			varchar2(100);
	heading		varchar2(100);
	script		varchar2(2000);

BEGIN
	if	compile_only > 0		then
		return;
	end if;

	select '*** SCRUB ADDRESS Fix AdrResult  '||to_char(sysdate,'Mon dd hh24:mi') into heading from dual; 
	dbms_output.put_line(heading);

--	==========================================================================================
--	Fix non-address mistakes
--	When addr_name is a valid street name, but is padded w/spaces
--	Fix padded street and Fix Verify Code
--	==========================================================================================

	update garland.adrResult
		set	addr_name	=  nvl(rtrim(addr_name),' ')
		where	addr_name	> ' '
		and	addr_name	<> rtrim(addr_name);

	update garland.adrResult
		set	addr_type	=  nvl(rtrim(addr_type),' ')
		where	addr_type	> ' '
		and	addr_type	<> rtrim(addr_type);

	update garland.adrResult
		set	addr_pfx	=  nvl(rtrim(addr_pfx), ' ')
		where	addr_pfx	> ' '
		and	addr_pfx	<> rtrim(addr_pfx);

	update garland.adrResult
		set	addr_sfx	=  nvl(rtrim(addr_sfx), ' ')
		where	addr_sfx	> ' '
		and	addr_sfx	<> rtrim(addr_sfx);

	commit;

--	==========================================================================================


--	update garland.adrResult_Input	R			--	C H A N G E		<<<<<<<==========
	update garland.adrResult		R

	set	verify_code = 10,
		do_parse	= '.........',
		addr_name   = rtrim(addr_name),
		addr_type	= nvl(rtrim(addr_type),' '),
		addr_pfx	= nvl(rtrim(addr_pfx), ' '),
		addr_sfx	= nvl(rtrim(addr_sfx), ' ')

--	-----------------------------------------------------

	where	verify_code < 10

	and	ltrim(addr_num, '0123456789 ') is null

--	-----------------------------------------------------

	and	exists
(
	select 'x'
	from	garland.adrStreets
	where	addr_name = rtrim(r.addr_name)
);


	total_processed := sql%rowcount;
	dbms_output.put_line ( 'Scrub Address Fix total = ' || total_processed);

--	-----------------------------------------------------

--	rollback;
	commit;

--	-----------------------------------------------------
END;
