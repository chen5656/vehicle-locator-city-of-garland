
--	create kill session(s) 

	set echo off;

	select	distinct
			'alter system	kill session  '''		||
			s.sid	||','|| s.serial#				||
			''';'							" "
	from		v$session		s,
			v$mystat		m
	where		lower(osuser) = 'jdeacuti'
	and		s.sid <> m.sid;

