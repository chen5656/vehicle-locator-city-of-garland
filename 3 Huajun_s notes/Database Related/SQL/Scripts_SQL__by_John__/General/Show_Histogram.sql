	SET ECHO OFF;
--	============================================================================
--	Create  Histogram
--	Display Histogram
--	Analyze Histogram
--	============================================================================

/*

	analyze table adrStreets  compute statistics for columns addr_name size 10;


	analyze table cdreladr compute statistics for columns addr_num size 10;
	analyze table cdreladr compute statistics for columns addr_num;


	select endpoint_number, endpoint_value, endpoint_actual_value
	from user_histograms	
	where table_name = 'ADRSTREETS' and column_name = 'ADDR_NAME';


	select endpoint_number, endpoint_value, endpoint_actual_value
	from user_histograms	
	where table_name = 'CDRELADR' and column_name = 'ADDR_NUM';


	select * from dict_COLUMNS where TABLE_NAME Like '%HISTOGRAM%';

*/



	select min(width), max(width), avg(width)
	from
(

	select	a.endpoint_number, b.endpoint_number, 
			b.endpoint_value - a.endpoint_value		width

	from	user_histograms	a,
		user_histograms	b
	where	a.table_name  = b.table_name
	and	a.column_name = b.column_name
	and	b.endpoint_number = a.endpoint_number + 01

	and	a.table_name = 'CDRELADR'
)

	where	width < 9999

--	group by width
	;


