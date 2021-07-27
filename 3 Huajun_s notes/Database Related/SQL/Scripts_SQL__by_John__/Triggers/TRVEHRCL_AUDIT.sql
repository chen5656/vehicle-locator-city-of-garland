	set echo off;
--	===============================================================================
--	audit activity against TRVEHRCL
--	===============================================================================

	create or replace trigger	garland.TRVEHRCL_audit

	after		insert or delete or
			update of MSLINK, ADDR_NAME, ADDR_NUM, ADDR_TYPE, ADDR_PFX, ADDR_SFX, ADDR_LO, ADDR_HI,
						BRANCH_NO, SECTION_NO
	on  		garland.TRVEHRCL			--	live
--	on  		garland.TRVEHRCL_COPY		--	test
	for each row

declare

	retention_count	number := 16000;		--	specify maximum records
	purge_days		number := 07;		--	specify days to be purged

	this_osuser		varchar2(08);
	this_machine	varchar2(40);
	this_action		varchar2(01);
	this_count		number;
	this_oldest		date;

	old_mslink		varchar2(20);
	old_branch		varchar2(20);
	old_section		varchar2(20);
	old_lo		varchar2(20);
	old_hi		varchar2(20);
	old_pfx		varchar2(20);
	old_name		varchar2(40);
	old_type		varchar2(20);
	old_sfx		varchar2(20);

	new_mslink		varchar2(20);
	new_branch		varchar2(20);
	new_section		varchar2(20);
	new_lo		varchar2(20);
	new_hi		varchar2(20);
	new_pfx		varchar2(20);
	new_name		varchar2(40);
	new_type		varchar2(20);
	new_sfx		varchar2(20);

begin

	select count(*)
	into	this_count
	from	trvehrcl_audit;

	if	this_count > retention_count			then
		select min(timestamp)
		into	 this_oldest
		from	 trvehrcl_audit;

		delete from trvehrcl_audit
		where	 timestamp < this_oldest + purge_days - 01;
	end if;


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

	old_mslink	:= :old.mslink;
	new_mslink	:= :new.mslink;

	if	:old.branch_no = :new.branch_no		then
		null;
	else
		old_branch	:= :old.branch_no;
		new_branch	:= :new.branch_no;
	end if;

	if	:old.section_no = :new.section_no		then
		null;
	else
		old_section	:= :old.section_no;
		new_section	:= :new.section_no;
	end if;

	if	:old.addr_lo = :new.addr_lo			then
		null;
	else
		old_lo	:= :old.addr_lo;
		new_lo	:= :new.addr_lo;
	end if;

	if	:old.addr_hi = :new.addr_hi			then
		null;
	else
		old_hi	:= :old.addr_hi;
		new_hi	:= :new.addr_hi;
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

	if	nvl(old_mslink, 0) <>  nvl(new_mslink, 0)	
	or	old_branch||new_branch|| old_section||new_section||	
		old_lo  ||new_lo  || old_hi  ||new_hi  ||	
		old_pfx ||new_pfx || old_name||new_name||
		old_type||new_type|| old_sfx ||new_sfx	is not null 	then

		insert into	trvehrcl_audit	values
		(
			this_osuser,
			this_action,
			sysdate,
	
			old_mslink,
			new_mslink,
			old_branch,
			new_branch,
			old_section,
			new_section,
	
			old_pfx,
			new_pfx,
			old_name,
			new_name,
			old_type,
			new_type,
			old_sfx,
			new_sfx,

			old_lo,
			new_lo,
			old_hi,
			new_hi
		);
	end if;

end;

