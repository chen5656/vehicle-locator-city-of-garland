	set echo		off;
	set serveroutput	on	 size 999999;
--	select rpad (' ',70) " " from dual;
--	select chr(12) " "	 from dual;
--	==========================================================================

--	SET SAMPLE SIZE BELOW

--	==========================================================================
--	display samples of different qualifier audits from adrResolve 

	select	do_qual 				"CHANGE AUDIT",
			lpad(count(*),5)			"TOTAL" 
	from 		adrResult
	where		do_qual > '0'
	group by	do_qual;

	select	count(rtrim(do_qual))		"   CHANGED",
			count(*)				"     TOTAL"
	from		adrResult;

--	==========================================================================
--	Display specific kinds of audits
--	Limit number of duplicate streets
--	Filter out duplicate addresses

declare

	sample_size			number	:= 10;
	show_details		number	:= 01;		-- show relevant GIS records
	show_appl			number	:= 01;		-- show original app address
	do_filter			number	:= 01;		-- 1 = ignore dupe street  2 = ignore dupe addr

	dupe_limit			number	:= 0;			-- duplicate street limit
	line_limit			number	:= 999;		-- display limit

	do_compile_only		number	:= 0;
	show_count			number	:= 0;
	dupe_count			number	:= 0;
	this_count			number;
	this_do_qual		varchar2(24);

	work_name			varchar2(40);
	work_type			varchar2(10);
	work_pfx			varchar2(10);
	work_sfx			varchar2(10);
	work_num1			varchar2(10);
	work_num2			varchar2(10);

	prev_qual			varchar2(24);
	prev_name			varchar2(40);
	prev_type			varchar2(10);
	prev_pfx			varchar2(10);
	prev_sfx			varchar2(10);
	prev_num			varchar2(10);

	last_qual			varchar2(40);
	seg_label			char(3);

--	==========================================================================
cursor	read_result			is

		select	all *
		from		garland.adrResult
		where		do_qual > '0'

--	--------------------------------------------------------------------------
--	*******************  F I L T E R S   *****************************
--	--------------------------------------------------------------------------

--	filter for changes & removes

		and	(	do_qual like '%c%'		
		or		do_qual like '%r%'
--		or		do_qual like '%a%'
			)

--	filter for other than Street modifications

		and		do_qual not like 'Sct_'
		and		do_qual not like 'Srt_'

--	filter for miscellaneous constraints

		and	(	verify_code >= 10			-- always

--		and		addr_num	= 0
			)

--	additional filters

		or		do_qual like '%s%'


--	--------------------------------------------------------------------------

		order by	do_qual, form_name, form_type, form_pfx, form_sfx, addr_num;

		READ		read_result%rowtype;

--	==========================================================================
cursor	read_street			is

		select	distinct
				addr_name,	addr_type,	addr_pfx,	addr_sfx,
				' ',		' '
		from		adrStreets
		where		addr_name = read.addr_name;

--	==========================================================================
cursor	read_block			is

		select	distinct
				addr_name,	addr_type,	addr_pfx,	addr_sfx, 
				addr_block, ' '
		from		adrBlock
		where		addr_name = read.addr_name
		and		addr_block = trunc(read.addr_num, -2);

--	==========================================================================
cursor	read_segment		is

		select	distinct
				addr_name,	addr_type,	addr_pfx,	addr_sfx,
				addr_lo,	addr_hi
		from		trvehrcl
		where		addr_name	= read.addr_name
		and		read.addr_num	between trunc(addr_lo, -2)  
							and	  trunc(addr_hi, -2) + 99

		and		addr_name = NULL;		--	SUPPRESS THIS QUERY

--	==========================================================================
cursor	read_address		is

		select	distinct
				addr_name,	addr_type,	addr_pfx,	addr_sfx,
				addr_num,	' '
		from		cdreladr
		where		addr_name	= read.addr_name
		and		addr_num	= read.addr_num;

--	==========================================================================

begin

	if	do_compile_only > 0			then
		return;
	end if;

	open	read_result;

	fetch	read_result				into	read;
	if	read_result%notfound
	or	read_result%notfound is null		then
		return;
	end if;


<<main>>

loop

	this_do_qual := read.do_qual;
	this_count	 := sample_size;

while	read.do_qual = this_do_qual			loop	

	this_count	:= this_count - 01;

	if	this_count < 0				then
		goto	read_next_result;
	end if;

	show_count	:= show_count + 01;

--	exit main when show_count > line_limit;

	if	show_count > line_limit			then
		dbms_output.put_line ( 'Print line limit exceeded ' || line_limit);
		exit;
	end if;

	dbms_output.put_line (' ');

	dbms_output.put_line (		     rpad(read.do_qual,	   20) 
					||' / ' || rpad(read.do_parse,   20) 
					||' / ' || rpad(read.verify_code,02) 
					||' / ' || rpad(read.do_alias,   06)
					||' / ' || rpad(read.rec_seq,    06) 	
--					||' // '|| rpad(read.rec_key,    15) 
					);


	if	show_appl > 0	then
	dbms_output.put_line (	rpad('APP',8) || rpad(nvl(rtrim(read.appl_num),' '),12)   || 
					rpad(upper(read.appl_pfx),  3,' ') || rpad(upper(read.appl_name), 21,' ')	|| 
					rpad(upper(read.appl_type), 5,' ') || rpad(upper(read.appl_sfx),  10,' ')	||	
					rpad(upper(read.appl_code1),5,' ') || rpad(upper(read.appl_unit1),10,' ')	||	
					rpad(upper(read.appl_code2),5,' ') || rpad(upper(read.appl_unit2),10,' ')	); 
	end if;


	dbms_output.put_line (	rpad('IN',8) || rpad(nvl(rtrim(read.addr_num),' '),12)   || 
					rpad(upper(read.form_pfx), 3,' ') || rpad(upper(read.form_name),21,' ')  || 
					rpad(upper(read.form_type),5,' ') || rpad(upper(read.form_sfx), 02,' ')	); 

	if	show_details = 0		then
		goto	show_output;
	end if;

--	==========================================================================

	open	read_street;

loop	

	fetch	read_street	
	into	work_name,	work_type,	work_pfx,	work_sfx,	work_num1,	work_num2;
	exit when	read_street%notfound
	or		read_street%notfound is null;

	dbms_output.put_line (	rpad('str',8)	||  
				   	rpad(work_num1,6) || rpad(work_num2,6)  || 
					rpad(lower(work_pfx), 3) || rpad(lower(work_name),21)  || 
					rpad(lower(work_type),5) || rpad(lower(work_sfx), 2)); 
end loop;

	close	read_street;

--	==========================================================================

	open	read_block;

loop	

	fetch	read_block
	into	work_name,	work_type,	work_pfx,	work_sfx,	work_num1, work_num2;
	exit when	read_block%notfound
	or		read_block%notfound is null;

	dbms_output.put_line (	rpad('blk',8)	||  
					rpad(work_num1,6) || rpad(work_num2,6)  || 
					rpad(lower(work_pfx), 3) || rpad(lower(work_name),21)  || 
					rpad(lower(work_type),5) || rpad(lower(work_sfx), 2)); 
end loop;

	close	read_block;

--	==========================================================================

	open	read_segment;

loop	

	fetch	read_segment
	into	work_name,	work_type,	work_pfx,	work_sfx,	work_num1,	work_num2;
	exit when	read_segment%notfound
	or		read_segment%notfound is null;

	if	read.addr_num between work_num1 and work_num2		then
		seg_label	:= 'rng';
	else
		seg_label	:= '';						--	'hun' if desired
	end if;

	if	seg_label > ' '		then
--	if	seg_label = 'rng'		then
	dbms_output.put_line (	rpad(seg_label,8)	||  
					rpad(work_num1,6) || rpad(work_num2,6)  || 
					rpad(lower(work_pfx), 3) || rpad(lower(work_name),21)  || 
					rpad(lower(work_type),5) || rpad(lower(work_sfx), 02)); 
	end if;

end loop;

	close	read_segment;

--	==========================================================================

	open	read_address;

loop	

	fetch	read_address
	into	work_name,	work_type,	work_pfx,	work_sfx,	work_num1,	work_num2;
	exit when	read_address%notfound
	or		read_address%notfound is null;

	dbms_output.put_line (	rpad('adr',8)	||  
					rpad(work_num1,6) || rpad(work_num2,6)  || 
					rpad(lower(work_pfx), 3) || rpad(lower(work_name),21)  || 
					rpad(lower(work_type),5) || rpad(lower(work_sfx), 2)); 
end loop;

	close	read_address;

--	==========================================================================
<<show_output>>


	dbms_output.put_line (	rpad('OUT',8) || rpad(nvl(rtrim(read.addr_num),' '),12)  || 
					rpad(read.addr_pfx, 3,' ')|| rpad(read.addr_name,21,' ') || 
					rpad(read.addr_type,5,' ')|| rpad(read.addr_sfx,  2,' ')	); 

--	==========================================================================

<<read_next_result>>	

	prev_qual	:= read.do_qual;
	prev_name	:= read.form_name;
	prev_type	:= read.form_type;
	prev_pfx	:= read.form_pfx;
	prev_sfx	:= read.form_sfx;
	prev_num	:= read.addr_num;

	fetch	read_result		into	read;
	exit main	when	read_result%notfound
			or	read_result%notfound is null;


	last_qual	:= substr(' ' || read.do_qual, instr(' ' || rtrim(read.do_qual),' ', -1));

--	dbms_output.put_line (  'prev/read ' || 
--					prev_name ||'/'|| read.form_name ||' '|| 
--					prev_type ||'/'|| read.form_type ||' '|| 
--					prev_pfx  ||'/'|| read.form_pfx  ||' '||
--					prev_sfx  ||'/'|| read.form_sfx  ||' '||
--					prev_num  ||'/'|| read.addr_num	);

	if	do_filter		> 0
	and	read.do_qual	= prev_qual
	and	read.form_name	= prev_name
	and	read.form_type	= prev_type
	and	read.form_pfx	= prev_pfx
	and	read.form_sfx	= prev_sfx			then

		if	do_filter < 2							-- jun 2003
		or	read.addr_num = prev_num		then

			dupe_count	:= dupe_count + 01;

			if	dupe_count >= dupe_limit		
			or	last_qual like ' S%'		then
--			or	read.addr_num = prev_num	then
				goto	read_next_result;
			end if;
		else
			dupe_count := 0;
		end if;
	end if;

end loop;

end loop;

	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( 'total sample = ' || show_count );

end;
