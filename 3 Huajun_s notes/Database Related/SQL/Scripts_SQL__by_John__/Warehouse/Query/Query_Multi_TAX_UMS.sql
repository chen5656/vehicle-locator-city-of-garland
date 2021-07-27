
--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into jdeacutis.plan_table for
--	=====================================================================

      select addr_number, addr_prefix, addr_name, addr_type, address_id, tax_id, ums_id, tax_owner, ums_last_name
      from garland.ccs_address_test where address_id in
(
      select address_id from
(
     select address_id, tax_id, ums_id from garland.ccs_address_test     
     minus
     select address_id, tax_id, ums_id from garland.ccs_address
)     
)
      order by addr_name, addr_number;

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('GIS', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================