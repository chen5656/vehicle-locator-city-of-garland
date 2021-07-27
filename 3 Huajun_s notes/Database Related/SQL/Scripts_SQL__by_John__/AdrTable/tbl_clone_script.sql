
--	drop table		garland.clone_script;

	create table	garland.clone_script
(
	script_id		varchar2(40),
	script_seq		number,
	script_line		varchar2(200)
)
	tablespace	gis_data
	storage	(initial 50k  next 50k  pctincrease 0);
