
--	==================================================================

	if	series = 2	and  step = 1											then
		if (have.error = error_extra   and have.here2 = have.next1 and have.here1 in ('E', 'S') )
		or (have.error = error_missing and have.here1 = have.next2 and have.here2 in ('E', 'S') )	then
			also_error := also_final;
		end if;
	end if;

--	==================================================================

	have.error := have.error + also_error;

	if	also_error = also_final				then
		weight  := weight_final;

	elsif	also_error = also_misplace			then
		weight  := weight_misplace;
	end if;


--	==================================================================

	adjust1 := 0;
	adjust2 := 0;

	name := rtrim(name1,'ES ');
	if	name1 <> name		then
		name1 := name;
		adjust1 := 1;
	end if;

	name := rtrim(name2,'ES ');
	if	name2 <> name		then
		name2 := name;
		adjust2 := 1;
	end if;

	if	adjust1 <> adjust2	then
		score := weight_ending;
	end if;

--	==================================================================
