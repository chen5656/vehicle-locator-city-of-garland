
--	================================================	

	update mscatalog		a
	set	nextocc =
(
	select	b.nextocc
--			,b.tablename

	from		garland.mscatalog@gis2.world		b
--			,mscatalog					a

	where		b.entitynum = a.entitynum
	and		b.tablename like 'ut%'
	and		b.tablename not like '%original'
)
	where		tablename like 'ut%'
	and		tablename not like '%original'
;


--	select *
--	from 	mscatalog
--	where		tablename like 'ut%'
--	and		tablename not like '%original';
--	utwatmtr	2187	1

--	================================================	
