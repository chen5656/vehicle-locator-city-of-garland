	set	echo	off;
--	===============================================================================
--	display augmented execution plans in plan_table
--	===============================================================================

	select rpad(' ', 80) " " from dual;

	create or replace view	explain_remote		as

	select	

	adr_string_cleaner(
	initcap		(
	translate		(  

	decode (	id,
			00,	chr(10),
			''		)				||

	replace (lpad (nvl (object_instance, 0), 02, '0'), '00', '  ')	||
	lpad(' ', (level - 1))					||	


	rpad(operation, 14, ' ')				||		
	lpad(' ', (14 - (level - 1)))				||


	decode (	id,
			00,	rpad (statement_id,	  23),				
				rpad (nvl (options, ' '), 17)	
		 )							||
	' '								||


	decode (	id,
			00,	rpad (nvl (substr (optimizer, 07), ' '), 15),
--			00,	rpad (nvl (substr (optimizer, 07), ' '), 23),
--				rpad (nvl (object_name, ' '), 23)
				rpad (nvl (object_name, ' '), 21)
		 )							||
	' '								||


	decode (	substr (operation,01, 06),
--			'SELECT',	lpad (nvl (position, 0), 	07),
--			'CREATE',	lpad (nvl (position, 0), 	07),
			'INDEX',	rpad (nvl (object_type, ' '), 10),		
			'TABLE ',	lpad (nvl (optimizer,   ' '), 10),
					lpad (nvl (optimizer,   ' '), 10)
		 )  


	,' ', '.')	

	)
	)
						" "
--	,lpad (id, 02, '0') || '.' || lpad (parent_id, 02, '0')	" "

	,lpad(cost,		 07)		"  cost" 
	,lpad(cardinality, 07)		"  rows" 
	,lpad(bytes,	 07)		"  size" 
	,rpad(object_node, 12)		"  node"
--	,rpad(other_tag,   18)		"  type"
	,other				"command"


	from		syn_plan_table
	start with	id = 0
	connect by	prior statement_id	= statement_id
	and		prior timestamp		= timestamp
	and		prior id 			= parent_id
	
--	order by	statement_id,
--			timestamp,
--			id
;

commit;

set echo	on;
