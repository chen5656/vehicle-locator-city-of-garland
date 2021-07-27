	select 'UTSTOOUTF  ' || to_char(sysdate, 'mon dd,yyyy hh24:mi') " " from dual;

--	drop table		UTSTOOUTF;

	explain plan set statement_id = 'UTSTOOUTF'  into garland.plan_table  for

	Create table	UTSTOOUTF			
(
	mslink			number(8,0)		not null,
	mapid				number(8,0),
	project_num			varchar2(11),
	scan_num			varchar2(20),

	outfall_id			varchar2(12),
	map_grid			varchar2(03),
	map_quad			varchar2(01),
	outfall_num			number(8,0),

	parent_id			varchar2(12),
	latitude			number,
	longitude			number,

	access_instruction	varchar2(40),		-- 

	outfall_dimension		number,
	outfall_type		varchar2(12),
	outfall_material		varchar2(10),

	quantity			number,
	discharge			varchar2(05),
	recv_sub_basin		varchar2(05),
	epa_total_score		number,

	OUTFALL_DATE		VARCHAR2(04),		-- NOV 2004

	inspect_date		varchar2(10),

	basin				varchar2(20),		--
	sub_basin			varchar2(20),		--

	outfall_cond		varchar2(40),
	general_comments		varchar2(40)
)
	nologging
	tablespace			gis_data
	pctfree	20
	storage			(initial 50K  next 50K  pctincrease 0);

--	===============================================================
/*	NOV 4, 2004

Table                                      ** INDEXED        COLUMN **                 Type        
------------------------- ------------------------------ --- ------------------------- ------------
UTSTOOUTF                 UTSTOOUTF_MSLINK                 1 MSLINK                    NUMBER      
UTSTOOUTF                 UTSTOOUTF_OUTFALL_ID             1 OUTFALL_ID                VARCHAR2    


** TABLE **          Tablespace IOT        Rows AvgLen  Empty  Free Chains Extent Blocks        Bytes     Initial        Next
-------------------- ---------- --- ----------- ------ ------ ----- ------ ------ ------ ------------ ----------- -----------
UTSTOOUTF            GIS_DATA                15     68     33  2963      0      1      1      143,360     131,072      57,344


Table                ** CONSTRAINT **     Type Reference                      Status  
-------------------- -------------------- ---- ------------------------------ --------
UTSTOOUTF            UTSTOOUTF_MSLINK     U                                   ENABLED 


Table                Tablespace ** INDEX **               Unique    Distinct Extent   Blocks   Bytes          Initial        Next Type      
-------------------- ---------- ------------------------- --------- -------- ------ -------- ------------ ----------- ----------- ----------
UTSTOOUTF            GIS_DATA   UTSTOOUTF_MSLINK          UNIQUE          15      1       35      143,360     131,072      57,344 NORMAL    
UTSTOOUTF            GIS_DATA   UTSTOOUTF_OUTFALL_ID      NONUNIQUE        1      1       35      143,360     131,072      57,344 NORMAL    

*/
--	===============================================================

