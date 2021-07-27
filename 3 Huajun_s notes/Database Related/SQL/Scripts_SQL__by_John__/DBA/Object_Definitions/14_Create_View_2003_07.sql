 
create or replace view	 GARLAND.ADDRESS_REGION
(
 ADDR_NUM
,ADDR_PFX
,ADDR_NAME
,ADDR_TYPE
,ADDR_SFX
,UNIT_TYPE
,UNIT_NUM
,X_COORD
,Y_COORD
,PARCEL_ID
,TAX_ACCT
,SUBDIV_ID
,COUNCIL_ID
,POLICE_BEAT
,ZIP_CODE
,CODE_INSPECT_AREA
,FIRE_DISTRICT
)
as
select	a.addr_num,
			a.addr_pfx,
			a.addr_name,
			a.addr_type,
			a.addr_sfx,
			a.unit_type,
			a.unit_num,

			a.x_coord,
			a.y_coord,
			p.parcel_id,

			p.tax_acct,
			p.subdiv_id,
			p.counci
_id,
			p.police_beat,
			p.zip_code,
			p.code_inspect_area,
			p.fire_district

	from		cdreladr		a,
			cdrelpar		p
	where		a.parcel_id		=
p.parcel_id
;
 
create or replace view	 GARLAND.ADDRESS_UNIT_REGION
(
 ADDR_NUM
,ADDR_PFX
,ADDR_NAME
,ADDR_TYPE
,ADDR_SFX
,ADDR_BLDG1
,ADDR_UNIT1
,ADDR_BLDG2
,ADDR_UNIT2
,X_COORD
,Y_COORD
,PARCEL_ID
,TAX_ACCT
,SUBDIV_ID
,COUNCIL_ID
,POLICE_BEAT
,ZIP_CODE
,CODE_INSPECT_AREA
,FIRE_DISTRICT
)
as
select	u.addr_num,
			u.addr_pfx,
			u.addr_name,
			u.addr_type,
			u.addr_sfx,

			u.addr_bldg1,
			u.addr_unit1,
			u.addr_bldg2,
			u.addr_unit2,

			u.x_coord,
			u.y_coord,
			u.parcel_id,

			p
tax_acct,
			p.subdiv_id,
			p.council_id,
			p.police_beat,
			p.zip_code,
			p.code_inspect_area,
			p.fire_district

	from		address_unit	u,
			cdreladr		a,
			cdrelpar		p

	where		a.parcel_id		=
p.parcel_id

	and		a.addr_name		= u.addr_name
	and		a.addr_type		=
u.addr_type
	and		a.addr_pfx		= u.addr_pfx
	and		a.addr_sfx		=
u.addr_sfx
	and		a.addr_num		= u.addr_num
	
;
 
create or replace view	 GARLAND.ADDR_INDUSTRY_VW
(
 ADDR_NUM
,ADDR_PFX
,ADDR_NAME
,ADDR_TYPE
,ADDR_SFX
,PARCEL_ID
,VERIFY_ID
,MSLINK
,MAPID
)
as
select all GARLAND.CDRELADR.ADDR_NUM, GARLAND.CDRELADR.ADDR_PFX,
GARLAND.CDRELADR.ADDR_NAME, GARLAND.CDRELADR.ADDR_TYPE,
GARLAND.CDRELADR.ADDR_SFX, GARLAND.INDUSTRY.PARCEL_ID,
GARLAND.INDUSTRY.VERIFY_ID, GARLAND.CDRELADR.MSLINK,
GARLAND.CDRELADR.MAPID from GARLAND.CDRELADR, GARLAND.INDUSTRY
where GARLAND.CDRELADR.ADDR_NUM = GARLAND.INDUSTRY.ADDR_NUM
and GARLAND.CDRELADR.ADDR_PFX = GARLAND.INDUSTRY.ADDR_PFX
and GARLAND.CDRELADR.ADDR_NAME = GARLAND.INDUSTRY.ADDR_NAME
and GARLAND.CDRELADR.ADDR_TYPE = GARLAND.INDUSTRY.ADDR_TYPE
and GARLAND.CDRELADR.ADDR_SFX = GARLAND.INDUSTRY.ADDR_SFX
;
 
create or replace view	 GARLAND.ADRALIAS_VW
(
 ALIAS_PFX
,ALIAS_NAME
,ALIAS_TYPE
,ALIAS_SFX
,ALIAS_LO
,ALIAS_HI
,ADDR_PFX
,ADDR_NAME
,ADDR_TYPE
,ADDR_SFX
,ALIAS_HOW
)
as
select	alias_pfx,
			alias_name,
			alias_type,
			alias_sfx,

			alias_lo,
			alias_hi,

			addr_pfx,
			addr_name,
			addr_type,
			addr_sfx,

			alias_how

	from		adrAlias
;
 
create or replace view	 GARLAND.ADRALTER_FULL_VW
(
 ADDR_NUM
,ADDR_PFX
,ADDR_NAME
,ADDR_TYPE
,ADDR_SFX
,ADDR_CODE1
,ADDR_UNIT1
,ADDR_CODE2
,ADDR_UNIT2
,FORM_PFX
,FORM_NAME
,FORM_TYPE
,FORM_SFX
,FORM_CODE1
,FORM_UNIT1
,FORM_CODE2
,FORM_UNIT2
,APPL_NUM
,APPL_PFX
,APPL_NAME
,APPL_TYPE
,APPL_SFX
,APPL_CODE1
,APPL_UNIT1
,APPL_CODE2
,APPL_UNIT2
,VERIFY_CODE
,DO_PARSE
,DO_ALIAS
,DO_NAME
,DO_QUAL
,REC_SEQ
,REC_KEY
,SPEC_VERIFY
,SPEC_PARSE
,SPEC_ALIAS
,SPEC_NAME
,SPEC_QUAL
,SPEC_SEQ
,SPEC_KEY
)
as
select
		addr_num,	
		addr_pfx,	
		addr_name,	
		addr_type,	
		addr_sfx,	

		addr_code1,	
		addr_unit1,	
		addr_code2,	
		addr_unit2,	

		form_pfx,	
		form_name,	
		form_type,	
		form_sfx,	

		form_co
e1,	
		form_unit1,	
		form_code2,	
		form_unit2,	

		appl_num,	
		appl_pfx,	
		appl_name,	
		appl_type,	
		appl_sfx,	

		appl_code1,	
		appl_unit1,	
		appl_code2,	
		appl_unit2,	

		verify_code,	
		do
parse,	
		do_alias,	
		do_name,	
		do_qual,	
		rec_seq,	
		rec_key,	

		verify_code,	
		do_parse,	
		do_alias,	
		do_name,	
		do_qual,	
		rec_seq,	
		rec_key	

		from	garland.adrResult
;
 
create or replace view	 GARLAND.ADRALTER_MAIN_VW
(
 ADDR_NUM
,ADDR_PFX
,ADDR_NAME
,ADDR_TYPE
,ADDR_SFX
,ADDR_CODE1
,ADDR_UNIT1
,ADDR_CODE2
,ADDR_UNIT2
,FORM_PFX
,FORM_NAME
,FORM_TYPE

,FORM_SFX
,FORM_CODE1
,FORM_UNIT1
,FORM_CODE2
,FORM_UNIT2
,APPL_NUM
,APPL_PFX
,APPL_NAME
,APPL_TYPE
,APPL_SFX
,APPL_CODE1
,APPL_UNIT1
,APPL_CODE2
,APPL_UNIT2
,VERIFY_CODE
,DO_PARSE
,DO_ALIAS
,DO_NAME
,DO_QUAL
,REC_SEQ
,REC_KEY
,SPEC_VERIFY
,SPEC_PARSE
,SPEC_ALIAS
,SPEC_NAME
,SPEC_QUAL
,SPEC_SEQ
,SPEC_KEY
)
as
select
		addr_num,	
		addr_pfx,	
		addr_name,	
		addr_type,	
		addr_sfx,	

		addr_code1,	
		addr_unit1,	
		addr_code2,	
		addr_unit2,	

		null,
null, null, null,
		null, null, null, null,

		appl_num,	
		appl_pfx,	
		appl_name,	
		appl_type,	
		appl_sfx,	

		appl_code1,	
		appl_unit1,	
		appl_code2,	
		appl_unit2,	

		verify_code,	
		do_parse
	
		do_alias,	
		do_name,	
		do_qual,	
		rec_seq,	
		rec_key,	

		verify_code,	
		do_parse,	
		do_alias,	
		do_name,	
		do_qual,	
		rec_seq,	
		rec_key	

		from	garland.adrResult
;
 
create or replace view	 GARLAND.ADRALTER_PART_VW
(
 ADDR_NUM
,ADDR_PFX
,ADDR_NAME
,ADDR_TYPE
,ADDR_SFX
,ADDR_CODE1
,ADDR_UNIT1
,ADDR_CODE2
,ADDR_UNIT2
,FORM_PFX
,FORM_NAME
,FORM_TYPE
,FORM_SFX
,FORM_CODE1
,FORM_UNIT1
,FORM_CODE2
,FORM_UNIT2
,APPL_NUM
,APPL_PFX
,APPL_NAME
,APPL_TYPE
,APPL_SFX
,APPL_CODE1
,APPL_UNIT1
,APPL_CODE2
,APPL_UNIT2
,VERIFY_CODE
,DO_PARSE
,DO_ALIAS
,DO_NAME
,DO_QUAL
,REC_SEQ
,REC_KEY
,SPEC_VERIFY
,SPEC_PARSE
,SPEC_ALIAS
,SPEC_NAME
,SPEC_QUAL
,SPEC_SEQ
,SPEC_KEY
)
as
select
		addr_num,	
		addr_pfx,	
		addr_name,	
		addr_type,	
		addr_sfx,	
		null,
null, null, null,

		form_pfx,	
		form_name,	
		form_type,	
		form_sfx,	
		null,
null, null, null,

		null, null, null, null, null,
		--	appl addr
		null, null, null, null,				--	appl
unit
		null, null, null, null, null,			--	verify,parse,alias,name,qual
		null,
null,						--	seq,key

		verify_code,	
		do_parse,	
		do_alias,	
		do_name,	
		do_qual,	
		rec_seq,	
		rec_key	

		from	garland.adrResult
;
 
create or replace view	 GARLAND.ADRALTER_VW
(
 LO_RANGE
,HI_RANGE
,NOTES
,FLAG1
,PFX1
,NAME1
,TYPE1
,SFX1
,FLAG2
,PFX2
,NAME2
,TYPE2
,SFX2
,FLAG3
,PFX3
,NAME3
,TYPE3
,SFX3
)
as
select

LO_RANGE,                      
HI_RANGE,
                     
NOTES,                     
   
FLAG1,                         
PFX1,        
                 
NAME1,                         
TYPE1,
                        
SFX1,                   
      
FLAG2,                         
PFX2,     
                    
NAME2,                      
  
TYPE2,                         
SFX2,         
                
FLAG3,                         
PFX3,
                         
NAME3,                 
       
TYPE3,                         
SFX3     
                    

from	adrAlter
;
 
create or replace view	 GARLAND.ADRRESULT_LOCAL
(
 ADDR_NUM
,ADDR_PFX
,ADDR_NAME
,ADDR_TYPE
,ADDR_SFX
,ADDR_CODE1
,ADDR_UNIT1
,ADDR_CODE2
,ADDR_UNIT2
,VERIFY_CODE
,DO_PARSE
,DO_ALIAS
,DO_NAME
,DO_QUAL
,REC_SEQ
,REC_ROWID
,REC_KEY
,PARCEL_ID
,SEGMENT_ID
,FORM_PFX
,FORM_NAME
,FORM_TYPE
,FORM_SFX
,FORM_CODE1
,FORM_UNIT1
,FORM_CODE2
,FORM_UNIT2
,APPL_PFX
,APPL_NAME
,APPL_TYPE
,APPL_SFX
,APPL_CODE1
,APPL_UNIT1
,APPL_CODE2
,APPL_UNIT2
,APPL_NUM
)
as
select "ADDR_NUM","ADDR_PFX","ADDR_NAME","ADDR_TYPE","ADDR_SFX","ADDR_CODE1","ADDR_UNIT1","ADDR_CODE2","ADDR_UNIT2","VERIFY_CODE","DO_PARSE","DO_ALIAS","DO_NAME","DO_QUAL","REC_SEQ","REC_ROWID","REC_K
Y","PARCEL_ID","SEGMENT_ID","FORM_PFX","FORM_NAME","FORM_TYPE","FORM_SFX","FORM_CODE1","FORM_UNIT1","FORM_CODE2","FORM_UNIT2","APPL_PFX","APPL_NAME","APPL_TYPE","APPL_SFX","APPL_CODE1","APPL_UNIT1","A
PL_CODE2","APPL_UNIT2","APPL_NUM" from	garland.adrResult_Input
;
 
create or replace view	 GARLAND.ADRRESULT_NULL_VW
(
 ADDR_NUM
,ADDR_PFX
,ADDR_NAME
,ADDR_TYPE
,ADDR_SFX
,ADDR_CODE1
,ADDR_UNIT1
,ADDR_CODE2
,ADDR_UNIT2
,VERIFY_CODE
,DO_PARSE
,DO_ALIAS
,DO_NAME
,DO_QUAL
,REC_SEQ
,REC_ROWID
,REC_KEY
,PARCEL_ID
,SEGMENT_ID
,FORM_PFX
,FORM_NAME
,FORM_TYPE
,FORM_SFX

,FORM_CODE1
,FORM_UNIT1
,FORM_CODE2
,FORM_UNIT2
,APPL_PFX
,APPL_NAME
,APPL_TYPE
,APPL_SFX
,APPL_CODE1
,APPL_UNIT1
,APPL_CODE2
,APPL_UNIT2
,APPL_NUM
)
as
select
		addr_num,	
		addr_pfx,	
		addr_name,	
		addr_type,	
		addr_sfx,	
		addr_code1,	
		addr_unit1,	
		addr_code2,	
		addr_unit2,	

		verify_code,	
		do_parse,	
		do_alias,	
		do_name,	
		do_qual,	

		rec_seq,	
		rec_rowid,	
		rec_key,	

		parcel_id,	
		segment_id,	

		form_pfx,	
		form_name,	
		form_type,	
		form_sfx,	
		form_code1,	
		form_unit1,	
		form_code2,	
		form_unit2,	

		appl_num,	
		
ppl_pfx,	
		appl_name,	
		appl_type,	
		appl_sfx,	
		appl_code1,	
		appl_unit1,	
		appl_code2,	
		appl_unit2	

		from	garland.adrResult
;
 
create or replace view	 JDEACUTIS.ADRRESULT_NULL_VW
(
 ADDR_NUM
,ADDR_PFX
,ADDR_NAME
,ADDR_TYPE
,ADDR_SFX
,ADDR_CODE1
,ADDR_UNIT1
,ADDR_CODE2
,ADDR_UNIT2
,VERIFY_CODE
,DO_PARSE
,DO_ALIAS
,DO_NAME
,DO_QUAL
,REC_SEQ
,REC_ROWID
,REC_KEY
,PARCEL_ID
,SEGMENT_ID
,FORM_PFX
,FORM_NAME
,FORM_TYPE
,FORM_SFX
,FORM_CODE1
,FORM_UNIT1
,FORM_CODE2
,FORM_UNIT2
,APPL_PFX
,APPL_NAME
,APPL_TYPE
,APPL_SFX
,APPL_CODE1
,APPL_UNIT1
,APPL_CODE2
,APPL_UNIT2
,APPL_NUM
)
as
select
		addr_num,	
		addr_pfx,	
		addr_name,	
		addr_type,	
		addr_sfx,	
		addr_code1,	
		addr_unit1,	
		addr_code2,	
		addr_unit2,	

		verify_code,	
		do_parse,	
		do_alias,	
		do_name,	
		do_qual,	

		rec_seq,	
		rec_rowid,	
		rec_key,	

		parcel_id,	
		segment_id,	

		form_pfx,	
		form_name,	
		form_type,	
		form_sfx,	
		form_code1,	
		form_unit1,	
		form_code2,	
		form_unit2,	

		null,
null, null, null, null, null, null, null, null		--
appl

		from	garland.adrResult
;
 
create or replace view	 GARLAND.ADRRESULT_USER
(
 REC_KEY
,REC_ROWID
,ADDR_NUM
,ADDR_PFX
,ADDR_NAME
,ADDR_TYPE
,ADDR_SFX
,ADDR_CODE1
,ADDR_UNIT1
,ADDR_CODE2
,ADDR_UNIT2
)
as
select

		item01,		--	record key
		rowid,		--	record
rowid

		'',		--	addr_num,
		'',		--	addr_pfx,
		item02,	--	addr_name,
		'',		--	addr_type,
		'',		--	addr_sfx,

		'',		--	addr_code1,
		'',		--	addr_unit1,
		'',		--	addr_code2,

		''		--	addr_unit2

	from	garland.gis_temp1
;
 
create or replace view	 GARLAND.ADRRESULT_VW
(
 ADDR_NUM
,ADDR_PFX
,ADDR_NAME
,ADDR_TYPE
,ADDR_SFX
,ADDR_CODE1
,ADDR_UNIT1
,ADDR_CODE2
,ADDR_UNIT2
,VERIFY_CODE
,DO_PARSE
,DO_ALIAS
,DO_NAME
,DO_QUAL
,REC_SEQ
,REC_ROWID
,REC_KEY
,PARCEL_ID
,SEGMENT_ID
,FORM_PFX
,FORM_NAME
,FORM_TYPE
,FORM_SFX
,FORM_CODE1
,FORM_UNIT1
,FORM_CODE2
,FORM_UNIT2
,APPL_PFX
,APPL_NAME
,APPL_TYPE
,APPL_SFX
,APPL_CODE1
,APPL_UNIT1
,APPL_CODE2
,APPL_UNIT2
,APPL_NUM
)
as
select  	

	 ADDR_NUM                      
	,ADDR_PFX
                     
	,replace(ADDR_NAME, '''', '''''')		addr_name
	,ADDR_TYPE
                    
	,ADDR_SFX                  
   
	,ADDR_CODE1                    
	,ADDR_UNIT1
                   
	,ADDR_CODE2                 
  
	,ADDR_UNIT2                    
	,VERIFY_CODE
                  
	,DO_PARSE                    
 
	,DO_ALIAS                      
	,DO_NAME     
                 
	,DO_QUAL                      

	,REC_SEQ                       
	,REC_ROWID    
                
	,REC_KEY                       
	,PARCEL_ID
                    
	,SEGMENT_ID                
   
	,FORM_PFX                      
	,replace(FORM_NAME,
'''', '''''')		form_name   
	,FORM_TYPE          
          
	,FORM_SFX                      
	,FORM_CODE1
                   
	,FORM_UNIT1                 
  
	,FORM_CODE2                    
	,FORM_UNIT2 
                  
	,APPL_PFX                    
 
	,replace(APPL_NAME, '''', '''''')		appl_name
	,APPL_TYPE
                    
	,APPL_SFX                  
   
	,APPL_CODE1                    
	,APPL_UNIT1
                   
	,APPL_CODE2                 
  
	,APPL_UNIT2                    
	,APPL_NUM   
                  

	from	garland.adrResult
;
 
create or replace view	 JDEACUTIS.ADRRESULT_VW
(
 ADDR_NUM
,ADDR_PFX
,ADDR_NAME
,ADDR_TYPE
,ADDR_SFX
,ADDR_CODE1
,ADDR_UNIT1
,ADDR_CODE2
,ADDR_UNIT2
,VERIFY_CODE
,DO_PARSE
,DO_ALIAS
,DO_NAME
,DO_QUAL
,REC_SEQ
,REC_ROWID
,REC_KEY
,PARCEL_ID
,SEGMENT_ID
,FORM_PFX
,FORM_NAME
,FORM_TYPE
,FORM_SFX
,FORM_CODE1
,FORM_UNIT1
,FORM_CODE2
,FORM_UNIT2
,APPL_PFX
,APPL_NAME
,APPL_TYPE
,APPL_SFX
,APPL_CODE1
,APPL_UNIT1
,APPL_CODE2
,APPL_UNIT2
,APPL_NUM
)
as
select  	

	 ADDR_NUM                      
	,ADDR_PFX
                     
	,replace(ADDR_NAME, '''', '''''')		addr_name
	,ADDR_TYPE
                    
	,ADDR_SFX                  
   
	,ADDR_CODE1                    
	,ADDR_UNIT1
                   
	,ADDR_CODE2                 
  
	,ADDR_UNIT2                    
	,VERIFY_CODE
                  
	,DO_PARSE                    
 
	,DO_ALIAS                      
	,DO_NAME     
                 
	,DO_QUAL                      

	,REC_SEQ                       
	,REC_ROWID    
                
	,REC_KEY                       
	,PARCEL_ID
                    
	,SEGMENT_ID                
   
	,FORM_PFX                      
	,replace(FORM_NAME,
'''', '''''')		form_name   
	,FORM_TYPE          
          
	,FORM_SFX                      
	,FORM_CODE1
                   
	,FORM_UNIT1                 
  
	,FORM_CODE2                    
	,FORM_UNIT2 
                  
	,APPL_PFX                    
 
	,replace(APPL_NAME, '''', '''''')		appl_name
	,APPL_TYPE
                    
	,APPL_SFX                  
   
	,APPL_CODE1                    
	,APPL_UNIT1
                   
	,APPL_CODE2                 
  
	,APPL_UNIT2                    
	,APPL_NUM   
                  

	from	garland.adrResult
;
 
create or replace view	 GARLAND.BLOCK_REGION1_VIEW
(
 ADDR_NAME
,ADDR_TYPE
,ADDR_PFX
,ADDR_SFX
,ADDR_BLOCK
,REGION1
,REGION2
)
as
select	item01, item02, item03, item04, item05, item06,
item07
	from		gis_temp1
;
 
create or replace view	 GARLAND.BLOCK_REGION2_VIEW
(
 ADDR_NAME
,ADDR_TYPE
,ADDR_PFX
,ADDR_SFX
,ADDR_BLOCK
,REGION1
,REGION2
)
as
select	item01, item02, item03, item04, item05, item06,
item07
	from		gis_temp2
;
 
create or replace view	 GARLAND.BLOCK_REGION3_VIEW
(
 ADDR_NAME
,ADDR_TYPE
,ADDR_PFX
,ADDR_SFX
,ADDR_BLOCK
,REGION1
,REGION2
)
as
select	item01, item02, item03, item04, item05, item06,
item07
	from		gis_temp3
;
 
create or replace view	 GARLAND.BLOCK_REGION_VIEW
(
 ADDR_NAME
,ADDR_TYPE
,ADDR_PFX
,ADDR_SFX
,ADDR_BLOCK
,ADDR_PARITY
,BLOCK_ID
,ROW_ID
,REGION
,KIND
,EMPTY
)
as
select	addr_name, addr_type, addr_pfx, addr_sfx, addr_block,
addr_parity, block_id, rowid,

--	------------------------------------------------------------------------------------------------

		POLICE_BEAT,		'BEAT',				'0'

--		POLICE_DISTRICT,		'DISTRICT',			
'0'			

--	------------------------------------------------------------------------------------------------

	from
garland.adrBlock_Side
;
 
create or replace view	 GARLAND.CDRELADR_DUPE_PARCELS
(
 PARCEL_ID
,ADDR_NUM
,ADDR_PFX
,ADDR_NAME
,ADDR_TYPE
,ADDR_SFX
,ARCVIEW_X
,ARCVIEW_Y
)
as
select	distinct
			p.parcel_id,
			addr_num,
			addr_pfx,
			addr_name,
			addr_type,
			addr_sfx,
			arcview_x,
			arcview_y

	from		cdreladr	a,
			cdrelpar	p

	where		a.parcel_id	=
p.parcel_id
	and		a.parcel_id		in
(
	select	parcel_id
	from		cdreladr
	where		nvl
(lower (rtrim (addr_status)), ' ') <> 'd'
	group by
	parcel_id
	having	count(*) > 1
)

--	order by	p.parcel_id,
--			a.addr_name,
--			a.addr_type,
--			a.addr_num,
--			a.addr_num
	
;
 
create or replace view	 GARLAND.CDRELSUBDV_VW
(
 MSLINK
,MAPID
,SUBDIV_ID
,FINAL_PLAT
,REPLAT
,BLOCK
,LOT_LO
,LOT_HI
,RESIDENT_LOTS
,COMMON_LOTS
,VOLUME
,PAGE_NO
,AREA_SQFT
,AREA_ACRE
,FILING_DATE
,LOGIN_DATE
,PARCEL1
,PARCEL2
,PARCEL3
,PARCEL4
,GRID1
,GRID2
,GRID3
,GRID4
)
as
select "MSLINK","MAPID","SUBDIV_ID","FINAL_PLAT","REPLAT","BLOCK","LOT_LO","LOT_HI","RESIDENT_LOTS","COMMON_LOTS","VOLUME","PAGE_NO","AREA_SQFT","AREA_ACRE","FILING_DATE","LOGIN_DATE","PARCEL1","PARCE
2","PARCEL3","PARCEL4","GRID1","GRID2","GRID3","GRID4"
from garland.cdrelsubdv
;
 
create or replace view	 GARLAND.CORNER
(
 ESRI_NODE
,NODE_ID
,INTERSECT_ROWID
,BLOCK1_ROWID
,BLOCK2_ROWID
,SPOKE1_ROWID
,SPOKE2_ROWID
,ROAD1_ROWID
,ROAD2_ROWID
,CORNER_COMPASS
)
as
select
		item01,
		item02,
		item03,
		item04,
		item05,
		item06,
		item07,
		item08,
		item09,
		item10
	from	gis_temp3
;
 
create or replace view	 GARLAND.GIS_ADDRESSES
(
 PARCELID
,STREETNUMBER
,DIRECTION
,STREETNAME
,STREETTYPE
,SUFFIX
,BLDG
,ZIPCODE
,TENCODE
,XCOORD
,YCOORD
,TAXID
,COUNCILDISTRICT
)
as
select a.parcel_id ParcelID,
a.addr_num StreetNumber,
a.addr_pfx Direction,
a.addr_name StreetName, a.addr_type
StreetType,
a.addr_sfx Suffix, a.addr_bldg Bldg, a.zip_code
ZipCode,
a.zip_plus TenCode, a.x_coord XCoord, a.y_coord
YCoord,
b.tax_acct TaxID, b.council_id CouncilDistrict
from
garland.cdreladr a, garland.cdrelpar b
where a.parcel_id
= b.parcel_id

;
 
create or replace view	 GARLAND.INDSTL_VW
(
 PARCEL_ID
,ADDR_NUM
,ADDR_PFX
,ADDR_NAME
,ADDR_TYPE
,ADDR_SFX
,MSLINK
,MAPID
)
as
select all GARLAND.CDRELPAR.PARCEL_ID, GARLAND.INDSTL.ADDR_NUM,
GARLAND.INDSTL.ADDR_PFX, GARLAND.INDSTL.ADDR_NAME,
GARLAND.INDSTL.ADDR_TYPE, GARLAND.INDSTL.ADDR_SFX,
GARLAND.CDRELPAR.MSLINK, GARLAND.CDRELPAR.MAPID from
GARLAND.CDRELPAR, GARLAND.CDRELADR, GARLAND.INDSTL
where GARLAND.CDRELPAR.PARCEL_ID = GARLAND.CDRELADR.PARCEL_ID
and GARLAND.CDRELADR.ADDR_NUM = GARLAND.INDSTL.ADDR_NUM
and GARLAND.CDRELADR.ADDR_PFX = GARLAND.INDSTL.ADDR_PFX
and GARLAND.CDRELADR.ADDR_NAME = GARLAND.INDSTL.ADDR_NAME
and GARLAND.CDRELADR.ADDR_TYPE = GARLAND.INDSTL.ADDR_TYPE
and GARLAND.CDRELADR.ADDR_SFX = GARLAND.INDSTL.ADDR_SFX
;
 
create or replace view	 GARLAND.INTERSECTION_REGION_VIEW
(
 ADDR1_NAME
,ADDR1_TYPE
,ADDR1_PFX
,ADDR1_SFX
,ADDR1_BLOCK
,ADDR2_NAME
,ADDR2_TYPE
,ADDR2_PFX
,ADDR2_SFX
,ADDR2_BLOCK
,INTERSECT_ID
,NODE_ID
,ROW_ID
,REGION
,KIND
,EMPTY
)
as
select	
		addr1_name, addr1_type, addr1_pfx, addr1_sfx,
addr1_block, 
		addr2_name, addr2_type, addr2_pfx,
addr2_sfx, addr2_block, 
		intersect_id,		node_id,	rowid,

--	------------------------------------------------------------------------------------------------

		POLICE_BEAT,		'BEAT',			'0'

--		POLIC
_DISTRICT,		'DISTRICT',			'0'			

--	------------------------------------------------------------------------------------------------

	from
garland.intersection
;
 
create or replace view	 GARLAND.JOB_ASSIGN_PARCEL_VIEW
(
 ADDR_NAME
,ADDR_TYPE
,ADDR_PFX
,ADDR_SFX
,ADDR_NUM
,PARCEL_ID
,USER_ROWID
)
as
SELECT
			ADDR_NAME,
			ADDR_TYPE,
			ADDR_PFX,
			ADDR_SFX,
			ADDR_NUM,
			PARCEL_ID,

			rowid			"USER_ROWID"

	FROM		NSA_TAX_ALIAS
	
;
 
create or replace view	 GARLAND.PID_ADDR_VW
(
 PARCEL_ID
,ADDR_NUM
,ADDR_PFX
,ADDR_NAME
,ADDR_TYPE
,ADDR_SFX
,ADDR_BLDG
,UNIT_TYPE
,UNIT_NUM
,ZIP_CODE
,ZIP_PLUS
,ADDR_STATUS
,MAP_GRID
,UNIT_AUX
,MSLINK
,MAPID
)
as
select all GARLAND.CDRELPAR.PARCEL_ID, GARLAND.CDRELADR.ADDR_NUM,
GARLAND.CDRELADR.ADDR_PFX, GARLAND.CDRELADR.ADDR_NAME,
GARLAND.CDRELADR.ADDR_TYPE, GARLAND.CDRELADR.ADDR_SFX,
GARLAND.CDRELADR.ADDR_BLDG, GARLAND.CDRELADR.UNIT_TYPE,
GARLAND.CDRELADR.UNIT_NUM, GARLAND.CDRELADR.ZIP_CODE,
GARLAND.CDRELADR.ZIP_PLUS, GARLAND.CDRELADR.ADDR_STATUS,
GARLAND.CDRELADR.MAP_GRID, GARLAND.CDRELADR.UNIT_AUX,
GARLAND.CDRELPAR.MSLINK, GARLAND.CDRELPAR.MAPID from
GARLAND.CDRELPAR, GARLAND.CDRELADR where GARLAND.CDRELPAR.PARCEL_ID
= GARLAND.CDRELADR.PARCEL_ID
;
 
create or replace view	 GARLAND.PID_ADR_TAX_VW
(
 PARCEL_ID
,ADDR_NUM
,ADDR_PFX
,ADDR_NAME
,ADDR_TYPE
,ADDR_SFX
,ACCOUNT
,DIST_ACCOUNT
,OWNER_NAME
,SUPP_TYPE
,SUPP_NUM
,LOT
,BLOCK
,LEGAL_DESC
,PROPERTY_TYPE
,PROPERTY_AREA
,AUX_AREA
,TAX_AMOUNT
,APPRAISAL
,PREV_APPRAISAL
,DCAD_CODE
,STATE_CODE
,LEGAL_DESC2
,LEGAL_DESC3
,LOAN_CO
,MSLINK
,MAPID
)
as
select all GARLAND.CDRELPAR.PARCEL_ID, GARLAND.CDRELADR.ADDR_NUM,
GARLAND.CDRELADR.ADDR_PFX, GARLAND.CDRELADR.ADDR_NAME,
GARLAND.CDRELADR.ADDR_TYPE, GARLAND.CDRELADR.ADDR_SFX,
GARLAND.CDRELTAX.ACCOUNT, GARLAND.CDRELTAX.DIST_ACCOUNT,
GARLAND.CDRELTAX.OWNER_NAME, GARLAND.CDRELTAX.SUPP_TYPE,
GARLAND.CDRELTAX.SUPP_NUM, GARLAND.CDRELTAX.LOT, GARLAND.CDRELTAX.BLOCK,
GARLAND.CDRELTAX.LEGAL_DESC, GARLAND.CDRELTAX.PROPERTY_TYPE,
GARLAND.CDRELTAX.PROPERTY_AREA, GARLAND.CDRELTAX.AUX_AREA,
GARLAND.CDRELTAX.TAX_AMOUNT, GARLAND.CDRELTAX.APPRAISAL,
GARLAND.CDRELTAX.PREV_APPRAISAL, GARLAND.CDRELTAX.DCAD_CODE,
GARLAND.CDRELTAX.STATE_CODE, GARLAND.CDRELTAX.LEGAL_DESC2,
GARLAND.CDRELTAX.LEGAL_DESC3, GARLAND.CDRELTAX.LOAN_CO,
GARLAND.CDRELPAR.MSLINK, GARLAND.CDRELPAR.MAPID from
GARLAND.CDRELPAR, GARLAND.CDRELADR, GARLAND.CDRELTAX
where GARLAND.CDRELPAR.PARCEL_ID = GARLAND.CDRELADR.PARCEL_ID
and GARLAND.CDRELPAR.PARCEL_ID = GARLAND.CDRELTAX.PARCEL_ID
;
 
create or replace view	 GARLAND.SNGLFAM_RENTAL_VW
(
 PARCEL_ID
,ADDR_NUM
,ADDR_PFX
,ADDR_NAME
,ADDR_TYPE
,ADDR_SFX
,TAX_OWNER
,MAIL_ADDR
,MAIL_CITY
,UMS_OCCUPANT
,LAND_USE_CODE
,MSLINK
,MAPID
)
as
select all GARLAND.CDRELPAR.PARCEL_ID, GARLAND.CDRELADR.ADDR_NUM,
GARLAND.CDRELADR.ADDR_PFX, GARLAND.CDRELADR.ADDR_NAME,
GARLAND.CDRELADR.ADDR_TYPE, GARLAND.CDRELADR.ADDR_SFX,
GARLAND.SNGLFAM_RENTAL.TAX_OWNER, GARLAND.SNGLFAM_RENTAL.MAIL_ADDR,
GARLAND.SNGLFAM_RENTAL.MAIL_CITY, GARLAND.SNGLFAM_RENTAL.UMS_OCCUPANT,
GARLAND.SNGLFAM_RENTAL.LAND_USE_CODE, GARLAND.CDRELPAR.MSLINK,
GARLAND.CDRELPAR.MAPID from GARLAND.CDRELPAR, GARLAND.CDRELADR,
GARLAND.SNGLFAM_RENTAL where GARLAND.CDRELPAR.PARCEL_ID
= GARLAND.CDRELADR.PARCEL_ID and GARLAND.CDRELADR.ADDR_NUM
= GARLAND.SNGLFAM_RENTAL.ADDR_NUM and GARLAND.CDRELADR.ADDR_PFX
= GARLAND.SNGLFAM_RENTAL.ADDR_PFX and GARLAND.CDRELADR.ADDR_NAME
= GARLAND.SNGLFAM_RENTAL.ADDR_NAME and GARLAND.CDRELADR.ADDR_TYPE
= GARLAND.SNGLFAM_RENTAL.ADDR_TYPE and GARLAND.CDRELADR.ADDR_SFX
= GARLAND.SNGLFAM_RENTAL.ADDR_SFX
;
 
create or replace view	 GARLAND.SPOKE
(
 ESRI_NODE
,ROAD_ID
,TERMINAL
,FROM_NODE
,TO_NODE
,COORD_X
,COORD_Y
,VECTOR_X
,VECTOR_Y
,STREET_ID
,BLOCK_ID
)
as
select	item01,
			item02,
			item03,
			item04,
			item05,
			item06,
			item07,
			item08,
			item09,
			item10,
			item11
	from		gis_temp1
;
 
create or replace view	 GARLAND.TAX_CODE_VW
(
 PARCEL_ID
,ACCOUNT
,DIST_ACCOUNT
,LEGAL_DESC
,NO_OF_CASES
,MSLINK
,MAPID
)
as
select all GARLAND.CDRELPAR.PARCEL_ID, GARLAND.CDRELTAX.ACCOUNT,
GARLAND.CDRELTAX.DIST_ACCOUNT, GARLAND.CDRELTAX.LEGAL_DESC,
GARLAND.CDBG_INSPECTION.NO_OF_CASES, GARLAND.CDRELPAR.MSLINK,
GARLAND.CDRELPAR.MAPID from GARLAND.CDRELPAR, GARLAND.CDRELTAX,
GARLAND.CDBG_INSPECTION where GARLAND.CDRELPAR.PARCEL_ID
= GARLAND.CDRELTAX.PARCEL_ID and GARLAND.CDRELTAX.ACCOUNT
= GARLAND.CDBG_INSPECTION.TAX_ID
;
 
create or replace view	 GARLAND.TEMP_VIEW
(
 ADDR_NUM
,ADDR_PFX
,ADDR_NAME
,ADDR_TYPE
,ADDR_SFX
)
as
select item01, item02, item03, item04, item05	from
garland.gis_objects
;
 
create or replace view	 GARLAND.TEMP_VIEW1
(
 KEY
,OWNER_NAME
,TABLE_NAME1
,TABLE_NAME2
,COLUMN_ID
,COLUMN_NAME
,COLUMN_TYPE
,FIRST_COMMA
,STORAGE_CLAUSE
)
as
select
		item01, 
		item02, item03, item04, 
		item05,
item06, item07, 
		item08, item09
	from	garland.gis_objects
;
 
create or replace view	 GARLAND.TMP_VIEW
(
 KEY_
,TYPE_
,SCHEMA_
,PREFIX_
,SUFFIX_
,TABLESPACE_
,INITIAL_
,NEXT_
,MAXEXTENTS_
,MAXTRANS_
,PCTFREE_
,PCTUSED_
,OPTION1_
,OPTION2_
,DBLINK_
)
as
select
		item01,	item02,	item03,	item04,	item05,	
item06,
		item07,	item08,	item09,	item10,	item11,	
item12,	
		item13,	item14,	item15

	from	gis_objects
;
 
create or replace view	 GARLAND.TRVEHACL_PAVE_MAST_VW
(
 MSLINK
,MAPID
,ALLEY_ID
,BRANCH_NO
,SECTION_NO
,ALLEY_AREA
,CATEGORY
,BRANCH
,SECTION
,SEGMENT
,LENG
,LANES
,SURF_TYPE
,REAR_ENTRY
,CDBG
,CONST_DATE
,LAST_INSPECT_DATE
,NEXT_INSPECT_DATE
,PCI
,CLASS
,CRACK_SEAL
,DISTRESSES
,POT_HOLE_REQ
,COUN_DIST
,THOR_TYPE
,ADDR_NUM
,ADDR_PFX
,ADDR_NAME
,ADDR_TYPE
,ADDR_SFX
,FROM_ADDR_NUM
,FROM_ADDR_PFX
,FROM_ADDR_NAME
,FROM_ADDR_TYPE
,FROM_ADDR_SFX
,TO_ADDR_NUM
,TO_ADDR_PFX
,TO_ADDR_NAME
,TO_ADDR_TYPE
,TO_ADDR_SFX
,REMARKS
,MISSING_SDWK
,THOR_TYPE_NEW
,CPI_YN
)
as
(
	select	t.*,
			p.*

	from		trvehacl		t,
			pave_mast		p

	where	t.branch_no
 = p.branch  (+)
	and	t.section_no = p.section (+)
)
;
 
create or replace view	 GARLAND.TRVEHRCL_PAVE_MAST_VW
(
 MSLINK
,MAPID
,CLINE_ID
,BRANCH1
,SECTION1
,NUM_LANES
,FR_COORD
,TO_COORD
,CLINE_LEN
,ST_NAME
,COUN_DIST1
,BOND_PROJ
,ADR1_NUM
,ADR1_PFX
,ADR1_NAM
,ADR1_TYP
,ADR1_SFX
,ADR_LF_FR
,ADR_LF_TO
,ADR_RT_FR
,ADR_RT_TO
,PILOT
,SOURCE
,NOTCARRIED
,ADR_LO
,ADR_HI
,SEGMENT_ID
,CATEGORY
,BRANCH2
,SECTION2
,SEGMENT2
,LENG
,LANES
,SURF_TYPE
,REAR_ENTRY
,CDBG
,CONST_DATE
,LAST_INSP
,NEXT_INSP
,PCI
,CLASS
,CRACK_SEAL
,DISTRESSES
,POTHOLE_RQ
,COUN_DIST2
,THOR_TYPE
,ADR2_NUM
,ADR2_PFX
,ADR2_NAM
,ADR2_TYP
,ADR2_SFX
,FR_ADR_NUM
,FR_ADR_PFX
,FR_ADR_NAM
,FR_ADR_TYP
,FR_ADR_SFX
,TO_ADR_NUM
,TO_ADR_PFX
,TO_ADR_NAM
,TO_ADR_TYP
,TO_ADR_SFX
,REMARKS
,NO_SDWK
,THOR_NEW
,CPI_YN
)
as
select	t.*,
			p.*
	from		trvehrcl		t,
			pave_mast		p

	where	t.branch_no
 = p.branch  (+)
	and	t.section_no = p.section (+)
	and	p.category
(+) = 'S'
;
 
create or replace view	 GARLAND.TRVEH_ALLEY_VW
(
 ALLEY_ID
,BRANCH_NO
,SECTION_NO
,ALLEY_AREA
,COUNCIL_DIST
,ALLEY_NAME
,ST_NAME_FROM
,ST_NAME_TO
,REAR_ENTRY
,SECTION_LENGTH
,NUM_OF_LANES
,SEAL_COND
,DISTRESSES
,PCI
,SURFACE_TYPE
,LAST_INSPECTION
,NEXT_INSPECTION
,SECTION_CLASS
,CONT_REPAIR_COST
,CONT_REPLACE_COST
,CITY_REPLACE_COST
,MAT_REPAIR_COST
,MAT_REPLACE_COST
,CONSTR_DATE
,CDBG
,THOR_TYPE
,MSLINK
,MAPID
)
as
select all GARLAND.TRVEHACL.ALLEY_ID, GARLAND.TRVEHACL.BRANCH_NO,
GARLAND.TRVEHACL.SECTION_NO, GARLAND.TRVEHACL.ALLEY_AREA,
GARLAND.TRVEHALY.COUNCIL_DIST, GARLAND.TRVEHALY.ALLEY_NAME,
GARLAND.TRVEHALY.ST_NAME_FROM, GARLAND.TRVEHALY.ST_NAME_TO,
GARLAND.TRVEHALY.REAR_ENTRY, GARLAND.TRVEHALY.SECTION_LENGTH,
GARLAND.TRVEHALY.NUM_OF_LANES, GARLAND.TRVEHALY.SEAL_COND,
GARLAND.TRVEHALY.DISTRESSES, GARLAND.TRVEHALY.PCI,
GARLAND.TRVEHALY.SURFACE_TYPE, GARLAND.TRVEHALY.LAST_INSPECTION,
GARLAND.TRVEHALY.NEXT_INSPECTION, GARLAND.TRVEHALY.SECTION_CLASS,
GARLAND.TRVEHALY.CONT_REPAIR_COST, GARLAND.TRVEHALY.CONT_REPLACE_COST,
GARLAND.TRVEHALY.CITY_REPLACE_COST, GARLAND.TRVEHALY.MAT_REPAIR_COST,
GARLAND.TRVEHALY.MAT_REPLACE_COST, GARLAND.TRVEHALY.CONSTR_DATE,
GARLAND.TRVEHALY.CDBG, GARLAND.TRVEHALY.THOR_TYPE,
GARLAND.TRVEHACL.MSLINK, GARLAND.TRVEHACL.MAPID from
GARLAND.TRVEHACL, GARLAND.TRVEHALY where GARLAND.TRVEHACL.BRANCH_NO
= GARLAND.TRVEHALY.BRANCH_NO and GARLAND.TRVEHACL.SECTION_NO
= GARLAND.TRVEHALY.SECTION_NO
;
 
create or replace view	 GARLAND.UNIQUE_STREET
(
 ADDR_PFX
,ADDR_NAME
,ADDR_TYPE
,ADDR_SFX
)
as
select	addr_pfx,
			addr_name,
			addr_type,
			addr_sfx
	from		adrstreet
	where		addr_name		in
	(
		select	addr_name
		from		adrstreet
		group
by	addr_name
		having	count(*) = 1
	)
;
 
create or replace view	 GARLAND.UTWATPIP_TEMP
(
 PROJECT_NO
,PROJECT_NAME
,SUBDIVISION_NAME
,PROJECT_DESC
,ASBUILT_DATE
,INSPECTOR_NAME
,CONTRACT_NAME
,MAP_GRID
,MAP_QUAD
,MSLINK
,MAPID
,PIPE_DIAMETER
,PIPE_LENGTH
,PIPE_MATERIAL
,UP_NODE_ID
,DN_NODE_ID
,UP_NODE_ELEV
,UP_NODE_GRND_ELEV
,DN_NODE_ELEV
,DN_NODE_GRND_ELEV
,SLOPE
,PIPE_CLASS
,PIPE_MANUFACTURER
,PIPE_USE
,PIPE_STATUS
,PIPE_OWNER
,PIPE_OWNER_STATUS
,CONTRACTOR
,CONTRACT_NUM
,LINE_NUM
,ZONE
,SUB_BASIN
,SUB_SUB_BASIN
,PRESSURE_NORMAL
,PRESSURE_MAX
,PRESSURE_SOURCE
,REPAIR_DATE
,WORK_ORDER_NUM
,INSPECT_DATE
,FROM_X_COORD
,FROM_Y_COORD
,TO_X_COORD
,TO_Y_COORD
,DATA_SOURCE
,USER_FLAG
,POST_MODE
,DATE_ADD
,PIPE_ID
,PIPE_NUM
,ATS
,COMMENTS
)
as
select                                           
                                       
      ITEM01
                                                 
                                     
     ,ITEM02
                                                 
                                     
     ,ITEM03
                                                 
                                     
     ,ITEM04
                                                 
                                     
     ,ITEM05
                                                 
                                     
     ,ITEM06
                                                 
                                     
     ,ITEM07
                                                 
                                     
     ,ITEM08
                                                 
                                     
     ,ITEM09
                                                 
                                     
     ,ITEM10
                                                 
                                     
     ,ITEM11
                                                 
                                     
     ,ITEM12
                                                 
                                     
     ,ITEM13
                                                 
                                     
     ,ITEM14
                                                 
                                     
     ,ITEM15
                                                 
                                     
     ,ITEM16
                                                 
                                     
     ,ITEM17
                                                 
                                     
     ,ITEM18
                                                 
                                     
     ,ITEM19
                                                 
                                     
     ,ITEM20
                                                 
                                     
     ,ITEM21
                                                 
                                     
     ,ITEM22
                                                 
                                     
     ,ITEM23
                                                 
                                     
     ,ITEM24
                                                 
                                     
     ,ITEM25
                                                 
                                     
     ,ITEM26
                                                 
                                     
     ,ITEM27
                                                 
                                     
     ,ITEM28
                                                 
                                     
     ,ITEM29
                                                 
                                     
     ,ITEM30
                                                 
                                     
     ,ITEM31
                                                 
                                     
     ,ITEM32
                                                 
                                     
     ,ITEM33
                                                 
                                     
     ,ITEM34
                                                 
                                     
     ,ITEM35
                                                 
                                     
     ,ITEM36
                                                 
                                     
     ,ITEM37
                                                 
                                     
     ,ITEM38
                                                 
                                     
     ,ITEM39
                                                 
                                     
     ,ITEM40
                                                 
                                     
     ,ITEM41
                                                 
                                     
     ,ITEM42
                                                 
                                     
     ,ITEM43
                                                 
                                     
     ,ITEM44
                                                 
                                     
     ,ITEM45
                                                 
                                     
     ,ITEM46
                                                 
                                     
     ,ITEM47
                                                 
                                     
     ,ITEM48
                                                 
                                     
     ,ITEM49
                                                 
                                     
     ,ITEM50
                                                 
                                     
     ,ITEM51
                                                 
                                     
     from garland.GIS_TEMP1
;
 
create or replace view	 GARLAND.VEHRCL_PAVEMAST_VW
(
 CLINE_ID
,BRANCH_NO
,SECTION_NO
,NUM_LANES
,FR_COORD
,TO_COORD
,CLINE_LENGTH
,ST_NAME
,COUNCIL_DISTRICT
,BOND_PROJ
,ADDR_NUM
,ADDR_PFX
,ADDR_NAME
,ADDR_TYPE
,ADDR_SFX
,ADDR_LEFT_FROM
,ADDR_LEFT_TO
,ADDR_RGHT_FROM
,ADDR_RGHT_TO
,PILOT
,SOURCE
,NOTCARRIED
,ADDR_LO
,ADDR_HI
,SEGMENT_ID
,CATEGORY
,LENG
,LANES
,SURF_TYPE
,REAR_ENTRY
,CDBG
,PCI
,CLASS
,CRACK_SEAL
,DISTRESSES
,POT_HOLE_REQ
,COUN_DIST
,THOR_TYPE
,REMARKS
,MISSING_SDWK
,THOR_TYPE_NEW
,MSLINK
,MAPID
)
as
select trvehrcl.cline_id,trvehrcl.branch_no,trvehrcl.section_no,trvehrcl.num_lanes,trvehrcl.fr_coord,trvehrcl.to_coord,trvehrcl.cline_length,trvehrcl.st_name,trvehrcl.council_district,trvehrcl.bond_pr
j,trvehrcl.addr_num,trvehrcl.addr_pfx,trvehrcl.addr_name,trvehrcl.addr_type,trvehrcl.addr_sfx,trvehrcl.addr_left_from,trvehrcl.addr_left_to,trvehrcl.addr_rght_from,trvehrcl.addr_rght_to,trvehrcl.pilot
trvehrcl.source,trvehrcl.notcarried,trvehrcl.addr_lo,trvehrcl.addr_hi,trvehrcl.segment_id,PAVE_MAST.category,PAVE_MAST.leng,PAVE_MAST.lanes,PAVE_MAST.surf_type,PAVE_MAST.rear_entry,PAVE_MAST.cdbg,PAVE
MAST.pci,PAVE_MAST.class,PAVE_MAST.crack_seal,PAVE_MAST.distresses,PAVE_MAST.pot_hole_req,PAVE_MAST.coun_dist,PAVE_MAST.thor_type,PAVE_MAST.remarks,PAVE_MAST.missing_sdwk,PAVE_MAST.thor_type_new,trveh
cl.mslink,trvehrcl.mapid from trvehrcl,PAVE_MAST where
trvehrcl.branch_no=PAVE_MAST.branch and trvehrcl.section_no=PAVE_MAST.section
;

