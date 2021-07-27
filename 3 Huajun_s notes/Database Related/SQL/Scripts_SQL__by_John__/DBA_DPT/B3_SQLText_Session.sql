	set echo	off;
--	=============================================================================
--	display sql text currently being executed 
--	optionally, specify selection filters
--	=============================================================================

	variable	pick_command	number;
	variable	pick_sid		number;
	variable	pick_user		varchar2(20);
	variable	pick_address	varchar2(20);

	execute	:pick_user		:= 'snguyen';
	execute	:pick_command	:= 0;
	execute	:pick_sid		:= 0;
	execute	:pick_address	:= '';

--	-----------------------------------------------------------------------------
	select sid, serial#, osuser, sql_address, program, status 
	from	 v$session	where osuser not like '%SYSTEM%'
	and	lower(osuser) like '%'|| :pick_user ||'%';
--	-----------------------------------------------------------------------------

	select	rpad (
			nvl(rpad(chr(10), decode(t.piece, 0,1, 0)),' ')			||
			rpad(' ',		decode(t.piece, 0,2, 1)	)			||

			t.command_type								||' '||
			t.piece									||' '||

--			t.address									||' '||
--			t.hash_value								||' '||
			' '										||

--			rpad(s.sid,   02)								||' '||
--			rpad(s.osuser,08)								||' '||

			ltrim(t.sql_text)	
			,70)				"cmd seq text"

	from		v$sqltext		t,
			v$session		s
	where		sql_address 	= t.address
	and		s.sql_hash_value 	= t.hash_value

	and		:pick_command	in (0, t.command_type)
	and	 	:pick_sid		in (0, s.sid )
	and		lower(s.osuser)	like '%'|| :pick_user ||'%'

	and	(	:pick_address is null
	or		s.sql_address = hextoraw(:pick_address)	)

	order by	s.sid,
			t.address,
			t.hash_value,
			t.piece;

--	-----------------------------------------------------------------------------



