--	==========================================================================

	set	termout	off;

	spool  c:\deacutis\extract\WATER.txt;		--  CHANGE

--	==========================================================================

	select
			rec_key			||','||
			addr_num			||','||
			addr_pfx			||','||
			addr_name			||','||
			addr_type			||','||
			addr_sfx			||','||
			addr_code1			||','||
			addr_unit1			||','||
			parcel_id			||','||

			' '				" "
--	from		garland.adrResult_Input			--  CHANGE

	from		garland.adrResult_Water 		--  CHANGE

	where		verify_code = 55

	;
--	==========================================================================

	spool off;

	set	termout	on;

--	==========================================================================




