--	==========================================================================
	set	fetchrows;

	set	termout	off;
	set	charwidth	300;

	spool  c:\deacutis\extract\WATER.txt;		--  CHANGE

--	==========================================================================

	select
--			count(*),

			rec_key			||','||
			w.addr_num			||','||
			w.addr_pfx			||','||
			w.addr_name			||','||
			w.addr_type			||','||
			w.addr_sfx			||','||
			w.addr_code1		||','||
			w.addr_unit1		||','||
			w.parcel_id			||','||
			a.x_coord			||','||
			a.y_coord			||


			' '				" "
--	from		garland.adrResult_Input				--  CHANGE
	from		garland.adrResult_Water		w 		--  CHANGE

			,garland.cdreladr			a

	where		verify_code = 55

	and		a.parcel_id = w.parcel_id
	and		a.addr_name	= w.addr_name
	and		a.addr_type	= w.addr_type
	and		a.addr_pfx	= w.addr_pfx
	and		a.addr_num	= w.addr_num
	and		rtrim(a.unit_type) is null
	and		rtrim(a.unit_num)  is null

	order by 	a.addr_name, a.addr_type, a.addr_pfx, a.addr_sfx, a.addr_num
--	order by	a.parcel_id
	;
--	==========================================================================

	spool off;

	set	termout	on;
	set	charwidth;

	set	fetchrows;

--	==========================================================================
