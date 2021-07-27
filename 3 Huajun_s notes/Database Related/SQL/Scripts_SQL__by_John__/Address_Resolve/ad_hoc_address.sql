	set timing	off;
	set echo 	off;
--	===============================================================================================
	variable	str_num	number;
	variable	str_name	varchar2;
	variable	str_type	varchar2;
	variable	str_pfx	varchar2;
	variable	str_sfx	varchar2;

	execute :str_num		:= 2509;
	execute :str_name		:= upper ('glenbrook');

	execute :str_pfx		:= upper ('');	
	execute :str_type		:= upper ('');	
	execute :str_sfx		:= upper ('');	

--	==============================================================================================

	select  'ENTRY ' " ", 	lpad(:str_num, 06) " ", rpad(:str_pfx,06) " ", rpad(:str_name,20) " ", 
					rpad(:str_type,10) " ", rpad(:str_sfx,06) " "
	from	dual;

--	street
	select 'STREET' "str", addr_pfx " ", addr_name " ", addr_type " ", addr_sfx  " "
	from adrStreets
	where	addr_name = 	:str_name
--	and	addr_type = 	:str_type
--	and	addr_pfx  = 	:str_pfx
	;	

--	block
	select 'BLOCK' "blk", addr_pfx " ",   addr_name " ", addr_type " ", addr_sfx " ", 
					addr_block " ", start_lo  " ", stop_lo   " "
	from adrBlock
	where	addr_block =	trunc(:str_num, -2)	
	and	addr_name  = 	:str_name
--	and	addr_type  = 	:str_type
--	and	addr_pfx   = 	:str_pfx
	;	

--	segment block
	select 'SEGBLK' "segblk", addr_pfx " ", addr_name " ", addr_type " ", addr_sfx " ", addr_lo " ", addr_hi " "
	from trvehrcl
	where	:str_num	between trunc (addr_lo,-2) and trunc(addr_hi,-2) + 99
	and	addr_name = 	:str_name
--	and	addr_type = 	:str_type
--	and	addr_pfx  = 	:str_pfx
	;	
--	range
	select 'RANGE' "rng", addr_lo " ", addr_hi " ", addr_pfx " ", addr_name " ", addr_type " ", addr_sfx " " 
	from trvehrcl
	where	:str_num	between addr_lo and addr_hi
	and	addr_name = 	:str_name
--	and	addr_type = 	:str_type
--	and	addr_pfx  = 	:str_pfx
	;	

--	address
	select 'ADDRESS' "adr", addr_num " ", addr_pfx " ", addr_name " ", addr_type " ", addr_sfx " "
	from cdreladr
	where	addr_num  =		:str_num
	and	addr_name = 	:str_name
--	and	addr_type = 	:str_type
--	and	addr_pfx  = 	:str_pfx
	;	

--	address block
	select 'ADRBLK' "adrblk", addr_pfx " ", addr_name " ", addr_type " ", addr_sfx " ", addr_lo " ", addr_hi " "
	from trvehrcl
	where	trunc(addr_num,-2) = trunc(:str_num,-2)
	and	addr_name = 	:str_name
--	and	addr_type = 	:str_type
--	and	addr_pfx  = 	:str_pfx
	and	rownum < 6
	;	

--	============================================================================================
--	============================================================================================

	set echo	on;
