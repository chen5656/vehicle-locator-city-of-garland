
--	select o.*

	select distinct rpad(name,30) name, type, status, timestamp

	from	obj		o,
		user_source	u

	where	u.name = o.object_name
	and	u.line = 1

	order by 1,2,4,3
