

/*
	insert into	garland.feature
(
	select * from garland.feature@gis2.world
	where	 tablename like 'ut%'

	minus
		
	select * from garland.feature
	where	tablename like 'ut%'

);


	rollback;
*/



	select distinct tablename, fcode, mslink, fname
	from	 garland.feature@gis2.world	g
	where	 tablename like 'ut%'
	and exists
(
	select 'x'
	from	 garland.feature

	where	 tablename like 'ut%'
	and	 tablename	 = g.tablename
	and	 fcode	 = g.fcode
	and	 mslink	>= g.mslink

)