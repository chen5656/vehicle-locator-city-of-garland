	set echo	off;
--	=================================================================
--	drop	package			garland.Resolve_Address;

	create or replace package	garland.Resolve_Address		as

--	=================================================================
--	TRACE PACKAGE

	trace_of_pick_only	varchar2(10)	:= '%0110%';	-- basic, focus, & scope only

	trace_flow_off		varchar2(10)	:= '%0710%';	-- suppress flow trace
	trace_data_off		varchar2(10)	:= '%0720%';	-- suppress data tracking

	trace_file_on		varchar2(10)	:= '%0810%';	-- write to gis_objects
	trace_print_off		varchar2(10)	:= '%0820%';	-- suppress print

	trace_of_debug1		varchar2(10)	:= '%0910%';
	trace_of_debug2		varchar2(10)	:= '%0920%';
	trace_of_debug3		varchar2(10)	:= '%0930%';

	trace_line_leng		number	:= 80;
	trace_who_leng		number	:= 13;
	trace_what1_leng		number	:= 06;
	trace_what2_leng		number	:= 07;
	trace_max_data		number	:= 99999;
	trace_max_flow		number	:= 99999;
	trace_new_line		char		:= '*';

--	=============================================================


--	=============================================================

	procedure	Location_Driver;

--	=============================================================

	procedure	Batch_Driver
(	
	spec_insert		in		number	default 0,
	spec_seq		in		number	default 0,
	spec_trace		in		number	default 0,
	spec_show		in		number	default 99,	
	spec_focus		in		varchar2	default null	

);

--	=============================================================
	procedure	Query_Driver
(

	addr_num		in out	varchar2,
	addr_pfx		in out	varchar2,
	addr_name		in out	varchar2,
	addr_type		in out	varchar2,
	addr_sfx		in out	varchar2,	

	addr_code1		in out	varchar2,
	addr_unit1		in out	varchar2,
	addr_code2		in out	varchar2,
	addr_unit2		in out	varchar2,

	form_pfx		in out	varchar2,
	form_name		in out	varchar2,
	form_type		in out	varchar2,
	form_sfx		in out	varchar2,	

	form_code1		in out	varchar2,
	form_unit1		in out	varchar2,
	form_code2		in out	varchar2,
	form_unit2		in out	varchar2,

	verify_code		out		number,
	gis_key		out		varchar2,
	audit			out		varchar2,

	spec_insert		in		number	default 0,
	spec_seq		in		number	default 0,

	spec_trace		in		number	default 0,
	spec_show		in		number	default 99,
	spec_focus		in		varchar2	default null	

);
--	=============================================================

end;

