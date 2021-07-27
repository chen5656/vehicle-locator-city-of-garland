

	create table 	chained_rows
	(
		owner_name		varchar2(30),
		table_name		varchar2(30),
		cluster_name	varchar2(30),
		partition_name	varchar2(30),
		head_rowid		rowid,
		analyze_timestamp	date
	)

		tablespace		gis_data
		storage		( initial 1m  next 1m  pctincrease 0 );
