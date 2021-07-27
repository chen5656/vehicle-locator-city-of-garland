
--	intersection problems

===========================================================================
--	If spoke node is missing street id or block id
--	then display error and do not process

--	Node might belong to "duplicate nodes" 
--	so duplicate correction would be wrong
--	so an intersection id would be wrong.

--	DO NOT load Intersection table until problem is corrected.
===========================================================================


===========================================================================
--	spoke has invalid mslinks
--	because trvehrcl has been modified
--	and spoke is based on old ESRI extract

	select segment_id 
	from spoke
	where	block_id is null

	minus

	select rtrim(mslink) from trvehrcl;

===========================================================================
