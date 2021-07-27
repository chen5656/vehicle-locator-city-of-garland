	set echo		off;
    set linesize	2000;
	set fetchrows	111;
--	=========================================================================

	select
		x.location_no,
--		x.account_no,
--		x.service_seq

		,max(x.effective_dt)

--		,min(p.person_no), max(p.person_no)
--		,count(*)

	from	sfg.um00250t@umsrep.world		X,	-- xref
		sfg.um00100m@umsrep.world		L,	-- location
		sfg.um00200m@umsrep.world		A,	-- account
		sfg.um00240t@umsrep.world		S	-- status

--		,sfg.sg00100m@umsrep.world	P

	where	l.location_no	= x.location_no
	and	a.account_no	= x.account_no
	and	a.account_no	= s.account_no

--	and	a.person_no		= p.person_no

	and	x.service_stat	= 'CUTON'
	and	l.location_stat	= 'ACT'
	and	s.is_connect_yn	= 'T'

--	and	l.location_no = 379



	group by	x.location_no,
	having	count(max(effective_dt)) > 1


--	order by	1,2,3

	;

--	=========================================================================
--	there is only 1 person per account

	select count(*)	from
(
	select a.account_no, count(*)
	from
		sfg.um00200m@umsrep.world		A,	-- account
		sfg.sg00100m@umsrep.world		P	-- person

	where	a.person_no = p.person_no

	group by	a.account_no
	having	count(p.person_no) > 1
);

--	=========================================================================
--	=========================================================================
/*
	and	l.location_stat	= 'ACT'

	and	x.service_stat	= 'CUTON'

	and	a.account_stat_start_dt	is not null
	and	a.account_stat_end_dt	is null

	and	to_char(a.last_bill_dt, 'yyyymm') > '200401'	--	
--	and	a.account_stat	= 'BILBL'				--	
*/

--	===========================================================================
/*

LOCATION_STAT
-------------
ACT  
INACT
TMPPL


ACCOUNT_STAT
------------
BILBL
INBIL
NOBIL
WRTOF

account records
---------------
    156464

account start date
------------------
     78909

account end date
----------------
      1573

account closed_yn
- ---------------
F       9780
T     146677
           8

*/
--	=====================================================================
	set echo	on;
	set fetchrows;
