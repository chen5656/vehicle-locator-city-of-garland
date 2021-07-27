--	===============================================================================
/*	

	alter table ===AAA===	drop constraint ===AAA===_PKEY;


--	explain plan set statement_id = '===AAA=== ID KEY'  into garland.plan_table  for

	alter table ===AAA===
	add	constraint	===AAA===_pkey
		primary key	(===CCC===)
	using index
	tablespace	gisindx
	storage	(initial 50K  next 50K  pctincrease 0);

*/
--	===============================================================================


	drop index ===AAA===_===CCC===;


--	explain plan set statement_id = '===AAA=== ID INDEX'  into garland.plan_table  for

	create index ===AAA===_===CCC===
		 on	 ===AAA===(===CCC===)
	tablespace	gisindx
	storage	(initial 50K  next 50K  pctincrease 0);

--	===============================================================================

	alter table ===AAA===	drop constraint ===AAA===_MSLINK;


--	explain plan set statement_id = '===AAA=== MSLINK UNIQUE'  into garland.plan_table  for

	alter table ===AAA===
	add	constraint	===AAA===_MSLINK
		unique	(mslink)
	using index
	tablespace	gisindx
	storage	(initial 50K  next 50K  pctincrease 0);

--	===============================================================================

