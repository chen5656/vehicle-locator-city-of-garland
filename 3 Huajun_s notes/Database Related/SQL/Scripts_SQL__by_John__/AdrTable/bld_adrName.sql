	set echo off;
--	=======================================================

	truncate table garland.adrName  reuse storage;

	insert into garland.adrname (addr_name)
	select addr_name	from
(
	select addr_name  from garland.cdreladr
	union
	select addr_name  from garland.trvehrcl
	order by addr_name
)
	where length(addr_name) <= 20
	;

--	=======================================================
	set echo on;
