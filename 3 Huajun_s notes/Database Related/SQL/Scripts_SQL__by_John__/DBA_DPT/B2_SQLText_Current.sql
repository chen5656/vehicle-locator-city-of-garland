	set echo off;
	set charwidth	100;
--	==============================================================================
--	display sql text of open cursor
--	specify osuser
--	==============================================================================

	variable	pick_user		varchar2(20);
	variable	pick_sid		number;
	variable	pick_command	number;
	variable	pick_line_size	number;

	execute	:pick_user		:= '';
	execute	:pick_sid		:= 0;

	execute	:pick_command	:= 0;				-- any command
--	execute	:pick_command	:= 03;			-- select
--	execute	:pick_command	:= 02;			-- insert
--	execute	:pick_command	:= 06;			-- update

	execute	:pick_line_size	:= 100;
--	-----------------------------------------------------------------------------

	select	rpad (
			nvl(rpad(chr(10), decode(t.piece, 0,1, 0)),' ')			||
			rpad(' ',		decode(t.piece, 0,2, 1)	)			||

			t.command_type								||' '||
			lpad(t.piece,2)								||' '||

--			t.address									||' '||
--			t.hash_value								||' '||
			' '										||

			rpad(s.sid,   02)								||' '||
			rpad(s.osuser,08)								||' '||
			' '										||

			ltrim(t.sql_text)	
			, :pick_line_size)	"cmd seq text"

	from		v$open_cursor	c,		
			v$session		s,
			v$sqltext		t

	where		c.sid			= s.sid
	and		t.address		= s.sql_address
	and		t.hash_value	= s.sql_hash_value 
	and		s.osuser not like '%SYSTEM%'

	and		:pick_command	in (0, t.command_type)
	and	 	:pick_sid		in (0, s.sid )
	and		lower(s.osuser)	like '%'|| :pick_user ||'%'

	order by	c.sid,
			c.hash_value,
			t.piece;
