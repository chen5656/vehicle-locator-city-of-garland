--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	800;
set pagesize	9999;
--	alter session	set nls_date_format = 'yyyymmdd';  
--	=====================================================================

	select count(*)	from	ucbcust@banbprd;		-- 211719

	select ucbcust_status_ind, count(*)			-- 211719
	from	ucbcust@banbprd
	group by ucbcust_status_ind;

--	=====================================================================
/*
	select date_created, activity_date, date_retired
	from ucbprem@banbprd
	where rownum < 11;

	select ucracct_status_ind, count(*)
	from	ucracct@banbprd
	group by ucracct_status_ind;


	select count(*)
	from	ucracct@banbprd			B,
		sfg.um00200m@umsrep.world	U
	where	b.ucracct_old_account = u.account_no
	;

	select count(*)	from	ucbcust@banbprd;		-- 211719
	select ucbcust_status_ind, count(*)			-- 211719
	from	ucbcust@banbprd
	group by ucbcust_status_ind;
*/

--	=====================================================================
/*


	select ucracct_status_ind, count(*)	from	ucracct@banbprd
- ----------
A      79630
F          6
I     142563
N        259



	select count(*) from ucracct@banbprd;
----------
    222458
	from	ucracct@banbprd			B,
		sfg.um00200m@umsrep.world	U
	where	b.ucracct_old_account = u.account_no
----------
    222349

*/

--	=====================================================================

/*
	select 
		l.location_no, 
		a.account_no, 
		x.service_seq, 
		p.person_no, 
		to_char(x.effective_dt,'yyyymmdd') 
	from	sfg.um00250t@umsrep.world		X,	
		sfg.um00100m@umsrep.world		L,	
		sfg.um00200m@umsrep.world		A,	
		sfg.sg00100m@umsrep.world		P	
	where	x.location_no = l.location_no
	and	x.account_no  = a.account_no
	and	p.person_no	  = a.person_no
	and	rtrim(x.service_stat)	  	   =  'CUTON'
	and	nvl(rtrim(l.location_stat),' ') in ('ACT')
	and	nvl(rtrim(p.person_stat),  ' ') in ('ACT', ' ')
	and	ltrim(l.city) 			like  'G%'
	and	rtrim		(l.sec_addr_id)	  is null
	and	rtrim(ltrim	(l.sec_addr_range)) is null
	;
*/
--	=====================================================================
