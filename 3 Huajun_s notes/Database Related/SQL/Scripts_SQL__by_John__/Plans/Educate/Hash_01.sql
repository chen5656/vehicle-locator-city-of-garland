--	analyze table	adrname	compute statistics;
--	analyze table	adrstreet	compute statistics;
truncate table plan_table;

explain plan	set statement_id = 'a01'		for
	select	count(*)
	from		adrname	n,
			adrstreet	s
	where		s.addr_name	= n.addr_name;

explain plan	set statement_id = 'a02'		for
	select	s.*
	from		adrname	n,
			adrstreet	s
	where		s.addr_name	= n.addr_name;

explain plan	set statement_id = 'a03'		for
	select	n.*
	from		adrname	n,
			adrstreet	s
	where		s.addr_name	= n.addr_name;

explain plan	set statement_id = 'a031'		for
	select	n.*
	from		adrname	n,
			adrstreet	s
	where		s.addr_name	(+) = n.addr_name;

explain plan	set statement_id = 'a04'		for
	select	*
	from		adrname	n,
			adrstreet	s
	where		s.addr_name	= n.addr_name;

explain plan	set statement_id = 'a041'		for
	select	*
	from		adrname	n,
			adrstreet	s
	where		s.addr_name	(+) = n.addr_name;

explain plan	set statement_id = 'a042'		for
	select	*
	from		adrname	n,
			adrstreet	s
	where		s.addr_name	= n.addr_name (+);


@c:\deacutis\scripts\plans\exhibit.sql;


  
--
/*
                                                                                
--------------------------------------------------------------------------------


__SELECT_STATE____________a01_________________________________________________
___SORT___________________AGGREGATE_____________________________________________
____NESTED_LOOPS________________________________________________________________
02___TABLE_ACCESS_________FULL_____________ADRSTREET____________________ANALYZED
_____INDEX________________UNIQUE_SCAN______ADRNAME_PKEY_______________UNIQUE____


__SELECT_STATE____________a02_________________________________________________
___NESTED_LOOPS_________________________________________________________________
02__TABLE_ACCESS__________FULL_____________ADRSTREET____________________ANALYZED
____INDEX_________________UNIQUE_SCAN______ADRNAME_PKEY_______________UNIQUE____


__SELECT_STATE____________a03_________________________________________________
___HASH_JOIN____________________________________________________________________
02__TABLE_ACCESS__________FULL_____________ADRSTREET____________________ANALYZED
01__TABLE_ACCESS__________FULL_____________ADRNAME______________________ANALYZED


__SELECT_STATE____________a031________________________________________________
___HASH_JOIN______________OUTER_________________________________________________
01__TABLE_ACCESS__________FULL_____________ADRNAME______________________ANALYZED
02__TABLE_ACCESS__________FULL_____________ADRSTREET____________________ANALYZED


__SELECT_STATE____________a04_________________________________________________
___HASH_JOIN____________________________________________________________________
01__TABLE_ACCESS__________FULL_____________ADRNAME______________________ANALYZED
02__TABLE_ACCESS__________FULL_____________ADRSTREET____________________ANALYZED


__SELECT_STATE____________a041________________________________________________
___HASH_JOIN______________OUTER_________________________________________________
01__TABLE_ACCESS__________FULL_____________ADRNAME______________________ANALYZED
02__TABLE_ACCESS__________FULL_____________ADRSTREET____________________ANALYZED


__SELECT_STATE____________a042________________________________________________
___HASH_JOIN______________OUTER_________________________________________________
02__TABLE_ACCESS__________FULL_____________ADRSTREET____________________ANALYZED
01__TABLE_ACCESS__________FULL_____________ADRNAME______________________ANALYZED
  
--
*/
