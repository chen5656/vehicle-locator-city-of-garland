	set echo	  off;
	set charwidth 200;
	set fetchrows;
--	================================================================================
--	display widow centerline & pave mast records  w/out matching branch & section
--	display centerline records without a pave mast  record
--	display pave mast  records without a centerline record
--	================================================================================

--	select count(*)

	select rpad(branch_no,05) ||' '|| rpad(section_no,05) " ",

		 addr_lo  " ", addr_hi " ",
		 addr_pfx " ", addr_name " ", addr_type " ", addr_sfx " ", mslink 

	from	 garland.trvehrcl
	where	 branch_no  not in (777, 7777, 999, 9999)
	and	 section_no not in (777, 7777, 999, 9999)
	and	(branch_no, section_no)		in  

(
	select branch_no, section_no	from garland.trvehrcl
	minus
	select branch,	section	from garland.pave_mast
	where  category = 'S'
);

--	==========================================================================

--	select count(*) 


	select rpad(branch,05) ||' '|| rpad(section,05) ||

		 rpad( addr_num||' '|| addr_pfx ||' '|| addr_name ||' '|| addr_type ||' '|| addr_sfx, 30) ||

		 null || '  from  ' ||
		 rpad( from_addr_num||' '|| from_addr_pfx ||' '|| from_addr_name ||' '|| from_addr_type ||' '|| from_addr_sfx, 30) ||

		 '  to  ' ||
		 rpad( to_addr_num||' '|| to_addr_pfx ||' '|| to_addr_name ||' '|| to_addr_type ||' '|| to_addr_sfx, 30) ||

		' '	" "
	from	 garland.pave_mast
	where  category = 'S'
	and	 branch  not in (777, 7777, 999, 9999)
	and	 section not in (777, 7777, 999, 9999)
	and (	 branch, section)		in
(
	select branch,	section	from garland.pave_mast
	where  category = 'S'
	minus
	select branch_no, section_no	from garland.trvehrcl
);

--	==========================================================================
	set echo	  on;
	set fetchrows;
	set charwidth;
