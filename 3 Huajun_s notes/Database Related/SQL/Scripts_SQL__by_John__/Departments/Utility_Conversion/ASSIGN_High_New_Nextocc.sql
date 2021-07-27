	 echo off;                                                                                
--------------------------------------------------------------------------------
/*

   garland,mscatalog  nextocc = 15969     ;  -- UTSANFITT              
   garland,mscatalog  nextocc = 13404     ;  -- UTSANLATR              
   garland,mscatalog  nextocc = 13119     ;  -- UTSANLIFT              
   garland,mscatalog  nextocc = 14772     ;  -- UTSANMANH              
   garland,mscatalog  nextocc = 118058    ;  -- UTSANPIPE              
   garland,mscatalog  nextocc = 101069    ;  -- UTSTOCHAN              
   garland,mscatalog  nextocc = 1066      ;  -- UTSTOHWAL              
   garland,mscatalog  nextocc = 28430     ;  -- UTSTOINLT              
   garland,mscatalog  nextocc = 11        ;  -- UTSTOJUNC              
   garland,mscatalog  nextocc = 12184     ;  -- UTSTOMANH              
   garland,mscatalog  nextocc = 278       ;  -- UTSTOOUTF              
   garland,mscatalog  nextocc = 116702    ;  -- UTSTOPIPE              
   garland,mscatalog  nextocc = 2         ;  -- UTSTOPOND              
   garland,mscatalog  nextocc = 33984     ;  -- UTWATFITT              
   garland,mscatalog  nextocc = 31065     ;  -- UTWATHYDR              
   garland,mscatalog  nextocc = 235297    ;  -- UTWATMETR              
   garland,mscatalog  nextocc = 154672    ;  -- UTWATPIPE              
   garland,mscatalog  nextocc = 28280     ;  -- UTWATPUMP              
   garland,mscatalog  nextocc = 29993     ;  -- UTWATTANK              
   garland,mscatalog  nextocc = 34714     ;  -- UTWATVALV              
20 rows selected.

	select count(*) from garland.engr_asbuilt;	 -- 308

*/
--------------------------------------------------------------------------------

--	desc garland.mscatalog

	select '   garland,mscatalog nextocc = ' || 
		    rpad(m.nextocc,10) || ';  -- ' || v.new_table

	" "
	from	garland.mscatalog		M,
		garland.Temp_View		V
	where	m.tablename = 	lower(v.new_table)
	order by v.new_table;

--------------------------------------------------------------------------------

	select NEW_TABLE ||',' || NEXTOCC   " "
	from	garland.mscatalog		M,
		garland.Temp_View		V
	where	m.tablename = 	lower(v.new_table)
	order by v.new_table;

--------------------------------------------------------------------------------
                                                                                                                                                                                                                                                                                                                                                                                                                
UTSANFITT,15969                                                                                                                                                                                                                                                                                                                                                                                                 
UTSANLATR,13404                                                                                                                                                                                                                                                                                                                                                                                                 
UTSANLIFT,13119                                                                                                                                                                                                                                                                                                                                                                                                 
UTSANMANH,14772                                                                                                                                                                                                                                                                                                                                                                                                 
UTSANPIPE,118058                                                                                                                                                                                                                                                                                                                                                                                                
UTSTOCHAN,101069                                                                                                                                                                                                                                                                                                                                                                                                
UTSTOHWAL,1066                                                                                                                                                                                                                                                                                                                                                                                                  
UTSTOINLT,28430                                                                                                                                                                                                                                                                                                                                                                                                 
UTSTOJUNC,11                                                                                                                                                                                                                                                                                                                                                                                                    
UTSTOMANH,12184                                                                                                                                                                                                                                                                                                                                                                                                 
UTSTOOUTF,278                                                                                                                                                                                                                                                                                                                                                                                                   
UTSTOPIPE,116702                                                                                                                                                                                                                                                                                                                                                                                                
UTSTOPOND,2                                                                                                                                                                                                                                                                                                                                                                                                     
UTWATFITT,33984                                                                                                                                                                                                                                                                                                                                                                                                 
UTWATHYDR,31065                                                                                                                                                                                                                                                                                                                                                                                                 
UTWATMETR,235297                                                                                                                                                                                                                                                                                                                                                                                                
UTWATPIPE,154672                                                                                                                                                                                                                                                                                                                                                                                                
UTWATPUMP,28280                                                                                                                                                                                                                                                                                                                                                                                                 
UTWATTANK,29993                                                                                                                                                                                                                                                                                                                                                                                                 
UTWATVALV,34714                                                                                                                                                                                                                                                                                                                                                                                                 
20 rows selected.

--------------------------------------------------------------------------------
F





