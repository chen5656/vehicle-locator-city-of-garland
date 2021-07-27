	set echo	off;
--	===========================================================================

	select table_name from all_tables 
	where owner = 'JDEACUTIS'
	and table_name in 
(
	'ATTRIBUTE_CATALOG',
	'CATEGORY',
	'DOMAIN_CATALOG',
	'FEATURE',
	'JOIN_CATALOG',
	'LABEL',
	'LIST_DOMAIN',
	'MAPS',
	'MSCATALOG',
	'RANGE_DOMAIN',
	'VIEW_CATALOG',
	'VIEW_CONTENT',
	'VIEW_JOIN'
);

--	===========================================================================

	truncate table	garland.attribute_catalog		reuse storage;

	truncate table	garland.category				reuse storage;

	truncate table	garland.domain_catalog			reuse storage;

	truncate table	garland.feature				reuse storage;

	truncate table	garland.join_catalog			reuse storage;

	truncate table	garland.label				reuse storage;

	truncate table	garland.list_domain			reuse storage;

	truncate table	garland.maps				reuse storage;

	truncate table	garland.mscatalog				reuse storage;

	truncate table	garland.range_domain			reuse storage;

	truncate table	garland.view_catalog			reuse storage;

	truncate table	garland.view_content			reuse storage;

	truncate table	garland.view_join				reuse storage;

--	===========================================================================

	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	===========================================================================

	insert /*+ append */  into garland.attribute_catalog		select * from jdeacutis.attribute_catalog;

	insert /*+ append */  into garland.category			select * from jdeacutis.category;

	insert /*+ append */  into garland.domain_catalog		select * from jdeacutis.domain_catalog;

	insert /*+ append */  into garland.feature			select * from jdeacutis.feature;

	insert /*+ append */  into garland.join_catalog			select * from jdeacutis.join_catalog;

	insert /*+ append */  into garland.label				select * from jdeacutis.label;

	insert /*+ append */  into garland.list_domain			select * from jdeacutis.list_domain;

	insert /*+ append */  into garland.maps				select * from jdeacutis.maps;

	insert /*+ append */  into garland.mscatalog			select * from jdeacutis.mscatalog;

	insert /*+ append */  into garland.range_domain			select * from jdeacutis.range_domain;

	insert /*+ append */  into garland.view_catalog			select * from jdeacutis.view_catalog;

	insert /*+ append */  into garland.view_content			select * from jdeacutis.view_content;

	insert /*+ append */  into garland.view_join			select * from jdeacutis.view_join;

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;

	commit;
	alter rollback segment rb1 offline;
--	===========================================================================
	set echo	on;
