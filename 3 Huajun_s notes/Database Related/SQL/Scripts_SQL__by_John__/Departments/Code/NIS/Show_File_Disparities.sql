
--	display counts of invalid column references between tables


--	================================================================================
/*

--	inspection number is not used

	select count(*) from inspection where inspection_number > 0		--	00


--	================================================================================


--	invalid inspection addr_id

	select addr_id	from inspection						--	nulls
	minus
	select addr_id	from codeaddr;

	
--	invalid inspection citation_number
 
	select citation_number			from inspection			--	nulls
	minus
	select to_char (citation_number)	from citation;

	
--	invalid case_violation code_id

	select code_id	from case_violation					--	nulls
	minus
	select code_id	from code;	



	select count(*) from inspection where addr_id is null;		--	12

	select count(*) from case_violation where code_id is null;		--	34676

	select count(*) from inspection where citation_number is null;	--	64043

--	======================================================================================

--	inspection follow-up differs from case violation action		--	31057

	select case_number, to_number (follow_up_action) from inspection
	minus
	select case_number, action				 from case_violation


--	inspection with citation number						

	select count(*) from inspection	where citation_number > 0;	--	00


--	inspection with complaint

 	select count(*) from inspection where complaint_number > 0;		--	4617


--	inspection without case_violation 

	select case_number	from	inspection
	minus
	select case_number	from	case_violation

--	======================================================================================

--	inspection of complaint with different case number

	select case_number	from	inspection					--	00
	where	complaint_number > 0
	minus
	select case_number	from	complaint

	
--	complaint case without an inspection case 

	select case_number	from	complaint					--	72
	minus
	select case_number	from	inspection


--	======================================================================================

*/

--	================================================================================





	select count(*)								
	from inspection	

	where	case_number is not null
	and	(case_number, to_number(follow_up_action)	)	

	in
(

	select	case_number, to_number (follow_up_action)		from inspection
	minus
	select	case_number, action					from case_violation

);





--	select count(*) from inspection 	where complaint_number > 0;


--	select count(*) from inspection	where citation_number > 0;	


