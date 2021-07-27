
--	==============================================================================
--	use these column lengths to specify rpad length of each item in execution plan
--	==============================================================================

--	desc plan_table


	select all *
	from	
( 
	select *	from	garland.plan_table			--	define hierarchal query
),

(
	select *	from
(
	select rpad(p.operation, 	l.oper)	oper,
		 rpad(p.options,		l.optn)	optn,
		 rpad(p.object_name,	l.objn)	objn,
		 rpad(p.object_type,	l.objt)	objt

	from	 garland.plan_table		P,
(
	select max(length(operation)) 	oper,
		 max(length(options))		optn,
		 max(length(object_name))	objn,
		 max(length(object_type))	objt

	 from  garland.plan_table  )		L			--	define hierarchal query
));


