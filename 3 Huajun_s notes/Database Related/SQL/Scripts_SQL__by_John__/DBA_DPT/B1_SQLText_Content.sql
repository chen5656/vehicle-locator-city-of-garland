	set echo		off;
	set fetchrows			;
--	=============================================================================
--	display sql text currently being executed 
--	optionally, specify selection filters
--	=============================================================================

	variable	pick_text		varchar2(80);
	variable	pick_address	varchar2(80);

	variable	show_commands	varchar2(80);
	variable	not_commands	varchar2(80);

	execute	:pick_text		:= 'cdrelsub';		-- use lower case
	execute	:pick_address	:= '';

	execute	:show_commands	:= '02 06';		-- select commands (null = all)
	execute	:not_commands	:= '47';		-- reject commands (not null)

--			select = 03;
--			insert = 02;
--			update = 06;

--	-----------------------------------------------------------------------------

	select	nvl(rpad(chr(10), decode(t.piece, 0,1, 0) ),' ')		||
			rpad(' ',		decode(t.piece, 0,2, 1)	)			||

			t.command_type								||' '||
			t.piece									||' '||

--			t.address									||' '||
--			t.hash_value								||' '||

			' '										||
			ltrim(t.sql_text)	

			"cmd seq text"
	from		v$sqltext	t,
(
	select	address, hash_value
	from		v$sqltext
	where		lower(sql_text) like '%'|| :pick_text ||'%'
)					a

	where		t.address 		= a.address
	and		t.hash_value	= a.hash_value


	and		:pick_command in (0, t.command_type)

	and		:show_commands	like '%'|| t.command_type ||'%'
	and		:not_commands not like '%'|| t.command_type ||'%'

	and	(	:pick_address is null
	or		t.address = hextoraw(:pick_address)		)


	order by	t.address,
			t.hash_value,
			t.piece;

--	-----------------------------------------------------------------------------
	variable	 show_user		varchar2(80);
--	execute	:show_user		:= '';
	execute	:show_user		:= 'snguyen';

	select sid, serial#, osuser, sql_address, program, status 
	from v$session	where osuser not like '%SYSTEM%'
	and	lower(osuser) like '%'||:show_user ||'%';
--	-----------------------------------------------------------------------------

	set echo 	on;