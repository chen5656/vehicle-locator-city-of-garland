	set echo off;
--	================================================================

	create or replace  procedure	Explain_More	as

	begin

		insert into plan_table (object_owner, object_name)

		select x.owner, x.table_name

		from	syn_dba_indexes		x,
			syn_plan_table		p

		where	x.index_name = p.object_name
		and not exists
(
		select 'x'
		from	 syn_plan_table
		where	 object_name = x.table_name 
)

		union

		select owner, index_name
		from	syn_dba_indexes		x,
			syn_plan_table		p
		where	x.table_name = p.object_name
		and not exists
(
		select 'x'
		from	 syn_plan_table
		where	 object_name = x.index_name 
);

		commit;
	end;

--	================================================================

