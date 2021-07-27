	set	echo		off;
	set 	termout	off;
--	set timing		on;
--	===========================================================================

--	analyze table	garland.gis_verify_addr			compute statistics;
--	analyze table	garland.adrResult_UMS_Location	compute statistics;

	truncate table	garland.plan_table	reuse storage;

	spool  c:\deacutis\extract\water_address.txt;

--	explain plan set statement_id = 'xxx'	into garland.plan_table	for

--	===========================================================================

--	select count(*)

	select
	 	replace (
			addr_num			||','||
			rtrim(addr_pfx)		||','||
			addr_name			||','||
			rtrim(addr_type)		||','||
			rtrim(addr_sfx)
		,'  ',' ')				||','||

			rec_key			||','||
			rpad(parcel_id,02)	||','||
			decode (sign(y_coord - 7018580), -1, 'S', 'N')	
	" "
	from
(
	select	adr.addr_num, adr.addr_pfx, adr.addr_name, adr.addr_type, adr.addr_sfx, 
			ums.rec_key, adr.parcel_id, adr.y_coord
	from	
(
		select addr_name, addr_type, addr_pfx, addr_sfx, addr_num, parcel_id, y_coord
		from	garland.cdreladr
		where	addr_num <> 9999
)								ADR,

		garland.adrResult_UMS_Location	UMS	
--		garland.adrResult				UMS	

		where	adr.parcel_id = ums.parcel_id (+)
		and	adr.addr_name = ums.addr_name (+)
		and	rtrim(adr.addr_num)  = rtrim(ums.addr_num (+) )

)
	order by 	addr_name, addr_type, addr_pfx, addr_sfx, addr_num;

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

