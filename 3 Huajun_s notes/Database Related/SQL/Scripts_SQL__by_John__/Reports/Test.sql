	set echo		off;
	set serveroutput	on	size 999999;

--	generate "dime" list of all address ranges in Garland 


declare

		do_compile		number	:= 0;
		report_count	number	:= 0;


cursor	read_dime_info	is

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for

	select

		t.addr_name,  	
		t.addr_type,	
		t.addr_pfx,   	
		t.addr_sfx,   	
		t.addr_lo,

		t.addr_left_from,
		t.addr_left_to,
		t.addr_rght_from,
		t.addr_rght_to,

		p.zip_code,
		p.fire_district,
		rtrim(p.police_beat)		police_beat,
	
		decode  (lpad(rtrim(p.police_beat),3,'0'),

				'001',		'11',
				'002',		'11',
				'003',		'21',
				'004',		'11',
				'005',		'21',
				'006',		'21',
				'007',		'12',
				'008',		'12',
				'009',		'14',

				'010',		'21',
				'011',		'21',
				'012',		'21',
				'013',		'22',
				'014',		'22',
				'015',		'22',
				'016',		'22',
				'017',		'13',
				'018',		'13',
				'019',		'14',

				'020',		'14',
				'021',		'23',
				'022',		'13',
				'023',		'15',
				'024',		'15',
				'025',		'23',
				'026',		'25',
				'027',		'24',
				'028',		'24',
				'029',		'26',

				'030',		'16',
				'031',		'16',
				'032',		'16',
				'033',		'25',
				'034',		'31',
				'035',		'31',
				'036',		'33',
				'037',		'25',
				'038',		'26',
				'039',		'31',

				'040',		'32',
				'041',		'32',
				'042',		'35',
				'043',		'35',
				'044',		'35',
				'045',		'33',
				'046',		'34',
				'047',		'34',
				'048',		'41',
				'049',		'41',

				'050',		'35',
				'051',		'42',
				'052',		'42',
				'053',		'43',
				'054',		'43',
				'055',		'44',
				'056',		'43',
				'057',		'45',
				'058',		'45',

				'114',		'24',
				'142',		'32',
				'143',		'32',
							'  '	)	district

	from	trvehrcl		t,
		cdreladr		a,
		cdrelpar		p

	where	p.parcel_id	 	= a.parcel_id

	and	nvl(t.addr_left_from, 0) > 0
	and	nvl(t.addr_rght_from, 0) > 0

	and	a.addr_name		 = t.addr_name
	and	a.addr_type		 = t.addr_type
	and	a.addr_pfx		 = t.addr_pfx
	and	a.addr_sfx		 = t.addr_sfx
	and	a.addr_num 		>= t.addr_lo
	and	a.addr_num 		<= t.addr_hi

	union

	select

		t.addr_name,  	
		t.addr_type,	
		t.addr_pfx,   	
		t.addr_sfx,   	
		t.addr_lo,

		t.addr_left_from,
		t.addr_left_to,
		t.addr_rght_from,
		t.addr_rght_to,

		''					zip_code,
		''					fire,
		''					beat,	
		''					district	

	from	trvehrcl		t

	where	nvl(t.addr_left_from,0) > 0
	and	nvl(t.addr_rght_from,0) > 0
	
	and	not exists
(
	select 'x'
	from	cdreladr	a,
		cdrelpar	p

	where	p.parcel_id	 	= a.parcel_id

	and	nvl(t.addr_left_from, 0) > 0
	and	nvl(t.addr_left_to,   0) > 0

	and	a.addr_name		 = t.addr_name
	and	a.addr_type	 	 = t.addr_type
	and	a.addr_pfx		 = t.addr_pfx
	and	a.addr_sfx		 = t.addr_sfx
	and	a.addr_num 		>= t.addr_lo
	and	a.addr_num 		<= t.addr_hi
);

--	select * from explain_plan;

	seg		read_dime_info%rowtype;


begin

	if	do_compile > 0	then
		return;
	end if;

for look in	read_dime_info		loop

	if	look.addr_name		= seg.addr_name
	and	look.addr_type		= seg.addr_type
	and	look.addr_pfx		= seg.addr_pfx
	and	look.addr_sfx		= seg.addr_sfx
	and	look.addr_left_from	= seg.addr_left_from
	and	look.addr_left_to		= seg.addr_left_to
	and	look.addr_rght_from	= seg.addr_rght_from
	and	look.addr_rght_to		= seg.addr_rght_to
	then
		null;
	else
		dbms_output.put_line (	look.addr_left_from ||','|| look.addr_left_to ||','||
						look.addr_rght_from ||','|| look.addr_rght_to ||','|| 
						look.addr_pfx	  ||','|| look.addr_name    ||','||
						look.addr_type	  ||','|| look.addr_sfx     ||','|| 

						look.police_beat	  ||','|| 
						look.fire_district  ||','|| 
						look.zip_code 	  ||','||
						' '						); 

		report_count := report_count + 01;
	end if;


	seg	:= look;

end loop;

	dbms_output.put_line ('total records:  ' || report_count);

end;