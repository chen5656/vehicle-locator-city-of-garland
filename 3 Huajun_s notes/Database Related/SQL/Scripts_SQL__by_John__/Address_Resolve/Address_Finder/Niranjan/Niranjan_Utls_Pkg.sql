
drop package			niranjan_utls;

create or replace PACKAGE    NIRANJAN_UTLS	 AS              

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

