	set echo		off;
	set timing		on;
	set serveroutput	on	size 999999;
--	============================================================================
--	Build 'rhyme' Alias records
--	Find close fuzzy match where 1st letter is different
--	============================================================================

	select 'Build Rhyme Alias' " ", to_char(sysdate, 'Mon dd,yyyy hh24:mi:ss') " " from dual;

--	============================================================================
--	CAUTION !!!

	delete from garland.adrAlias where alias_how = 'rhyme';
	commit;
--	============================================================================

declare

	do_compile		binary_integer	:= 0;
	do_test		binary_integer	:= 0;

	do_insert		binary_integer	:= 01;
	do_print		binary_integer	:= 0;

	spec_method		varchar2(10)	:= 'rhyme';
	spec_weight		binary_integer	:= 001;

	read_limit		binary_integer	:= 0100;
	match_score		binary_integer	:= 150;
	vowel_score		binary_integer	:= 050;
	length_differ	binary_integer	:= 03;
	alias_group		binary_integer	:= 10;

	like_name1		varchar2(10)	:= '%';
	like_name2		varchar2(10)	:= '%';

	read_total		binary_integer	:= 0;
	fuzzy_total		binary_integer	:= 0;
	alias_total		binary_integer	:= 0;
	insert_total	binary_integer	:= 0;

	best_name1		varchar2(40);
	best_name2		varchar2(40);
	best_name3		varchar2(40);

	best_score		binary_integer;
	best_count		binary_integer;
	good_count		binary_integer;

	score			binary_integer;
	errors		binary_integer;
	max_score		binary_integer;

	name1			varchar2(40);
	name2			varchar2(40);
	compress1		varchar2(40);
	compress2		varchar2(40);
	prefix1		varchar2(10);
	prefix2		varchar2(10);

--	============================================================================
begin

	dbms_output.put_line (' ');

	if	do_test > 0			then
		garland.adr_compare_name		('connie', 'BOBBIE', score, errors);	
		dbms_output.put_line	( score ||' '|| errors);
	end if;

	if	do_compile > 0		then
		return;
	end if;

--	============================================================================

for look in  (select distinct addr_name, addr_compress, addr_reduced 
			from garland.adrStreets 
			where	addr_name like	like_name1	)
loop

	best_name1	:= null;
	best_name2	:= null;
	best_name3	:= null;

	best_score	:= 999999;
	best_count	:= 0;

--	============================================================================

for scan in  (select distinct addr_name, addr_compress, addr_reduced 
			from garland.adrStreets 
			where	addr_name like	like_name2	)
loop

	read_total	:= read_total + 01;

	compress1	:= look.addr_compress;
	compress2	:= scan.addr_compress;

	prefix1	:= rpad(look.addr_name, 1);
	prefix2	:= rpad(scan.addr_name, 1);

	if	prefix1 = prefix2	
	or	length (look.addr_name) > 20
	or	length (scan.addr_name) > 20
	or	substr (look.addr_name, length(look.addr_name)) <> substr (scan.addr_name, length(scan.addr_name)) 
	or	nvl (length (translate (compress1, 'x'||compress2, 'x')), 0)  +
		nvl (length (translate (compress2, 'x'||compress1, 'x')), 0) > length_differ
	then
		goto	end_loop;
	end if;

	name1	:= 'x' || look.addr_reduced;
	name2	:= 'x' || scan.addr_reduced;

--	============================================================================
	garland.ADR_Compare_Name (name1, name2, score, errors);	
--	============================================================================

	fuzzy_total	:= fuzzy_total + 01;

	prefix1 := 	rpad(compress1, 1);
	prefix2 := 	rpad(compress2, 1);

	if	prefix1 = 'O'
	and	prefix2 = 'O'		then	
		max_score	:= match_score - vowel_score;
	else
		max_score	:= match_score;
	end if;

	if	score <= max_score
	and	score <  best_score	then
		best_score	:= score;
		best_count	:= 0;
	end if;

	if	score = best_score	then
		best_count	:= best_count + 01;
		best_name3	:= best_name2;
		best_name2	:= best_name1;
		best_name1	:= scan.addr_name;

		if	do_test > 0		then
		dbms_output.put_line ( 'name1 ' || best_name1 ||' name2 ' || best_name2 ||' name3 ' || best_name3);
		end if;

	end if;
	
<<end_loop>>
	null;
end loop;

		if	do_test > 0		then
		dbms_output.put_line ( 'name1 ' || best_name1 ||' name2 ' || best_name2 ||' name3 ' || best_name3);
		dbms_output.put_line ( 'best  ' || best_count);
		end if;


	good_count	:= least (best_count, 03);
	best_count	:= 0;

while best_count < good_count			loop

	best_count := best_count + 01;

	if	best_count = 01			then
		name1		:= best_name1;
	elsif	best_count = 02			then
		name1		:= best_name2;
	elsif	best_count = 03			then
		name1		:= best_name3;
	end if;

	alias_total	:= alias_total + 01;

	if	do_insert > 0		then
		insert into garland.adrAlias values 
	(
		'*', look.addr_name,	'*', '*',
		alias_group + best_count, 999999, 0,
		'', name1,			'', '',
		spec_method,
		'','','',
		spec_weight
		,0					-- alias_match	nov 2003
		,0					-- alias_priority	dec 2004
	);

		insert_total := insert_total + 01;
	end if;

	if	do_print > 0		then
		dbms_output.put_line (	rpad(look.addr_name,20) ||'   '|| rpad(name1,20)		||'   '|| 
						lpad(best_score,3)	||' / '|| lpad(best_count,3) );
	end if;

end loop;

	if	do_test > 0		
	and	good_count = 3	then
		exit;
	end if;

end loop;

--	============================================================================

	commit;

	dbms_output.put_line (	' ' );
	dbms_output.put_line (	'total read   ' || read_total);
	dbms_output.put_line (	'total fuzzy  ' || fuzzy_total);
	dbms_output.put_line (	'total alias  ' || alias_total);
	dbms_output.put_line (	'total insert ' || insert_total);

end;


/*
--	============================================================================
	set serveroutput	on	size 999999;
declare
	name1		varchar2(40)	:= 'B';
	name2		varchar2(40)	:= 'F';

	score			binary_integer;
	errors		binary_integer;
begin
	garland.ADR_Compare_Name (name1, name2, score, errors);	

	dbms_output.put_line (	name1	||'   '|| name2	||'   '|| 
					score		||' / '|| errors	 );
end;
--	============================================================================
*/

