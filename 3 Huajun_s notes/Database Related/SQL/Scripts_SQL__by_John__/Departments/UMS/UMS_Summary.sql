
UMS SUMMARY

--	==============================================================

	250T		Account Location
	250T		total					496100
	250T		distinct account_no		105200
	250T		distinct location_no		 79300

	locations	with multiple accounts		 16400
	accounts	with multiple locations		  3200


	100M		Utility Location			 82600
	100M		distinct location_no		 82600	

	260T		Bill Header		   
	261T		Bill Detail

	100M		distinct postal_code		    27 
	260T		distinct postal_code		  2572
	

--	==============================================================

SERVICE_STAT		Account Location Service	250T
------------
CTOFF
CUTOF
CUTON
FINAL

--	==============================================================

Service Type     
------------
EL   				electric
FLOAT				hand held
LTG  				lighting
SPK  				sprinkler
STM  				storm water
SWR  				sewer
SWRSD				sanitation
TMP  				temporary pole
WTR  				water


SQLWKS> 	select	count(*)
     3> 	from		 sfg.um00250t@umsp.world	al		--	account location
     4> 			,sfg.um00140t@umsp.world	st		--	installed service
     6> 	where		al.location_no	= st.location_no
     7> 	and		al.service_seq	= st.serv_seq
     9> 	and		rtrim(st.service_tp) in ('EL', 'WTR')
COUNT(*)  
----------
    228064


--	==============================================================
	select distinct bill_cd 
	from sfg.um00142t@umsp.world

BILL_CD
-------
21GLS
21TS 
24DUP
24RES
26COM
26RES
RESCH
SWPK3
SWPK4
SWPK6
SWPK7
SWPK8
SWR05
SWR06
SWR07
SWR10
SWR11
SWR14
SWR15
SWR16
SWR17
SWR20
SWR23
SWR24
SWR25
SWR39
SWR47
SWR49
SWR55
SWR56
SWRSD
SWSCH
TAPT 
TBAYL
TCOM 
TDAIS
TDUP 
TESYS
TGQTF
TINTR
TKRFT
TLITT
TRES 
TSW  
TTPRE
TUNCA
TVALS
47 rows selected.

--	==============================================================

