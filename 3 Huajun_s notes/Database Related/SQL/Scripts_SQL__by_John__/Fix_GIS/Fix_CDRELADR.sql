	set echo	off;
--	=========================================================
--	display, update, & display  CDRELADR 
--	=========================================================

--	=========>>>>>>>>	CHECK ROLLBACK	<<<<<<<<<<<==========

--	=========================================================

--	MSLINK 20 PARCELID 3701159.000 321 WALNUT CIRCLE EAST CHANGE TO 
--	  PARCELID 3701608.000 321 E WALNUT ST



	select parcel_id, addr_num, addr_pfx, addr_name, addr_type, addr_sfx, x_coord, y_coord, mslink
	from garland.cdreladr
	where	rownum < 99	

	and	parcel_id	in ( '3701159.000', '0.000' )

	and	addr_num	in ( 321 )
	and	addr_name	in ( 'WALNUT CIRCLE EAST', '' )

--	and	addr_pfx	in ( '', '' )
--	and	addr_type	in ( '', '' )
	;

--	=========================================================

	update garland.cdreladr
	set	mapid = mapid

--		,parcel_id	= '2701358.000'

--		,x_coord	=	2569551.67465
--		,y_coord	=	7002371.38341


		,addr_name	= 'WALNUT'
		,addr_pfx	= 'E'
		,addr_type	= 'ST'
	
	where	rownum < 99	

	and	parcel_id	in ( '3701159.000', '0.000' )

	and	addr_num	in ( 321 )
	and	addr_name	in ( 'WALNUT CIRCLE EAST', '' )

--	and	addr_pfx	in ( '', '' )
--	and	addr_type	in ( '', '' )
	;

--	=========================================================
/*

	delete from garland.cdreladr
	where	rownum < 99	
	and	parcel_id	in ( '', '' )
	and	addr_num	in ( '' )
	and	addr_name	in ( '', '' )
--	and	addr_pfx	in ( '', '' )
--	and	addr_type	in ( '', '' )
	;

*/
--	=========================================================

	select parcel_id, addr_num, addr_pfx, addr_name, addr_type, addr_sfx, x_coord, y_coord, mslink
	from garland.cdreladr
	where	rownum < 99	

	and	parcel_id	in ( '3701159.000', '0.000' )

	and	addr_num	in ( 321 )
--	and	addr_name	in ( 'WALNUT CIRCLE EAST', '' )

--	and	addr_pfx	in ( '', '' )
--	and	addr_type	in ( '', '' )
	;

--	=========================================================

	ROLLBACK;
	commit;

--	=========================================================

	select parcel_id, addr_num, addr_pfx, addr_name, addr_type, addr_sfx, x_coord, y_coord, mslink
	from garland.cdreladr
	where	rownum < 99	

	and	parcel_id	in ( '3701159.000', '0.000' )

	and	addr_num	in ( 321 )
--	and	addr_name	in ( 'WALNUT CIRCLE EAST', '' )

--	and	addr_pfx	in ( '', '' )
--	and	addr_type	in ( '', '' )
	;

--	=========================================================
	set echo	on;
