
--	how many bad nums are really bad names
--	are in adrResult


--	truncate table plan_table	reuse storage;
--	explain plan set statement_id = 'xxx'   for

	select count(*) 
	from adrResult_UMS_Safe		a

	where a.verify_code between 20 and 49

	and	(addr_name, addr_num)	in
(
	select item01, item02
	from	 gis_temp4
	where	 item01 = a.addr_name
	and	 item02 = a.addr_num
);


--	select * from explain_plan;



	select count(*) 
	from adrResult_UMS_Safe		a
	where a.verify_code between 20 and 49;
