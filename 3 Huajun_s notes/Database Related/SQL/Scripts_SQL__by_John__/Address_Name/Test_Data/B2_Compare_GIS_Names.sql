--	=================================================================
--	test harness for tst_compare_names procedure
--	=================================================================

	set echo		off;
	set timing		on;
	set serveroutput	on		size 99999;
	set charwidth	800;
--	=================================================================
--	create or replace procedure	test2		as

declare

--	===================================================================

	job_spec		varchar2(20)	:= '';			-- sep 2003
	best_spec		number		:= '';	
	good_spec		number		:= '';	

--	job_spec		varchar2(20)	:= '$$02';			-- sep 2003
--	best_spec		number		:= -01;	
--	good_spec		number		:= -400;	


	fixed_leng		number	:= 20;

	best_count		number	:= -4000;
	good_count		number	:= 0;

	best_list		varchar2(400)	:= null;
	good_list		varchar2(400)	:= null;

	user_name		varchar2(400)	:= null;
	label			varchar2(80)	:= null;

--	===================================================================

begin

	dbms_output.put_line (rpad ('=', 105, '='));
	dbms_output.put_line (' ');

	label	:= '      ';						-- sep 2003

--	===================================================================

for	look in (select item01	from garland.gis_objects)		loop

	user_name	:= upper (look.item01);
	best_list	:= user_name;

	good_list	:= job_spec;					-- sep 2003	
	best_count	:= best_spec;
	good_count	:= good_spec;

--	TEST
--	dbms_output.put_line ( 	'job= ' || good_list);
--	dbms_output.put_line ( 	'best=' || best_count);
--	dbms_output.put_line ( 	'good=' || good_count);

--	---------------------------------------------------------------------------------

--	Compare_names ( best_list, good_list, best_count, good_count);
--	TST_compare_names ( best_list, good_list, best_count, good_count);

	Fuzzy_Driver (best_list, good_list, best_count, good_count);

--	---------------------------------------------------------------------------------

--	TEST
--	dbms_output.put_line ( 	'name=' || user_name);
--	dbms_output.put_line ( 	'best=' || best_list);
--	dbms_output.put_line ( 	'good=' || rpad(good_list,240));
--	dbms_output.put_line ( 	' ' );

--	=======================================================================================

	dbms_output.put_line ( 	rpad(nvl(user_name, ' '),20)	
--					||  length(best_list)/20 ||' '|| length(good_list)/20	
			);

	dbms_output.put_line (	rpad(best_count,20) ||	substr(best_list, 001, 80)
--					||chr(10)		  ||	substr(best_list, 081, 80)
			);

--	dbms_output.put_line (	rpad(good_count,20) ||	substr(good_list, 001, 80)
--					||chr(10)		  ||	substr(good_list, 081, 80)
--			);


	dbms_output.put_line (' ');					-- sep 2003


--	=======================================================================================

end loop;

end;

