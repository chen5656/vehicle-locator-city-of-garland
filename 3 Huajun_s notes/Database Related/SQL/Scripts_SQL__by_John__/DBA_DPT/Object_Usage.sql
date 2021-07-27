
--	display sql statements that are currently using a specified oracle object


select	o.to_name,
		z.sid,
		s.sql_text

from	v$object_dependency	o,
	v$sql				s,
	v$session			z

where	s.address		= o.from_address
and	s.hash_value	= o.from_hash
and	s.address		= z.sql_address
and	s.hash_value	= z.sql_hash_value

and	o.to_name		= upper( 'cdrelsubdv' )

;
