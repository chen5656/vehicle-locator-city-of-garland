
--	drop package				ADR_Finder;
--	create or replace	package           ADR_Finder		as

	drop package				ADR_Finder_01;
	create or replace	package           ADR_Finder_01	as

/*
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
     
--	=================================================================
*/


type adr_num is table of varchar(10)        
	index by binary_integer;     

type adr_prefix is table of varchar(2)                     
	index by binary_integer;     

type adr_name is table of varchar(40)                      
	index by binary_integer;     

type adr_type is table of varchar(4)                       
	index by binary_integer;     

type adr_suffix is table of varchar(2)                     
	index by binary_integer;     

type adr_parcel is table of varchar(11)   
	index by binary_integer;     

type adr_id  is table of integer
	index by binary_integer;     

type adr_status is table of varchar2(5)
	index by binary_integer;     


procedure Verify_Address 
(         		
	num_in		in	varchar2,           --  changed from number
	pfx_in		in	varchar2,         
	name_in		in	varchar2,       
	type_in		in	varchar2,         
	sfx_in		in	varchar2,         

	num_out		out	adr_num,     
	pfx_out		out	adr_prefix,    
	name_out		out	adr_name,    
	type_out		out	adr_type,      
	sfx_out		out	adr_suffix,    

	parcel_id_out	out	adr_parcel,
	addr_id_out		out	adr_id,
	status_out		out	adr_status,

	best_option	   in	out	varchar2,
	best_choice	   in out	number
);   
     
end; 

