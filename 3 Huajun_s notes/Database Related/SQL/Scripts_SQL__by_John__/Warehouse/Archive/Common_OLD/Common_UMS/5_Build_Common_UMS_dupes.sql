	set echo	off;
--	===========================================================================

	alter session	set nls_date_format = 'yyyy-mm-dd';

	Truncate table	JDEACUTIS.Common_UMS	reuse storage;

--	===========================================================================

--	select count(*) from  

	insert	--+ append
	into		JDEACUTIS.Common_UMS

	select distinct
		b.address_id,
		b.addr_num,
		b.addr_pfx,
		b.addr_name,
		b.addr_type,
		b.addr_sfx,
		null, null,
		b.location_no,
		b.account_no,
		b.person_no,
		b.last_name,
		b.first_name,
		b.drivers_license,
		b.birth_date,
		null	
	from	garland.Basic_UMS		B
	where	translate(b.addr_num, '/1234567890','/') is null;

	Commit;

--	===========================================================================

	analyze table	JDEACUTIS.Common_UMS	compute statistics;	-- ******

--	===========================================================================

	select count(*)	"GARLAND"
	from	GARLAND.Common_UMS;

	select count(*)	"JDEACUTIS"
	from	JDEACUTIS.Common_UMS;

	select count(count(*))	"Dupes"
	from	JDEACUTIS.Common_UMS
	group by address_id
	having count(*) > 1;

--	select * from obj where object_name = 'COMMON_UMS';

--	===========================================================================
	set timing		off;
