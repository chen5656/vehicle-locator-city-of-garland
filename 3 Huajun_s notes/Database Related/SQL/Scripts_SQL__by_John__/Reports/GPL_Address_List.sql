	set echo		off;
	set termout		off;
--	set fetchrows	111;
--	=====================================================================================================

	spool  c:\deacutis\extract\gpl_address_list.txt

--	=====================================================================================================


	select	addr_name ||','|| addr_type ||','|| addr_pfx ||','|| addr_sfx ||','|| addr_num ||','||

			trunc(x_coord)   ||','|| trunc(y_coord)	||','|| 

			rpad(replace(parcel_id,'4A','89'),7)	||','|| 	mslink

	" "
	from	cdreladr
	
	where	addr_num <> 9999

	and	rtrim(unit_type) is null
	and	rtrim(unit_num)  is null

	
--	and	parcel_id like '4A%'

	order by	addr_name, addr_type, addr_pfx, addr_sfx, addr_num;


--	=====================================================================================================

	spool off;

--	=====================================================================================================
	set echo		on;
	set termout		on;
	set fetchrows;
