	set echo 		off;
    set linesize	2000;
	set fetchrows;
	set charwidth;
	set stoponerror	on;
--	=================================================================================

--	select count(*)

	select
		ltrim(rtrim(l.house_no))			numb,
		rpad(l.street_pfx_dir,	03)			pfx,
		rpad(l.street_nm,		15)			street, 
		rpad(l.street_nm_sfx,	04)			type,
--		rpad(l.street_sfx_dir,	03)			sfx,
--		rpad(l.sec_addr_id,	05)			secid,
		rpad(l.sec_addr_range,	05)			unit,
		x.effective_dt, 
		rpad(x.service_stat,	06)			serv,
		rpad(l.location_stat,	06)			locn,
		rpad(p.person_stat,	06)			pers,
		rpad(l.city,		08)			city,
		p.person_lnm, p.person_fnm,
--		l.location_no, x.service_seq, a.account_no, p.person_no,
		' ' " "

	from	sfg.um00250t@umsrep.world	X,
		sfg.um00100m@umsrep.world	L,
		sfg.um00200m@umsrep.world	A,
		sfg.sg00100m@umsrep.world	P
	where	x.location_no	= l.location_no
	and	x.account_no	= a.account_no
	and	a.person_no		= p.person_no

--	---------------------------------------------------------------------------------
--	research particular address

--	and	l.street_nm				= 'WHITEOAK'
--	and	ltrim(rtrim(l.house_no))	= '1602'
--	and	p.person_lnm||''			= 'MOSS'
--	and	l.sec_addr_range||''		= 'TP'

--	---------------------------------------------------------------------------------
--	how much difference does person_stat make

	and	rtrim(l.location_stat) = 'ACT'
	and	nvl(rtrim(p.person_stat),' ') in ('ACT', ' ')		-- 82734
--	and	rtrim(p.person_stat) 		in ('ACT')			-- 79346

--	---------------------------------------------------------------------------------

	order by	effective_dt desc
--	order by	street_nm, street_nm_sfx, street_pfx_dir, street_sfx_dir, house_no, effective_dt desc
	;
--	=================================================================================
/*
	select table_name, 
		 rpad(column_name,30) 		column_name, 
		 index_name, 
		 lpad(column_position,04)	posn
	from all_ind_columns@umsp.world
	where	table_name in ( 'UM00250T',  'UM00100M',  'UM00200M',  'SG00100M'   )
	order by table_name, index_name, column_position;
*/
--	=================================================================================
	set fetchrows;
	set charwidth;





--	and	x.service_stat	= 'CUTON'
--	and	l.location_stat	= 'ACT'
--	and	p.person_stat	= 'ACT'
--	and	ltrim(l.city) like  'G%'
--	and	rtrim		(l.sec_addr_id)		is null
--	and	rtrim(ltrim	(l.sec_addr_range))	is null
