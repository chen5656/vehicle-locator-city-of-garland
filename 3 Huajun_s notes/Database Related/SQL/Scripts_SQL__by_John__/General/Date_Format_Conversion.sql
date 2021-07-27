	set echo	off;

	alter session set nls_date_format = 'yyyy/mm/dd';

	truncate table	plan_table	reuse storage;

	insert into plan_table (statement_id, timestamp) values ( '9999', ' 2003-08  12 ' );
	commit;

	update plan_table set remarks = timestamp;
	commit;

	update plan_table set timestamp = remarks;
	commit;

	select statement_id, timestamp, remarks from plan_table;

	set echo	on;
