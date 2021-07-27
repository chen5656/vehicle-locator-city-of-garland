	set echo	on;


Create or Replace PACKAGE BODY    adr_finder_utls AS        
  
FUNCTION CHECK_NAME(         
A_NAME IN VARCHAR2) 
RETURN BOOLEAN    
AS         
NO_RECORDS INTEGER;          
BEGIN      
SELECT COUNT(*) INTO NO_RECORDS FROM ADRSTREET WHERE ADDR_NAME=A_NAME;    
IF NO_RECORDS>0 THEN         
	RETURN TRUE;       
ELSE       
	RETURN FALSE;      
END IF;    
END CHECK_NAME;     
  
  
FUNCTION CHECK_NUM(          
A_NUM IN INTEGER,A_NAME IN VARCHAR2) 
RETURN BOOLEAN     
AS         
NO_RECORDS INTEGER;          
BEGIN      
SELECT COUNT(*) INTO NO_RECORDS FROM CDRELADR WHERE ADDR_NUM=A_NUM AND ADDR_NAME=A_NAME;    
IF NO_RECORDS>0 THEN         
	RETURN TRUE;       
ELSE       
	RETURN FALSE;      
END IF;    
END CHECK_NUM;      
  
  
  
FUNCTION GET_SQL_EQ          
(          
A_NUM	 NUMBER,       
A_PFX  VARCHAR,      
A_NAME VARCHAR,     
A_TYPE VARCHAR,     
A_SFX  VARCHAR) 
RETURN VARCHAR2        
AS         
STRSQL VARCHAR2(400);         				--	up from 200
BEGIN      
  
	STRSQL := 'SELECT DISTINCT ADDR_NUM, ADDR_PFX, ADDR_NAME, ADDR_TYPE, ADDR_SFX, parcel_id  FROM CDRELADR ';	    

	strsql := strsql || ' where lower(nvl(addr_status,'' '')) <> ''d''  ';

  
	IF A_NUM IS NOT NULL THEN   
		STRSQL := STRSQL || ' AND ADDR_NUM='''  || A_NUM || '''';		
	END IF;   
		         
	IF A_PFX IS NOT NULL THEN   
		STRSQL := STRSQL || ' AND ADDR_PFX='''  || A_PFX || ''''; 		
	END IF;   
  
	IF A_NAME IS NOT NULL THEN  
		STRSQL := STRSQL || ' AND ADDR_NAME=''' || A_NAME || ''''; 		
	END IF;   
  
	IF A_TYPE IS NOT NULL THEN  
		STRSQL := STRSQL || ' AND ADDR_TYPE=''' || A_TYPE || ''''; 		
	END IF;   
  
	IF A_SFX IS NOT NULL THEN   
		STRSQL := STRSQL || ' AND ADDR_SFX='''  || A_SFX || '''';		
	END IF;   

	
	if	instr (strsql, ' AND ') = 0		then
		strsql := null;
	end if;

  
--	IF SUBSTR(STRSQL,LENGTH(STRSQL)-3,4)='AND ' THEN       
--		STRSQL := SUBSTR(STRSQL,1,LENGTH(STRSQL)-5);          
--	END IF;   
--	IF SUBSTR(STRSQL,LENGTH(STRSQL)-5,6)='WHERE ' THEN     
--		STRSQL := NULL;   
--	END IF;   
  
RETURN STRSQL;      
END GET_SQL_EQ;     
  
  
FUNCTION GET_SQL_LIKE        
(          
A_NUM    NUMBER,       
A_PREFIX VARCHAR,   
A_NAME   VARCHAR) 
RETURN   VARCHAR2       
AS         
STRSQL VARCHAR2(400);        					--	up from 200
BEGIN      
  
	STRSQL := 'SELECT DISTINCT ADDR_NUM, ADDR_PFX, ADDR_NAME, ADDR_TYPE, ADDR_SFX  FROM CDRELADR ';	

	strsql := strsql || ' where lower(nvl(addr_status,'' '')) <> ''d''  ';

  
	IF A_NUM IS NOT NULL THEN   
		STRSQL := STRSQL || ' AND ADDR_NUM LIKE ''' || A_NUM || '%'''; 				
	END IF;   
		         
	IF A_PREFIX IS NOT NULL THEN         
		STRSQL := STRSQL || ' AND ADDR_PFX = ''' || A_PREFIX || ''''; 					
	END IF;   
  
	IF A_NAME IS NOT NULL THEN  
		IF CHECK_NAME(A_NAME) THEN          
			STRSQL := STRSQL || ' AND ADDR_NAME = ''' || A_NAME || ''''; 					
		ELSE     
			STRSQL := STRSQL || ' AND ADDR_NAME LIKE ''' || SUBSTR(A_NAME,1,3) || '%''';	
		END IF;  
	END IF;   

	if	instr (strsql, ' AND ') = 0		then
		strsql := null;
	end if;


  
--	IF SUBSTR(STRSQL,LENGTH(STRSQL)-3,4)='AND ' THEN       
--		STRSQL := SUBSTR(STRSQL,1,LENGTH(STRSQL)-5);          
--	END IF;   
--	IF SUBSTR(STRSQL,LENGTH(STRSQL)-5,6)='WHERE ' THEN     
--		STRSQL := NULL;   
--	END IF;   
  
RETURN STRSQL;      
END GET_SQL_LIKE;   
  
END;       

