	set echo	off;
--	==================================================================
--	table specifies the Tax and UMS key for each GIS address
--	==================================================================

	create table	address_app_keys
(
	address_id		number,
	parcel_id		varchar2(11),

	tax_id			varchar2(11),
	ums_location_no	number,

	unit_exists		number,

	address			???
)

	tablespace
	storage		(initial		next		pctincrease 0 );

--	==================================================================

	pkey		address id
	index		parcel id

--	==================================================================
	set echo	on;

