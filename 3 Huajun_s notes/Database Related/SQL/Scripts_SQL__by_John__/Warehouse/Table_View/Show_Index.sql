--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;

--	=====================================================================
--	Describe Index

	select 
		rpad(index_owner,     	10)	owner,
		rpad(table_name, 		30)	table_name, 
		rpad(index_name, 		30)	index_name, 
		rpad(column_name,		25)	column_name,
		lpad(column_position,	04)	posn   
	from	all_IND_columns
	where (
		table_name like 'CCS_%'
	or 	table_name like 'COMMON_%'
	or 	table_name like 'GDS_%'	
		)
	and	table_owner in	('GARLAND', 'JDEACUTIS' )
	order by index_owner, table_name, index_name, column_position;

--	=====================================================================