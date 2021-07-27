
--	dynamic performance table queries



--	display statistics for sessions

select	z.osuser, rpad(n.name,30), s.value 
from 	v$session z, v$statname n, v$sesstat s
	where	s.sid = z.sid 
	and	s.statistic# = n.statistic#
	and	s.value > 0
	and	z.type  = 'user'
	and	z.status = 'active'
	and	z.osuser in ( 'JDEACUTI' )
order by z.osuser, s.statistic#
;




--	display sql query being executed by session

select	z.osuser, s.sql_text, s.command_type 
from	v$session z, v$sqltext s
	where	z.sql_address = s.address
	and	z.sql_hash_value = s.hash_value
	and	z.osuser in ( 'JDEACUTI' )
order by z.osuser, s.piece
;




--	what objects are locked by what sessions ?

	select	all *
	from 		v$lock				l,
			all_objects			o,
			v$session			s,
			v$locked_object		lo

	where		l.sid = s.sid
	and		l.sid = lo.session_id
	and		lo.object_id = o.object_id
	;

