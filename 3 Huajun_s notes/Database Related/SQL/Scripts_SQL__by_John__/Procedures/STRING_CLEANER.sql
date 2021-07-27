
--	same as adr_String_Cleaner except extra spaces & whitespace controls are allowed 

CREATE OR REPLACE	FUNCTION	STRING_CLEANER (OLD_TEXT  VARCHAR2)
					
					RETURN	VARCHAR2
AS	

	VALID_BYTES		VARCHAR2(100);
	NEW_TEXT		VARCHAR2(2000);

	WORK_BYTE		CHAR(01);
	PREV_BYTE		CHAR(01);

BEGIN

	VALID_BYTES	:=	'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz 0123456789'	||
				'''",.;:?!@#$%&*-_=+()/\[]{}<>|^`~'	|| chr(10) || chr(13) || chr(09);

	NEW_TEXT		:= ' ';
	WORK_BYTE		:= ' ';
	PREV_BYTE		:= ' ';

	FOR	X	IN	01..LENGTH (OLD_TEXT)
	LOOP

		WORK_BYTE	:= SUBSTR (OLD_TEXT, X, 01);

		IF	INSTR (VALID_BYTES, WORK_BYTE) = 0		THEN
			WORK_BYTE := ' ';
		END IF;

--		IF	WORK_BYTE	= ' '		
--		OR	PREV_BYTE	= ' '				THEN
			NEW_TEXT := NEW_TEXT || WORK_BYTE;
--		END IF;

		PREV_BYTE := WORK_BYTE;

	END LOOP;

	RETURN	LTRIM (RTRIM (NEW_TEXT));


END	STRING_CLEANER;

