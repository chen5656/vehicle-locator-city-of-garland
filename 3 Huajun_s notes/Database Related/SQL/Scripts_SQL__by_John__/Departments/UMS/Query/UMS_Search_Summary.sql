	set echo		off;
	set charwidth	200;
--	=====================================================================================

	variable	find_num	varchar2;	
	variable	find_pfx	varchar2;
	variable	find_name	varchar2;
	variable	find_type	varchar2;
	variable	find_lnm1	varchar2;
	variable	find_lnm2	varchar2;
	variable	find_lnm3	varchar2;

	execute	:find_num	:= '%1133%';
	execute	:find_name	:= '%WESTMINSTER%';
--	execute	:find_pfx	:= '%%'
--	execute	:find_type	:= '%%';

	execute	:find_lnm1	:= '%BASHAM%';
	execute	:find_lnm2	:= '%CHAMBERS%';
	execute	:find_lnm3	:= '%/%';

--	=====================================================================================

	select	distinct
			'locn='	||	x.location_no	
			||' acct='	||	x.account_no	
			||' pers='	||	a.person_no
			|| chr(10)			

			||'occupant	'			||
			rtrim(a.person_fnm)		||' '||
			rtrim(a.person_lnm)		||'	'||
			ltrim(rtrim(l.house_no))	||' '||
			rtrim(l.street_pfx_dir)		||' '||
			rtrim(l.street_nm)		||' '||
			rtrim(l.street_nm_sfx)		||' '||
			rtrim(l.sec_addr_id)		||' '||
			ltrim(rtrim(l.sec_addr_range))||' '||
			chr(10)				
			" "

	from	sfg.um00250t@umsrep.world		x,	-- xref
		sfg.um00100m@umsrep.world		l,	-- location
		sfg.um00200m@umsrep.world		a	-- account

	where	x.location_no	= l.location_no
	and	x.account_no	= a.account_no

--	------------------------------------------------------------------------

	and	l.house_no		like :find_num
	and 	l.street_nm		like :find_name 

	and (	a.person_lnm	like :find_lnm1 
	or	a.person_lnm	like :find_lnm2 	
	or 	a.person_lnm	like :find_lnm3 	)

--	------------------------------------------------------------------------

	union all

	select	distinct
			'related	' 			||
			rtrim(p.person_fnm)		||' '||
			rtrim(p.person_lnm)		||'	'||
			ltrim(rtrim(r.house_no))	||' '||
			rtrim(r.street_pfx_dir)		||' '||
			rtrim(r.street_nm)		||' '||
			rtrim(r.street_nm_sfx)		||' '||
			rtrim(r.sec_addr_id)		||' '||
			ltrim(rtrim(r.sec_addr_range))||' '||
			rtrim(r.city)			||' '||
			chr(10)	

			||'		'					||
			'drlic=' || rtrim(p.i_drivers_lic_no)	||
			chr(10)	
			" "

	from	sfg.um00250t@umsrep.world		x,	-- xref
		sfg.um00100m@umsrep.world		l,	-- location
		sfg.um00200m@umsrep.world		a	-- account

		,sfg.sg00100m@umsrep.world	p	-- person
		,sfg.sg00130t@umsrep.world	r	-- related address	

	where	x.location_no	= l.location_no
	and	x.account_no	= a.account_no

	and	a.person_no		= p.person_no
	and	a.person_no		= r.person_no

--	------------------------------------------------------------------------

	and	l.house_no		like :find_num
	and 	l.street_nm		like :find_name 

	and (	a.person_lnm	like :find_lnm1 
	or	a.person_lnm	like :find_lnm2 	
	or 	a.person_lnm	like :find_lnm3 	)

--	------------------------------------------------------------------------
	;

--	=====================================================================================
	set echo	on;
