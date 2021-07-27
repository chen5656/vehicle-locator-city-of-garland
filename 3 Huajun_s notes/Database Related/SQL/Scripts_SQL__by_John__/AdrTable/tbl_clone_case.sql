
	drop table		garland.clone_case;

	create table	garland.clone_case
(
	case_id		varchar2(40),
	item_A		varchar2(40),
	item_B		varchar2(40),
	item_C		varchar2(40),
	item_D		varchar2(40),
	item_E		varchar2(40),
	item_F		varchar2(40),
	item_G		varchar2(40),
	item_H		varchar2(40)
)
	tablespace		gis_data
	storage		(initial 50k  next 50k  pctincrease 0);
