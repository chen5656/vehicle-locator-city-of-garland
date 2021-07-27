

--	display waiting events and their parameters
--	specify user


	select	s.*,
			n.*,
			w.*
	from	
			v$session_wait	w,
			v$event_name	n,
			v$session_event	s

	where		s.event = w.event
	and		s.event = n.name

--	and 		s.sid = 22
	;
			
	
