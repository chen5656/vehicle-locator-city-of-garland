
	create or replace trigger	TRVEHRCL_INSERT

	before INSERT

	on     garland.TRVEHRCL

	for each row

	declare

	begin


--	verify street items

		:new.addr_name	:= nvl ( upper ( rtrim (:new.addr_name)),' ');
		:new.addr_type	:= nvl ( upper ( rtrim (:new.addr_type)),' ');
		:new.addr_pfx	:= nvl ( upper ( rtrim (:new.addr_pfx )),' ');
		:new.addr_sfx	:= nvl ( upper ( rtrim (:new.addr_sfx )),' ');


--		select trvehrcl_segment_seq.nextval 		-- AUG 2005
--		into :new.segment_id 
--		from dual;

--		if	:new.addr_name = ' '							then
--			raise_application_error (-20200,'*** Street name is missing ***');
--		end if;

		if	:new.addr_pfx not in ( ' ', 'N', 'S', 'E', 'W' )		then
			:new.addr_pfx := ' ';
--			raise_application_error (-20201,'*** Prefix ' || :new.addr_pfx || ' is invalid ***');
		end if;

		if	:new.addr_sfx not in ( ' ', 'N', 'S', 'E', 'W' )		then
			:new.addr_sfx := ' ';
--			raise_application_error (-20202,'*** Suffix ' || :new.addr_sfx || ' is invalid ***');
		end if;

	end;

