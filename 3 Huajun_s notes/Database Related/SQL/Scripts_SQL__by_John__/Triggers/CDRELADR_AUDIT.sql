	set echo on;
--	===============================================================================
--	audit activity against CDRELADR
--	===============================================================================

	create or replace trigger	garland.CDRELADR_Audit

	after		insert or delete or
			update of PARCEL_ID, ADDR_NAME, ADDR_NUM, ADDR_TYPE, ADDR_PFX, ADDR_SFX
	on  		garland.CDRELADR			--	live
--	on  		garland.CDRELADR_COPY		--	test
	for each row

declare

	retention_count	number := 16000;		--	SPECIFY maximum records
	purge_days		number := 07;		--	SPECIFY days to be purged

	this_osuser		varchar2(20);
	this_machine	varchar2(40);
	this_action		varchar2(01);
	this_count		number;
	this_oldest		date;

	old_parcel		varchar2(20);
	old_num		varchar2(20);
	old_pfx		varchar2(20);
	old_name		varchar2(20);
	old_type		varchar2(20);
	old_sfx		varchar2(20);

	new_parcel		varchar2(20);
	new_num		varchar2(20);
	new_pfx		varchar2(20);
	new_name		varchar2(20);
	new_type		varchar2(20);
	new_sfx		varchar2(20);

begin


	select count(*)
	into	this_count
	from	cdreladr_audit;

	if	this_count > retention_count			then
		select min(timestamp)
		into	 this_oldest
		from	 cdreladr_audit;

		delete from cdreladr_audit
		where	 timestamp < this_oldest + purge_days - 01;
	end if;


	select userenv('TERMINAL') 					-- MAR 2005
	into	this_osuser
	from dual;

	this_osuser := substr (this_osuser, instr( this_osuser, '-', -1) + 1);


	select substr(userenv('TERMINAL'),8) 			-- MAY 16, 2005
	into	this_osuser
	from dual;


--	select osuser, machine
--	into	 this_osuser, this_machine
--	from	 v$session
--	where	 audsid = userenv('SESSIONID');


	if	inserting			then
		this_action	:= 'I';
	elsif	updating			then
		this_action	:= 'U';
	elsif	deleting			then
		this_action	:= 'D';
	end if;

	old_parcel	:= :old.parcel_id;
	new_parcel	:= :new.parcel_id;

	if	:old.addr_num = :new.addr_num		then
		null;
	else
		old_num	:= :old.addr_num;
		new_num	:= :new.addr_num;
	end if;

	if	:old.addr_pfx = :new.addr_pfx		then
		null;
	else
		old_pfx	:= :old.addr_pfx;
		new_pfx	:= :new.addr_pfx;
	end if;

	if	:old.addr_name = :new.addr_name	then
		null;
	else
		old_name	:= :old.addr_name;
		new_name	:= :new.addr_name;
	end if;

	if	:old.addr_type = :new.addr_type	then
		null;
	else
		old_type	:= :old.addr_type;
		new_type	:= :new.addr_type;
	end if;

	if	:old.addr_sfx = :new.addr_sfx		then
		null;
	else
		old_sfx	:= :old.addr_sfx;
		new_sfx	:= :new.addr_sfx;
	end if;

	if	nvl(old_parcel,' ') <>  nvl(new_parcel,' ')		
	or	old_num ||new_num ||	old_pfx||new_pfx||	old_name||new_name||	
		old_type||new_type||	old_sfx||new_sfx		is not null 	then

		insert into	cdreladr_audit	values
		(
			this_osuser,
			this_action,
			sysdate,
			old_parcel,
			new_parcel,
			old_num,
			new_num,
			old_pfx,
			new_pfx,
			old_name,
			new_name,
			old_type,
			new_type,
			old_sfx,
			new_sfx
		);
	end if;

end;
