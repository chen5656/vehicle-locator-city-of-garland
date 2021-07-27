	set echo oN;
--	===============================================================================
--	audit activity against CDRELPAR
--	===============================================================================

	drop trigger			garland.CDRELPAR_Audit;

	create or replace trigger	garland.CDRELPAR_Audit

	After		Insert or Delete or Update
	on  		garland.CDRELPAR			--	live
--	on  		garland.CDRELPAR_COPY		--	test
	for each row

declare

	retention_count	number := 16000;		--	SPECIFY maximum records
	purge_days		number := 07;		--	SPECIFY days to be purged

	this_osuser		varchar2(08);
	this_action		varchar2(01);
	this_count		number;
	this_oldest		date;

	old_parcel		varchar2(12);
	new_parcel		varchar2(12);
	old_mslink		number;
	new_mslink		number;

begin

	select count(*)
	into	this_count
	from	cdrelpar_audit;

	if	this_count > retention_count			then
		select min(timestamp)
		into	 this_oldest
		from	 cdrelpar_audit;

		delete from cdrelpar_audit
		where	 timestamp < this_oldest + purge_days - 01;
	end if;


	select substr(userenv('TERMINAL'),8) 			-- MAY 16, 2005
	into	this_osuser
	from dual;

	if	inserting			then
		this_action	:= 'I';
	elsif	updating			then
		this_action	:= 'U';
	elsif	deleting			then
		this_action	:= 'D';
	end if;

	old_parcel	:= :old.parcel_id;
	new_parcel	:= :new.parcel_id;

	if	:old.mslink = :new.mslink	then
		null;
	else
		old_mslink	:= :old.mslink;
		new_mslink	:= :new.mslink;
	end if;

	if	nvl(old_parcel,' ') <> nvl(new_parcel,' ')
	or	old_mslink||new_mslink		is not null			then

	  	insert into	cdrelpar_audit	values
	   	(
	 		this_osuser,
			this_action,
			sysdate,
			old_mslink,
			new_mslink,
			old_parcel,
			new_parcel
		);
	end if;

end;

