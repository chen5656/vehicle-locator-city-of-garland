	set echo		off;
	set serveroutput	on	size 999999;
--	=========================================================================
--	display samples of different parse results from adrResolve 
--	=========================================================================

	select '                              ' " "	from dual;
	select	rpad (do_parse,30)	"PARSE",
			lpad(count(*),5)		"TOTAL", 

			decode ( rpad(do_parse,3),
					'!70',	' Non Address',
					'!81',	' Code',
					'!82',	' Unit',
					'!83',	' Fraction',
					'!90',	' Length',
					'!91',	' Format',
					'!92',	' Parts',
					'!93',	' Redo',
					'!94',	' Loop',
					' '		)	"  ERROR"
	from 		garland.gis_verify_addr
	group by	do_parse;

--	================================================================================================

--	***************	CUSTOMIZE THE CURSOR FILTER 	*********************

--	================================================================================================
declare
		sample_size			number	:= 10;

		loop_limit			number	:= 99999;

		do_compile_only		number	:= 0;

		this_do_parse		varchar2(40);
		this_count			number;

		prev_name			varchar2(80);
		prev_type			varchar2(80);
		prev_pfx			varchar2(80);
		prev_sfx			varchar2(80);
		prev_code1			varchar2(80);
		prev_code2			varchar2(80);
		prev_unit1			varchar2(80);
		prev_unit2			varchar2(80);

--	==========================================================================
cursor	read_result			is

		select	--+	rule 
				distinct

				do_parse,	

				addr_name,
				addr_type,
				addr_pfx,
				addr_sfx,
				addr_code1,
				addr_unit1,
				addr_code2,
				addr_unit2,

				addr_num,
--				' '			addr_num,

				appl_num,
--				' '			appl_num,

				form_name, form_type, form_pfx,  form_sfx, 
				form_code1, form_code2, 
				form_unit1, form_unit2,

				nvl(rtrim(appl_name) ,' ')	appl_name,
				nvl(rtrim(appl_type) ,' ')	appl_type,
				nvl(rtrim(appl_pfx ) ,' ')	appl_pfx,
				nvl(rtrim(appl_sfx ) ,' ')	appl_sfx,
				nvl(rtrim(appl_code1),' ')	appl_code1,
				nvl(rtrim(appl_code2),' ')	appl_code2,
				nvl(rtrim(appl_unit1),' ')	appl_unit1,	
				nvl(rtrim(appl_unit2),' ')	appl_unit2,

				do_alias,

--				rec_key,		
--				rec_seq, 
				null			rec_key,	
				null			rec_seq

		from		garland.adrResult

		where		nvl(do_parse,' ') <> '.........'

--	-----------------------------------------------------------------------------------

		and	(

				ltrim (lower(do_parse), 'npmt. ') > ' '		-- ordinary formats

				or	nvl(do_parse,' ') = ' '
			)


		and	nvl(do_parse,' ') > '.........z'

--		and		do_parse not like '!%'					-- error locations

--		and		addr_num > '0'						-- does addr_num exist ?

--	-----------------------------------------------------------------------------------
--		and		ltrim (lower(do_parse), 'npmt. ') > ' '		-- ordinary address ?
--		and		do_parse like '!%'					-- error location
--		and		addr_num > 0						-- does number exist ?
--		and		do_parse like '%u%'					-- does unit exist ?
--		and	(	rtrim(lower(addr_unit1)) <> rtrim(lower(appl_unit1))		-- was unit modified ?
--		or		rtrim(lower(addr_unit2)) <> rtrim(lower(appl_unit2))		)
--	-----------------------------------------------------------------------------------

		order by	do_parse,
--				replace(replace(replace(appl_name,'  ',' '),'  ',' '),'  ',' '),
				addr_name,
				addr_type,  addr_pfx,   addr_sfx, 
--				addr_code1, addr_code2, addr_unit1, addr_unit2
				' ';

		READ		read_result%rowtype;

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

	this_do_parse := read.do_parse;
	this_count	  := sample_size;

while	read.do_parse = this_do_parse			loop	

	this_count	:= this_count - 01;
	if	this_count < 0				then
		goto	read_next_result;
	end if;

	dbms_output.put_line (' ');

	if	nvl(read.do_parse,' ') < '!'		then
		dbms_output.put_line ( 'Alias  ' || read.do_alias );
	else
		dbms_output.put_line (	rpad (read.do_parse, 39)
						||'seq= '|| read.rec_seq ||'   key='|| read.rec_key);
	end if;

	dbms_output.put_line (	lpad(nvl(ltrim(rtrim(read.appl_num)),' '),06) ||' '||
					rpad(nvl(read.appl_pfx,  ' '),03) || rpad(nvl(read.appl_name, ' '),30) || 
					rpad(nvl(read.appl_type, ' '),05) || rpad(nvl(read.appl_sfx,  ' '),03) ||' || '|| 
					rpad(nvl(read.appl_code1,' '),10) || rpad(nvl(ltrim(read.appl_unit1),' '),20) ||' || '||
					rpad(nvl(read.appl_code2,' '),10) || rpad(nvl(ltrim(read.appl_unit2),' '),20) ); 


	if	read.do_parse not like '!%'
	and	read.form_name > '0'				then
	dbms_output.put_line (	lpad(nvl(ltrim(rtrim(read.addr_num)),' '),06) ||' '||
					rpad(nvl(read.form_pfx,  ' '),03) || rpad(nvl(read.form_name, ' '),30)	|| 
					rpad(nvl(read.form_type, ' '),05) || rpad(nvl(read.form_sfx,  ' '),03)	||' || '|| 
					rpad(nvl(read.form_code1,' '),10) || rpad(nvl(read.form_unit1,' '),20)	||' || '||
					rpad(nvl(read.form_code2,' '),10) || rpad(nvl(read.form_unit2,' '),20)	 ); 
	end if;

	if	nvl(read.do_alias,' ') < 'A'			then
	dbms_output.put_line (	lpad(nvl(ltrim(rtrim(read.addr_num)),' '),06) ||' '||
					rpad(nvl(read.addr_pfx,  ' '),03) || rpad(nvl(read.addr_name, ' '),30)	|| 
					rpad(nvl(read.addr_type, ' '),05) || rpad(nvl(read.addr_sfx,  ' '),03)	||' || '||
					rpad(nvl(read.addr_code1,' '),10) || rpad(nvl(read.addr_unit1,' '),20)	||' || '||
					rpad(nvl(read.addr_code2,' '),10) || rpad(nvl(read.addr_unit2,' '),20)	 ); 
	end if;



/*
	if	nvl(read.do_alias,' ') < '0'			then
	dbms_output.put_line (	lpad(nvl(ltrim(rtrim(read.addr_num)),' '),06)	
				||' pfx='|| rpad(nvl(read.addr_pfx,  ' '),03) 	
				||' nam='|| rpad(nvl(read.addr_name, ' '),30)	
				||' typ='|| rpad(nvl(read.addr_type, ' '),05) 	
				||' sfx='|| rpad(nvl(read.addr_sfx,  ' '),03)	
				||' cod='|| rpad(nvl(read.addr_code1,' '),10) 	
				||' unt='|| rpad(nvl(read.addr_unit1,' '),20)	
				||' cod='|| rpad(nvl(read.addr_code2,' '),10) 	
				||' unt='|| rpad(nvl(read.addr_unit2,' '),20)	 
				); 
	end if;
*/

<<read_next_result>>	

	prev_name	:= (read.appl_name);
	prev_type	:= (read.appl_type);
	prev_pfx	:= (read.appl_pfx);
	prev_sfx	:= (read.appl_sfx);
	prev_code1	:= (read.appl_code1);
	prev_code2	:= (read.appl_code2);
	prev_unit1	:= (read.appl_unit1);
	prev_unit2	:= (read.appl_unit2);	

	fetch	read_result		into	read;

	exit main	when	read_result%notfound
			or	read_result%notfound is null;


--	dbms_output.put_line ( (prev_name)		||' '|| (read.appl_name)	);
--	dbms_output.put_line ( (prev_type)		||' '|| (read.appl_type)	);
--	dbms_output.put_line ( length(prev_name)	||' '|| length(read.appl_name)	);
--	dbms_output.put_line ( length(prev_type)	||' '|| length(read.appl_type)	);

--	read.appl_name		:= translate (read.appl_name, '.',' ');
--	read.appl_type		:= translate (read.appl_type, '.',' ');
--	read.appl_pfx		:= translate (read.appl_pfx,  '.',' ');
--	read.appl_sfx		:= translate (read.appl_sfx,  '.',' ');
--	read.appl_code1		:= translate (read.appl_code1,'.',' ');
--	read.appl_code2		:= translate (read.appl_code2,'.',' ');
--	read.appl_unit1		:= translate (read.appl_unit1,'.',' ');
--	read.appl_unit2		:= translate (read.appl_unit2,'.',' ');

	if	prev_name	 = read.appl_name
	and	prev_type	 = read.appl_type
	and	prev_pfx	 = read.appl_pfx
	and	prev_sfx	 = read.appl_sfx
	and	prev_code1	 = read.appl_code1
	and	prev_code2	 = read.appl_code2
	and	prev_unit1	 = read.appl_unit1
	and	prev_unit2	 = read.appl_unit2		
	then
		goto	read_next_result;
	end if;

end loop;

end loop;

end;

