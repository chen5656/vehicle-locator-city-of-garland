

create or replace trigger GARLAND.ADRNAME_UPDATE
BEFORE 
INSERT
OR
DELETE
OR
UPDATE
on GARLAND.ADRNAME
REFERENCING NEW AS NEW OLD AS OLD
for each row 
declare

	user_terminal	varchar2(40);
	table_id		varchar2(40)	:=
'ADRNAME';

begin

	select lower(userenv('TERMINAL'))

	into	 user_terminal 
	from	 dual;
	
	if	user_terminal
like '%jdeacuti'
	or	user_terminal like '%enavarro'
	or	user_terminal
like '%nstimely'
--	or	user_terminal like '%staplin'
--	or	user_terminal
like '%njones'
	or	user_terminal like '%fsouza'
	or	user_terminal
like '%wlangley'
	then	
		null;
	else
		raise_application_error
(-20101, 'ERROR - User is not allowed to modify table
' || table_id );

	end if;

end;


create or replace trigger GARLAND.CDRELADR_INSERT
BEFORE 
INSERT
UPDATE
on GARLAND.CDRELADR
REFERENCING NEW AS NEW OLD AS OLD
for each row 
declare

	begin

--	update null columns

		:new.addr_status	:=
nvl (lower ( rtrim (:new.addr_status)), ' ');

--	verify
street items

		:new.addr_name	:= nvl ( upper ( rtrim
(:new.addr_name)),' ');
		:new.addr_type	:= nvl (
upper ( rtrim (:new.addr_type)),' ');
		:new.addr_pfx	:=
nvl ( upper ( rtrim (:new.addr_pfx)), ' ');
		:new.addr_sfx	:=
nvl ( upper ( rtrim (:new.addr_sfx)), ' ');

		if	:new.addr_name
= ' '							then
			raise_application_error (-20100,'***
Street name is missing ***');
		end if;

		if	:new.addr_pfx
not in ( ' ', 'N', 'S', 'E', 'W' )		then
			raise_application_error
(-20101,'*** Prefix ' || :new.addr_pfx || ' is invalid
***');
		end if;

		if	:new.addr_sfx not in ( ' ',
'N', 'S', 'E', 'W' )		then
			raise_application_error
(-20102,'*** Suffix ' || :new.addr_sfx || ' is invalid
***');
		end if;


--	verify the format of the Parcel
ID

		if	translate (:new.parcel_id, '123456789AB',
'00000000000') <> '0000000.000'	then
			raise_application_error
(-20110,'*** Parcel ID ' || :new.parcel_id || ' has
an invalid format ***');
		end if;

	end;



create or replace trigger GARLAND.CDRELADR_AUDIT
AFTER 
INSERT
OR
DELETE
OR
UPDATE
of ADDR_NAME
,ADDR_NUM
,ADDR_PFX
,ADDR_SFX
,ADDR_TYPE
,PARCEL_ID
on GARLAND.CDRELADR
REFERENCING NEW AS NEW OLD AS OLD
for each row 
declare

	retention_count	number := 16000;		--	SPECIFY
maximum records
	purge_days		number := 07;		--	SPECIFY
days to be purged

	this_osuser		varchar2(08);
	this_machine	varchar2(40);
	this_action		varchar2(01);
	this_count		number;
	this_oldest		date;

	old_parcel		varchar2(20);
	old_num		varchar2(20);
	old
pfx		varchar2(20);
	old_name		varchar2(20);
	old_type		varchar2(20);
	old_sfx		varchar2(20);

	new_parcel		varchar2(20);
	new_num		varchar2(20);
	new_pfx		varchar2(20);
	new_name		varchar2(20);
	new_t
pe		varchar2(20);
	new_sfx		varchar2(20);

begin

	select
count(*)
	into	this_count
	from	cdreladr_audit;

	if	this_count
> retention_count			then
		select min(timestamp)
		into	
this_oldest
		from	 cdreladr_audit;

		delete from
cdreladr_audit
		where	 timestamp < this_oldest +
purge_days - 01;
	end if;

	select osuser, machine
	into	
this_osuser, this_machine
	from	 v$session
	where	
audsid = userenv('SESSIONID');

	if	inserting			then
		this_action	:=
'I';
	elsif	updating			then
		this_action	:= 'U';
	elsif	deleting			then
		this_action	:=
'D';
	end if;

	old_parcel	:= :old.parcel_id;
	new_parcel	:=
:new.parcel_id;

	if	:old.addr_num = :new.addr_num		then
		null;
	else
		old_num	:=
:old.addr_num;
		new_num	:= :new.addr_num;
	end if;

	if	:old.addr_pfx
= :new.addr_pfx		then
		null;
	else
		old_pfx	:= :old.addr_pfx;
		new_pfx	:=
:new.addr_pfx;
	end if;

	if	:old.addr_name = :new.addr_name	then
		null;
	else
		old_name	:=
:old.addr_name;
		new_name	:= :new.addr_name;
	end
if;

	if	:old.addr_type = :new.addr_type	then
		null;
	else
		old_type	:=
:old.addr_type;
		new_type	:= :new.addr_type;
	end
if;

	if	:old.addr_sfx = :new.addr_sfx		then
		null;
	else
		old_sfx	:=
:old.addr_sfx;
		new_sfx	:= :new.addr_sfx;
	end if;

	if	nvl(old_parcel,'
') <>  nvl(new_parcel,' ')		
	or	old_num ||new_num
||	old_pfx||new_pfx||	old_name||new_name||	
		old_type||new_type||	old_sfx||new_sfx		is
not null 	then

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
			new_na
e,
			old_type,
			new_type,
			old_sfx,
			new_sfx
		);
	end
if;

end;


create or replace trigger GARLAND.CDRELPAR_INSERT
BEFORE 
INSERT
on GARLAND.CDRELPAR
REFERENCING NEW AS NEW OLD AS OLD
for each row 
declare

	grid				varchar2(20);
	high_parcel_id		varchar2(20);	

	next_seq			number;
	count_parcel_id		number;

begin

--	assign
a new parcel_id when only the grid (first two digits
of parcel_id) is entered by user

	grid	:= rtrim (:new.parcel_id);
	if	length
(grid) = 02			then

		select max (parcel_id)		
		into	high_parcel_id
		from	cdrelpar
		where	parcel_id
like grid || '%';

		if	translate (high_parcel_id,
'123456789AB', '00000000000') = '0000000.000'	then	
			
next_seq	   := substr (high_parcel_id, 03, 05) + 01;
			:new.parcel_id
:= grid || lpad (next_seq, 05, '0') || '.000';

		elsif	high_parcel_id
is null		then	
			raise_application_error (-20112,
'Parcel grid (' || grid || 
								   ') does not
exist. If this is a new grid, call GIS');
		else
			raise_application_error
(-20113, 'Highest Parcel ID  (' || high_parcel_id
|| 
								   ') is invalid. Next Parcel ID was not
calculated');
		end if;

	end if;

--	verify the format
of parcel id

	if	translate (:new.parcel_id, '123456789AB',
'00000000000') <> '0000000.000'	then
		raise_application_error
(-20110,'Parcel ID ' || :new.parcel_id || ' is invalid');
	end
if;


--	temporary guard against insertion of duplicate
parcel id until unique key can be defined


	if	inserting	then
		select
count(*)
		into	 count_parcel_id
		from	 cdrelpar
		where	
parcel_id = :new.parcel_id;
	end if;

	if	count_parcel_id
> 0	then
		raise_application_error (-20111, 'Parcel
ID ' || :new.parcel_id || ' is dupe');
	end if;



<<eoj>>
	null;

end;



create or replace trigger GARLAND.CDRELPAR_AUDIT
AFTER 
INSERT
OR
DELETE
OR
UPDATE
on GARLAND.CDRELPAR
REFERENCING NEW AS NEW OLD AS OLD
for each row 
declare

	retention_count	number := 16000;		--	SPECIFY
maximum records
	purge_days		number := 07;		--	SPECIFY
days to be purged

	this_osuser		varchar2(08);
	this_action		varchar2(01);
	this_count		number;
	this_oldest		date;

	old_parcel		varchar2(12);
	new_parcel		varchar2(12);
	old_mslink		number;
	new_msl
nk		number;

begin

	select count(*)
	into	this_count
	from	cdrelpar_audit;

	if	this_count
> retention_count			then
		select min(timestamp)
		into	
this_oldest
		from	 cdrelpar_audit;

		delete from
cdrelpar_audit
		where	 timestamp < this_oldest +
purge_days - 01;
	end if;

	select osuser
	into	 this_osuser
	from	
v$session
	where	 audsid = userenv('SESSIONID');

	if	inserting			then
		this_action	:=
'I';
	elsif	updating			then
		this_action	:= 'U';
	elsif	deleting			then
		this_action	:=
'D';
	end if;

	old_parcel	:= :old.parcel_id;
	new_parcel	:=
:new.parcel_id;

	if	:old.mslink = :new.mslink	then
		null;
	else
		old_mslink	:=
:old.mslink;
		new_mslink	:= :new.mslink;
	end if;

	if	nvl(old_parcel,'
') <> nvl(new_parcel,' ')
	or	old_mslink||new_mslink		is
not null			then

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
	end
if;

end;



create or replace trigger GARLAND.CDRELSUBDV_INSERT
BEFORE 
INSERT
on GARLAND.CDRELSUBDV
REFERENCING NEW AS NEW OLD AS OLD
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

--	===
================
--	Edit subdivision id
--	====================

	this_subdiv_id	:=
:new.subdiv_id;

	if	this_subdiv_id is null		then
		goto	edit_date_formats;
	end
if;

	if	this_subdiv_id = 0 							then
		year1		:=
to_char(sysdate, 'yyyy') * 1000;
		year2		:= year1
+ 999;

	elsif	substr(abs(this_subdiv_id),1,4) between
'1900' and '2099'	then
		null;

	else
		raise_application_error
(-20101, 'Bad Subdiv Yr');
	end if;

	if	this_subdiv_id
> 0					then
		if	this_subdiv_id between 1900 and
2099	then
			year1			:= this_subdiv_id * 1000;
			year2			:=
year1  + 0999;
			this_subdiv_id	:= 0;
		elsif	this_subdiv_id
< 1900001			
		or	this_subdiv_id > 2099999			
		or	mod(this_subdiv_id,
1000) = 0			then
			raise_application_error (-20111,
'Bad Subdiv Id');
		end if;
	end if;

	if	this_subdiv_id
> 1900000				then
		select count(*)
		into	 dupe
		from	
garland.cdrelsubdv
		where  subdiv_id = this_subdiv_id;

		if	dupe
> 0		then
			raise_application_error (-20112, 'Dupe
Subdiv Id');
		end if;
	end if;

	if	this_subdiv_id
= 0					then
		select nvl (max(subdiv_id), 0)
		into	
this_subdiv_id
		from	 garland.cdrelsubdv
		where	
subdiv_id between year1 and year2;

		if	this_subdiv_id
= 0				then
			this_subdiv_id	:= year1  + 001;
		else
			this_subdiv_id	:=
this_subdiv_id + 001;
		end if;

	end if;

	if	this_subdiv_id
not between 1900001 and 2099999	then
		raise_application_error
(-20900, 'Program Error');
	end if;

	
<<edit_date_formats>>

--	=============================================================================
--	Dates
are varchar2 because of difficulty in using Oracle
dates by MGE users
--	=============================================================================

	pattern
:= translate (:new.filing_date, '012345678', '999999999');

	if	pattern
is null
	or	pattern = '9999/99/99'			then
		this_filing_date	:=
:new.filing_date;
	elsif	pattern = '99999999'			then
		this_filing_date	:=
substr(:new.filing_date, 01,04)	||'/'||
					   substr(:new.filing_date,
05,02)	||'/'||
					   substr(:new.filing_date, 07,02);
	else
		raise_application_error
(-20201,'Filing is YYYY/MM/DD');
	end if;

	pattern
:= translate (:new.login_date, '012345678', '999999999');

	if	pattern
is null
	or	pattern = '9999/99'			then
		this_login_date	:=
:new.login_date;
	elsif	pattern = '999999'			then
		this_login_date	:=
substr(:new.login_date, 01,04)	||'/'||
					   substr(:new.login_date,
05,02);
	else
		raise_application_error (-20202,'Login
YYYY/MM');
	end if;


--	let Oracle validate dates
& give error messages

	valid_date	:= to_date (this_filing_date,
'yyyy/mm/dd');
	valid_date	:= to_date (this_login_date,
 'yyyy/mm');

--	==================
--	prepare output
--	==================

	:new.subdiv_id	:=
nvl(this_subdiv_id,	:old.subdiv_id);
	:new.filing_date	:=
nvl(this_filing_date,:old.filing_date);
	:new.login_date	:=
nvl(this_login_date, :old.login_date);

end;


create or replace trigger GARLAND.INSP_ARCH
BEFORE 
UPDATE
,ADDR_NAME
,ADDR_NUM
,ADDR_PFX
,ADDR_SFX
,ADDR_TYPE
,BRANCH
,CATEGORY
,CDBG
,CLASS
,CONST_DATE
,COUN_DIST
,CRACK_SEAL
,DISTRESSES
,FROM_ADDR_NAME
,FROM_ADDR_NUM
,FROM_ADDR_PFX
,FROM_ADDR_SFX
,FROM_ADDR_TYPE
,LANES
,LAST_INSPECT_DATE
,LENG
,MISSING_SDWK
,NEXT_INSPECT_DATE
,PCI
,POT_HOLE_REQ
,REAR_ENTRY
,REMARKS
,SECTION
,SEGMENT
,SURF_TYPE
,THOR_TYPE
,TO_ADDR_NAME
,TO_ADDR_NUM
,TO_ADDR_PFX
,TO_ADDR_SFX
,TO_ADDR_TYPE
on GARLAND.PAVE_MAST
REFERENCING NEW AS NEW OLD AS OLD
for each row 
BEGIN 
insert into insp_arch(
     CATEGORY,
    
BRANCH,

    SECTION,
     SEGMENT,
     LENG,
  
  LANES,

    SURF_TYPE,
     REAR_ENTRY,
     CDBG,

    CONST_DATE,

    LAST_INSPECT_DATE,
     NEXT_INSPECT_DATE,

 
  PCI,
     CLASS,
     CRACK_SEAL,
     DISTRESSES,


   POT_HOLE_REQ,
     COUN_DIST,
     THOR_TYPE,


   ADDR_NUM,
     ADDR_PFX,
     ADDR_NAME,
    
ADDR_TYPE,

    ADDR_SFX,
     FROM_ADDR_NUM,
   
 FROM_ADDR_PFX,

    FROM_ADDR_NAME,
     FROM_ADDR_TYPE,

    FROM_ADDR_SFX,

    TO_ADDR_NUM,
     TO_ADDR_PFX,

    TO_ADDR_NAME,

    TO_ADDR_TYPE,
     TO_ADDR_SFX,

    REMARKS)

values(
     :old.CATEGORY,
     :old.BRANCH,

 
  :old.SECTION,
     :old.SEGMENT,
     :old.LENG,


   :old.LANES,
     :old.SURF_TYPE,
     :old.REAR_ENTRY,


   :old.CDBG,
     :old.CONST_DATE,
     :old.LAST_INSPECT_DATE,


   :old.NEXT_INSPECT_DATE,
     :old.PCI,
     :old.CLASS,


   :old.CRACK_SEAL,
     :old.DISTRESSES,
     :old.POT_HOLE_REQ,


   :old.COUN_DIST,
     :old.THOR_TYPE,
     :old.ADDR_NUM,


   :old.ADDR_PFX,
     :old.ADDR_NAME,
     :old.ADDR_TYPE,


   :old.ADDR_SFX,
     :old.FROM_ADDR_NUM,
     :old.FROM_ADDR_PFX,


   :old.FROM_ADDR_NAME,
     :old.FROM_ADDR_TYPE,


   :old.FROM_ADDR_SFX,
     :old.TO_ADDR_NUM,
  

 :old.TO_ADDR_PFX,
     :old.TO_ADDR_NAME,
     :old.TO_ADDR_TYPE,


   :old.TO_ADDR_SFX,
     :old.REMARKS);
end;


create or replace trigger GARLAND.TRVEHRCL_INSERT
BEFORE 
INSERT
on GARLAND.TRVEHRCL
REFERENCING NEW AS NEW OLD AS OLD
for each row 
declare

	begin

--	verify street items

		:new.addr_name	:=
nvl ( upper ( rtrim (:new.addr_name)),' ');
		:new.addr_type	:=
nvl ( upper ( rtrim (:new.addr_type)),' ');
		:new.addr_pfx	:=
nvl ( upper ( rtrim (:new.addr_pfx )),' ');
		:new.addr_sfx	:=
nvl ( upper ( rtrim (:new.addr_sfx )),' ');


		select
trvehrcl_segment_seq.nextval 
		into :new.segment_id

		from dual;

		if	:new.addr_name = ' '							then
			raise_application_error
(-20200,'*** Street name is missing ***');
		end if;

		if	:new.addr_pfx
not in ( ' ', 'N', 'S', 'E', 'W' )		then
			:new.addr_pfx
:= ' ';
--			raise_application_error (-20201,'***
Prefix ' || :new.addr_pfx || ' is invalid ***');
		end
if;

		if	:new.addr_sfx not in ( ' ', 'N', 'S', 'E',
'W' )		then
			:new.addr_sfx := ' ';
--			raise_application_error
(-20202,'*** Suffix ' || :new.addr_sfx || ' is invalid
***');
		end if;

	end;



create or replace trigger GARLAND.TRVEHRCL_AUDIT
AFTER 
INSERT
OR
DELETE
OR
UPDATE
,ADDR_HI
,ADDR_LO
,ADDR_NAME
,ADDR_NUM
,ADDR_PFX
,ADDR_SFX
,ADDR_TYPE
,BRANCH_NO
,MSLINK
,SECTION_NO
on GARLAND.TRVEHRCL
REFERENCING NEW AS NEW OLD AS OLD
for each row 
declare

	retention_count	number := 16000;		--	specify
maximum records
	purge_days		number := 07;		--	specify
days to be purged

	this_osuser		varchar2(08);
	this_machine	varchar2(40);
	this_action		varchar2(01);
	this_count		number;
	this_oldest		date;

	old_mslink		varchar2(20);
	old_branch		varchar2(20);
	
ld_section		varchar2(20);
	old_lo		varchar2(20);
	old_hi		varchar2(20);
	old_pfx		varchar2(20);
	old_name		varchar2(40);
	old_type		varchar2(20);
	old_sfx		varchar2(20);

	new_mslink		varchar2(20);
	n
w_branch		varchar2(20);
	new_section		varchar2(20);
	new_lo		varchar2(20);
	new_hi		varchar2(20);
	new_pfx		varchar2(20);
	new_name		varchar2(40);
	new_type		varchar2(20);
	new_sfx		varchar2(20);

beg
n

	select count(*)
	into	this_count
	from	trvehrcl_audit;

	if	this_count
> retention_count			then
		select min(timestamp)
		into	
this_oldest
		from	 trvehrcl_audit;

		delete from
trvehrcl_audit
		where	 timestamp < this_oldest +
purge_days - 01;
	end if;

	select osuser, machine
	into	
this_osuser, this_machine
	from	 v$session
	where	
audsid = userenv('SESSIONID');

	if	inserting			then
		this_action	:=
'I';
	elsif	updating			then
		this_action	:= 'U';
	elsif	deleting			then
		this_action	:=
'D';
	end if;

	old_mslink	:= :old.mslink;
	new_mslink	:=
:new.mslink;

	if	:old.branch_no = :new.branch_no		then
		null;
	else
		old_branch	:=
:old.branch_no;
		new_branch	:= :new.branch_no;
	end
if;

	if	:old.section_no = :new.section_no		then
		null;
	else
		old_section	:=
:old.section_no;
		new_section	:= :new.section_no;
	end
if;

	if	:old.addr_lo = :new.addr_lo			then
		null;
	else
		old_lo	:=
:old.addr_lo;
		new_lo	:= :new.addr_lo;
	end if;

	if	:old.addr_hi
= :new.addr_hi			then
		null;
	else
		old_hi	:= :old.addr_hi;
		new_hi	:=
:new.addr_hi;
	end if;

	if	:old.addr_pfx = :new.addr_pfx		then
		null;
	else
		old_pfx	:=
:old.addr_pfx;
		new_pfx	:= :new.addr_pfx;
	end if;

	if	:old.addr_name
= :new.addr_name	then
		null;
	else
		old_name	:=
:old.addr_name;
		new_name	:= :new.addr_name;
	end
if;

	if	:old.addr_type = :new.addr_type	then
		null;
	else
		old_type	:=
:old.addr_type;
		new_type	:= :new.addr_type;
	end
if;

	if	:old.addr_sfx = :new.addr_sfx		then
		null;
	else
		old_sfx	:=
:old.addr_sfx;
		new_sfx	:= :new.addr_sfx;
	end if;

	if	nvl(old_mslink,
0) <>  nvl(new_mslink, 0)	
	or	old_branch||new_branch||
old_section||new_section||	
		old_lo  ||new_lo  ||
old_hi  ||new_hi  ||	
		old_pfx ||new_pfx || old_name||new_name||
		old_type||new_type||
old_sfx ||new_sfx	is not null 	then

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
	end
if;

end;




