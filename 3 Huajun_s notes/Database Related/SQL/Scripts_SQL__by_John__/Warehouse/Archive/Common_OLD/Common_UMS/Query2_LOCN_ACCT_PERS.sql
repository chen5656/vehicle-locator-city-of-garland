	set echo 		off;
	set timing		on;
	set fetchrows;
--	=================================================================================
--	Count occurrences of different sets of values
--	=================================================================================

	alter session	set nls_date_format = 'yyyymmdd';

--	=================================================================================

	select count(*)

--	select p.person_stat, count(*)

	from	sfg.um00250t@umsrep.world	X,
		sfg.um00100m@umsrep.world	L,
		sfg.um00200m@umsrep.world	A,
		sfg.sg00100m@umsrep.world	P

	where	x.location_no	= l.location_no
	and	x.account_no	= a.account_no
	and	a.person_no		= p.person_no

--	---------------------------------------------------------------------------------

	and	rtrim(l.location_stat)	= 'ACT'
--	and	rtrim(p.person_stat)	= 'ACT'
--	and	rtrim(p.person_stat)	is null
	and	rtrim(x.service_stat)	= 'CUTON'
	and	ltrim(l.city) 	  like  'G%'

	and	rtrim		(l.sec_addr_id)		is null
	and	rtrim(ltrim	(l.sec_addr_range))	is null

--	---------------------------------------------------------------------------------

--	and (	 street_nm, house_no, nvl(street_nm_sfx,' '), nvl(street_pfx_dir,' '), nvl(street_sfx_dir,' '), 
--		 x.effective_dt || a.last_bill_dt || x.service_seq )		IN
--	(
--	select street_nm, house_no, nvl(street_nm_sfx,' '), nvl(street_pfx_dir,' '), nvl(street_sfx_dir,' '), 
--		 max(x.effective_dt || nvl(a.last_bill_dt,'19910101') || x.service_seq)



	and (	 street_nm, house_no, nvl(street_nm_sfx,' '), nvl(street_pfx_dir,' '), nvl(street_sfx_dir,' '), 
		 x.effective_dt || x.service_seq )		IN
	(
	select street_nm, house_no, nvl(street_nm_sfx,' '), nvl(street_pfx_dir,' '), nvl(street_sfx_dir,' '), 
		 max(x.effective_dt || x.service_seq)

--	---------------------------------------------------------------------------------

	from	sfg.um00250t@umsrep.world	X,
		sfg.um00100m@umsrep.world	L,
		sfg.um00200m@umsrep.world	A
	where	x.location_no	= l.location_no
	and	x.account_no	= a.account_no
	and	x.effective_dt is not null
--	and	a.last_bill_dt is not null

	group by street_nm, house_no, nvl(street_nm_sfx,' '), nvl(street_pfx_dir,' '), nvl(street_sfx_dir,' ') 
)

--	---------------------------------------------------------------------------------

--	group by p.person_stat

--	---------------------------------------------------------------------------------

	;

--	=================================================================================
/*
	select table_name, 
		 rpad(column_name,30) 		column_name, 
		 index_name, 
		 lpad(column_position,04)	posn
	from all_ind_columns@umsrep.world
	where	table_name in ( 'UM00250T',  'UM00100M',  'UM00200M',  'SG00100M'   )
	order by table_name, index_name, column_position;

*/
--	=================================================================================
/*

max(x.effective_dt || nvl(a.last_bill_dt,'19910101') || x.service_seq)
PERSO COUNT(*)--
----- ----------
ACT        54782
INACT        123
            5426

select street_nm, house_no, nvl(street_nm_sfx,' '), nvl(street_pfx_dir,' '), nvl(street_sfx_dir,' '), 
max(x.effective_dt || x.service_seq)
COUNT(*)--
----------
     61482


current jdeacutis.common_ums
COUNT(*)  
----------
     60651


*/
--	=================================================================================

	set timing		off;
	set fetchrows;
