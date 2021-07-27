	set echo		off;
	set fetchrows	1111;

--	===============================================================
--	what are the outer and inner loops of a hash join
--	===============================================================

	truncate table  plan_table	reuse storage;

--	===============================================================
	explain plan set statement_id = 'sss/rrr'   for

	select --+ use_hash (a)
		'Street/Result   ' " ", 
		s.*, a.*  
	from

(	select addr_type, addr_reduced
	from	garland.adrStreets
	order by 1,2			)	s,


(	select rpad(addr_num,10) 	addr_num, 
	rpad(addr_type,4) 		addr_type, 
	rpad(addr_name,20) 		addr_name, 
	rpad(verify_code,2) 		verify_code
	from	garland.adrResult		)	a

--	where	s.addr_type = a.addr_type
	where	s.addr_type = a.addr_type (+)

	and	a.verify_code = 54
	;

--	===============================================================
	explain plan set statement_id = 'sss/aaa'   for

	select --+ use_hash (a)
		'Street/Address   ' " ", 
		s.*, a.*  
	from

(	select addr_type, addr_reduced
	from	garland.adrStreets
	order by 1,2			)	s,


(	select addr_num, addr_type, addr_name
	from	garland.cdreladr		)	a

	where	s.addr_type = a.addr_type;
--	where	s.addr_type = a.addr_type (+);

--	===============================================================
	explain plan set statement_id = 'aaa/sss'   for

	select --+ use_hash (s) 
		'Address/Street   ' " ", 
		s.*, a.*  
	from

(	select addr_type, addr_reduced
	from	garland.adrStreets	)	s,


(	select addr_num, addr_type, addr_name
	from	garland.cdreladr	
	order by 1,2			)	a

	where	s.addr_type (+) = a.addr_type;

--	===============================================================

	select * from explain_plan;

-------------------------------------------------------------------------------- ------- -------
/*

..Select.State................Aaa/Sss...........................................     242 6473340
...Hash.Join..................Outer.............................................     242 6473340
04..Table.Access..............Full..............Cdreladr........................      83   65747
01..View........................................................................      19    2363
.....Sort.....................Order.By..........................................      19    2363
02....Table.Access............Full..............Adrstreets......................       4    2363


..Select.State................Sss/Aaa...........................................     159 6473340
...Hash.Join..................Outer.............................................     159 6473340
01..View........................................................................      19    2363
.....Sort.....................Order.By..........................................      19    2363
02....Table.Access............Full..............Adrstreets......................       4    2363
04..Table.Access..............Full..............Cdreladr........................      83   65747



----------------- ---- ------------------------------ ---------- ----
Street/Address    CT   YOUNGER                              3101 CT  
Street/Address    CT   WYNDHAM                              3101 CT  
Street/Address    CT   WORDSWORTH                           3101 CT  
Street/Address    CT   WOLVERTON                            3101 CT  
Street/Address    CT   WODS                                 3101 CT  
Street/Address    CT   WODMEADOW                            3101 CT  
Street/Address    CT   WISTERIA                             3101 CT  
Street/Address    CT   WINTERWOD                            3101 CT  
Street/Address    CT   WIMBLEDON                            3101 CT  
Street/Address    CT   WILTSHIRE                            3101 CT  
Street/Address    CT   WILOWCREK                            3101 CT  
Street/Address    CT   WILOWBROK                            3101 CT  
Street/Address    CT   WILOUGHBY                            3101 CT  
Street/Address    CT   WHISPERINGCOVE                       3101 CT  
Street/Address    CT   WESTLAKE                             3101 CT  
Street/Address    CT   WELSLEX                              3101 CT  
Street/Address    CT   WELBECK                              3101 CT  
Street/Address    CT   WATERSIDE                            3101 CT  
Street/Address    CT   WATERBURY                            3101 CT  
Street/Address    CT   WALTHAM                              3101 CT  
Street/Address    CT   VISTARIDGE                           3101 CT  
Street/Address    CT   VISTACREK                            3101 CT  


Address/Street    CT   ABEY                                 1209 CT  
Address/Street    CT   ABEY                                 1205 CT  
Address/Street    CT   ABEY                                 1202 CT  
Address/Street    CT   ABEY                                 1206 CT  
Address/Street    CT   ABEY                                 1210 CT  
Address/Street    CT   ABEY                                  910 CT  
Address/Street    CT   ABEY                                  906 CT  
Address/Street    CT   ABEY                                  902 CT  
Address/Street    CT   ABEY                                  822 CT  
Address/Street    CT   ABEY                                  818 CT  
Address/Street    CT   ABEY                                  814 CT  
Address/Street    CT   ABEY                                  810 CT  
Address/Street    CT   ABEY                                  806 CT  
Address/Street    CT   ABEY                                  802 CT  
Address/Street    CT   ABEY                                  714 CT  
Address/Street    CT   ABEY                                  710 CT  
Address/Street    CT   ABEY                                  706 CT  
Address/Street    CT   ABEY                                  702 CT  
Address/Street    CT   ABEY                                  709 CT  
Address/Street    CT   ABEY                                  801 CT  
Address/Street    CT   ABEY                                  805 CT  
Address/Street    CT   ABEY                                  809 CT  

*/
-------------------------------------------------------------------------------- ------- -------

	set echo		on;
	set fetchrows;

