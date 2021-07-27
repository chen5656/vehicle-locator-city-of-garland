	set echo	off;
--	================================================================================================
--	Edit subdivision id and dates during update
--	then update the record
--	================================================================================================

--	desc cdrelsubdv;

--	create or replace view	garland.cdrelsubdv_vw		as select * from garland.cdrelsubdv;

--	================================================================================================

	create or replace trigger	garland.cdrelsubdv_update
	instead of update
	on  garland.cdrelsubdv_vw
	for each row

declare

	this_subdiv_id	number;
	this_filing_date	varchar2(20);
	this_login_date	varchar2(20);

	year1			number;
	year2			number;
	dupe			number;
	valid_date		date;
	pattern		varchar2(20);

begin

--	====================
--	Edit subdivision id
--	====================
	
	if	:new.subdiv_id = :old.subdiv_id		then
		this_subdiv_id	:= :old.subdiv_id;
		goto	edit_dates;
	else
		this_subdiv_id	:= :new.subdiv_id;
	end if;

	if	this_subdiv_id = 0 							then
		year1		:= to_char(sysdate, 'yyyy') * 1000;
		year2		:= year1 + 999;

	elsif	substr(abs(this_subdiv_id),1,4) between '1900' and '2099'	then
		null;

	else
		raise_application_error (-20101, '** Bad Subdiv Year ' || this_subdiv_id);
	end if;

	if	this_subdiv_id > 0					then
		if	this_subdiv_id between 1900 and 2099	then
			year1			:= this_subdiv_id * 1000;
			year2			:= year1  + 0999;
			this_subdiv_id	:= 0;
		elsif	this_subdiv_id < 1900001			
		or	this_subdiv_id > 2099999			
		or	mod(this_subdiv_id, 1000) = 0			then
			raise_application_error (-20111, '** Bad Subdiv Id ' || this_subdiv_id);
		end if;
	end if;

	if	this_subdiv_id > 1900000				then
		select count(*)
		into	 dupe
		from	 garland.cdrelsubdv
		where  subdiv_id = this_subdiv_id;

		if	dupe > 0		then
			raise_application_error (-20112, '** Dupe Subdiv Id ' || this_subdiv_id);
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
		raise_application_error (-20900, '** Program Error ' || this_subdiv_id);
	end if;

	
--	==================
--	Edit date formats
--	Dates are varchar2 because of difficulty in using Oracle dates by MGE users
--	==================

<<edit_dates>>

	pattern := translate (:new.filing_date, '012345678', '999999999');

	if	pattern is null
	or	pattern = '9999/99/99'			then
		this_filing_date	:= :new.filing_date;

	elsif	pattern = '99999999'			then
		this_filing_date	:= substr(:new.filing_date, 01,04)	||'/'||
					   substr(:new.filing_date, 05,02)	||'/'||
					   substr(:new.filing_date, 07,02);

	else
		raise_application_error (-20201,'** Filing Date is YYYY/MM/DD');
	end if;


	pattern := translate (:new.login_date, '012345678', '999999999');

	if	pattern is null
	or	pattern = '9999/99'			then
		this_login_date	:= :new.login_date;

	elsif	pattern = '999999'			then
		this_login_date	:= substr(:new.login_date, 01,04)	||'/'||
					   substr(:new.login_date, 05,02);

	else
		raise_application_error (-20202,'** Login Date is YYYY/MM');
	end if;


--	let Oracle validate dates & give error message

	valid_date	:= to_date (this_filing_date, 'yyyy/mm/dd');
	valid_date	:= to_date (this_login_date,  'yyyy/mm');

--	==================
--	update the record
--	==================

	this_subdiv_id	:= nvl(this_subdiv_id,	:old.subdiv_id);
	this_filing_date	:= nvl(this_filing_date,:old.filing_date);
	this_login_date	:= nvl(this_login_date, :old.login_date);

	update garland.cdrelsubdv	
	set
		subdiv_id		= this_subdiv_id,
		filing_date		= this_filing_date,
		login_date		= this_login_date,

		mslink		= :new.mslink,                                                
		mapid			= :new.mapid,                                                  
		final_plat		= :new.final_plat,                                        
		replat		= :new.replat,                                                
		block			= :new.block,                                                  
		lot_lo		= :new.lot_lo,                                                
		lot_hi		= :new.lot_hi,                                                
		resident_lots	= :new.resident_lots,                                  
		common_lots		= :new.common_lots,                                      
		volume		= :new.volume,                                                
		page_no		= :new.page_no,                                              
		area_sqft		= :new.area_sqft,                                          
		area_acre		= :new.area_acre,                                          
		parcel1		= :new.parcel1,                                              
		parcel2		= :new.parcel2,                                              
		parcel3		= :new.parcel3,                                              
		parcel4		= :new.parcel4,                                              
		grid1			= :new.grid1,                                                  
		grid2			= :new.grid2,                                                  
		grid3			= :new.grid3,                                                  
		grid4			= :new.grid4

	where mslink = :old.mslink;

/*
		mslink		= nvl(:new.mslink,	:old.mslink),                                      
		mapid			= nvl(:new.mapid,		:old.mapid),                                         
		final_plat		= nvl(:new.final_plat,	:old.final_plat),                          
		replat		= nvl(:new.replat,	:old.replat),                                      
		block			= nvl(:new.block,		:old.block),                                         
		lot_lo		= nvl(:new.lot_lo,	:old.lot_lo),                                      
		lot_hi		= nvl(:new.lot_hi,	:old.lot_hi),                                      
		resident_lots	= nvl(:new.resident_lots,   :old.resident_lots),                 
		common_lots		= nvl(:new.common_lots,	:old.common_lots),                       
		volume		= nvl(:new.volume,	:old.volume),                                      
		page_no		= nvl(:new.page_no,	:old.page_no),                                   
		area_sqft		= nvl(:new.area_sqft,	:old.area_sqft),                             
		area_acre		= nvl(:new.area_acre,	:old.area_acre),                             
		parcel1		= nvl(:new.parcel1,	:old.parcel1),                                   
		parcel2		= nvl(:new.parcel2,	:old.parcel2),                                   
		parcel3		= nvl(:new.parcel3,	:old.parcel3),                                   
		parcel4		= nvl(:new.parcel4,	:old.parcel4),                                   
		grid1			= nvl(:new.grid1,		:old.grid1),                                         
		grid2			= nvl(:new.grid2,		:old.grid2),                                         
		grid3			= nvl(:new.grid3,		:old.grid3),                                         
		grid4			= nvl(:new.grid4,		:old.grid4)
*/

end;

--	================================================================================================
/*	format column updates to be used in SQL update command

	select
	'		'	|| lower(column_name) || '		= nvl(:new.' || lower(column_name) 
				||',	:old.'|| lower(column_name) ||'),'		" "
	from	cols
	where	table_name = 'CDRELSUBDV'
	order by 	column_id;
*/
--	================================================================================================
