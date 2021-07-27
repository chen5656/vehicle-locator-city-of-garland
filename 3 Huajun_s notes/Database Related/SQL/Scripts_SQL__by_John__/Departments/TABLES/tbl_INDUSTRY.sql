

	DROP TABLE		TMP_INDUSTRY;

	CREATE TABLE	TMP_INDUSTRY
	(
		RECORD_ID			NUMBER(06),
		PARCEL_ID			VARCHAR2(11),
		ADDRESS_ID			NUMBER(08),
		VERIFY_ID			NUMBER(02),

		BUSINESS			VARCHAR2(60),

		ADDR_NUM			NUMBER(06),
		ADDR_PFX			VARCHAR2(02),
		ADDR_NAME			VARCHAR2(40),
		ADDR_TYPE			VARCHAR2(04),
		ADDR_SFX			VARCHAR2(02),
		UNIT_TYPE			VARCHAR2(10),
		UNIT_NUM			VARCHAR2(20),

		ZIP_CODE			NUMBER,
		WATERSHED			VARCHAR2(03),
		PHONE				VARCHAR2(10),
		CONTACT			VARCHAR2(40),

		SIC1				NUMBER,
		SIC2				NUMBER,
		SIC3				NUMBER,

		CATEGORY			NUMBER,
		NPDESP			VARCHAR2(05),
		PERMIT			VARCHAR2(09),
		SARA_III			VARCHAR2(05),

		SWP3				VARCHAR2(05),
		SWP_INSP			DATE,
		SOURCE_INSP			DATE,

		NOV_ISS			DATE,
		NOV_MEMO			VARCHAR2(400),
		NOV_CORR			DATE,

		CIT_ISS			DATE,
		CIT_MEMO			VARCHAR2(400),

		WWM_DATA			VARCHAR2(40),
		WWM_MEMO			VARCHAR2(400),
		LETTER			VARCHAR2(05),

		NOT_FLAG			VARCHAR2(05),
		NOT_DATA			VARCHAR2(40),
		NOI				VARCHAR2(05),

		CITY				VARCHAR2(20),
		STATE				VARCHAR2(02),

		LAT				NUMBER,
		LON				NUMBER,

		WORK_AREA			VARCHAR2(80)
	)

		STORAGE 			(INITIAL 64K)
	;
