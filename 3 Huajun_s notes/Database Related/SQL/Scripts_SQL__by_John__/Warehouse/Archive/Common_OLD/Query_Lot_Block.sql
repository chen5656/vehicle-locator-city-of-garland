	set echo	off;
    set linesize	2000;
--	================================================


	select distinct

--	desc1, 
	desc2, desc3, desc4

	from	garland.TAX

--	where desc2 || desc3 like '%BLK%BLK%'


	where	(
	
		desc2 like 'LT %' 

	or	desc2 like 'BLK %'

	or	desc2 like 'LOT %'

	or	desc3 like '%BLK %' 

		)

--	------------------------------------------------
/*

	and	(
		desc2 like '%PT '

	or	desc3 like '%PT '
		)

*/
--	------------------------------------------------

	and	rownum < 111
;
--	------------------------------------------------

--	================================================
	set echo	on;

