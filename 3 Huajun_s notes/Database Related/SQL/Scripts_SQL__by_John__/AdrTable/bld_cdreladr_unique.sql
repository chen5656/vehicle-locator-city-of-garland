
/*
	DROP TABLE		TMP_CDRELADR_DISTINCT;


	CREATE TABLE	TMP_CDRELADR_DISTINCT
	AS

	SELECT	MAX (ROWID)		ROW_ID

	FROM		CDRELADR

	WHERE		NVL (LOWER (ADDR_STATUS), ' ') <> 'd'
--	AND		NVL (UNIT_TYPE, ' ') = ' '
--	AND		NVL (UNIT_NUM,  ' ') - ' '

	GROUP BY	ADDR_NAME,
			ADDR_TYPE,
			ADDR_PFX,
			ADDR_SFX,
			ADDR_NUM
	;

*/


/*
	DROP TABLE		TMP_CDRELADR_NAM_NUM;


	CREATE TABLE	TMP_CDRELADR_NAM_NUM		
	AS

	SELECT
			A.ADDR_NAME,
			A.ADDR_NUM

	FROM		CDRELADR			A,
			TMP_CDRELADR_DISTINCT	X

	WHERE		A.ROWID = X.ROW_ID

	GROUP BY	A.ADDR_NAME,
			A.ADDR_NUM
	HAVING	COUNT(*) = 1
	;

*/


--	CREATE INDEX	CDRELADR_X_DISTINCT
--	ON 			TMP_CDRELADR_DISTINCT
--				(ROW_ID)
--	tablespace	gisindx
--	storage		(initial 1m  next 1m  pctincrease 0);	





/*
--	NEED PLSQL LOOP ROUTINE

	UPDATE	CDRELTAX			T

	SET		T.PARCEL_ID = 
	(
		SELECT	A.PARCEL_ID		

		FROM		CDRELADR			A,
				TMP_CDRELADR_DISTINCT	X

		WHERE		A.ADDR_NAME = T.ADDR_NAME
		AND		A.ADDR_TYPE = T.ADDR_TYPE
		AND		A.ADDR_PFX  = T.ADDR_PFX
		AND		A.ADDR_SFX  = T.ADDR_SFX
		AND		A.ADDR_NUM  = T.ADDR_NUM

		AND		A.ROWID	= X.ROW_ID
	);
*/	
	


--	SELECT	COUNT(*)
--	FROM		TMP_CDRELADR_DISTINCT;

