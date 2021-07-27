	set echo		off;
	set timing		off;
--	===========================================================================
--	pick out alias_names to be examined by fuzzy name match
--	flag them with alias_hi = 888888

--	use fuzzy match score < 100
--	driver: select 's', addr_name union select 'a', alias_name
--	[good_list = $alias] triggers alias search
--	===========================================================================

	update garland.adrAlias		a
	set	alias_hi = 888888
	where not exists
(
	select 'x' from garland.adrStreets
	where addr_compress = a.alias_compress
)
	and alias_name > 'A'
	and lower(alias_how) not like '%push%'
	and lower(alias_how) not like '%pull%'
	and lower(alias_how) not like '%like%'
	and alias_how not in ( 'rhyme', 'transpose' )
	and length(translate(alias_name, '/ 0123456789','/')) >= 5
	;


	commit;

--	===========================================================================



