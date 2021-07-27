--	july 2 2003

	Set echo	off;
--	==========================================================================
--	==========================================================================
     
Create or replace	package body	adrFinder	as 

Procedure Verify_Address
(          
	num_in	in number,           
	pfx_in	in varchar2,         
	name_in	in varchar2,       
	type_in	in varchar2,         
	sfx_in	in varchar2,         

	num_out	out addr_num,       
	pfx_out	out addr_prefix,    
	name_out	out addr_name,    
	type_out	out addr_type,      
	sfx_out	out addr_suffix,    

	parcel_out	out addr_parcel,
	status_out	out addr_status,
	total_out	out addr_total
)    

Is   

	status_valid_adr		number := 10;
	status_valid_str		number := 20;

	status_invalid_adr	number := 11;
	status_invalid_str	number := 21;

	status_good_good		number := 12;
	status_good_bad		number := 22;

	status_bad_good		number := 13;
	status_bad_bad		number := 23;

	status_no_choice		number := 30;

	status		number;
	score			number;
	best_score		number;
	best_count		number;

	valid_name_exist	number;
	valid_num_exist	number;
	valid_exist		number;
	message		number;


	this_num		varchar2(40);
	this_pfx		varchar2(02);
	this_name		varchar2(40);
	this_type		varchar2(04);
	this_sfx		varchar2(02);

	this_alias		varchar2(10);
	this_reduced	varchar2(20);
	this_compact	varchar2(20);
	this_compress	varchar2(20);
	this_qualifier	varchar2(10);

	save_pfx		varchar2(02);
	save_name		varchar2(40);
	save_type		varchar2(04);
	save_sfx		varchar2(02);

--	==========================================================================

	type	best_rowid_table	is table of rowid
		index by binary_integer;
	best_rowid	best_rowid_table;

--	==========================================================================
	cursor read_address		is

	select	0 addr_num,
 			s.addr_pfx, s.addr_name, s.addr_type, s.addr_sfx, 
			s.addr_reduced,
			' '			parcel_id, 
			s.rowid 		row_id
	from		adrStreets		s
	where		addr_compress	= this_compress

	union
	select	a.addr_num,
 			a.addr_pfx, a.addr_name, a.addr_type, a.addr_sfx, 
			s.addr_reduced,
			a.parcel_id		parcel_id, 
			a.rowid	 	row_id
	from		adrStreets		s,
			cdreladr		a

	where		s.addr_compress	= this_compress
	and		s.addr_name		= a.addr_name
	and		a.addr_num 		= this_num
	and		rtrim(a.unit_type (+) || a.unit_num(+)) is null

	order by	addr_name, addr_num, addr_type, addr_pfx, addr_sfx;

--	==========================================================================

Begin

	this_num	:= nvl(num_in,0);
	this_pfx	:= nvl(upper(pfx_in), ' ');
	this_name	:= nvl(upper(name_in),' ');
	this_type	:= nvl(upper(type_in),' ');
	this_sfx	:= nvl(upper(sfx_in), ' ');

--	--------------------------------------------------------
--	qualifier corrections

	if	this_type > 'A'			then
		select max(standard) into this_qualifier 	from adrItem	
		where possible = this_type	and class = 'T';

		if	this_qualifier > 'A'	then
			this_type	:= this_qualifier;
		end if;
	end if;

	if	this_pfx > 'A'			then
		select max(standard) into this_qualifier 	from adrItem
		where possible = this_pfx	and class = 'D';

		if	this_qualifier > 'A'	then
			this_pfx	:= this_qualifier;
		end if;
	end if;

	if	this_sfx > 'A'			then
		select max(standard) into this_qualifier 	from adrItem
		where possible = this_sfx	and class = 'D';

		if	this_qualifier > 'A'	then
			this_sfx	:= this_qualifier;
		end if;
	end if;

--	--------------------------------------------------------
--	alias table corrections

	this_alias		:= 'alias';
	this_reduced	:= null;
	this_compact	:= null;

	save_pfx	:= this_pfx;
	save_name	:= this_name;
	save_type	:= this_type;
	save_sfx	:= this_sfx;

	adr_alias_match
	( 	this_alias,
		this_num, this_pfx, this_name, this_type, this_sfx, 
	 	this_reduced, this_compact);	

	if	this_name is null				then		
		this_pfx	:= save_pfx;	
		this_name	:= save_name;
		this_type	:= save_type;
		this_sfx	:= save_sfx;
	end if;

--	dbms_output.put_line ('alias how=' || this_alias || ' ' || this_name);		-- TEST

--	--------------------------------------------------------
--	look for the best match
--	priority:	name, number, qualifier

	this_compress := adr_compress_name (this_name,6);

	best_score		:= null;
	best_count		:= 0;
	status		:= 0;
	valid_name_exist	:= 0;
	valid_num_exist	:= 0;


for look in  read_address		loop

	score 	:= 0;

	if	this_reduced = look.addr_reduced	then
		score	:= score + 1000;
	end if;

	if	this_num = look.addr_num		then
		score	:= score + 100;
	end if;

	if	this_type = look.addr_type		then
		score	:= score + 10;
	elsif this_type = ' '				then
		score	:= score + 01;
	else
		score	:= score - 1000000;
	end if;

--	dbms_output.put_line ( 't score=' || score ||' '|| this_type);		-- TEST

	if	this_pfx = look.addr_pfx	then
		score	:= score + 10;
	elsif this_pfx	= ' '			then
		score	:= score + 01;
	else
		score	:= score - 1000000;
	end if;

--	dbms_output.put_line ( 'p score=' || score ||' '|| this_pfx);		-- TEST	

	if	this_sfx = look.addr_sfx	then
		score	:= score + 10;
	elsif this_sfx = ' '			then
		score	:= score + 01;
	else
		score	:= score - 1000000;
	end if;

--	dbms_output.put_line ( 's score=' || score ||' '|| this_sfx);		-- TEST	

	if	best_score is null
	or	score > best_score		then
		best_score	:= score;
		best_count	:= 0;

		if	look.addr_reduced = this_reduced		then
			valid_name_exist := 10;
		else
			valid_name_exist := 0;
		end if;

		if	look.addr_num > 0					then
			valid_num_exist := 01;
		else
			valid_num_exist := 0;
		end if;
	end if;

	if	score = best_score					then
		best_count 			:= best_count + 01;
		best_rowid (best_count) := look.row_id;
	end if;

End loop;

--	--------------------------------------------------------
--	determine result (status) of above match
--	display appropriate message

	message := 0;
	valid_exist := valid_name_exist + valid_num_exist;

	if	best_count = 0				then
		status := status_no_choice;
		dbms_output.put_line ('INVALID NAME');

	elsif	best_score < 0				then
		if	valid_num_exist > 0		then
			status := status_invalid_adr;
			message:= 1;
		else
			status := status_invalid_str;
			message:= 2;
		end if;

	elsif	valid_exist = 01				then
		status := status_bad_good;
		message:= 1;

	elsif	valid_exist = 00				then
		status := status_bad_bad;
		message:= 2;

	elsif	best_count = 1				then
		if	valid_exist = 11			then
			status := status_valid_adr;
			dbms_output.put_line ('VALID ADDRESS');

		elsif	valid_exist = 10			then
			status := status_valid_str;
			dbms_output.put_line ('VALID STREET');
		end if;


	elsif	best_count > 1				then
		if	valid_exist = 11			then
			status := status_good_good;
			message:= 1;

		elsif	valid_exist = 10			then
			status := status_good_bad;
			message:= 2;

		end if;

	end if;

	if	message = 1		then
		dbms_output.put_line ('CHOOSE ADDRESS');
	elsif	message = 2		then
		dbms_output.put_line ('CHOOSE STREET');
	end if;

--	--------------------------------------------------------
--	if no matches, keep street info (possibly corrected)

	if	best_count = 0				then
		num_out  (1)	:= this_num;
		pfx_out  (1)	:= this_pfx;
		name_out (1)	:= this_name;
		type_out (1)	:= this_type;
		sfx_out  (1)	:= this_sfx;
		parcel_out (1)	:= ' ';
		status_out (1)	:= status;
		total_out  (1)	:= 0;
	end if;


--	--------------------------------------------------------
--	build output array parameters


For idx in 1..best_count	loop

	if	status between 10 and 19		then

	select	a.addr_pfx,  a.addr_name, a.addr_type, a.addr_sfx, 
			nvl(a.addr_num, 0)	addr_num,
			a.parcel_id, 
			status, best_count
	into	
			pfx_out  (idx),
			name_out (idx),
			type_out (idx),
			sfx_out  (idx),

			num_out  (idx),
			parcel_out (idx),

			status_out (idx),
			total_out  (idx)

	from		cdreladr		a
	where		rowid  = best_rowid (idx);


	elsif	status between 20 and 29		then

	select	s.addr_pfx,  s.addr_name, s.addr_type, s.addr_sfx, 
			0	addr_num,
			null	parcel_id, 
			status, best_count
	into	
			pfx_out  (idx),
			name_out (idx),
			type_out (idx),
			sfx_out  (idx),

			num_out  (idx),
			parcel_out (idx),

			status_out (idx),
			total_out  (idx)

	from		adrStreets		s
	where		rowid     = best_rowid (idx);

	end if;

end loop;

End	Verify_Address;

End	adrFinder;
     

