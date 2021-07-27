
--	CREATE EXECUTION PLAN TABLE

--	C:ORANT\SCRIPTS\PLANS\TABLE.sql

--	04-14-98



DROP TABLE		PLAN_TABLE;

CREATE TABLE	PLAN_TABLE	
	(
	STATEMENT_ID	VARCHAR2(30),
	TIMESTAMP		DATE,
	REMARKS		VARCHAR2(80),
	OPERATION		VARCHAR2(30),
	OPTIONS		VARCHAR2(30),
	OBJECT_NODE		VARCHAR2(128),
	OBJECT_OWNER	VARCHAR2(30),
	OBJECT_NAME		VARCHAR2(30),
	OBJECT_INSTANCE	NUMERIC,
	OBJECT_TYPE		VARCHAR2(30),
	OPTIMIZER		VARCHAR2(255),
	SEARCH_COLUMNS	NUMERIC,
	ID			NUMERIC,
	PARENT_ID		NUMERIC,
	POSITION		NUMERIC,
	OTHER			LONG
	)
;
COMMIT;

