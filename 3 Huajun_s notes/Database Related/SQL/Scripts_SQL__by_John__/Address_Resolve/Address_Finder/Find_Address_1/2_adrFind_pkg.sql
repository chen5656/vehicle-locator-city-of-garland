	Set echo	off;
--	================================================================
--	Address Finder / Verification modules
--	================================================================

--	drop package			ADR_FIND;
--	Create or replace	package 	ADR_FIND		as 	--  perm

	drop package			garland.ADR_FIND_01;
	Create or replace	package 	garland.ADR_FIND_01		as 	--  test

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

	arg_match			binary_integer;	

--	================================================================

function	Find_Qualifier (qualifier  in  varchar2)	return varchar2;

--	================================================================

procedure	Find_Alias	
( 
	pass_num		in		number,
	pass_pfx		in out	varchar2,
	pass_name		in out	varchar2,
	pass_type		in out	varchar2,
	pass_sfx		in out	varchar2,

	pass_second		   out	varchar2,	-- second name
	pass_list		   out	varchar$v,	-- also valid (eg. transpose, rhyme)
	pass_method		   out	varchar2,	-- alias method    
	pass_match		   out	varchar2,	-- alias match
	pass_weight		   out	varchar2	-- alias weight      
);

end;

--	================================================================

