	set echo	off
	set termout off;
--	==============================================================================

	spool	c:\deacutis\extract\Rental_Teel.txt

	select 

		parcel_id			||','||
		addr_num			||','||
		addr_pfx			||','||
		addr_name			||','||
		addr_type			||','||
		addr_sfx			||
		' ' " "

	from	garland.Temp_View1
	where	known = '0'
	order by	addr_name, addr_type, addr_pfx, addr_sfx, addr_num;

	spool off

--	==============================================================================
	set echo	on
	set termout on;
