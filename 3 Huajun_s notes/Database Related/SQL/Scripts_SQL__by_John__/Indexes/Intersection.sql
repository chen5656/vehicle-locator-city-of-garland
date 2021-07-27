

--	create index garland.intersection_name1
--		on	 garland.intersection (addr1_name)
--	tablespace	gisindx
--	storage	( initial 6m  next 1m  pctincrease 0);



	create index garland.intersection_name2
		on	 garland.intersection (addr2_name)
	tablespace	gisindx
	storage	( initial 6m  next 1m  pctincrease 0);