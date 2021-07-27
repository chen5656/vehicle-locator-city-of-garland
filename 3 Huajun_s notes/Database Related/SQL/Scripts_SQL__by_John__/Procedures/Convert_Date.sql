	set echo off;
--	====================================================================
--	Convert a date in text format into an Oracle date
--	====================================================================

	Create or replace function	garland.Convert_Date  (in_date  varchar2)
				Return	Date

	As
		date_text		varchar2(40);
		date_pattern	varchar2(40);
		date_result		date;

	Begin

		date_text		:= in_date;
		date_text		:= translate (date_text, '/. ', '---------------');
		date_pattern	:= translate (date_text, '123456789', '000000000');

--	----------------------------------------------------------------------------------------------

		if	translate(date_text, 'x0/-', 'x')	is null	then
			return null;
		end if;

--	----------------------------------------------------------------------------------------------

		if	date_pattern in ( '00-00-0000', '0-0-0000', '0-00-0000', '00-0-0000' )	then
			date_result	:= to_date (date_text, 'mm-dd-yyyy');			

		elsif	date_pattern in ( '0000-00-00', '0000-0-0', '0000-0-00', '0000-00-0' )	then
			date_result	:= to_date (date_text, 'yyyy-mm-dd');	

--	----------------------------------------------------------------------------------------------

		elsif	date_pattern in ( '0000-00' )	
		and	date_text 			between '1900' and '2099'
		and	substr(date_text, 6,2)	between '01' and '12'		then
			date_result	:= to_date (date_text, 'yyyy-mm');	

		elsif	date_pattern in ( '0000-0' )	
		and	date_text 			between '1900' and '2099'
		and	substr(date_text, 6,1)	between '1' and '9'		then
			date_result	:= to_date (date_text, 'yyyy-mm');	

		elsif	date_pattern in ( '00-0000' )	
		and	substr(date_text, 1,2)	between '01' and '12'
		and	substr(date_text, 4,4)	between '1900' and '2099'	then
			date_result	:= to_date (date_text, 'mm-yyyy');	

		elsif	date_pattern in ( '0-0000' )	
		and	substr(date_text, 1,1)	between '1' and '9'
		and	substr(date_text, 3,4)	between '1900' and '2099'	then
			date_result	:= to_date (date_text, 'mm-yyyy');	

--	----------------------------------------------------------------------------------------------

		elsif	date_pattern in ( '0000' )
		and	date_text 			between '1900' and '2099'	then
			date_result	:= to_date (date_text || '01', 'yyyymm');	

		elsif	date_pattern in ( '000000' )
		and	date_text 			between '1900' and '2099'
		and	substr(date_text, 5,2)	between '01' and '12'		then
			date_result	:= to_date (date_text, 'yyyymm');	

		elsif	date_pattern = '00000000'  
		and	date_text 			between '1900' and '2099'
		and	substr(date_text, 5,2)	between '01' and '12'
		and	substr(date_text, 7,2)	between '01' and '31'		then
			date_result	:= to_date (date_text, 'yyyymmdd');			

--	----------------------------------------------------------------------------------------------

		else

--			raise_application_error (-20100,'*** Invalid Input Date: ' || date_text || ' ***' );

			dbms_output.put_line ( '*** Invalid Date ' || date_text );

		end if;
		
		return	date_result;

	End;


--	====================================================================
/*
	set echo	off;
	variable	text_date		varchar2(40);

--	-----------------------------------------------------------------------------------------------------

	execute	:text_date	:= '2005/03/15';
	select :text_date ||'  '|| to_char (garland.convert_date(:text_date), 'Mon dd,yyyy') " " from dual;

	execute	:text_date	:= '03/15/2005';
	select :text_date ||'  '|| to_char (garland.convert_date(:text_date), 'Mon dd,yyyy') " " from dual;

--	-----------------------------------------------------------------------------------------------------

	execute	:text_date	:= '2005/03';
	select :text_date ||'  '|| to_char (garland.convert_date(:text_date), 'Mon dd,yyyy') " " from dual;

	execute	:text_date	:= '2005/3';
	select :text_date ||'  '|| to_char (garland.convert_date(:text_date), 'Mon dd,yyyy') " " from dual;

	execute	:text_date	:= '03/2005';
	select :text_date ||'  '|| to_char (garland.convert_date(:text_date), 'Mon dd,yyyy') " " from dual;

	execute	:text_date	:= '3/2005';
	select :text_date ||'  '|| to_char (garland.convert_date(:text_date), 'Mon dd,yyyy') " " from dual;

--	-----------------------------------------------------------------------------------------------------

	execute	:text_date	:= '20050315';
	select :text_date ||'  '|| to_char (garland.convert_date(:text_date), 'Mon dd,yyyy') " " from dual;

	execute	:text_date	:= '200503';
	select :text_date ||'  '|| to_char (garland.convert_date(:text_date), 'Mon dd,yyyy') " " from dual;

	execute	:text_date	:= '2005';
	select :text_date ||'  '|| to_char (garland.convert_date(:text_date), 'Mon dd,yyyy') " " from dual;

*/
--	====================================================================

