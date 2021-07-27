	set echo	off;

	truncate table	gis_objects		reuse storage;

	insert into		gis_objects		(item01, item02, item03, item04, item05)

--	how many times has each sqltext executed so far 

	select
			t.address,			--	1
			t.hash_value,		--	2
			a.executions,		--	3
			a.users_executing,	--	4
			s.sid				--	5

	from		v$session				s,				
			v$sqltext				t
			,v$sqlarea				a	
--			,v$open_cursor			c	

	where		t.address		= s.sql_address	 (+)	
	and		t.hash_value	= s.sql_hash_value (+)	
	and		t.address		= a.address		
	and		t.hash_value	= a.hash_value
--	and		t.address		= c.address				
--	and		t.hash_value	= c.hash_value 			
	

	union

--	which sqltext contains system variable names and should be ignored

	select
			t.address,			--	1
			t.hash_value,		--	2
			-999,				--	3
			-999,				--	4
			0	
	from		v$sqltext				t
	where		instr (upper (t.sql_text), 'V$')	+
			instr (t.sql_text, 'obj$')		+
			instr (t.sql_text, 'obj#')		+
			instr (t.sql_text, 'user#')		+
			instr (t.sql_text, 'ts#')		+
			instr (t.sql_text, 'icol$')		+
			0 > 0
	;

	set echo 	on;
