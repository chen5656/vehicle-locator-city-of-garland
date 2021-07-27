	Set echo	off;
--	================================================================
--	Address Finder / Verification modules
--	================================================================

	drop package			Find_Street_Name;

	Create or replace	package 	Find_Street_Name		IS

--	================================================================

	asis_method			varchar2(10)	:= 'asis';
	partial_method		varchar2(10)	:= 'part';
    
 	reduced_score		binary_integer	:= 90;
 	compact_score		binary_integer	:= 80;

  	also_class			binary_integer	:= 01;
  	also_max			binary_integer	:= 03;

	list_also_start		binary_integer	:= 01;

	list_second_idx		binary_integer	:= 02;
	list_partial_idx		binary_integer	:= 03;
	list_method_idx		binary_integer	:= 0;
	list_match_idx		binary_integer	:= 0;
	list_weight_idx		binary_integer	:= 0;

--	================================================================

function	Find_Qualifier (qualifier  in  varchar2)	return varchar2;

--	================================================================

procedure	Main
( 
	pass_num		in		number,
	pass_pfx		in out	varchar2,
	pass_name		in out	varchar2,
	pass_type		in out	varchar2,
	pass_sfx		in out	varchar2,

	pass_exact		   out	varchar2,	-- reduced name
	pass_close		   out	varchar2,	-- compact name
	pass_also		   out	varchar2,	-- second name

	pass_match		   out	number,	-- alias match
	pass_count		   out	number,	-- match count
	pass_method		   out	varchar2,	-- alias method    
	pass_weight		   out	varchar2	-- alias weight      
);

end;

--	================================================================

