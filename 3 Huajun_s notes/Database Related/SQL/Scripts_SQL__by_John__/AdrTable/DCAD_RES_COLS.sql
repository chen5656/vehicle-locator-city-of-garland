
--	DCAD RESIDENTIAL TAX TABLE


CREATE TABLE	NSA_DCAD_RES
(
	PARCEL_ID		VARCHAR2(11);
	SUBDIV_ID		VARCHAR2(05);
	NSA_ID		VARCHAR2(05),

	PARCEL_		VARCHAR2(11),
--	PARCEL_ID		VARCHAR2(11),
	ACCT			VARCHAR2(17),
--	RECACS		VARCHAR2(-10),
	NBHD			VARCHAR2(6),
	OLD_RGN		VARCHAR2(-2),
	NBHD_CODE		VARCHAR2(3),
	PROP_CLASS		VARCHAR2(-4),
	BLDG_CLASS		VARCHAR2(-4),
	SUB_CLASS1		VARCHAR2(1),	
	SUB_CLASS2		VARCHAR2(1),
	DEED_X_DT		VARCHAR2(d),
	DEED_CG_DT		VARCHAR2(d),
	DEED_CHGCD		VARCHAR2(1),	
	STR_CTY_CD		VARCHAR2(2),
--	STR_HALF		VARCHAR2(5),
--	NEW_CNDO		VARCHAR2(5),
	LGL1_DESC		VARCHAR2(33),
	LGL2_DESC		VARCHAR2(33),
	LGL3_DESC		VARCHAR2(33),
	LGL4_DESC		VARCHAR2(33),
	LGL5_DESC		VARCHAR2(33),
	JNL_ENTRY		VARCHAR2(-4),
	MAPSCO_CDS		VARCHAR2(5),
	CNTY			VARCHAR2(2),
	CITY			VARCHAR2(2),
	HOSP			VARCHAR2(2),
	COLG			VARCHAR2(2),
	ISD			VARCHAR2(2),
--	SPCL			VARCHAR2(2),
	TAX_REP		VARCHAR2(3),
--	PRV1_MRKT		VARCHAR2(-11),
	MKT_VALUE		VARCHAR2(-11),
--	CAP_HMSTD		VARCHAR2(-9),
	IMPV_VALUE		VARCHAR2(-9),
	APPSR_DATE		VARCHAR2(d),
--	APPSR_INTL		VARCHAR2(3),

	LNDAREA1FL		VARCHAR2(1),
	LAND_AREA1		VARCHAR2(-8),
	FRONTAGE1		VARCHAR2(-8),
	LAND_DPTH1		VARCHAR2(-8),
	LAND1PRCFL		VARCHAR2(1),
	LAND1____		VARCHAR2(-11),
--	LND_2_FLAG		VARCHAR2(1),
--	LAND_AREA2		VARCHAR2(-8),	
--	FRONTAGE2		VARCHAR2(-8),
--	LAND_DPTH2		VARCHAR2(-8),
--	LAND2PRCFL		VARCHAR2(1),
--	LAND2____		VARCHAR2(-11),
--	LND_3_FLAG		VARCHAR2(1),
--	LAND_AREA3		VARCHAR2(-8),
--	FRONTAGE3		VARCHAR2(-8),
--	LAND_DPTH3		VARCHAR2(-8),
--	LAND3PRCFL		VARCHAR2(1),
--	LAND3_PRIC		VARCHAR2(-11),
--	LND_4_FLAG		VARCHAR2(1),
--	LAND_AREA4		VARCHAR2(-8),
--	FRONTAGE4		VARCHAR2(-8),
--	LAND_DPTH4		VARCHAR2(-8),
--	LAND4PRCFL		VARCHAR2(1),
--	LAND4_PRIC		VARCHAR2(-11),

--	PCT_ADJ_FL		VARCHAR2(1),
--	PCNT_ADJSM		VARCHAR2(-4),
--	LAND_DESCR		VARCHAR2(1),
	ALPS_ADJ_1		VARCHAR2(-9),
--	ALPS_ADJ_2		VARCHAR2(-9),
--	ALPS_ADJ_3		VARCHAR2(-9),
--	ALPS_ADJ_4		VARCHAR2(-9),
	LIVING_AR		VARCHAR2(-8),
	LIVNG_UNIT		VARCHAR2(-2),
	YEAR_BUILT		VARCHAR2(-5),
--	BLD_PRC_FL		VARCHAR2(1),
	BLDG_PRICE		VARCHAR2(-9),
	BLDG_DEPRE		VARCHAR2(-4),
--	CONST_MATL		VARCHAR2(2),
	FRAME_WORK		VARCHAR2(2),
	FOUNDATION		VARCHAR2(2),
	BASEMENT		VARCHAR2(2),
	EXT_WALL_1		VARCHAR2(2),
	EXT_WALL_2		VARCHAR2(2),
	ROOF_TYPE		VARCHAR2(2),
	ROOF_COMP		VARCHAR2(2),
	FULL_BATHS		VARCHAR2(-4),
	HALF_BATHS		VARCHAR2(-4),
	NUM_OF_KIT		VARCHAR2(-2),
	AC_TYPE		VARCHAR2(2),	
	HEAT			VARCHAR2(2),
--	EST_RPO_CS		VARCHAR2(-6),
--	SV_QTR_AR		VARCHAR2(-6),
--	SV_QTR_DPR		VARCHAR2(-4),
--	SV_QTR_UPR		VARCHAR2(-6),
--	SV_QTR_PRC		VARCHAR2(-8),
	SV_QTR_AGE		VARCHAR2(-2),
--	SV_QTR_CNS		VARCHAR2(2),
	FIREPLACE		VARCHAR2(-4),
--	WET_BAR		VARCHAR2(-4),
--	SAUNA_PRIC		VARCHAR2(-6),
	POOL_PRICE		VARCHAR2(-6),
--	POOL_SHAPE		VARCHAR2(2),
--	POOL_CONST		VARCHAR2(2),
	NB_CST_FAC		VARCHAR2(-4),
	EF_AG_NCRN		VARCHAR2(-4),
--	PANEL_DATE		VARCHAR2(d),
--	PANEL_AMT		VARCHAR2(-11),
	RENDITION		VARCHAR2(2),
	RENDRD_AMT		VARCHAR2(-11),
	PV_CNTRB__		VARCHAR2(-9),
	APROCH_FIN		VARCHAR2(1),
	LAST_OPER		VARCHAR2(3),
	LST_UPD_DT		VARCHAR2(d),
--	ALP_PCT_N1		VARCHAR2(-6),
--	ALP_SPTB_2		VARCHAR2(3),
--	FREZCODE		VARCHAR2(1),
--	DEED_DT_FR		VARCHAR2(1),
	ARB_FLAG		VARCHAR2(1),

	CRNT_PMTCD		VARCHAR2(1),
	CRNT_PMTDT		VARCHAR2(d),	
	CRNT_PMTVL		VARCHAR2(-9),
	CRNT_APSR		VARCHAR2(3),
	PREV_PMTCD		VARCHAR2(1),
	PREV_PMTDT		VARCHAR2(d),
	PREV_PMTVL		VARCHAR2(-9),
	PREV_APSR		VARCHAR2(3),
	PRV2_PMTCD		VARCHAR2(1),
	PRV2_PMTDT		VARCHAR2(d),
	PRV2_PMTVL		VARCHAR2(-9),
	PRV2_APSR		VARCHAR2(3),

	CRNT_SALPR		VARCHAR2(-9),
	CRNT_SALDT		VARCHAR2(d),
	PREV_SALPR		VARCHAR2(-9),
	PREV_SALDT		VARCHAR2(d),
	ALPS_AJ_1		VARCHAR2(-3),
--	ALPS_AJ_2		VARCHAR2(-3),
--	ALPS_AJ_3		VARCHAR2(-3),
--	ALPS_AJ_4		VARCHAR2(-3),
--	ALPS_SECZN		VARCHAR2(6),
	ALPS_SPTB		VARCHAR2(3),
	GARAGE_PRT		VARCHAR2(1),
	GARGE1_AR		VARCHAR2(-6),
	GARGE1_DEP		VARCHAR2(-4),
	GARGE1_PRF		VARCHAR2(1),
	GARGE1_PRC		VARCHAR2(-6),
	GARGE1_LOC		VARCHAR2(2),
	GARGE1_MTL		VARCHAR2(2),
	GARGE1_FLR		VARCHAR2(2),
	GARGE_PRT2		VARCHAR2(1),
	GARGE2_AR		VARCHAR2(-6),
	GARGE2_DPR		VARCHAR2(-4),
	GARGE2_PRF		VARCHAR2(1),
	GARGE2_PRC		VARCHAR2(-6),
	GARGE2_LOC		VARCHAR2(2),
	GARGE2_MTL		VARCHAR2(2),
	GARGE2_FLR		VARCHAR2(2),
--	GARGE1_PSF		VARCHAR2(-6),
--	GARGE2_PSF		VARCHAR2(-6),
--	GARGE3_PSF		VARCHAR2(-6),

--	ACCES1_BLD		VARCHAR2(1),
	AC_BLD1_DS		VARCHAR2(25),
	AC_BLD1_MN		VARCHAR2(-6),
	AC_BLD1_UP		VARCHAR2(-6),
	AC_BLD1_FP		VARCHAR2(-6),
	AC_BLD1_PC		VARCHAR2(-6),
	AC_BLD1_DP		VARCHAR2(-4),
	ACCES2_BLD		VARCHAR2(1),
	AC_BLD2_DS		VARCHAR2(25),
--	AC_BLD2_MN		VARCHAR2(-6),
--	AC_BLD2_UP		VARCHAR2(-6),
--	AC_BLD2_FP		VARCHAR2(-6),
--	AC_BLD2_PC		VARCHAR2(-6),
--	AC_BLD2_DP		VARCHAR2(-4),
--	ACCES3_BLD		VARCHAR2(1),
--	AC_BLD3_DS		VARCHAR2(25),
--	AC_BLD3_MN		VARCHAR2(-6),
--	AC_BLD3_UP		VARCHAR2(-6),
--	AC_BLD3_FP		VARCHAR2(-6),
--	AC_BLD3_PC		VARCHAR2(-6),
--	AC_BLD3_DP		VARCHAR2(-4),

	CUR_SL_TYP		VARCHAR2(1),
	DISABL_EX1		VARCHAR2(1),	
	HMSTD_EX_1		VARCHAR2(1),
	OVR_65_EX1		VARCHAR2(1),
--	DISABL_EX2		VARCHAR2(1),
--	HMSTD_EX_2		VARCHAR2(1),
--	OVR_65_EX2		VARCHAR2(1),
--	DISABL_EX3		VARCHAR2(1),
--	HMSTD_EX_3		VARCHAR2(1),	
--	OVR_65_EX3		VARCHAR2(1),
--	TOTALLY_EX		VARCHAR2(1),
--	TOTL_EX_CD		VARCHAR2(2),

--	DA_VET1__1		VARCHAR2(-3),
--	DA_VET2__1		VARCHAR2(-3),
--	FLT_RTE1_1		VARCHAR2(-5),
--	FLT_RTE2_1		VARCHAR2(-5),
--	DA_VET1__2		VARCHAR2(-3),
--	DA_VET2__2		VARCHAR2(-3),
--	FLT_RTE1_2		VARCHAR2(-5),
--	FLT_RTE2_2		VARCHAR2(-5),
--	DA_VET1__3		VARCHAR2(-3),
--	DA_VET2__3		VARCHAR2(-3),
--	FLT_RTE1_3		VARCHAR2(-5),
--	FLT_RTE2_3		VARCHAR2(-5),

	WATER_CD		VARCHAR2(2),
	WASTE_CD		VARCHAR2(2),
	APR_CLKNAM		VARCHAR2(17),
	DCAD_EMPLY		VARCHAR2(1),
	CONTRB_VAL		VARCHAR2(-11),
	AG_INDCATR		VARCHAR2(1),

	CNTY_SPLIT		VARCHAR2(-3),
	CITY_SPLIT		VARCHAR2(-3),
	ISD_SPLIT		VARCHAR2(-3),
	HOSP_SPLIT		VARCHAR2(-3),
	COLL_SPLIT		VARCHAR2(-3),
	SPEC_SPLIT		VARCHAR2(-3),

	TAXP_ADDR1		VARCHAR2(25),
	TAXP_ADDR2		VARCHAR2(25),
	TAXP_ADDR3		VARCHAR2(25),
	TAXP_CITY		VARCHAR2(23),
	TAXP_STATE		VARCHAR2(2),
	TAXP_ZIPCD		VARCHAR2(9),

	TXCEL_AMT1		VARCHAR2(-10),
	TXCEL_DTE1		VARCHAR2(-9),
--	TXCEL_AMT2		VARCHAR2(-10),
--	TXCEL_DTE2		VARCHAR2(-9),
--	TXCEL_AMT3		VARCHAR2(-10),	
--	TXCEL_DTE3		VARCHAR2(-9),

	CAP_HMSTD1		VARCHAR2(-10),
	DEFER_CAP1		VARCHAR2(-10),
--	CAP_HMSTD2		VARCHAR2(-10),
--	DEFER_CAP2		VARCHAR2(-10),
--	CAP_HMSTD3		VARCHAR2(-10),
--	DEFER_CAP3		VARCHAR2(-10),

--	CAP_DIFF		VARCHAR2(-8),
	REVAL_YEAR		VARCHAR2(-5),
	PV_RVAL_YR		VARCHAR2(-5),

--	PRATA_FLG1		VARCHAR2(2),
--	PRATA_NME1		VARCHAR2(15),
--	PRATA_DYS1		VARCHAR2(-4),
--	PRATA_EFF1		VARCHAR2(-9),
--	PRATA_RMV1		VARCHAR2(-9),
--	PRATA_FLG2		VARCHAR2(2),
--	PRATA_NME2		VARCHAR2(15),	
--	PRATA_DYS2		VARCHAR2(-4),
--	PRATA_EFF2		VARCHAR2(-9),
--	PRATA_RMV2		VARCHAR2(-9),
--	PRATA_FLG3		VARCHAR2(2),
--	PRATA_NME3		VARCHAR2(15),
--	PRATA_DYS3		VARCHAR2(-4),
--	PRATA_EFF3		VARCHAR2(-9),
--	PRATA_RMV3		VARCHAR2(-9),

	CITY_ACCT_		VARCHAR2(25),
	CNTY_ACCT_		VARCHAR2(17),
	GIS_ACCT_		VARCHAR2(17),	

	STREET_NAM		VARCHAR2(23),
	STREET_TYP		VARCHAR2(4),
	STREET_DIR		VARCHAR2(2),
	STREET_NUM		NUMBER(20),
	STREET_SFX		VARCHAR2(50)

	VERIFY_ID		NUMBER(04),
)
	
	STORAGE  ( INITIAL 10M  NEXT 10M  PCTINCREASE 0 )
;