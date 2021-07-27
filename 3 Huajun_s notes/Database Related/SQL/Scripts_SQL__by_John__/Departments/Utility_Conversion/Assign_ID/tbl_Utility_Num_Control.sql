
--	drop table		garland.Utility_Num_Control;

	create table	garland.Utility_Num_Control
(
		tablename		varchar2(20),
		grid			varchar2(03),
		quad			varchar2(01),
		num			number,

	constraint	Utility_Num_Seq_pkey 	
	primary key	(tablename, grid, quad)
)
	organization index
	tablespace	 gisindx
	storage	(initial 50k  next 50k  pctincrease 0)
	;

--	================================================================

