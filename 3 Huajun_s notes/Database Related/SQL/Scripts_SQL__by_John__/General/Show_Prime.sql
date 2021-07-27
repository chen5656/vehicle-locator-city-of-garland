
--	DISPLAY PRIME NUMBER LIST

	set echo		off;
	set timing		on;
	set serveroutput	on;
	

DECLARE

	prime_size			number	:= 1400;		--	number of primes to calculate

	show_start			number	:= 06000;
	show_stop			number	:= 10200;

--	=====================================================================

	TYPE	PRIME_NUM_TABTYPE	IS
		TABLE OF		NUMBER
		INDEX BY		BINARY_INTEGER;

	PRIME_NUM			PRIME_NUM_TABTYPE;

	TABLE_SIZE			NUMBER	:= 01;

	TEST_NUM			NUMBER	:= 02;

	show_num			number;

	PRIME_MATCH			CHAR		:= ' ';

--	=====================================================================

BEGIN

	PRIME_NUM (TABLE_SIZE)	:= TEST_NUM;

	WHILE TABLE_SIZE < PRIME_SIZE					LOOP	

		TEST_NUM	:=  TEST_NUM + 01;

		EXIT WHEN	TEST_NUM > 999999;					--	loop safety

		PRIME_MATCH	:= 'N';
		FOR	X	IN 01..TABLE_SIZE				LOOP
			IF	MOD ( TEST_NUM, PRIME_NUM(X) ) = 0	THEN		
				PRIME_MATCH := 'Y';
			END IF;
		END LOOP;

		IF	PRIME_MATCH = 'N'					THEN
			TABLE_SIZE 			:= TABLE_SIZE + 01;
			PRIME_NUM (TABLE_SIZE) 	:= TEST_NUM;
		END IF;

	END LOOP;


	FOR	P	IN 01..PRIME_SIZE					LOOP

		show_num := prime_num (p);
		if	show_num 	between show_start and show_stop		then
			DBMS_OUTPUT.PUT_LINE (show_num);
		end if;

	END LOOP;

	dbms_output.put_line ( 'max number tested: ' || test_num );

END;
