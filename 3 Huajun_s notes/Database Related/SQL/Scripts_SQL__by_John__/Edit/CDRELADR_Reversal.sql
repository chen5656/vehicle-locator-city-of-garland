	set echo		off;
	set timing		on;
	set serveroutput	on		size 999999;
--	============================================================================================
--	Look for reversal of position in addresses	along each side of every street
--	Look for zinger address in askew position		along each side of every street
--	============================================================================================

declare

	do_compile			number	:= 0;
	max_errors			number	:= 44;

	cosine_trigger		number	:= 0.90;
	zinger_ratio		number	:= 02;

	show_reversal		number	:= 01;
	show_reversal_calc	number	:= 01;

	show_zinger			number	:= 01;
	show_zinger_calc		number	:= 01;

	show_mslink			number	:= 01;
	show_dupe			number	:= 0;

	srch_addr_num1		number	:= 0;			--	live mode
	srch_addr_num2		number	:= 999999;		
	srch_addr_name		varchar2(20):= '%%';

--	srch_addr_num1		number	:= 2800;		--	test mode
--	srch_addr_num2		number	:= 2999;		
--	srch_addr_name		varchar2(20):= '%BELT LINE%';

--	------------------------------------------------------

	total_reversal		number	:= 0;
	total_zinger		number	:= 0;

	reversal			number;
	zinger			number;
	error				varchar2(10);

	axis				char;
	cosine			number;
	vector			number;
	x_vector			number;
	y_vector			number;
	prev_vector			number;
	prev_x_vector		number;
	prev_y_vector		number;

	this_x1			number;
	this_y1			number;
	this_x2			number;
	this_y2			number;

	distance			number;
	distance1			number;
	distance2			number;
	distance3			number;

	past_x_coord		number;
	past_y_coord		number;
	prev_x_coord		number;
	prev_y_coord		number;

	prev_addr_parity		number;
	prev_addr_num		number;
	prev_addr_name		varchar2(20);
	prev_addr_type		varchar2(04);
	prev_addr_pfx		varchar2(02);
	prev_addr_sfx		varchar2(02);
	prev_parcel_id		varchar2(11);
	prev_mslink			number;

cursor read_address is

	select	addr_name, addr_type, addr_pfx, addr_sfx,
			mod(addr_num,2) 	addr_parity,	
						addr_num,
			x_coord,	y_coord,
			mslink,	parcel_id

	from		garland.cdreladr	

	where		addr_num > 0
	and		addr_num < 9000
	and		x_coord  > 0
	and		y_coord  > 0

	and		addr_name	like srch_addr_name
	and		addr_num	between srch_addr_num1  and srch_addr_num2

	order by	1,2,3,4,5,6;

--	============================================================================================
begin

	if	do_compile > 0		then
		return;
	end if;

	dbms_output.put_line (' ');

for	look in read_address		loop

	if	look.addr_name	= prev_addr_name	
	and	look.addr_type	= prev_addr_type
	and	look.addr_pfx	= prev_addr_pfx	
	and	look.addr_sfx	= prev_addr_sfx	
	and	look.addr_parity	= prev_addr_parity	then	
		goto	process_vector;
	end if;

<<new_street_side>>

	axis			:= null;
	vector		:= null;
	x_vector		:= null;
	y_vector		:= null;
	this_x2		:= null;
	this_y2		:= null;
	prev_x_coord	:= null;
	prev_y_coord	:= null;
	distance		:= null;
	distance1		:= null;
	distance2		:= null;
	distance3		:= null;
	goto	housekeeping;

<<process_vector>>

	if	look.addr_num = prev_addr_num		then
		if	show_dupe > 0			then
			dbms_output.put_line (	'Duplicate number  ' || prev_addr_num ||' '|| prev_addr_name ||' @'||
											prev_mslink		);
		end if;
		goto	end_loop;
	end if;

	reversal	:= 0;
	zinger 	:= 0;

	distance3 := sqrt(power(look.x_coord - past_x_coord,2) + power(look.y_coord - past_y_coord,2));
	if	distance1 / distance3 >= zinger_ratio
	and	distance2 / distance3 >= zinger_ratio	then
		zinger 	:= 1;
		error	 	:= 'zinger	';
	end if;

	x_vector	:= look.x_coord - prev_x_coord;
	y_vector	:= look.y_coord - prev_y_coord;
	distance	:= sqrt(power(x_vector,2) + power(y_vector,2));

	if	axis = 'x'				then
		vector := sign(x_vector);
	elsif	axis = 'y'				then
		vector := sign(y_vector);
	else
		vector := null;
	end if;

	this_x1	:= - this_x2;
	this_y1	:= - this_y2;
	this_x2	:= x_vector / distance;
	this_y2	:= y_vector / distance;
	cosine 	:= (this_x1 * this_x2) + (this_y1 * this_y2);

	if	vector * prev_vector < 0
	and	cosine > cosine_trigger		then
		reversal	:= 1;
		error	 	:= 'reversal	';
	end if;

	if 	reversal * show_reversal > 0

	or  (	reversal = 0
	and	zinger   * show_zinger   > 0 ) 		then

		if	show_mslink = 0				then
			dbms_output.put_line (' ');
			dbms_output.put_line ( error			||
					rpad(prev_addr_num, 05)		||' '	|| 
					rpad(look.addr_num, 05)		||'    '|| 
					rpad(look.addr_pfx, 02)		||' '	|| 
					rpad(look.addr_name,20)		||' '	||
					rpad(look.addr_type,04)		||' '	|| 
					rpad(look.addr_sfx, 02)		|| 
					chr(10)				||
					
					'msl & pid	'			|| 
					rpad(prev_mslink, 05)		||' '		 ||
					rpad(look.mslink, 05)		||'		'||
					prev_parcel_id			||','		 ||
					look.parcel_id			||'	'
					);
		end if;

		if	show_mslink > 0 				then
			dbms_output.put_line	( look.mslink );

		elsif	reversal * show_reversal_calc > 0	then
			dbms_output.put_line	(				
				'trigger '		|| cosine_trigger		||'	'	||
				'cosine '		|| trunc(cosine,2)	||'	'	||
				axis  		|| ' axis  '		||
				'vectors '		|| prev_vector		||' ' || vector	||'	'	||
				'('			|| trunc(this_x1, 2)	||'),('|| trunc(this_y1, 2)	||
				') / (' 		|| trunc(this_x2, 2)	||'),('|| trunc(this_y2, 2)	||
				')'	 );

		elsif	zinger * show_zinger_calc > 0
		and	reversal = 0				then
			dbms_output.put_line	(
				'ratio '		|| zinger_ratio		||'	'||
				'distances	'	|| trunc(distance1, 2)	||'  '|| trunc(distance2, 2) ||'  '|| 
							   trunc(distance3, 2)	);

		end if;

	end if;

	if	reversal > 0	then	
		total_reversal := total_reversal + 01;
	elsif	zinger   > 0	then	
		total_zinger := total_zinger + 01;
	end if;

<<housekeeping>>

	distance1	:= distance2;
	distance2	:= distance;

	if	abs(x_vector) >= abs(y_vector)	then
		axis	:= 'x';
	elsif	abs(x_vector) < abs(y_vector)		then
		axis	:= 'y';
	else
		axis	:= null;
	end if;

	prev_vector		:= vector;
	prev_x_vector	:= x_vector;
	prev_y_vector	:= y_vector;

	past_x_coord	:= prev_x_coord;
	past_y_coord	:= prev_y_coord;
	prev_x_coord	:= look.x_coord;
	prev_y_coord	:= look.y_coord;

	prev_addr_parity	:= look.addr_parity;
	prev_addr_num	:= look.addr_num;
	prev_addr_name	:= look.addr_name;
	prev_addr_type	:= look.addr_type;
	prev_addr_pfx	:= look.addr_pfx;
	prev_addr_sfx	:= look.addr_sfx;

	prev_mslink		:= look.mslink;
	prev_parcel_id	:= look.parcel_id;

	exit when (total_reversal * sign(show_reversal)) + (total_zinger * sign(show_zinger)) > max_errors;

<<end_loop>>
	null;
end loop;

	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( 'Total Reversals	' || total_reversal );
	dbms_output.put_line ( 'Total Zingers	' || total_zinger );

end;


--	==========================================================================================
/*
	if	show_zinger = 111		then			--	T E S T
		dbms_output.put_line  (' ');
		dbms_output.put_line  (look.addr_num 	 ||' '|| look.addr_name		 ||chr(10)|| 
				rpad(trunc(past_x_coord,2),12) ||' '|| trunc(past_y_coord,2) ||chr(10)||
				rpad(trunc(prev_x_coord,2),12) ||' '|| trunc(prev_y_coord,2) ||chr(10)||			
				rpad(trunc(look.x_coord,2),12) ||' '|| trunc(look.y_coord,2)
				);
	end if;

	if	look.parcel_id	= prev_parcel_id
	and	look.mslink		= prev_mslink	then
		dbms_output.put_line (	'Duplicate parcel ['	|| prev_parcel_id	|| 
						'] and mslink ['		|| prev_mslink	||']'	);
		goto	end_loop;
	end if;

	if	abs(cosine) > 1.01		then
		dbms_output.put_line (	'Invalid cosine ' || cosine	  ||
						' at '  || look.addr_num || ' ' || look.addr_name ||
						'	mslink ' || look.mslink);
	end if;
*/
--	==========================================================================================


