	set echo off;

--	Revision	JAN 2003

	create or replace trigger	CDRELPAR_INSERT
	before	INSERT	
--	or		UPDATE					-- (ORA-4091)
	on  		garland.CDRELPAR
	for each row

declare

	grid				varchar2(20);
	high_parcel_id		varchar2(20);	

	next_seq			number;
	count_parcel_id		number;

begin

--	assign a new parcel_id when only the grid (first two digits of parcel_id) is entered by user

	grid	:= rtrim (:new.parcel_id);
	if	length (grid) = 02			then

		select max (parcel_id)		
		into	high_parcel_id
		from	cdrelpar
		where	parcel_id like grid || '%';

		if	translate (high_parcel_id, '123456789AB', '00000000000') = '0000000.000'	then	
			 next_seq	   := substr (high_parcel_id, 03, 05) + 01;
			:new.parcel_id := grid || lpad (next_seq, 05, '0') || '.000';

		elsif	high_parcel_id is null		then	
			:new.parcel_id := grid || '00001.000';						-- MAR 2005

--			raise_application_error (-20112, 'Parcel grid (' || grid || 
--								   ') does not exist. If this is a new grid, call GIS');

		else
			raise_application_error (-20113, 'Highest Parcel ID  (' || high_parcel_id || 
								   ') is invalid. Next Parcel ID was not calculated');
		end if;

	end if;

--	verify the format of parcel id

	if	translate (:new.parcel_id, '123456789AB', '00000000000') <> '0000000.000'	then
		raise_application_error (-20110,'Parcel ID ' || :new.parcel_id || ' is invalid');
	end if;


--	temporary guard against insertion of duplicate parcel id until unique key can be defined


	if	inserting	then
		select count(*)
		into	 count_parcel_id
		from	 cdrelpar
		where	 parcel_id = :new.parcel_id;
	end if;

	if	count_parcel_id > 0	then
		raise_application_error (-20111, 'Parcel ID ' || :new.parcel_id || ' is dupe');
	end if;



<<eoj>>
	null;

end;

