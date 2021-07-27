	set echo		off;
	set serveroutput	on;

--	Find ending name of a street name, if one exists
--	Ending may be preceded by a space or may be found in adrEnding
--	Example:	Naaman School
--	Example:	Ridgewood

--	create or replace function	garland.ADR_name_ending ( street_name  varchar2)		return varchar2
	create or replace function	garland.TST_name_ending ( street_name  varchar2)		return varchar2

as

	min_begin		number	:= 03;
	min_end		number	:= 03;	--	adrEnding minimum

	do_test		number	:= 0;

	user_name		varchar2(80);
	end_name		varchar2(80);
	tail			varchar2(10);

	leng_name		number;
	find_posn		number;
	end_posn		number;

begin

	user_name := ltrim (rtrim (upper (street_name)));
	leng_name := length(user_name);

--	tail	    := substr (user_name, leng_name - 2);		-- feb 2004

--	name should begin with an alpha character

	if	user_name between 'A' and 'Zzz'
	or	user_name between 'a' and 'zzz'			then
		null;
	else
		end_name  := null;
		goto	final_edit;
	end if;

--	the last word should be minimum length

	find_posn := instr (user_name, ' ', -1);
	if	find_posn > 0
	and	leng_name - find_posn >= min_end			then
		end_posn := find_posn;

--	else the words after the first word should be minimum length

	elsif	find_posn > 0						then
		find_posn := instr (user_name, ' ');
		if	leng_name - find_posn >= min_end		then
			end_posn := find_posn;
		end if;
	else
		end_posn := null;
	end if;


--	the begin word should be minimum length
--	the trimmed ending should begin with an alpha character
--	the trimmed ending should be minimum length

	if	do_test > 0		then
		dbms_output.put_line ('fff	' || end_posn);
	end if;

	if	end_posn  > min_begin				then
		end_name := ltrim(substr (user_name, end_posn));
		goto	final_edit;
	end if;

--	if the above fails then look for standard ending (per adrEnding)

	end_name	:= null;

for	look in (select /*+ cache(adrEnding) */ * from garland.adrEnding)		loop

--	if	look.name_tail = tail					then			-- feb 2004

		find_posn := instr (user_name, look.name, -1);
		if	find_posn > min_begin				then
			end_name  := look.name;
			exit;
		end if;

--	end if;

end loop;
	
	if	do_test > 0		then
		dbms_output.put_line ('mmm	' || find_posn ||' '|| end_name);
	end if;

<<final_edit>>

	if	end_name >= 'A'	
	and	length (end_name) >= min_end
	and	find_posn - 1	>= min_begin		then
		null;
	else
		end_name := null;
	end if;

	return  end_name;

end;
