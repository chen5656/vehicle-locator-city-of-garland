
TABLE COLUMNS

	select rpad(table_name,20) tablename, column_name, rpad(data_type,20) datatype,  data_length, data_scale 
	from	all_tab_columns@gdstax
	where table_name in ( 'Accounts', 'ExemptionRecords', 'ValueRecords', 'TaxRecords' );


COLUMN REFERENCE

	select max("NetTaxableValue") from taxrecords@gdstax;