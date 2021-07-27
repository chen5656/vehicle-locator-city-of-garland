--	================================================================
set echo		off;
set linesize	1000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=============================================================================

DECLARE

	compile_only	integer	:= 01;
	TEST_COUNT		integer	:= 11;

	tax_in1		varchar2(40);
	tax_in2		varchar2(40);
	tax_in3		varchar2(40);
	tax_in4		varchar2(40);

	tax_attn		varchar2(40);
	tax_strt		varchar2(40);
	tax_unit		varchar2(40);
	tax_city		varchar2(40);
	tax_state		varchar2(40);
	tax_name		varchar2(40);
	cast			varchar2(40);
	error			varchar2(40);

BEGIN

	if	compile_only > 0		then
		return;
	end if;
	
FOR	READ IN (select * from garland.gds_account where acct_type = 'R' and rownum < TEST_COUNT )	Loop

	tax_in1	:= read.owner_addr1; 
	tax_in2	:= read.owner_addr2; 
	tax_in3	:= read.owner_addr3; 
	tax_in4	:= read.owner_addr4;

	dbms_output.put_line (	' in1: '||tax_in1 ||chr(13)||' in2: '||tax_in2||chr(13)|| 
					' in3: '||tax_in3 ||chr(13)||' in4: '||tax_in4); 

	garland.FORMAT_TAX_OWNER (	tax_in1,  tax_in2,  tax_in3,  tax_in4,
						tax_attn, tax_strt, tax_unit, tax_city, tax_state, 
						tax_name, cast, error ); 

	dbms_output.put_line ('------------' );
	dbms_output.put_line (	' attn: ' ||tax_attn||chr(13) ||' strt: ' ||tax_strt ||chr(13)|| 
					' unit: ' ||tax_unit||chr(13) ||' city: ' ||tax_city ||chr(13)|| 
					' state: '||tax_state||chr(13)||' name: ' ||tax_name ||chr(13)||
					' cast: ' ||cast||chr(13)||' error: ');

	dbms_output.put_line ('********************************' );

END LOOP;

END;

