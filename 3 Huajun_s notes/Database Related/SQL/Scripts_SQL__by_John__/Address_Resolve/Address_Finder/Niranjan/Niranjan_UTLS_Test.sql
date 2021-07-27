
----------------------------------------------------------------------------------------------------
PACKAGE    NIRANJAN_UTLS_test AS                                                                    
                                                                                                    
FUNCTION GET_SQL_EQ                                                                                 
(                                                                                                   
A_NUM NUMBER,                                                                                       
A_PFX VARCHAR,                                                                                      
A_NAME VARCHAR,                                                                                     
A_TYPE VARCHAR,                                                                                     
A_SFX VARCHAR                                                                                       
                                                                                                    
--	a_parcel out varchar			--  july 2003                                                             
)                                                                                                   
RETURN VARCHAR2;                                                                                    
                                                                                                    
FUNCTION GET_SQL_LIKE                                                                               
(                                                                                                   
A_NUM NUMBER,                                                                                       
A_PREFIX VARCHAR,                                                                                   
A_NAME VARCHAR) RETURN VARCHAR2;                                                                    
                                                                                                    
FUNCTION CHECK_NAME(                                                                                
A_NAME IN VARCHAR2                                                                                  
) RETURN BOOLEAN;                                                                                   
                                                                                                    
                                                                                                    
FUNCTION CHECK_NUM(                                                                                 
A_NUM IN INTEGER,                                                                                   
A_NAME IN VARCHAR2) RETURN BOOLEAN;                                                                 
                                                                                                    
END;                                                                                                
                                                                                                    
                                                                                                    
PACKAGE BODY           NIRANJAN_UTLS_test		AS                                                       
                                                                                                    
--	july 2003		include parcel_id in parameter list                                                   
                                                                                                    
                                                                                                    
FUNCTION CHECK_NAME(                                                                                
A_NAME IN VARCHAR2) RETURN BOOLEAN                                                                  
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
A_NUM IN INTEGER,A_NAME IN VARCHAR2) RETURN BOOLEAN                                                 
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
A_NUM NUMBER,                                                                                       
A_PFX VARCHAR,                                                                                      
A_NAME VARCHAR,                                                                                     
A_TYPE VARCHAR,                                                                                     
A_SFX VARCHAR                                                                                       
--	a_parcel	out varchar				-- july 2003                                                             
) RETURN VARCHAR2                                                                                   
AS                                                                                                  
STRSQL VARCHAR(200);                                                                                
BEGIN                                                                                               
                                                                                                    
	STRSQL := 'SELECT DISTINCT ADDR_NUM,ADDR_PFX,ADDR_NAME,ADDR_TYPE,ADDR_SFX FROM CDRELADR WHERE ';   
                                                                                                    
--	STRSQL := 'SELECT DISTINCT ADDR_NUM,ADDR_PFX,ADDR_NAME,ADDR_TYPE,ADDR_SFX, parcel_id FROM CDRELAD
													-- july 2003                                                                           
                                                                                                    
                                                                                                    
	IF A_NUM IS NOT NULL THEN                                                                          
		STRSQL := STRSQL || 'ADDR_NUM=''' || A_NUM || ''' AND ';                                          
	END IF;                                                                                            
		                                                                                                  
	IF A_PFX IS NOT NULL THEN                                                                          
		STRSQL := STRSQL || 'ADDR_PFX=''' || A_PFX || ''' AND ';                                          
	END IF;                                                                                            
                                                                                                    
	IF A_NAME IS NOT NULL THEN                                                                         
		STRSQL := STRSQL || 'ADDR_NAME=''' || A_NAME || ''' AND ';                                        
	END IF;                                                                                            
                                                                                                    
	IF A_TYPE IS NOT NULL THEN                                                                         
		STRSQL := STRSQL || 'ADDR_TYPE=''' || A_TYPE || ''' AND ';                                        
	END IF;                                                                                            
                                                                                                    
	IF A_SFX IS NOT NULL THEN                                                                          
		STRSQL := STRSQL || 'ADDR_SFX=''' || A_SFX || '''';                                               
	END IF;                                                                                            
                                                                                                    
                                                                                                    
	IF SUBSTR(STRSQL,LENGTH(STRSQL)-3,4)='AND ' THEN                                                   
		STRSQL := SUBSTR(STRSQL,1,LENGTH(STRSQL)-5);                                                      
	END IF;                                                                                            
                                                                                                    
	IF SUBSTR(STRSQL,LENGTH(STRSQL)-5,6)='WHERE ' THEN                                                 
		STRSQL := NULL;                                                                                   
	END IF;                                                                                            
                                                                                                    
RETURN STRSQL;                                                                                      
                                                                                                    
END GET_SQL_EQ;                                                                                     
                                                                                                    
                                                                                                    
FUNCTION GET_SQL_LIKE                                                                               
(                                                                                                   
A_NUM NUMBER,                                                                                       
A_PREFIX VARCHAR,                                                                                   
A_NAME VARCHAR) RETURN VARCHAR2                                                                     
AS                                                                                                  
STRSQL VARCHAR(200);                                                                                
BEGIN                                                                                               
                                                                                                    
	STRSQL := 'SELECT DISTINCT ADDR_NUM,ADDR_PFX,ADDR_NAME,ADDR_TYPE,ADDR_SFX FROM CDRELADR WHERE ';   
                                                                                                    
	IF A_NUM IS NOT NULL THEN                                                                          
		STRSQL := STRSQL || 'ADDR_NUM LIKE ''' || A_NUM || '%' || ''' AND ';                              
	END IF;                                                                                            
		                                                                                                  
	IF A_PREFIX IS NOT NULL THEN                                                                       
		STRSQL := STRSQL || 'ADDR_PFX = ''' || A_PREFIX || ''' AND ';                                     
	END IF;                                                                                            
                                                                                                    
	IF A_NAME IS NOT NULL THEN                                                                         
		IF CHECK_NAME(A_NAME) THEN                                                                        
			STRSQL := STRSQL || 'ADDR_NAME = ''' || A_NAME || ''' AND ';                                     
		ELSE                                                                                              
			STRSQL := STRSQL || 'ADDR_NAME LIKE ''' || SUBSTR(A_NAME,1,3) || '%' || ''' AND ';               
		END IF;                                                                                           
	END IF;                                                                                            
                                                                                                    
	IF SUBSTR(STRSQL,LENGTH(STRSQL)-3,4)='AND ' THEN                                                   
		STRSQL := SUBSTR(STRSQL,1,LENGTH(STRSQL)-5);                                                      
	END IF;                                                                                            
                                                                                                    
	IF SUBSTR(STRSQL,LENGTH(STRSQL)-5,6)='WHERE ' THEN                                                 
		STRSQL := NULL;                                                                                   
	END IF;                                                                                            
                                                                                                    
RETURN STRSQL;                                                                                      
END GET_SQL_LIKE;                                                                                   
                                                                                                    
END;                                                                                                
