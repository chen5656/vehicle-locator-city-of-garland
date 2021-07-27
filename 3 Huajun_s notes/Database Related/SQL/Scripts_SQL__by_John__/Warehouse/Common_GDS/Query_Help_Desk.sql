	set echo	off;
--	===========================================================
--	Research address problems in CODE Compliance
--	===========================================================

	variable	st_name	varchar2(40);
	variable	st_num	number;

	variable	owner1	varchar2(20);
	variable	owner2	varchar2(20);

--	===========================================================
--	NEVER specify '%%'

	execute	:st_name	:=		'%FIRST%';
	execute	:st_num	:=		2013;

--	execute	:st_name	:=		'%BUCKINGHAM%';
--	execute	:st_num	:=		101;

	execute	:owner1	:=		'%SAFEWAY%';
	execute	:owner2	:=		'';

--	===========================================================

	select 'TRVEHRCL'  " " from dual;

	select * 
	from trvehrcl

	where	addr_name	like		:st_name
	and 	:st_num	between	addr_lo and addr_hi

	order by addr_name, addr_lo;

--	===========================================================

	select 'CDRELADR'  " " from dual;

	select * 
	from cdreladr

	where	addr_name	like	:st_name
	and 	addr_num  =		:st_num

	order by addr_name, addr_num;

--	===========================================================

	select 'CCS ADDRESSES'  " " from dual;

	select * 
	from ccs_addresses

	where	addr_name	like 	:st_name
	and	addr_number =	:st_num

	order by addr_name, addr_number;
	
--	===========================================================

	select 'GDS ACCOUNT'  " " from dual;

	select * 
	from gds_account  

	where	addr_name like	:st_name
	and	addr_num =		:st_num

	order by addr_name, addr_num;

--	===========================================================

	select 'GDS OWNER'  " " from dual;

	select * 
	from gds_account  

	where	owner_name	like	:owner1
	or	owner_name	like	:owner2

	order by addr_name, addr_num;

--	===========================================================
	set echo	on;

