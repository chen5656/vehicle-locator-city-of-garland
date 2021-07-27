	set	echo	off;
--	===============================================================================
--	display execution plans in plan_table
--	===============================================================================

--	select rpad ('*',70,'*') " " from dual;

	create or replace view	garland.explain_plan	as

	select	
	rpad			 (
	adr_string_cleaner (
	initcap		 (
	translate		 (  

	decode (	id,
			00,	chr(10),
			''		)				||

	replace (lpad (nvl (object_instance, 0), 02,'0'), '00','  ')	||
	lpad(' ', (level - 1))					||	

	rpad (replace(operation,'STATEMENT','STATE'),	14,' ')		||		
	lpad(' ', (14 - (level - 1)))				||

	decode (	id,
			00,	rpad (statement_id,	  	23),				
				rpad (nvl (options, ' '), 	17)	
		 )							||	' '		||

	decode (	id,
			00,	rpad (nvl (substr (optimizer, 07),' '), 15),
				rpad (nvl (object_name, ' '), 21)
		 )							||	' '		||

	decode (	substr (operation,01, 06),
			'INDEX',	rpad (nvl (object_type, ' '), 10),		
					rpad (' ',				10)

--			'SELECT',	lpad (nvl (position,	 0 ),	07),
--			'CREATE',	lpad (nvl (position,	 0 ),	07),
--			'TABLE ',	lpad (nvl (optimizer,   ' '), 10),
--					lpad (nvl (optimizer,   ' '), 10)
		 )  

	,' ', '.')	
	)
	), 80)
	" "

	,to_char(cost,		'9,999,999')				"      cost"
	,to_char(cardinality,	'9,999,999')				"      rows"

--	,other								"command"
--	,rpad (object_owner ||' '|| object_node, 25)		"  node" 
--	,rpad(other_tag, 20)						"  type"
--	,lpad (id, 02, '0') ||'.'|| lpad (parent_id, 02, '0')	" ids"
--	,lpad(bytes, 07)							"   size" 

	from		plan_table@gisp
	start with	id = 0
	connect by	prior statement_id = statement_id
	and		prior timestamp	 = timestamp
	and		prior id 		 = parent_id
	
	order by	statement_id,
			timestamp,
			id
;

commit;

set echo	on;
