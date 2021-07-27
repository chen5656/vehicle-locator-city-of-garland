
--	FORMAT SUBDIVISION INTO SEPARATE STANDARD COMPONENTS

--	=============================================================================================
--	MAINTENANCE

--		REMOVE INITIALS PER PATTERN ' X ' FROM FRONT AND BACK OF NAME1 
--		AND PUT INTO DESC_INTLS
--		NAME1 = NAME1 || NAME_LAST

--	=============================================================================================


DECLARE

	ORIG_NAME		VARCHAR2(80)	:= ' ';
	DESC_NAME		VARCHAR2(80)	:= ' ';
	DESC_NUMB		VARCHAR2(80)	:= ' ';
	DESC_SECT		VARCHAR2(80)	:= ' ';
	DESC_INST		VARCHAR2(80)	:= ' ';
	DESC_PHASE		VARCHAR2(80)	:= ' ';
	DESC_REPLAT		VARCHAR2(80)	:= ' ';
	FLAG_EST		CHAR			:= ' ';
	FLAG_ADDN		CHAR			:= ' ';
	FLAG_SUBD		CHAR			:= ' ';
	FLAG_REPLAT		CHAR			:= ' ';

--	============================================================

	POSN_LAST		NUMBER		:= 999;	

	ID_EST		NUMBER(3,2)		:= 0.01;
	ID_ADDN		NUMBER(3,2)		:= 0.02;
	ID_SUBD		NUMBER(3,2)		:= 0.03;
	ID_NAME_HI		NUMBER(3,2)		:= 0.09;	

	ID_NTH		NUMBER(3,2)		:= 0.10;
	ID_NUMB		NUMBER(3,2)		:= 0.21;
	ID_SECT		NUMBER(3,2)		:= 0.22;
	ID_INST		NUMBER(3,2)		:= 0.23;
	ID_PHASE		NUMBER(3,2)		:= 0.24;
	ID_REPLAT		NUMBER(3,2)		:= 0.30;

--	============================================================

	WORK_NAME		VARCHAR2(80);

	POSN_NEXT		NUMBER;
	POSN_NAME_HI	NUMBER;

	POSN_NTH		NUMBER;	
	POSN_EST		NUMBER;	
	POSN_ADDN		NUMBER;	
	POSN_SUBD		NUMBER;	
	POSN_NUM		NUMBER;	
	POSN_SECT		NUMBER;	
	POSN_INST		NUMBER;	
	POSN_PHASE		NUMBER;	
	POSN_REPLAT		NUMBER;	

	THIS_NTH		NUMBER;

	THIS_ID		NUMBER;
	THIS_START		NUMBER;	
	THIS_STOP		NUMBER;	
	THIS_ITEM		VARCHAR2(80);	

	THAT_ID		NUMBER;
	THAT_START		NUMBER;	
	THAT_STOP		NUMBER;	
	THAT_ITEM		VARCHAR2(80);	

	BURN_THIS		NUMBER	:= 1;
	BURN_THAT		NUMBER	:= 0;



BEGIN

--	=============================================================================================

	WORK_NAME	:= 	REPLACE (WORK_NAME, '#', ' # ');	
	WORK_NAME	:=	TRANSLATE (WORK_NAME,	'X,./<>?;:[]{}`~!@$%^&*()-_=+\|"''',	'X');

	WORK_NAME	:= ' ' || ADR_STRING_CLEANER (ORIG_NAME) || ' ';

	WORK_NAME	:=	REPLACE (WORK_NAME,	'ESTATE',	'EST');	
	WORK_NAME	:=	REPLACE (WORK_NAME,	'ESTATES',	'EST');	
	WORK_NAME	:=	REPLACE (WORK_NAME,	'HEIGHTS',	'HTS');	

	WORK_NAME	:=	REPLACE (WORK_NAME, 	' 1ST',	' =1');
	WORK_NAME	:=	REPLACE (WORK_NAME, 	' 2ND',	' =2');
	WORK_NAME	:=	REPLACE (WORK_NAME, 	' 3RD',	' =3');
	WORK_NAME	:=	REPLACE (WORK_NAME, 	' 4TH',	' =4');
	WORK_NAME	:=	REPLACE (WORK_NAME, 	' 5TH',	' =5');
	WORK_NAME	:=	REPLACE (WORK_NAME, 	' 6TH',	' =6');
	WORK_NAME	:=	REPLACE (WORK_NAME, 	' 7TH',	' =7');
	WORK_NAME	:=	REPLACE (WORK_NAME, 	' 8TH',	' =8');
	WORK_NAME	:=	REPLACE (WORK_NAME, 	' 9TH',	' =9');
	WORK_NAME	:=	REPLACE (WORK_NAME, 	' 10TH',	' =10');
	WORK_NAME	:=	REPLACE (WORK_NAME, 	' 11TH',	' =11');
	WORK_NAME	:=	REPLACE (WORK_NAME, 	' 12TH',	' =12');

	WORK_NAME	:=	REPLACE (WORK_NAME,	' I ',	' 1 ');
	WORK_NAME	:=	REPLACE (WORK_NAME, 	' II ',   	' 2 ');
	WORK_NAME	:=	REPLACE (WORK_NAME, 	' III ',  	' 3 ');
	WORK_NAME	:=	REPLACE (WORK_NAME, 	' IV ',  	' 4 ');
	WORK_NAME	:=	REPLACE (WORK_NAME, 	' V ',  	' 5 ');

--	=============================================================================================
/*
	PATTERN	:=	WORK_NAME;

	PATTERN	:=	TRANSLATE (PATTERN, 	'ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789', 
								'XXXXXXXXXXXXXXXXXXXXXXXXXX 9999999999');

	PATTERN	:=	TRANSLATE (PATTERN,	'.,()''',
							'    ');
*/
--	=============================================================================================

	POSN_NTH	:= 	INSTR (WORK_NAME, ' =')			+
				ID_NTH;

	POSN_EST	:= 	INSTR (WORK_NAME, ' ESTATES ')	+
				INSTR (WORK_NAME, ' EST ')		+
				ID_EST;

	POSN_ADDN	:= 	INSTR (WORK_NAME, ' ADDITION ')	+
				INSTR (WORK_NAME, ' ADDN ')		+
				INSTR (WORK_NAME, ' ADD ')		+
				ID_ADDN;

	POSN_SUBD	:= 	INSTR (WORK_NAME, ' SUBDIVISION ')	+
				INSTR (WORK_NAME, ' SUB ')		+
				ID_SUBD;

	POSN_NUM	:= 	INSTR (WORK_NAME, ' NO ')		+
				INSTR (WORK_NAME, ' #')			+
				ID_NUMB;

	POSN_SECT	:= 	INSTR (WORK_NAME, ' SECTION ')	+
				INSTR (WORK_NAME, ' SECT ')		+
				ID_SECT;

	POSN_INST	:= 	INSTR (WORK_NAME, ' INSTALLMENT ')	+
				INSTR (WORK_NAME, ' INST ')		+
				ID_INST;

	POSN_PHASE	:=	INSTR (WORK_NAME, 'PHASE ')		+
				ID_PHASE;

	POSN_REPLAT	:=	INSTR (WORK_NAME, 'REPLAT ')		+
				ID_REPLAT;


--	POSN_SEPAR	:= 	INSTR (WORK_NAME, '/')			+
--				ID_SEPAR;


	IF POSN_NTH		< 01	THEN POSN_NTH	:= POSN_LAST;	END IF;
	IF POSN_EST		< 01	THEN POSN_EST	:= POSN_LAST;	END IF;
	IF POSN_ADDN   	< 01	THEN POSN_ADDN	:= POSN_LAST;	END IF;
	IF POSN_SUBD   	< 01	THEN POSN_SUBD	:= POSN_LAST;	END IF;
	IF POSN_NUM    	< 01	THEN POSN_NUM	:= POSN_LAST;	END IF;
	IF POSN_SECT   	< 01	THEN POSN_SECT	:= POSN_LAST;	END IF;
	IF POSN_INST   	< 01	THEN POSN_INST	:= POSN_LAST;	END IF;
	IF POSN_PHASE  	< 01	THEN POSN_PHASE	:= POSN_LAST;	END IF;
	IF POSN_REPLAT 	< 01	THEN POSN_REPLAT	:= POSN_LAST;	END IF;

--	=============================================================================================

	WORK_NAME	:=	TRANSLATE (WORK_NAME,	'#',		' ');

--	=============================================================================================
	LOOP
--	=============================================================================================

	POSN_NEXT	:=	LEAST	(
					POSN_EST,
					POSN_ADDN,

					POSN_NTH,
					POSN_NUM,
					POSN_SECT,
					POSN_INST,
					POSN_REPLAT,
					POSN_PHASE,

					POSN_LAST	);	

	EXIT WHEN	POSN_NEXT = POSN_LAST;	

--	=============================================================================================
	

	THIS_START	:=	CEIL   (POSN_NEXT);
	THIS_STOP	:=	INSTR  (WORK_NAME, ' ', THIS_START);
	THIS_ITEM	:=	SUBSTR (WORK_NAME, THIS_START, THIS_STOP - THIS_START);

	THAT_START	:=	THIS_STOP + 01;
	THAT_STOP	:=	INSTR  (WORK_NAME, ' ', THAT_START);
	THAT_ITEM	:=	SUBSTR (WORK_NAME, THAT_START, THAT_STOP - THAT_START);


	THIS_ID	:=	POSN_NEXT - FLOOR (POSN_NEXT);

	IF	THIS_ID > ID_NAME_HI			THEN
		POSN_NAME_HI	:= THIS_START - 01;
	END IF;


--	=============================================================================================

	BURN_THIS	:=	1;

	IF	THIS_ID = ID_NTH				THEN
		THIS_NTH	:=	LTRIM (THIS_ITEM, '=');
		POSN_NTH	:=	POSN_LAST;
	END IF;


	IF	THIS_ID = ID_NUMB				THEN
		DESC_NUMB	:=	THAT_ITEM;

		POSN_NUM	:=	POSN_LAST;
		BURN_THAT	:=	1;
	END IF;


	IF	THIS_ID = ID_EST				THEN
		FLAG_EST	:=	'E';

		POSN_EST	:=	POSN_LAST;
	END IF;

	IF	THIS_ID = ID_ADDN				THEN
		FLAG_ADDN	:=	'A';

		POSN_ADDN	:=	POSN_LAST;
	END IF;

	IF	THIS_ID = ID_SUBD				THEN
		FLAG_SUBD	:=	'A';

		POSN_SUBD	:=	POSN_LAST;
	END IF;


	IF	THIS_ID	=	ID_SECT		THEN
		POSN_SECT	:=	POSN_LAST;
		IF	THIS_NTH > 0			THEN
			DESC_SECT	:= THIS_NTH;	
		ELSE
			DESC_SECT	:= THAT_ITEM;
			BURN_THAT	:= 1;
		END IF;
	END IF;


	IF	THIS_ID	=	ID_INST		THEN
		POSN_INST	:=	POSN_LAST;
		IF	THIS_NTH > 0			THEN
			DESC_INST	:= THIS_NTH;	
		ELSE
			DESC_INST	:= THAT_ITEM;
			BURN_THAT	:= 1;
		END IF;
	END IF;


	IF	THIS_ID	=	ID_PHASE		THEN
		POSN_PHASE	:=	POSN_LAST;
		IF	THIS_NTH > 0			THEN
			DESC_PHASE	:= THIS_NTH;	
		ELSE
			DESC_PHASE	:= THAT_ITEM;
			BURN_THAT	:= 1;
		END IF;
	END IF;


	IF	THIS_ID = ID_REPLAT			THEN
		FLAG_REPLAT	:=	'R';
		POSN_REPLAT	:=	POSN_LAST;
	END IF;

--	=============================================================================================

	IF	BURN_THAT = 1				THEN
		WORK_NAME	:=	SUBSTR (WORK_NAME, 01, THAT_START - 01)	|| 
					RPAD (' ', THAT_STOP - THAT_START)		||
					SUBSTR (WORK_NAME, THAT_STOP);
		BURN_THAT	:=	0;
		BURN_THIS	:=	1;
	END IF;
	
	IF	BURN_THIS = 1				THEN
		WORK_NAME	:=	SUBSTR (WORK_NAME, 01, THIS_START - 01)	|| 
					RPAD (' ', THIS_STOP - THIS_START)		||
					SUBSTR (WORK_NAME, THIS_STOP);
	ELSE
		BURN_THIS := 1;
	END IF;


	IF	THIS_NTH > 0
	AND	THIS_ID <> ID_NTH				THEN
		THIS_NTH	:=	0;
	END IF;


--	=============================================================================================
	END LOOP;
--	=============================================================================================

	IF	POSN_NAME_HI = 0			THEN
		DESC_NAME	:= WORK_NAME;
	ELSE
		DESC_NAME	:= SUBSTR (WORK_NAME, 01, POSN_NAME_HI);
	END IF;


	DESC_NAME	:=	LTRIM (RTRIM (DESC_NAME));
	DESC_SECT	:=	LTRIM (RTRIM (DESC_SECT));
	DESC_INST	:=	LTRIM (RTRIM (DESC_INST));
	DESC_PHASE	:=	LTRIM (RTRIM (DESC_PHASE));
	DESC_REPLAT	:=	LTRIM (RTRIM (DESC_REPLAT));


END;
