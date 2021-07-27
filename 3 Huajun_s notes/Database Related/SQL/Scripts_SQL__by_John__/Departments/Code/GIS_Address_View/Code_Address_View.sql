

	create or replace view	Code_Address_View		as

	select	g.*, t.*,  u.*

	from		Code_AID	a,
			Code_GIS	g,
			Code_TAX	t,
			Code_UMS	u

	where		a.address_id	= g.address_id
	and		a.app_key		= t.account_no
	and		a.app_key		= u.location_no
	;



