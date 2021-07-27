Statement processed.
Parse             0.09 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.02 (Elapsed)     0.00 (CPU)
Total             0.11               0.00
Echo                            OFF
Server Output                   ON
Charwidth                       100
MGR-03512: spool file "c:\deacutis\scripts\ora_create\Script_Snapshot.sql" is already open
Statement processed.
Parse             0.04 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.17 (Elapsed)     0.00 (CPU)
Total             0.21               0.00
create or replace trigger GARLAND.INSP_ARCH
BEFORE 
UPDATE
of ADDR_NAME
,ADDR_NUM
,ADDR_PFX
,ADDR_SFX
,ADDR_TYPE
,BRANCH
,CATEGORY
,CDBG
,CLASS
,CONST_DATE
,COUN_DIST
,CRACK_SEAL
,DISTRESSES
,FROM_ADDR_NAME
,FROM_ADDR_NUM
,FROM_ADDR_PFX
,FROM_ADDR_SFX
,FROM_ADDR_TYPE
,LANES
,LAST_INSPECT_DATE
,LENG
,MISSING_SDWK
,NEXT_INSPECT_DATE
,PCI
,POT_HOLE_REQ
,REAR_ENTRY
,REMARKS
,SECTION
,SEGMENT
,SURF_TYPE
,THOR_TYPE
,TO_ADDR_NAME
,TO_ADDR_NUM
,TO_ADDR_PFX
,TO_ADDR_SFX
,TO_ADDR_TYPE
on GARLAND.PAVE_MAST
REFERENCING NEW AS NEW OLD AS OLD
for each row 
BEGIN 
insert into insp_arch(
     CATEGORY,
    
BRANCH,

    SECTION,
     SEGMENT,
     LENG,
  
  LANES,

    SURF_TYPE,
     REAR_ENTRY,
     CDBG,

    CONST_DATE,

    LAST_INSPECT_DATE,
     NEXT_INSPECT_DATE,

 
  PCI,
     CLASS,
     CRACK_SEAL,
     DISTRESSES,


   POT_HOLE_REQ,
     COUN_DIST,
     THOR_TYPE,


   ADDR_NUM,
     ADDR_PFX,
     ADDR_NAME,
    
ADDR_TYPE,

    ADDR_SFX,
     FROM_ADDR_NUM,
   
 FROM_ADDR_PFX,

    FROM_ADDR_NAME,
     FROM_ADDR_TYPE,

    FROM_ADDR_SFX,

    TO_ADDR_NUM,
     TO_ADDR_PFX,

    TO_ADDR_NAME,

    TO_ADDR_TYPE,
     TO_ADDR_SFX,

    REMARKS)

values(
     :old.CATEGORY,
     :old.BRANCH,

 
  :old.SECTION,
     :old.SEGMENT,
     :old.LENG,


   :old.LANES,
     :old.SURF_TYPE,
     :old.REAR_ENTRY,


   :old.CDBG,
     :old.CONST_DATE,
     :old.LAST_INSPECT_DATE,


   :old.NEXT_INSPECT_DATE,
     :old.PCI,
     :old.CLASS,


   :old.CRACK_SEAL,
     :old.DISTRESSES,
     :old.POT_HOLE_REQ,


   :old.COUN_DIST,
     :old.THOR_TYPE,
     :old.ADDR_NUM,


   :old.ADDR_PFX,
     :old.ADDR_NAME,
     :old.ADDR_TYPE,


   :old.ADDR_SFX,
     :old.FROM_ADDR_NUM,
     :old.FROM_ADDR_PFX,


   :old.FROM_ADDR_NAME,
     :old.FROM_ADDR_TYPE,


   :old.FROM_ADDR_SFX,
     :old.TO_ADDR_NUM,
  

 :old.TO_ADDR_PFX,
     :old.TO_ADDR_NAME,
     :old.TO_ADDR_TYPE,


   :old.TO_ADDR_SFX,
     :old.REMARKS);
end;

 
create or replace trigger GARLAND.TLOG$_TST_JOHN
AFTER 
INSERT
OR
DELETE
OR
UPDATE
on GARLAND.TST_JOHN
REFERENCING NEW AS NEW OLD AS OLD
for each row 
declare    dmltype char;
 begin    if     inserting then dmltype := 'I';
   elsif  updating  then dmltype := 'U';
   elsif  deleting  then dmltype := 'D';
   end if;
   insert into "GARLAND"."MLOG$_TST_JOHN" (m_row$$,
dmltype$$)      values (:old.rowid, dmltype);
 end;
Echo                            OFF
Server Output                   ON
Charwidth                       200
Statement processed.
Parse             0.08 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.31 (Elapsed)     0.00 (CPU)
Total             0.39               0.00
 
create or replace view	 GARLAND.MVIEW$_TST_JOHN_SNAPSHOT
(
 ADDR_NAME
,ADDR_COMPRESS
)
as
select tst_john."ADDR_NAME", adrname.addr_compress
from
tst_john, adrname
where	tst_john.addr_name = adrname.addr_name

;
 
create or replace view	 GARLAND.SANI_FL_VW
(
 CUSTOMER_NAME
,ADDR_NUM
,ADDR_PFX
,ADDR_NAME
,ADDR_TYPE
,ADDR_SFX
,UNIT_TYPE
,UNIT_NUM
,ACCOUNT_NO
,OWNERCODE
,SIZEYARDS
,CONTAINER
,PICKUPCODE
,M
,T
,W
,R
,F
,S
,RATE_DOLLAR
,MONRTE
,TUESRTE
,WEDSRTE
,THURRTE
,FRIRTE
,SATRTE
,A_TYPE
,SEQ_NO
,COMMENTS
,PARCEL_ID
,MSLINK
,MAPID
)
as
select all GARLAND.SANI_COM_FL.CUSTOMER_NAME, GARLAND.SANI_COM_FL.ADDR_NUM,
GARLAND.SANI_COM_FL.ADDR_PFX, GARLAND.SANI_COM_FL.ADDR_NAME,
GARLAND.SANI_COM_FL.ADDR_TYPE, GARLAND.SANI_COM_FL.ADDR_SFX,
GARLAND.SANI_COM_FL.UNIT_TYPE, GARLAND.SANI_COM_FL.UNIT_NUM,
GARLAND.SANI_COM_FL.ACCOUNT_NO, GARLAND.SANI_COM_FL.OWNERCODE,
GARLAND.SANI_COM_FL.SIZEYARDS, GARLAND.SANI_COM_FL.CONTAINER,
GARLAND.SANI_COM_FL.PICKUPCODE, GARLAND.SANI_COM_FL.M,
GARLAND.SANI_COM_FL.T, GARLAND.SANI_COM_FL.W, GARLAND.SANI_COM_FL.R,
GARLAND.SANI_COM_FL.F, GARLAND.SANI_COM_FL.S, GARLAND.SANI_COM_FL.RATE_DOLLAR,
GARLAND.SANI_COM_FL.MONRTE, GARLAND.SANI_COM_FL.TUESRTE,
GARLAND.SANI_COM_FL.WEDSRTE, GARLAND.SANI_COM_FL.THURRTE,
GARLAND.SANI_COM_FL.FRIRTE, GARLAND.SANI_COM_FL.SATRTE,
GARLAND.SANI_COM_FL.A_TYPE, GARLAND.SANI_COM_FL.SEQ_NO,
GARLAND.SANI_COM_FL.COMMENTS, GARLAND.SANI_COM_FL.PARCEL_ID,
GARLAND.CDRELPAR.MSLINK, GARLAND.CDRELPAR.MAPID from
GARLAND.CDRELPAR, GARLAND.SANI_COM_FL where GARLAND.CDRELPAR.PARCEL_ID
= GARLAND.SANI_COM_FL.PARCEL_ID
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
)
as
select	trvehrcl.*,
			pave_mast.*
	from	trvehrcl,
		pave_mast
	where	branch_no	=
branch  (+)
	and	section_no	= section (+)
	
;
 
create or replace view	 GARLAND.TST_JOHN_SNAPSHOT
(
 ADDR_NAME
,ADDR_COMPRESS
)
as
select "ADDR_NAME","ADDR_COMPRESS" from "GARLAND"."SNAP$_TST_JOHN_SNAPSHOT"
with read only
;
Charwidth                       100
                                                                                   
-----------------------------------------------------------------------------------
create synonym   GARLAND.TMP_ADDRESS_SYN        for GARLAND.TMP_SANI_ADDRESS      ;
create synonym   GARLAND.TMP_USER_TABLE_SYN     for GARLAND.TMP_INDUSTRY          ;
create synonym   GARLAND.SYN_UTWATPIP_NEXT      for GARLAND.UTWATPIP_REVISE_01    ;
create synonym   GARLAND.SYN_PREV_WATER         for GARLAND.UTSTOOCH_ORIGINAL     ;
create synonym   GARLAND.SYN_THIS_WATER         for GARLAND.UTSTOOCH              ;
create synonym   GARLAND.SYN_THAT_WATER         for GARLAND.UTSTOOCH_REVISE_01    ;
create synonym   GARLAND.SYN_USER_TABLE1        for GARLAND.TMP_JOHN              ;
create synonym   GARLAND.SYN_USER_TABLE2        for GARLAND.UTSTOINL              ;
create synonym   GARLAND.SYN_FROM_TABLE         for GARLAND.UTSTOPIP_REVISE_01    ;
create synonym   GARLAND.SYN_TO_TABLE           for GARLAND.UTSTOPIP              ;
create synonym   GARLAND.SYN_JOHN1              for GARLAND.TMP_JOHN              ;
create synonym   GARLAND.SYN_JOHN2              for GARLAND.UTSANFIT              ;
create synonym   GARLAND.TMP_TABLE_SYN          for GARLAND.SANI_PICKUP           ;
create synonym   GARLAND.SYN_USER_TABLE         for GARLAND.ADRSTREET             ;
create synonym   GARLAND.SYN_NMMAIN             for LEADS.NMMAIN                  ;
create synonym   GARLAND.SYN_PRMAIN             for LEADS.PRMAIN                  ;
create synonym   GARLAND.SYN_ADDRESS            for GARLAND.TRVEHRCL              ;
create synonym   GARLAND.TMP_ADDRESS_SYN        for GARLAND.TMP_SANI_ADDRESS      ;
create synonym   GARLAND.TMP_USER_TABLE_SYN     for GARLAND.TMP_INDUSTRY          ;
create synonym   GARLAND.SYN_UTWATPIP_NEXT      for GARLAND.UTWATPIP_REVISE_01    ;
create synonym   GARLAND.SYN_PREV_WATER         for GARLAND.UTSTOOCH_ORIGINAL     ;
create synonym   GARLAND.SYN_THIS_WATER         for GARLAND.UTSTOOCH              ;
create synonym   GARLAND.SYN_THAT_WATER         for GARLAND.UTSTOOCH_REVISE_01    ;
create synonym   GARLAND.SYN_USER_TABLE1        for GARLAND.TMP_JOHN              ;
create synonym   GARLAND.SYN_USER_TABLE2        for GARLAND.UTSTOINL              ;
create synonym   GARLAND.SYN_FROM_TABLE         for GARLAND.UTSTOPIP_REVISE_01    ;
create synonym   GARLAND.SYN_TO_TABLE           for GARLAND.UTSTOPIP              ;
create synonym   GARLAND.SYN_JOHN1              for GARLAND.TMP_JOHN              ;
create synonym   GARLAND.SYN_JOHN2              for GARLAND.UTSANFIT              ;
create synonym   GARLAND.TMP_TABLE_SYN          for GARLAND.SANI_PICKUP           ;
create synonym   GARLAND.SYN_USER_TABLE         for GARLAND.ADRSTREET             ;
create synonym   GARLAND.SYN_NMMAIN             for LEADS.NMMAIN                  ;
create synonym   GARLAND.SYN_PRMAIN             for LEADS.PRMAIN                  ;
create synonym   GARLAND.SYN_ADDRESS            for GARLAND.TRVEHRCL              ;
create synonym   GARLAND.TMP_ADDRESS_SYN        for GARLAND.TMP_SANI_ADDRESS      ;
create synonym   GARLAND.TMP_USER_TABLE_SYN     for GARLAND.TMP_INDUSTRY          ;
create synonym   GARLAND.SYN_UTWATPIP_NEXT      for GARLAND.UTWATPIP_REVISE_01    ;
create synonym   GARLAND.SYN_PREV_WATER         for GARLAND.UTSTOOCH_ORIGINAL     ;
create synonym   GARLAND.SYN_THIS_WATER         for GARLAND.UTSTOOCH              ;
create synonym   GARLAND.SYN_THAT_WATER         for GARLAND.UTSTOOCH_REVISE_01    ;
create synonym   GARLAND.SYN_USER_TABLE1        for GARLAND.TMP_JOHN              ;
create synonym   GARLAND.SYN_USER_TABLE2        for GARLAND.UTSTOINL              ;
create synonym   GARLAND.SYN_FROM_TABLE         for GARLAND.UTSTOPIP_REVISE_01    ;
create synonym   GARLAND.SYN_TO_TABLE           for GARLAND.UTSTOPIP              ;
create synonym   GARLAND.SYN_JOHN1              for GARLAND.TMP_JOHN              ;
create synonym   GARLAND.SYN_JOHN2              for GARLAND.UTSANFIT              ;
create synonym   GARLAND.TMP_TABLE_SYN          for GARLAND.SANI_PICKUP           ;
create synonym   GARLAND.SYN_USER_TABLE         for GARLAND.ADRSTREET             ;
create synonym   GARLAND.SYN_NMMAIN             for LEADS.NMMAIN                  ;
create synonym   GARLAND.SYN_PRMAIN             for LEADS.PRMAIN                  ;
create synonym   GARLAND.SYN_ADDRESS            for GARLAND.TRVEHRCL              ;
create synonym   GARLAND.TMP_ADDRESS_SYN        for GARLAND.TMP_SANI_ADDRESS      ;
create synonym   GARLAND.TMP_USER_TABLE_SYN     for GARLAND.TMP_INDUSTRY          ;
create synonym   GARLAND.SYN_UTWATPIP_NEXT      for GARLAND.UTWATPIP_REVISE_01    ;
create synonym   GARLAND.SYN_PREV_WATER         for GARLAND.UTSTOOCH_ORIGINAL     ;
create synonym   GARLAND.SYN_THIS_WATER         for GARLAND.UTSTOOCH              ;
create synonym   GARLAND.SYN_THAT_WATER         for GARLAND.UTSTOOCH_REVISE_01    ;
create synonym   GARLAND.SYN_USER_TABLE1        for GARLAND.TMP_JOHN              ;
create synonym   GARLAND.SYN_USER_TABLE2        for GARLAND.UTSTOINL              ;
create synonym   GARLAND.SYN_FROM_TABLE         for GARLAND.UTSTOPIP_REVISE_01    ;
create synonym   GARLAND.SYN_TO_TABLE           for GARLAND.UTSTOPIP              ;
create synonym   GARLAND.SYN_JOHN1              for GARLAND.TMP_JOHN              ;
create synonym   GARLAND.SYN_JOHN2              for GARLAND.UTSANFIT              ;
create synonym   GARLAND.TMP_TABLE_SYN          for GARLAND.SANI_PICKUP           ;
create synonym   GARLAND.SYN_USER_TABLE         for GARLAND.ADRSTREET             ;
create synonym   GARLAND.SYN_NMMAIN             for LEADS.NMMAIN                  ;
create synonym   GARLAND.SYN_PRMAIN             for LEADS.PRMAIN                  ;
create synonym   GARLAND.SYN_ADDRESS            for GARLAND.TRVEHRCL              ;
68 rows selected.
Parse             0.03 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.10 (Elapsed)     0.04 (CPU)
Total             0.13               0.04
Echo                            OFF
Echo                            ON
SQLWKS> 
SQLWKS> --	=========================================================================
SQLWKS> --	DROP ORIGINAL TABLE
SQLWKS> 
SQLWKS> 	@c:\deacutis\scripts\ora_create\SCRIPT_DROP.sql;
SQLWKS>                                                                      
SQLWKS> ---------------------------------------------------------------------
SQLWKS> 	drop table ADRSTREET;   --  cascade constraints                     
Statement processed.
Parse             0.32 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.32               0.00
SQLWKS> 	drop table PAVE_MAST;   --  cascade constraints                     
Statement processed.
Parse             0.42 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.42               0.00
SQLWKS> 	drop table SANI_COM_FL;   --  cascade constraints                   
Statement processed.
Parse             0.49 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.49               0.00
SQLWKS> 	drop table TST_JOHN;   --  cascade constraints                      
Statement processed.
Parse             0.16 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.16               0.00
SQLWKS> 
SQLWKS> --	@d:\scripts\ora_create\SCRIPT_DROP.sql;
SQLWKS> 
SQLWKS> --	=========================================================================
SQLWKS> --	RENAME TO ORIGINAL TABLE
SQLWKS> 
SQLWKS> 	@c:\deacutis\scripts\ora_create\SCRIPT_RENAME.sql;
SQLWKS>                                                                                                     
SQLWKS> ----------------------------------------------------------------------------------------------------
SQLWKS> 	rename NEW_ADRSTREET  to  ADRSTREET;                                                               
Statement processed.
Parse             0.01 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.01               0.00
SQLWKS> 	rename NEW_PAVE_MAST  to  PAVE_MAST;                                                               
Statement processed.
Parse             0.01 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.01               0.00
SQLWKS> 	rename NEW_SANI_COM_FL  to  SANI_COM_FL;                                                           
Statement processed.
Parse             0.00 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.00               0.00
SQLWKS> 	rename NEW_TST_JOHN  to  TST_JOHN;                                                                 
Statement processed.
Parse             0.01 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.01               0.00
SQLWKS> 
SQLWKS> --	@d:\scripts\ora_create\SCRIPT_RENAME.sql;
SQLWKS> 
SQLWKS> 
SQLWKS> 
SQLWKS> 	set echo off;
Echo                            OFF
                   
-------------------
ADRSTREET_X_COMPACT
1 row selected.
Parse             0.01 (Elapsed)     0.01 (CPU)
Execute/Fetch     0.01 (Elapsed)     0.01 (CPU)
Total             0.02               0.02
Statement processed.
Parse             0.15 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.15               0.00
                   
-------------------
ADRSTREET_X_PERMUTE
1 row selected.
Parse             0.00 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.01 (Elapsed)     0.00 (CPU)
Total             0.01               0.00
Statement processed.
Parse             0.15 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.15               0.00
                    
--------------------
ADRSTREET_X_COMPRESS
1 row selected.
Parse             0.01 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.01 (Elapsed)     0.00 (CPU)
Total             0.02               0.00
Statement processed.
Parse             0.14 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.14               0.00
                  
------------------
ADRSTREET_X_ENDING
1 row selected.
Parse             0.00 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.01 (Elapsed)     0.01 (CPU)
Total             0.01               0.01
Statement processed.
Parse             0.14 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.14               0.00
                     
---------------------
SANI_COM_FL_X_ACCOUNT
1 row selected.
Parse             0.01 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.01 (Elapsed)     0.00 (CPU)
Total             0.02               0.00
Statement processed.
Parse             0.14 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.14               0.00
                    
--------------------
SANI_COM_FL_X_NAMNUM
1 row selected.
Parse             0.01 (Elapsed)     0.01 (CPU)
Execute/Fetch     0.01 (Elapsed)     0.01 (CPU)
Total             0.02               0.02
Statement processed.
Parse             0.15 (Elapsed)     0.01 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.15               0.01
              
--------------
ADRSTREET_PKEY
1 row selected.
Parse             0.00 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.01 (Elapsed)     0.00 (CPU)
Total             0.01               0.00
Statement processed.
Parse             0.18 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.18               0.00
            
------------
PAVE_MAST_PK
1 row selected.
Parse             0.00 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.01 (Elapsed)     0.01 (CPU)
Total             0.01               0.01
Statement processed.
Parse             0.21 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.01 (Elapsed)     0.00 (CPU)
Total             0.22               0.00
                       
-----------------------
SANI_COM_FL_FKEY_PICKUP
1 row selected.
Parse             0.00 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.01 (Elapsed)     0.01 (CPU)
Total             0.01               0.01
Statement processed.
Parse             0.06 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.06               0.00
                  
------------------
TST_JOHN_FKEY_NAME
1 row selected.
Parse             0.00 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.01 (Elapsed)     0.01 (CPU)
Total             0.01               0.01
Statement processed.
Parse             0.02 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.01 (Elapsed)     0.00 (CPU)
Total             0.03               0.00
MGR-00073: Warning: TRIGGER GARLAND.TLOG$_TST_JOHN created with compilation errors.
Statement processed.
Parse             0.01 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.01               0.00
Echo                            ON
SQLWKS> 
SQLWKS> --	================================================================================
SQLWKS> --	ANALYZE TABLES
SQLWKS> 
SQLWKS> 	@c:\deacutis\scripts\ora_create\Script_Analyze.sql;
SQLWKS>                                                                                                  
SQLWKS> -------------------------------------------------------------------------------------------------
SQLWKS> analyze table GARLAND.ADRSTREET   compute statistics;                                            
Statement processed.
Parse             0.29 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.29               0.00
SQLWKS> analyze table GARLAND.PAVE_MAST   compute statistics;                                            
Statement processed.
Parse             0.76 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.76               0.00
SQLWKS> analyze table GARLAND.SANI_COM_FL   compute statistics;                                          
Statement processed.
Parse             0.38 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.38               0.00
SQLWKS> analyze table GARLAND.TST_JOHN   compute statistics;                                             
Statement processed.
Parse             0.01 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.01               0.00
SQLWKS> 
SQLWKS> --	@d:\scripts\ora_create\Script_Analyze.sql;
SQLWKS> 
SQLWKS> --	================================================================================
SQLWKS> 
SQLWKS> 
SQLWKS> 	
SQLWKS> 	
SQLWKS> 
SQLWKS> 
SQLWKS> 
SQLWKS> 	@c:\deacutis\scripts\ora_create\09_SUMMARY.sql;		--	display data dictionary info
SQLWKS> 	set echo off;
Echo                            OFF
OWNER        TABLE_NAME                     TABLESPACE          
------------ ------------------------------ --------------------
GARLAND      TST_JOHN                       GIS_DATA            
GARLAND      SANI_COM_FL                    GIS_DATA            
GARLAND      PAVE_MAST                      GIS_DATA            
GARLAND      ADRSTREET                      GIS_DATA            
4 rows selected.
Parse             0.04 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.02 (Elapsed)     0.00 (CPU)
Total             0.06               0.00
OWNER        INDEX_NAME                     TABLE_NAME                     TABLESPACE           UNIQUENES
------------ ------------------------------ ------------------------------ -------------------- ---------
GARLAND      ADRSTREET_X_PERMUTE            ADRSTREET                      GISINDX              NONUNIQUE
GARLAND      ADRSTREET_X_COMPACT            ADRSTREET                      GISINDX              NONUNIQUE
GARLAND      ADRSTREET_X_COMPRESS           ADRSTREET                      GISINDX              NONUNIQUE
GARLAND      ADRSTREET_X_ENDING             ADRSTREET                      GISINDX              NONUNIQUE
GARLAND      SANI_COM_FL_X_ACCOUNT          SANI_COM_FL                    GISINDX              NONUNIQUE
GARLAND      SANI_COM_FL_X_NAMNUM           SANI_COM_FL                    GISINDX              NONUNIQUE
GARLAND      ADRSTREET_PKEY                 ADRSTREET                      GISINDX              UNIQUE   
GARLAND      PAVE_MAST_PK                   PAVE_MAST                      GISINDX              UNIQUE   
8 rows selected.
Parse             0.05 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.02 (Elapsed)     0.00 (CPU)
Total             0.07               0.00
OWNER        CONSTRAINT_NAME                TABLE_NAME                     C PARENT_OWNER PARENT_CONSTRAINT             
------------ ------------------------------ ------------------------------ - ------------ ------------------------------
GARLAND      TST_JOHN_FKEY_NAME             TST_JOHN                       R GARLAND      ADRNAME_PKEY                  
GARLAND      SANI_COM_FL_FKEY_PICKUP        SANI_COM_FL                    R GARLAND      SANI_COM_PICKUP_PKEY          
GARLAND      PAVE_MAST_PK                   PAVE_MAST                      P                                            
GARLAND      ADRSTREET_PKEY                 ADRSTREET                      P                                            
4 rows selected.
Parse             0.04 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.02 (Elapsed)     0.01 (CPU)
Total             0.06               0.01
OWNER        TABLE_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      SANI_COM_FL                        286720          1     270336      32768 GIS_DATA            
GARLAND      TST_JOHN                          5386240          1    5369856    5369856 GIS_DATA            
GARLAND      PAVE_MAST                          983040          1     974848      32768 GIS_DATA            
GARLAND      ADRSTREET                          307200          1     303104      32768 GIS_DATA            
4 rows selected.
Parse             0.01 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.05 (Elapsed)     0.00 (CPU)
Total             0.06               0.00
OWNER        INDEX_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      ADRSTREET_PKEY                     184320          1     167936      32768 GISINDX             
GARLAND      ADRSTREET_X_COMPACT                143360          1     135168      32768 GISINDX             
GARLAND      ADRSTREET_X_COMPRESS               143360          1     135168      32768 GISINDX             
GARLAND      ADRSTREET_X_ENDING                 102400          1     102400      32768 GISINDX             
GARLAND      ADRSTREET_X_PERMUTE                143360          1     135168      32768 GISINDX             
GARLAND      PAVE_MAST_PK                       245760          1     237568      32768 GISINDX             
GARLAND      SANI_COM_FL_X_ACCOUNT             1126400          1    1110016      32768 GISINDX             
GARLAND      SANI_COM_FL_X_NAMNUM              1126400          1    1110016      32768 GISINDX             
8 rows selected.
Parse             0.06 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.04 (Elapsed)     0.00 (CPU)
Total             0.10               0.00
OWNER        CONSTRAINT_NAME                TABLE_NAME                     C PARENT_OWNER PARENT_CONSTRAINT             
------------ ------------------------------ ------------------------------ - ------------ ------------------------------
GARLAND      TST_JOHN_FKEY_NAME             TST_JOHN                       R GARLAND      ADRNAME_PKEY                  
GARLAND      SANI_COM_FL_FKEY_PICKUP        SANI_COM_FL                    R GARLAND      SANI_COM_PICKUP_PKEY          
2 rows selected.
Parse             0.04 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.03 (Elapsed)     0.01 (CPU)
Total             0.07               0.01
TABLE_NAME                     TRIGGER_NAME                   TRIGGER_TYPE    
------------------------------ ------------------------------ ----------------
TST_JOHN                       TLOG$_TST_JOHN                 AFTER EACH ROW  
1 row selected.
Parse             0.02 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.02 (Elapsed)     0.01 (CPU)
Total             0.04               0.01
TABLE_NAME                     PRIVILEGE                               
------------------------------ ----------------------------------------
0 rows selected.
Parse             0.06 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.01 (Elapsed)     0.00 (CPU)
Total             0.07               0.00
OBJECT NAME              OBJECT TYPE  LINE TEXT 1                                                                                               TEXT 2                                                                          
------------------------ ------------ ---- ---------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------
ADRRESOLVE_VIEW          VIEW            0 ORA-00942: table or view does not exist
                                                                                                                                             
ADR_RESOLVE_ADDRESS      PROCEDURE     384 PLS-00306: wrong number or types of arguments in call to 'TST_COMPARE_NAMES'                                                                                                         
ADR_RESOLVE_ADDRESS      PROCEDURE     384 PL/SQL: Statement ignored                                                                                                                                                            
CHANGES_CUSTOMER_ID      PROCEDURE       4 PLS-00201: identifier 'CUSTOMER' must be declared                                                                                                                                    
CHANGES_CUSTOMER_ID      PROCEDURE       4 PL/SQL: SQL Statement ignored                                                                                                                                                        
CHANGES_CUSTOMER_ID      PROCEDURE       6 PLS-00201: identifier 'CUSTOMER' must be declared                                                                                                                                    
CHANGES_CUSTOMER_ID      PROCEDURE       6 PL/SQL: SQL Statement ignored                                                                                                                                                        
DELETE_ROWS              PROCEDURE       4 PLS-00201: identifier 'CUSTOMER' must be declared                                                                                                                                    
DELETE_ROWS              PROCEDURE       4 PL/SQL: SQL Statement ignored                                                                                                                                                        
DT_ADDUSEROBJECT         FUNCTION        1 PLS-00201: identifier 'MICROSOFTDTPROPERTIES' must be declared                                                                                                                       
DT_ADDUSEROBJECT         FUNCTION        1 PL/SQL: SQL Statement ignored                                                                                                                                                        
DT_DROPUSEROBJECTBYID    PROCEDURE       1 PLS-00201: identifier 'MICROSOFTDTPROPERTIES' must be declared                                                                                                                       
DT_DROPUSEROBJECTBYID    PROCEDURE       1 PL/SQL: SQL Statement ignored                                                                                                                                                        
DT_SETPROPERTYBYID       PROCEDURE       1 PLS-00201: identifier 'MICROSOFTDTPROPERTIES' must be declared                                                                                                                       
DT_SETPROPERTYBYID       PROCEDURE       1 PL/SQL: SQL Statement ignored                                                                                                                                                        
DT_SETPROPERTYBYID       PROCEDURE       1 PLS-00201: identifier 'MICROSOFTDTPROPERTIES' must be declared                                                                                                                       
DT_SETPROPERTYBYID       PROCEDURE       1 PL/SQL: SQL Statement ignored                                                                                                                                                        
DT_SETPROPERTYBYID       PROCEDURE       1 PLS-00201: identifier 'MICROSOFTDTPROPERTIES' must be declared                                                                                                                       
DT_SETPROPERTYBYID       PROCEDURE       1 PL/SQL: SQL Statement ignored                                                                                                                                                        
TLOG$_TST_JOHN           TRIGGER         6 PLS-00201: identifier 'GARLAND.MLOG$_TST_JOHN' must be declared                                                                                                                      
TLOG$_TST_JOHN           TRIGGER         6 PL/SQL: SQL Statement ignored                                                                                                                                                        
TST_RESOLVE_ADDRESS      PROCEDURE     477 PLS-00306: wrong number or types of arguments in call to 'TST_COMPARE_NAMES'                                                                                                         
TST_RESOLVE_ADDRESS      PROCEDURE     477 PL/SQL: Statement ignored                                                                                                                                                            
23 rows selected.
Parse             0.02 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.05 (Elapsed)     0.04 (CPU)
Total             0.07               0.04
		where		trigger_name like TLOG$%';
                                *
ORA-00911: invalid character
		select *		
  *
ORA-01789: query block has incorrect number of result columns
		)	
  *
ORA-00900: invalid SQL statement
		and		key_ ' all'
            *
ORA-00920: invalid relational operator
		)	
  *
ORA-00900: invalid SQL statement
		select *		
         *
ORA-00997: illegal use of LONG datatype
		)	
  *
ORA-00900: invalid SQL statement
		)	
  *
ORA-00933: SQL command not properly ended
OWNER                          TRIGGER_NAME                   TRIGGER_TYPE     TRIGGERING_EVENT           TABLE_OWNER                    TABLE_NAME                     REFERENCING_NAMES                                                                       WHEN_CLAUSE                                                                                          STATUS   DESCRIPTION                                                                                          TRIGGER_BODY                                                                     KEY_                           TYPE_                          SCHEMA_                        PREFIX_                        SUFFIX_                        TABLESPACE_                    INITIAL_                       NEXT_                          PCTFREE_                       PCTUSED_                       MAXEXTENTS_                    MAXTRANS_                      OPTION1_                       OPTION2_                      
------------------------------ ------------------------------ ---------------- -------------------------- ------------------------------ ------------------------------ --------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------- -------- ---------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------- ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------
0 rows selected.
Parse             0.17 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.02 (Elapsed)     0.00 (CPU)
Total             0.19               0.00
OWNER                          TRIGGER_NAME                   TRIGGER_TYPE     TRIGGERING_EVENT           TABLE_OWNER                    TABLE_NAME                     REFERENCING_NAMES                                                                       WHEN_CLAUSE                                                                                          STATUS   DESCRIPTION                                                                                          TRIGGER_BODY                                                                     KEY_                           TYPE_                          SCHEMA_                        PREFIX_                        SUFFIX_                        TABLESPACE_                    INITIAL_                       NEXT_                          PCTFREE_                       PCTUSED_                       MAXEXTENTS_                    MAXTRANS_                      OPTION1_                       OPTION2_                      
------------------------------ ------------------------------ ---------------- -------------------------- ------------------------------ ------------------------------ --------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------- -------- ---------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------- ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------
GARLAND                        TLOG$_TST_JOHN                 AFTER EACH ROW   INSERT OR UPDATE OR DELETE GARLAND                        TST_JOHN                       REFERENCING NEW AS NEW OLD AS OLD                                                                                                                                                            ENABLED  GARLAND.TLOG$_TST_JOHN
AFTER 
INSERT
OR
DELETE
OR
UPDATE
on GARLAND.TST_JOHN
REFERENCING NEW AS NEW  declare    dmltype char;
 begin    if     inserting then dmltype := 'I';
   elsi TST_JOHN                       table                          GARLAND                        NEW_                                                          GIS_DATA                       5242K                          5242K                          10                             40                             121                            255                                                                                         
1 row selected.
Parse             0.18 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.02 (Elapsed)     0.01 (CPU)
Total             0.20               0.01
	drop 	synonym	tst_dea
               *
ORA-01434: private synonym to be dropped does not exist
	create synonym	tst_dea		fro tst_dea1
                         *
ORA-00905: missing keyword
	drop 	synonym	tst_dea
               *
ORA-01434: private synonym to be dropped does not exist
	create synonym	tst_dea		from tst_dea1
                         *
ORA-00905: missing keyword
	drop 	synonym	tst_dea
               *
ORA-01434: private synonym to be dropped does not exist
Statement processed.
Parse             0.01 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.01               0.00
Statement processed.
Parse             0.02 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.01 (Elapsed)     0.00 (CPU)
Total             0.03               0.00
Echo                            ON
SQLWKS> 
SQLWKS> 
SQLWKS> 	drop 	synonym	syn_dea;
	drop 	synonym	syn_dea
               *
ORA-01434: private synonym to be dropped does not exist
SQLWKS> 	create synonym	syn_dea		for syn_dea1;
Statement processed.
Parse             0.01 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.01               0.00
SQLWKS> 
SQLWKS> 
SQLWKS> 	drop 	synonym	syn_dea1;
	drop 	synonym	syn_dea1
               *
ORA-01434: private synonym to be dropped does not exist
SQLWKS> 	create synonym	syn_dea1		for adrname;
Statement processed.
Parse             0.00 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.00               0.00
SQLWKS> 
SQLWKS> 
SQLWKS> 
SQLWKS> 	
SQLWKS> 
SQLWKS> 	set echo on;
Echo                            ON
SQLWKS> 
SQLWKS> 
SQLWKS> 	drop 	synonym	syn_dea;
Statement processed.
Parse             0.01 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.01               0.00
SQLWKS> 	create synonym	syn_dea		for syn_dea1;
Statement processed.
Parse             0.00 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.00               0.00
SQLWKS> 
SQLWKS> 
SQLWKS> 	drop 	synonym	syn_dea1;
Statement processed.
Parse             0.01 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.01               0.00
SQLWKS> 	create synonym	syn_dea1		for adrname;
Statement processed.
Parse             0.01 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.01               0.00
SQLWKS> 
SQLWKS> 
SQLWKS> 
SQLWKS> 	
SQLWKS> 
SQLWKS> 	set timing 	off;
Timing                          OFF
SQLWKS> 	set echo 	on;
Echo                            ON
SQLWKS> 
SQLWKS> 
SQLWKS> 	drop 	synonym	syn_dea;
Statement processed.
SQLWKS> 	create synonym	syn_dea		for syn_dea1;
Statement processed.
SQLWKS> 
SQLWKS> 
SQLWKS> 	drop 	synonym	syn_dea1;
Statement processed.
SQLWKS> 	create synonym	syn_dea1		for adrname;
Statement processed.
SQLWKS> 
SQLWKS> 
SQLWKS> 
