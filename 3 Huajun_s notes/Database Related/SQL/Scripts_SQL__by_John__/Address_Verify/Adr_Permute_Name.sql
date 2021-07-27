
--	C:\ORANT\SCRIPTS\VERIFY\ADR_PERMUTE_NAME.sql

--	DISPLAY PRIME NUMBER LIST USING:	 /SCRIPTS/ADRSHOW/SHOW_PRIME.sql

--	=========================================================
--	PRIME NUMBER LIST
--	EXCEPTION - OVERFLOW
--	=========================================================


CREATE OR REPLACE FUNCTION	garland.ADR_PERMUTE_NAME

	(	USER_NAME		IN 	VARCHAR2,		--  STREET NAME	

		COMPRESS_LEVEL	IN	VARCHAR2	)

		RETURN		NUMBER		--  PERMUTE CODE			

AS
		COMPRESS_NAME	VARCHAR2(80);

		MAX_LENG		NUMBER(04)		:= 20;

		COMPRESS_LENG	NUMBER(04)		:= 01;
		FACTOR		NUMBER(04)		:= 01;
		PERMUTE_LENG	NUMBER(04)		:= 01;
		PERMUTE_CODE	NUMBER		:= 01;

BEGIN

		COMPRESS_NAME := GARLAND.ADR_COMPRESS_NAME (USER_NAME, COMPRESS_LEVEL);

		COMPRESS_LENG := LENGTH (COMPRESS_NAME);

		IF	COMPRESS_LENG > MAX_LENG						THEN
			COMPRESS_NAME := ADR_COMPRESS_NAME (USER_NAME, '9');
			COMPRESS_LENG := LENGTH (COMPRESS_NAME);
		END IF;

		PERMUTE_LENG  := LEAST (COMPRESS_LENG, MAX_LENG);

		FOR	X  IN   01..PERMUTE_LENG
		LOOP

			SELECT DECODE (SUBSTR (COMPRESS_NAME, X, 01),

				'E',		02,
				'N',		03,
				'T',		05,
				'L',		07,
				'A',		11,
				'D',		13,
				'R',		17,
				'I',		19,
				'O',		23,
				'S',		29,
				'G',		31,
				'K',		37,
				'H',		41,
				'C',		43,
				'B',		47,
				'M',		53,
				'V',		59,
				'P',		61,
				'U',		67,
				'F',		71,
				'W',		73,
				'Y',		79,
				'Z',		83,
				'Q',		89,
				'J',		97,
				'X',		101,

				'0',		103,
				'3',		107,
				'6',		109,

				'1',		113,
				'2',		127,
				'4',		131,
				'5',		137,
				'7',		139,
				'8',		149,
				'9',		151,

				01)	

			INTO 	FACTOR
			FROM	 DUAL;
			

			PERMUTE_CODE :=  PERMUTE_CODE * FACTOR;

		END LOOP;


		RETURN	PERMUTE_CODE;


END	ADR_PERMUTE_NAME;
