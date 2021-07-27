	set echo	off;
--	=================================================================
--	drop	package			garland.Resolve_Address;

	create or replace package	garland.Resolve_Address		as

--	create or replace package	garland.Resolve_Address_TEST	as

--	=============================================================

	procedure	Batch_Driver
(	
	spec_insert		in		number	default 01,
	spec_seq		in		number	default 0
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

	spec_insert		in		number	default 01,
	spec_seq		in		number	default 0

	,Tracker_Mode	in		number	default 0
	,Tracker_Focus	in		varchar2	default null
	,Tracked_Focus	in		varchar2	default null
);
--	=============================================================

end;

