	set echo	off;
--	================================================================================================
--	Edit subdivision id and dates

--	User may insert or update a specific subdivision id = yyyysss
--	where yyyy = year and sss = sequence

--	If user specifies subdivision year only,	then the next id for that year is assigned
--	If user does not any subdivision info,	then the next id for current year is assigned

--	To insert next subdivision id for a year, user should enter Subdiv_ID = yyyy
--	To update next subdivision id for a year, user should enter MapID =   - yyyy
--	================================================================================================
--	================================================================================================
--	Tasks
--		edit grids & parcels
--		merge with Instead of Update
--	================================================================================================

	create or replace trigger	cdrelsubdv_insert
	before insert
	on  garland.cdrelsubdv
	for each row

declare

	this_subdiv_id	number;
	this_filing_date	date;
	this_login_date	date;

	pattern		varchar2(20);
	year1			varchar2(20);
	year2			varchar2(20);
	dupe			number;
	valid_date		date;

begin

--	====================
--	Edit subdivision id
--	====================

	this_subdiv_id	:= :new.subdiv_id;

	if	this_subdiv_id is null		then
		goto	edit_date_formats;
	end if;

	if	this_subdiv_id = 0 							then
		year1		:= to_char(sysdate, 'yyyy') * 1000;
		year2		:= year1 + 999;

	elsif	substr(abs(this_subdiv_id),1,4) between '1900' and '2099'	then
		null;

	else
--		raise_application_error (-20101, 'Bad Subdiv Yr');
		raise_application_error (-20101, 'Bad Year');
	end if;

	if	this_subdiv_id > 0					then
		if	this_subdiv_id between 1900 and 2099	then
			year1			:= this_subdiv_id * 1000;
			year2			:= year1  + 0999;
			this_subdiv_id	:= 0;
		elsif	this_subdiv_id < 1900001			
		or	this_subdiv_id > 2099999			
		or	mod(this_subdiv_id, 1000) = 0			then
--			raise_application_error (-20111, 'Bad Subdiv Id');
			raise_application_error (-20111, 'Bad Id');
		end if;
	end if;

	if	this_subdiv_id > 1900000				then
		select count(*)
		into	 dupe
		from	 garland.cdrelsubdv
		where  subdiv_id = this_subdiv_id;

		if	dupe > 0		then
--			raise_application_error (-20112, 'Dupe Subdiv Id');
			raise_application_error (-20112, 'Dupe Id');
		end if;
	end if;

	if	this_subdiv_id = 0					then
		select nvl (max(subdiv_id), 0)
		into	 this_subdiv_id
		from	 garland.cdrelsubdv
		where	 subdiv_id between year1 and year2;

		if	this_subdiv_id = 0				then
			this_subdiv_id	:= year1  + 001;
		else
			this_subdiv_id	:= this_subdiv_id + 001;
		end if;

	end if;

	if	this_subdiv_id not between 1900001 and 2099999	then
		raise_application_error (-20900, 'Program Error');
	end if;

	
<<edit_date_formats>>

--	=============================================================================
--	Dates are varchar2 because of difficulty in using Oracle dates by MGE users
--	=============================================================================

	pattern := translate (:new.filing_date, '012345678', '999999999');

	if	pattern is null
	or	pattern = '9999/99/99'			then
		this_filing_date	:= :new.filing_date;
	elsif	pattern = '99999999'			then
		this_filing_date	:= substr(:new.filing_date, 01,04)	||'/'||
					   substr(:new.filing_date, 05,02)	||'/'||
					   substr(:new.filing_date, 07,02);
	else
		raise_application_error (-20201,'Filing is YYYY/MM/DD');
	end if;

	pattern := translate (:new.login_date, '012345678', '999999999');

	if	pattern is null
	or	pattern = '9999/99'			then
		this_login_date	:= :new.login_date;
	elsif	pattern = '999999'			then
		this_login_date	:= substr(:new.login_date, 01,04)	||'/'||
					   substr(:new.login_date, 05,02);
	else
		raise_application_error (-20202,'Login YYYY/MM');
	end if;


--	let Oracle validate dates & give error messages

	valid_date	:= to_date (this_filing_date, 'yyyy/mm/dd');
	valid_date	:= to_date (this_login_date,  'yyyy/mm');

--	==================
--	prepare output
--	==================

	:new.subdiv_id	:= nvl(this_subdiv_id,	:old.subdiv_id);
	:new.filing_date	:= nvl(this_filing_date,:old.filing_date);
	:new.login_date	:= nvl(this_login_date, :old.login_date);

end;

