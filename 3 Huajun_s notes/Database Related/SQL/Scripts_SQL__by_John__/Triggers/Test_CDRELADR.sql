
	create or replace trigger	trig_cdreladr_insert
	before insert or update
	on     garland.cdreladr
	for each row

	declare

		new_pfx		varchar2(02);
		new_sfx		varchar2(02);

	begin

--	update null columns

		:new.addr_status	:= nvl (:new.addr_status, ' ');

--	verify street qualifiers

		new_pfx := nvl ( upper ( rtrim (:new.addr_pfx)), ' ');
		new_sfx := nvl ( upper ( rtrim (:new.addr_sfx)), ' ');

		if	new_pfx not in ( ' ', 'N', 'S', 'E', 'W' )		then
			raise_application_error (-20101,'*** Prefix ' || :new.addr_pfx || ' is invalid ***');
		end if;

		if	new_sfx not in ( 'N', 'S', 'E', 'W' )		then
			raise_application_error (-20102,'*** Suffix ' || :new.addr_sfx || ' is invalid ***');
		end if;

		:new.addr_pfx := new_pfx;
		:new.addr_sfx := new_sfx;


--	verify the format of the Parcel ID

		if	translate (:new.parcel_id, '123456789AB', '00000000000') <> '0000000.000'	then
			raise_application_error (-20110,'*** Parcel ID ' || :new.parcel_id || ' has an invalid format ***');
		end if;

	end;


