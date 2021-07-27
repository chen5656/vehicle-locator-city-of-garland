
--	ASSIGN PARCEL_ID'S TO A USER TABLE BY MATCHING AGAINST CDRELADR

--	=======================================================================

--	Execute	deacutis \ scripts \ scrubber \ fix_user_addr.sql

--	Define  Index on User Addr_Name (optional)
--	Correct Street Qualifiers in CDRELADR
--	Specify JOB_ASSIGN_PARCEL_VIEW table & columns
--	Execute Update Script

--	=======================================================================


	CREATE OR REPLACE	 VIEW		JOB_ASSIGN_PARCEL_VIEW		
	(
		addr_name,
		addr_type,
		addr_pfx,
		addr_sfx,
		addr_num,
		parcel_id,
		user_rowid
	)

--	Specify actual user table and column names (in CAPS) below
	AS SELECT
			ADDR_NAME,
			ADDR_TYPE,
			ADDR_PFX,
			ADDR_SFX,
			ADDR_NUM,
			PARCEL_ID,

			rowid			"USER_ROWID"

	FROM		NSA_TAX_ALIAS
	;


--	=======================================================================

DECLARE

	do_compile_only		BOOLEAN	:= FALSE;	--  compile but do not execute
	do_all_parcels		BOOLEAN	:= TRUE;	--  re-assign existing parcel ids

	start_name			VARCHAR2(9)	:= ' ';	--  starting address name
	batch_size			NUMBER	:= 999999;	--  total user table reads

	commit_count		NUMBER	:= 100;	--  updates per commit

	update_count		NUMBER	:= 0;

	this_parcel_id		VARCHAR2(16);


CURSOR  Read_User_Address	IS

	SELECT	*
	FROM		JOB_ASSIGN_PARCEL_VIEW

	WHERE		addr_name 	>= start_name
	AND		ROWNUM 	<  batch_size + 01

	AND		parcel_id is null
	;


BEGIN

	if	do_compile_only			then
		return;
	end if;		


FOR	LOOK IN	Read_User_Address		LOOP


BEGIN

	SELECT	distinct parcel_id
	INTO		this_parcel_id

	FROM		CDRELADR

	WHERE		UPPER ( NVL (ADDR_STATUS, ' ')) <> 'D'

	AND		addr_name	= NVL (RTRIM (look.addr_name), ' ')
	AND		addr_type	= NVL (RTRIM (look.addr_type), ' ')
	AND		addr_pfx	= NVL (RTRIM (look.addr_pfx),  ' ')
	AND		addr_sfx	= NVL (RTRIM (look.addr_sfx),  ' ')
	AND		addr_num	= NVL (look.addr_num, 0)

--	AND		addr_name	= look.addr_name, 
--	AND		addr_type	= look.addr_type, 
--	AND		addr_pfx	= look.addr_pfx,  
--	AND		addr_sfx	= look.addr_sfx,  
--	AND		addr_num	= look.addr_num
	;

	if	LENGTH (this_parcel_id) = 11
	and	this_parcel_id > '0'			then

		UPDATE	JOB_ASSIGN_PARCEL_VIEW
		SET		parcel_id = this_parcel_id
		WHERE		rowid = look.user_rowid;

		update_count := update_count + 01;
		if	update_count > commit_count	then
			commit;
			update_count := 0;
		end if;

	end if;


EXCEPTION

	WHEN OTHERS		THEN NULL;

--	WHEN OTHERS		THEN RAISE;
	
END;

END LOOP;


	COMMIT;

END;


