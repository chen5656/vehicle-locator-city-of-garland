	set	echo		off;
	set 	termout	off;			--	<<<<<<<<<<<<
	set	timing	on;
--	===========================================================================

--	analyze table	garland.gis_verify_addr			compute statistics;
--	analyze table	garland.adrResult_UMS_Location	compute statistics;

--	===========================================================================

	spool  c:\deacutis\extract\WATER_ADDRESS.txt;

--	===========================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id = 'xxx'	into garland.plan_table	for
--	===========================================================================

--	select count(*)

	select

	 	replace (

			addr_num			||','||
			nvl(addr_pfx, ' ')	||','||
			addr_name			||','||
			nvl(addr_type,' ')	||','||
			nvl(addr_sfx, ' ')

		,'  ',' ')				||','||


			rec_key			||','||
			rpad(parcel_id,02)	||','||
			decode (sign(y_coord - 7018580), -1, 'S', 'N')	||','||

			decode (zone, 'WEST', 'W', 'E')			||','||		-- jun 2005
			decode (basin,'ROWLETT', 'ROWL', 'DUCK')											-- jun 2005
	" "
	from
(
	select	distinct
			adr.addr_num, adr.addr_pfx, adr.addr_name, adr.addr_type, adr.addr_sfx, 
			ums.rec_key, adr.parcel_id, adr.y_coord, adr.mslink,
			gis.item02  zone,
			gis.item03	basin
	from	
(
		select addr_name, addr_type, addr_pfx, addr_sfx, addr_num, parcel_id, y_coord, mslink
		from	garland.cdreladr
		where	addr_num <> 9999
)								ADR,

		garland.adrResult_UMS_Location	UMS,	
--		garland.adrResult				UMS,

		garland.GIS_Objects			GIS				--  becomes table GIS_WATER

		where	adr.parcel_id		= ums.parcel_id (+)

		and	adr.addr_name		= ums.addr_name	   (+)
		and	rtrim(adr.addr_num)	= rtrim(ums.addr_num (+) )

		and	adr.mslink			= to_number(gis.item01 (+))

		order by 	addr_name, addr_type, addr_pfx, addr_sfx, addr_num
)
	;

--	===========================================================================

	spool off;

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_constraint;
--	select * from garland.explain_column;
--	select * from garland.explain_analyze;

--	===========================================================================
	set 	termout	on;
	set	echo		on;
	set 	timing	off;



