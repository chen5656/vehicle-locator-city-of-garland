--	===========================================================
--	remove duplicate keys from address unit table
--	===========================================================

declare

	delete_total	number	:= 0;
	delete_count	number	:= 999;

begin

while delete_count > 0		loop
	
	delete from garland.address_unit
	where	rowid		in
(	
	select max(rowid)
	from	 garland.address_unit
	group by	addr_name,
			addr_type,
			addr_pfx,
			addr_sfx,
			addr_num,
			addr_bldg1,
			addr_unit1,
			addr_bldg2,
			addr_unit2
	having	count(*) > 1
);

	delete_count := sql%rowcount;
	delete_total := delete_total + delete_count;

end loop;

	commit;

	dbms_output.put_line ( 'total deletes = ' || delete_total);

end;
