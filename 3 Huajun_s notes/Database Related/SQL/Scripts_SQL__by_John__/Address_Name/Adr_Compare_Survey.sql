
--	survey proximity of adrstreet names ot neighboring street names

	set echo 		off;
	set timing		on;
	set serveroutput	on;

	truncate table	gis_objects	reuse storage;

declare

		spec_score_rating		number		:=  2.0;
		spec_length_factor	number		:=  0.80;

		spec_lo			varchar2(20)	:= 'C';
		spec_hi			varchar2(20)	:= spec_lo || 'z';

--		spec_lo			varchar2(20)	:= 'CA';
--		spec_hi			varchar2(20)	:= 'CE';

		do_compile_only		number		:= 0;

		this_name			varchar2(20)	:= ' ';
		that_name			varchar2(20)	:= ' ';
		name_lo			varchar2(20);		
		name_hi			varchar2(20);		

		score				number;
		good				number;
		rating			number;
		errors			number;
		leng_name			number;

		insert_count		number	:= 0;
		primary_count		number	:= 0;
		secondary_count		number	:= 0;


cursor	read_adrstreet		is

	select	addr_name
	from		adrstreet
	where		addr_name	between spec_lo and spec_hi;


cursor	read_like_names		is

	select	addr_name
	from		adrstreet
	where		addr_name  > name_lo 
	and		addr_name <> this_name
	and		abs (length(addr_name) - leng_name) / leng_name <= spec_length_factor
	;

--	===========================================================================

begin

	if	do_compile_only > 0		then
		return;
	end if;


for	look in	read_adrstreet			loop

	this_name	:= look.addr_name;
	leng_name	:= length(this_name);

	name_lo	:= substr (this_name, 01, 01);
	name_hi	:= name_lo || 'z';

	primary_count := primary_count + 01;

loop

	open	read_like_names;
	fetch	read_like_names		into that_name;
	exit when	read_like_names%notfound
		or	read_like_names%notfound is null;

	if	that_name > name_hi		then
		exit;
	else
		name_lo := that_name;	
	end if;	

	TST_compare_name (this_name, that_name, score, good, errors);

	rating := score / good;

	if	rating <= spec_score_rating 	then
		insert into gis_objects	( item01, 	 item02, 	item03, item04, item05 )
				values		( this_name, that_name,	score,  good,   errors );
		commit;
		insert_count := insert_count + 01;
	end if;

	close	read_like_names;

	secondary_count := secondary_count + 01;

end loop;

	close	read_like_names;

	commit;

end loop;

	dbms_output.put_line ( 'inserts ' || insert_count ||' reads  '|| primary_count ||' / '|| secondary_count);

end;
