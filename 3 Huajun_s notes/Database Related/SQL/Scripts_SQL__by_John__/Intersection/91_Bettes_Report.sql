	set charwidth	100;
	set echo		off;
	set timing		off;
	set termout		off;
--	===========================================================================

	spool	c:\deacutis\extract\Intersection_Bettes.txt;

--	===========================================================================
--	truncate table	garland.plan_table	reuse storage;
--	insert into	garland.plan_table (object_name,object_owner) values ( '' , '' );

--	alter rollback segment rb1 online;
--	commit;
--	set transaction use rollback segment rb1;

--	explain plan set statement_id =	'xxx'		into garland.plan_table	for
--	===========================================================================

	select 'block1,prefix1,street1,type1,suffix1,block2,prefix2,street2,type2,suffix2,beat,district,dummy ' " "
	from	dual;

	select
		addr1_block		||','||
		addr1_pfx		||','||
		addr1_name		||','||
		addr1_type		||','||
		addr1_sfx		||','||

		addr2_block		||','||
		addr2_pfx		||','||
		addr2_name		||','||
		addr2_type		||','||
		addr2_sfx		||','||

		b.police_beat	||','||	

		decode  (lpad(rtrim(b.police_beat),3,'0'),
				
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
							'  '	)

			||', '	
			" "

	from		intersection	x,
			block_side		b

	where		x.addr1_name	= b.addr_name
	and		x.addr1_type	= b.addr_type
	and		x.addr1_pfx		= b.addr_pfx
	and		x.addr1_sfx		= b.addr_sfx
	and		x.addr1_block	= b.addr_block

	and		b.addr_parity = 0

	and		intersect_id like 'B%'
	and		(rpad(addr1_name,20) || addr1_type) < (rpad(addr2_name,20) || addr2_type) 

--	and		rownum < 11

	order by	addr1_name, addr1_type, addr2_name, addr2_type, addr1_pfx, addr1_sfx, addr2_pfx, addr2_sfx 
	;

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_constraint;
--	select * from garland.explain_column;
	select * from garland.explain_analyze;

--	commit;
--	alter rollback segment rb1 offline;
--	===========================================================================

	spool		off;
	set	echo	on;
	set termout	on;

