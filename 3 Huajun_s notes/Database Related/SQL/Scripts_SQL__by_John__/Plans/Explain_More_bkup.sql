	set echo off;
--	================================================================

	create or replace  procedure	garland.Explain_More	as

begin

--	-------------------------------------------------------------------------
--	Get "Like" Object Names

	insert into plan_table(object_owner,object_name)

	select distinct t.owner, t.object_name
	from	 all_objects	T,
		 plan_table		P

	where	 p.object_name <> rtrim(p.object_name,'% ')
	and	 t.object_name >= rtrim(p.object_name,'%')
	and	 t.object_name <  rtrim(p.object_name,'% ') || 'z'

--	and	 t.object_type in ( 'TABLE', 'INDEX', 'VIEW')
	;

	commit;

--	-------------------------------------------------------------------------
--	Get Dependent Object Names

	insert into plan_table (object_owner, object_name)

	select d.owner, d.name
	from	all_dependencies		D,
		plan_table			P

	where	d.referenced_name		= p.object_name
	and	d.referenced_owner	= p.object_owner

	and not exists
(
	select 'x'
	from	 plan_table
	where	 object_name = d.name
)
	and	d.type in ( 'TABLE', 'INDEX' )
	;

	commit;

--	-------------------------------------------------------------------------
--	Get Dependent Object References

	insert into plan_table (object_owner, object_name)

	select d.referenced_owner, d.referenced_name
	from	all_dependencies		D,
		plan_table			P

	where	d.name	= p.object_name
	and	d.owner	= p.object_owner

	and not exists
(
	select 'x'
	from	 plan_table
	where	 object_name = d.referenced_name
)
	and	d.referenced_type in ( 'TABLE', 'INDEX' )
	;

	commit;

--	-------------------------------------------------------------------------
--	Get Synonym References

	insert into plan_table (object_owner, object_name)

	select s.table_owner, s.table_name

	from	all_synonyms	S,
		plan_table		P

	where	s.synonym_name	= p.object_name
	and	s.owner		= p.object_owner

	and not exists
(
	select 'x'
	from	 plan_table
	where	 object_name = s.table_name
);

	commit;

--	-------------------------------------------------------------------------
--	Get Index Names

	insert into plan_table (object_owner, object_name)

	select x.owner, x.table_name
	from	all_indexes		x,
		plan_table		p
	where	x.owner	 = p.object_owner
	and	x.index_name = p.object_name

	and not exists
(
	select 'x'
	from	 plan_table
	where	 object_name = x.table_name 
);

	commit;

--	-------------------------------------------------------------------------
--	Get Table Names

	insert into plan_table (object_owner, object_name)

	select owner, index_name
	from	all_indexes		x,
		plan_table		p
	where	x.owner	 = p.object_owner
	and	x.table_name = p.object_name
	and not exists
(
	select 'x'
	from	 plan_table
	where	 object_name = x.index_name 
);

	commit;

--	-------------------------------------------------------------------------

end;


