
--	created on Aug 19, 2004


	create or replace trigger	cdreladr_insert
	before insert or update
	on     garland.cdreladr
	for each row

	declare

		occurs		binary_integer;

	begin

--	update null columns

		:new.addr_status	:= nvl (lower ( rtrim (:new.addr_status)), ' ');

--	verify street items

		:new.addr_name	:= nvl ( upper ( rtrim (:new.addr_name)),' ');
		:new.addr_type	:= nvl ( upper ( rtrim (:new.addr_type)),' ');
		:new.addr_pfx	:= nvl ( upper ( rtrim (:new.addr_pfx)), ' ');
		:new.addr_sfx	:= nvl ( upper ( rtrim (:new.addr_sfx)), ' ');

		if	:new.addr_name = ' '							then
			raise_application_error (-20100,'*** Street name is missing ***');
		end if;

		if	:new.addr_pfx not in ( ' ', 'N', 'S', 'E', 'W' )		then
			raise_application_error (-20101,'*** Prefix ' || :new.addr_pfx || ' is invalid ***');
		end if;

		if	:new.addr_sfx not in ( ' ', 'N', 'S', 'E', 'W' )		then
			raise_application_error (-20102,'*** Suffix ' || :new.addr_sfx || ' is invalid ***');
		end if;


--	verify the format of the Parcel ID

		if	translate (:new.parcel_id, '123456789AB', '00000000000') <> '0000000.000'	then
			raise_application_error (-20110,'*** Parcel ID ' || :new.parcel_id || ' has an invalid format ***');
		end if;

--	update address id

		if	inserting	then
			select	cdreladr_addr_id.nextval
			into		:new.addr_id
			from		dual;
		end if;

		if	inserting	then
			select	count(*)
			into	occurs
			from	garland.cdreladr
			where	addr_name	= :new.addr_name
			and	addr_num	= :new.addr_num
			and	addr_type	= nvl (:new.addr_type, '  ' )
			and	addr_pfx	= nvl (:new.addr_pfx,  '  '  )
			and	addr_sfx	= nvl (:new.addr_sfx,  '  '  )
			and	unit_type	= nvl (:new.unit_type, '  '  )
			and	unit_num	= nvl (:new.unit_num, '  '  )
			;

			if	occurs > 0	then
				raise_application_error (-20120,'***  duplicate address  ***');
			end if;

		end if;

	end;


