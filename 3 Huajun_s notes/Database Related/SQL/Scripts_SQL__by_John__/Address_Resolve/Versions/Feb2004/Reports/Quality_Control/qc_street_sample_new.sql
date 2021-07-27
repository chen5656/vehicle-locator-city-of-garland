	set echo		off;
	set serveroutput	on	 size 999999;
--	select rpad (' ',70) " " from dual;
--	select chr(12) " "	 from dual;
--	==========================================================================
/*
	spec_verify		varchar2(80)	value '2 21 45';
	spec_name		varchar2(80)	value 'b c';

	spec_alias		varchar2(80)	value 'spull NTH part*';

	spec_qual		varchar2(80)	value ' ';		-- all
	spec_qual1		varchar2(80)	value 'SBRA';
	spec_qual2		varchar2(80)	value 'arc';
	spec_qual3		varchar2(80)	value 'pts';


	where	verify_code >= 10

	and	do_qual = 'all'
	or (	translate (rpad  (do_qual,1),		  '/'||spec_qual1, '/') <> do_qual
	and	translate (substr(do_qual,2,1),	  '/'||spec_qual2, '/') <> do_qual
	and	translate (rtrim (do_qual,'SBRAarc'), '/'||spec_qual3, '/') <> do_qual	)


*/
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

	sample_size			number	:= 20;
	show_details		number	:= 01;		-- show relevant GIS records
	do_filter			number	:= 01;		-- ignore dupes

	dupe_limit			number	:= 0;			-- duplicate street limit
	line_limit			number	:= 999;		-- display limit

	do_compile_only		number	:= 0;
	line_count			number	:= 0;
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

	last_qual			varchar2(10);
	seg_label			char(3);

--	==========================================================================
cursor	read_result			is

		select	*
		from		adrResult
		where		do_qual > '0'

--	--------------------------------------------------------------------------
--	*******************  F I L T E R S   *****************************
--	--------------------------------------------------------------------------
/*

--	filter for other than Street modifications occurred

		and		do_qual not like '%S___'			


--	filter for other than just appends

		and	(	do_qual like '%r%'		
		or		do_qual like '%c%'	)

--	filter formiscellaneous constraints

		and	(		
				verify_code >= 10
			)

*/
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
							and	  trunc(addr_hi, -2) + 99;

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

	line_count	:= line_count + 01;
	exit main when line_count > line_limit;

	dbms_output.put_line (' ');

	dbms_output.put_line (		     rpad(read.do_qual,	   47) 
					||' / ' || rpad(read.verify_code,02) 
					||' / ' || rpad(read.do_alias,   06)
					||' / ' || rpad(read.rec_seq,    06) 	
--					||' // '|| rpad(read.rec_key,    15) 
					);

	dbms_output.put_line (	rpad('IN',8) || rpad(nvl(rtrim(read.addr_num),' '),12)   || 
					rpad(upper(read.form_pfx), 2,' ') || rpad(upper(read.form_name),21,' ')  || 
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
					rpad(lower(work_pfx), 2) || rpad(lower(work_name),21)  || 
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
					rpad(lower(work_pfx), 2) || rpad(lower(work_name),21)  || 
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
					rpad(lower(work_pfx), 2) || rpad(lower(work_name),21)  || 
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
					rpad(lower(work_pfx), 2) || rpad(lower(work_name),21)  || 
					rpad(lower(work_type),5) || rpad(lower(work_sfx), 2)); 
end loop;

	close	read_address;

--	==========================================================================
<<show_output>>


	dbms_output.put_line (	rpad('OUT',8) || rpad(nvl(rtrim(read.addr_num),' '),12)  || 
					rpad(read.addr_pfx, 2,' ')|| rpad(read.addr_name,21,' ') || 
					rpad(read.addr_type,5,' ')|| rpad(read.addr_sfx,2,' ')	); 

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
		dupe_count	:= dupe_count + 01;

		if	dupe_count >= dupe_limit		
		or	last_qual like ' S%'
		or	read.addr_num = prev_num		then
			goto	read_next_result;
		end if;
	else
		dupe_count := 0;
	end if;

end loop;

end loop;

	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( 'total sample = ' || line_count );

end;

