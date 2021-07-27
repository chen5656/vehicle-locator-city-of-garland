
 	CREATE OR REPLACE TRIGGER 	TST_JOHN_TRIG3	
      	BEFORE 	UPDATE  OR INSERT 
      	ON 		TST_JOHN1 	
      	FOR EACH ROW
      
      	DECLARE
      
      		INVALID_COMPACT	EXCEPTION;
      
     	BEGIN
     
     		IF	:NEW.ADDR_COMPACT = 'OBOY'		THEN
     			RAISE INVALID_COMPACT;
     		END IF;
     
     
     	EXCEPTION
     
     		WHEN	INVALID_COMPACT	THEN
     			RAISE_APPLICATION_ERROR (-20000, 'INVALID OBOY ' || :NEW.ADDR_COMPACT);	
     	END;


--	================================================================================================


DECLARE

	BAD_DEAL	EXCEPTION;

	PRAGMA	EXCEPTION_INIT ( BAD_DEAL, -20000);

BEGIN

	UPDATE 	TST_JOHN1
	SET		ADDR_COMPACT = 'OBOY'
	WHERE		ADDR_NAME =  'ABBEY';

EXCEPTION

	WHEN	BAD_DEAL		THEN

		UPDATE	TST_JOHN1
		SET		ADDR_ENDING = 'OGIRL'
		WHERE		ADDR_NAME = 'ABBEY';

END;


--	==============================================================


DECLARE

	BAD_DEAL	EXCEPTION;

	PRAGMA	EXCEPTION_INIT ( BAD_DEAL, -20000);

BEGIN


	RAISE BAD_DEAL;


EXCEPTION

	WHEN	BAD_DEAL		THEN
		RAISE BAD_DEAL;


END;


--	==============================================================

