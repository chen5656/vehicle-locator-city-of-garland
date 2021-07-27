	set echo	off;
	set timing	on;
	set termout	off;
	set fetchrows;
--	=====================================================================================================
--	extract UMS electric addresses for GPL
--	=====================================================================================================

	spool	c:\deacutis\extract\UMS_Electric_Meter.txt;

--	truncate table 	plan_table		reuse storage;
--	explain plan	set statement_id = 'ums'  	for

	select	rec_key  ||','|| parcel_id ||','||
			addr_num ||','|| addr_pfx  ||','|| addr_name ||','|| addr_type ||','|| addr_sfx ||','||
			x_coord  ||','|| y_coord	
			" "
	from
(
	select	--+ use_hash (u)
			distinct
			r.rec_key  ,r.parcel_id ,
			r.addr_num ,r.addr_pfx  ,r.addr_name ,r.addr_type ,r.addr_sfx ,
			a.x_coord  ,a.y_coord	

	from		garland.adrResult		r,
			garland.ums_keys		u,
			garland.cdreladr		a

	where		r.rec_key	= rtrim(u.location_no)
	and		r.parcel_id = a.parcel_id
	and		r.addr_name	= a.addr_name
	and		r.addr_type	= a.addr_type
	and		r.addr_pfx	= a.addr_pfx
	and		r.addr_sfx	= a.addr_sfx
	and		r.addr_num	= a.addr_num
	and		r.verify_code = 55
)
	order by	addr_name, addr_type, addr_pfx, addr_sfx, addr_num;


--	select * from explain_plan;

	spool		off;

--	=====================================================================================================
	set echo	on;
	set timing	off;
	set termout	on;
	set fetchrows;
