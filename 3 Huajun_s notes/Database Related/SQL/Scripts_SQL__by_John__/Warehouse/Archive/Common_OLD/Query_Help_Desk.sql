	set echo off;
    set linesize	2000;
--	==============================================================

	variable	stname	varchar2(20);
	variable	stnum		number;
	
	execute	:stname :=		'WHITEOAK';		--	SPECIFY
	execute	:stnum  :=		1602			--	SPECIFY

--	==============================================================
--	CCS ADDRESSES

	select * 
	from garland.ccs_addresses
	where	rownum < 11

	and	addr_name = 	:stname
	and	addr_number = 	:stnum
	;

--	==============================================================
--	CDRELADR  CDRELPAR  aR_TAX

	select a.mslink, a.parcel_id, a.addr_num, a.addr_pfx, a.addr_name, a.addr_type, a.addr_sfx, 
		'geo>>>' " ", nvl(p.code_inspect_area, '???') " ",
		'tax>>>' " ", nvl(t.rec_key, '???') " "

	from	garland.cdreladr			A,
		garland.cdrelpar			P,
		garland.adrResult_TAX_GDS	T

	where	a.parcel_id		= p.parcel_id (+)

	and	a.mslink		= to_number(t.segment_id (+))

	and	a.addr_name =	:stname
	and	a.addr_num  =	:stnum
	;

--	==============================================================
--	GDS ACCOUNT

	select  account, addr_num, addr_name, owner_name
	from	  garland.GDS_ACCOUNT

	where	addr_name like	'%' || :stname || '%'
	and	addr_num =		lpad(:stnum, 7,'0')

	order by addr_name, addr_num;

--	==============================================================


--	select * from garland.cdrelpar
--	where	parcel_id in ( '2601383.000',  '2601384.000'  )
--	;

--	==============================================================
/*

	delete from garland.cdreladr 

	where mslink = 10907

	and	parcel_id = '6500414.000'
	;

--	rollback;
	commit;

*/
--	==============================================================
	set echo on;
