--	dec 10, 2003
	Set echo	off;
--	=============================================================================
--	name compression routine with processing options
--	=============================================================================

--	option format = 9xxx...

--	numeric options are cumulative.  Higher options include all lower options.

--	OBSOLETE
--	option 0		replace punctuation with spaces (no compression)
--	option 1		remove  spaces 
--	option 2		reduce  double letter to single letter
--	option 3		remove  plural 's'	
--	option 4		uniform vowels	
--	option 5		remove  vowels
--	option 6		remove  inner vowels / keep initial vowels

--	REVISION  		jan 2005
--	option 0		replace punctuation with spaces (no compression)
--	option 1		remove  spaces 
--	option 2		remove  spaces 
--	option 3		reduce  double letter to single letter
--	option 4		remove  plural 's'	
--	option 5		uniform vowels	
--	option 6		remove  vowels
--	option 7		remove  inner vowels / keep initial vowels


--	option b		remove  spaces (blanks)
--	option d		reduce  double letters
--	option s		output singles (no doubles)
--	option p		remove  plural 's'
--	option u		uniform vowels
--	option v		remove  vowels
--	option i		initial vowels
--	option w		treat  'w' as vowel
--	option y		treat  'y' as vowel
--	option x		apply   soundex 

	create or replace function	ADR_compress_name       
	(         
		user_name		in 	varchar2,			  
		user_option		in	varchar2		   
	)	        
		return			varchar2				   
as         
      
		soundex_from		varchar2(20)	:= 'PKQTVJMXZ';
		soundex_to			varchar2(20)	:= 'BCCDFGNSS';
		spaces			char(40)		:= ' ';
      
		compress_name		varchar2(1000);
		compress_text		varchar2(1000);
		compress_first		varchar2(01);
      
		edit1				char(01);	     
		edit2				char(01);	     
		next				number(04);		
      
		keep_option			varchar2(20);

		option_b			char(01)		:= ' ';	-- remove Blank
		option_d			char(01)		:= ' ';	-- Double letter to single letter
		option_p			char(01)		:= ' ';	-- remove Plural  ('s')
		option_u			char(01)		:= ' ';	-- Uniform vowel = 'o'
		option_v			char(01)		:= ' ';	-- remove  Vowel
		option_i			char(01)		:= ' ';	-- keep Initial vowel
		option_w			char(01)		:= ' ';	-- remove non-initial W
		option_y			char(01)		:= ' ';	-- remove non-initial Y
		option_x			char(01)		:= ' ';	-- apply soundeX
		option_s			char(01)		:= ' ';	-- output Single letters
      
Begin      
      
		keep_option := rtrim (user_option);

		if	keep_option is null		then 
			keep_option := '0';					-- oct 2003
		end if;
      
		edit1	:= substr (keep_option, 01, 01);
      
		if	edit1 between '0' and '9'	then          
      
			if	edit1 >= '1'		then  
				option_b	:= 'B';	     

			if	edit1 >= '2'		then  
				option_d	:= 'D';

			if	edit1 >= '3'		then  
				option_p	:= 'P';
				option_s	:= 'S';				-- dec 2003

			if	edit1 >= '4'		then  
				option_u	:= 'U';

			if	edit1 >= '5'		then  
				option_v	:= 'V';

			if	edit1 >= '6'		then
				null;
			end if;
			end if;
			end if;
			end if;
			end if;
			end if;
      
			if	keep_option = edit1		then		-- oct 2003
				goto 	process_name;
			end if;	     
	     
		end if;
      
--	===================================================================
      
		if	keep_option like '%B%'		then       
			option_b	:= 'B';
		end if;
      
		if	keep_option like '%D%'		then       
			option_d	:= 'D';
		end if;
      
		if	keep_option like '%P%'		then       
			option_p	:= 'P';
		end if;
      
		if	keep_option like '%U%'		then       
			option_u	:= 'U';
		end if;
      
		if	keep_option like '%V%'		then       
			option_v	:= 'V';
		end if;
      
		if	keep_option like '%I%'		then       
			option_i	:= 'I';
		end if;
      
		if	keep_option like '%W%'		then       
			option_w	:= 'W';
		end if;
      
		if	keep_option like '%Y%'		then       
			option_y	:= 'Y';
		end if;
      
		if	keep_option like '%X%'		then       
			option_x	:= 'X';
		end if;
      
		if	keep_option like '%S%'		then       
			option_s	:= 'S';
		end if;
      
--	===================================================================
	<<process_name>>    
--	===================================================================
      
	compress_name	:= ' ' || upper (ltrim (user_name)) || ' ';		-- oct 2003
--	compress_name	:= upper (ltrim (user_name)) || ' ';

	compress_name	:= translate (compress_name,	
					'~`!@#$%^&*()_-+=|\{[]}:;"<,>.?/''' || chr(09),
					spaces);

--	===================================================================
      
		if	option_x = 'X'									then			          
			compress_name	:= translate (compress_name, soundex_from, soundex_to);
		end if;
      
		if	option_i = 'I'									then
			compress_name	:= replace (compress_name, ' A', ' a');
			compress_name	:= replace (compress_name, ' E', ' e');
			compress_name	:= replace (compress_name, ' I', ' i');
			compress_name	:= replace (compress_name, ' O', ' o');
			compress_name	:= replace (compress_name, ' U', ' u');
      
			if	option_w = 'W'								then 
				compress_name := replace (compress_name, ' W', ' w');
			end if;
			if	option_y = 'Y'								then 
				compress_name := replace (compress_name, ' Y', ' y');
			end if;
      
		end if;
         
		if	option_u = 'U'									then        
			compress_name		:= translate (compress_name, 'AEIOU', 'OOOOO');
      
			if	option_w = 'W'								then        
				compress_name 	:= translate (compress_name, 'W', 'O');		     
			end if;

			if	option_y = 'Y'								then        
				compress_name 	:= translate (compress_name, 'Y', 'O');		     
			end if;
		end if;
      
--	===================================================================
     
         
		compress_name	:= ltrim  (compress_name);					-- oct 2003
		compress_first	:= substr (compress_name,	01, 01 );			-- oct 2003
		compress_name 	:= nvl(substr (compress_name, 02),' ');			-- oct 2003
      
		if	option_p = 'P'							then 		-- jan 2004
			compress_name	:= replace (compress_name, 'S ', ' ');
		end if;			

     
		if	option_v= 'V'							then		-- oct 2003
			compress_name	:= translate (compress_name, '/AEIOU', '/');		  
		end if;

		compress_name	:= compress_first || compress_name;				-- oct 2003
      
		if	option_i = 'I'							then		-- oct 2003
			compress_name	:= translate (compress_name, '/aeiou', '/AEIOU');		  
		end if;

--	=============================================================================
      
		if	option_s = 'S'							then		-- oct 2003       
			compress_name	:= translate (compress_name, '/ ', '/');			     
		end if;
      
		if	option_d = 'D'							then			       
      
			compress_name := compress_name || ' ';
			compress_text := ' ';
      
			for	here	in  01..length (compress_name) - 01		loop       
      
				next	:= here + 01;
				edit1	:= substr (compress_name, here, 01);
				edit2	:= substr (compress_name, next, 01);
      
				if	edit1	<> edit2     
				or	edit1 <  'A'					then   
					compress_text := compress_text || edit1;
				end if;
      
			end loop;
      
			compress_name := ltrim (compress_text);
      
		end if;
      
		if	option_b = 'B'							then		-- apr 2002       
			compress_name	:= translate (compress_name, '/ ', '/');			     
		end if;
      
--	===================================================================
--		compress_name := nvl(ltrim (rtrim (compress_name)),' ');			-- oct 2003
--		if	option_d = ' '     	-- oct 2003
--		or	compress_first <> substr (compress_name, 01, 01)	then  
--			compress_name := compress_first || compress_name;
--		end if;
--	===================================================================

		return nvl(ltrim(rtrim(compress_name)),' ');					-- july 2003

end;



--	=================================================================================================
/*
--		Check for plural word within the name by looking via standard ending word at end of name

		if	option_p = 'P'							then
			compress_name	:= rtrim(compress_name, 'S');

			count1 := instr(compress_name, 'S ', -1);
			if	count1 > 4							then
				select name into text1 from adrEnding 
				where  name = substr(compress_name, count1 + 02);

				if	 text1 > ' '					then
					compress_name	:= substr(compress_name, 01, count1 -1) || text1;
				end if;		
			end if;
		end if;
*/
--	=================================================================================================
