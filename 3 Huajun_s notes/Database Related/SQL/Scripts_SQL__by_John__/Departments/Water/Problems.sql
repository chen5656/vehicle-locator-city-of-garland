--	=====================================================================================
--	Water verification for 2805 Country Club gave 2 addresses for 1 locatoin
--	The problem is not with GIS, but with the current Water Address file layout

--	2805 S Country Club Rd
--	2805   Country Club Pkwy

--	======================================================================================
--	UMS Query

--	select * from cdreladr where addr_name = 'COUNTRY CLUB'  and addr_num = 2805

	select * from sfg.um00100m@umsp.world  
	where house_no like '%2805%'
	and  street_nm like 'COUNTRY CLUB%';

	36032		PKWY
	30494		S RD

--	=============================================================================
--	GIS Query


SQLWKS> 	select distinct rec_key, addr_pfx, addr_type
     2> 	from adrResult_UMS_Location
     3> 	where addr_name = 'COUNTRY CLUB'
     4> 	and	addr_num = 2805
     5> 

REC_KEY              ADDR_PFX   ADDR_TYPE 
-------------------- ---------- ----------
30494                S          RD        
36032                           PKWY      
2 rows selected.


