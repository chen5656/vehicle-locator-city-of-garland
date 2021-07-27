
--	===================================================================

	alter table cdreladr	add				xxxx
(
		tax_key	char(25),
		ums_key	number
);


--	===================================================================

	create user	readonly
		identified by		gis2221read
		default tablespace	gis_data
		temporary tablespace	gistemp_segs;

--	===================================================================

	grant select any table to readonly			xxxx;

--	===================================================================

	create sequence	garland.cdreladr_addr_id	xxxx
	start with		001
	increment by	001
	minvalue		001
	maxvalue		999999
	cache			01
	order
	nocycle;

--	===================================================================

	create or replace trigger	cdreladr_insert
	before insert or update
	on     garland.cdreladr
	for each row

	declare

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

--	maintain address id

		if	inserting		then
			:new.addr_id := cdreladr_addr_id.nextval;
		end if;

	end;


