
PACKAGE           NIRANJAN_test	as                                                                  
                                                                                                    
--	july 2003		include parcel_id in parameter list                                                   
                                                                                                    
TYPE ADDR_NUM IS TABLE OF VARCHAR(40)                                                               
	INDEX BY BINARY_INTEGER;                                                                           
                                                                                                    
TYPE ADDR_PREFIX IS TABLE OF VARCHAR(2)                                                             
	INDEX BY BINARY_INTEGER;                                                                           
                                                                                                    
TYPE ADDR_NAME IS TABLE OF VARCHAR(40)                                                              
	INDEX BY BINARY_INTEGER;                                                                           
                                                                                                    
TYPE ADDR_TYPE IS TABLE OF VARCHAR(4)                                                               
	INDEX BY BINARY_INTEGER;                                                                           
                                                                                                    
TYPE ADDR_SUFFIX IS TABLE OF VARCHAR(2)                                                             
	INDEX BY BINARY_INTEGER;                                                                           
                                                                                                    
TYPE addr_parcel IS TABLE OF VARCHAR(11)                     -- july 2003                           
	INDEX BY BINARY_INTEGER;                                                                           
                                                                                                    
TYPE ADDR_STATUS IS TABLE OF INTEGER                                                                
	INDEX BY BINARY_INTEGER;                                                                           
                                                                                                    
PROCEDURE VRFY_ADDR(          					-- july 2003                                                     
	num_IN	IN NUMBER,                                                                                  
	pfx_IN	IN VARCHAR2,                                                                                
	name_IN	IN VARCHAR2,                                                                               
	type_IN	IN VARCHAR2,                                                                               
	sfx_IN	IN VARCHAR2,                                                                                
                                                                                                    
	num_OUT	OUT ADDR_NUM,                                                                              
	pfx_OUT	OUT ADDR_PREFIX,                                                                           
	name_OUT	OUT ADDR_NAME,                                                                            
	type_OUT	OUT ADDR_TYPE,                                                                            
	sfx_OUT	OUT ADDR_SUFFIX,                                                                           
                                                                                                    
	parcel_out	out addr_parcel,                                                                        
	STATUS_OUT	OUT ADDR_STATUS                                                                         
                                                                                                    
/*                                                                                                  
    N_IN IN NUMBER,                                                                                 
    P_IN IN VARCHAR2,                                                                               
    NAM_IN IN VARCHAR2,                                                                             
    T_IN IN VARCHAR2,                                                                               
    S_IN IN VARCHAR2,                                                                               
                                                                                                    
    N_OUT OUT ADDR_NUM,                                                                             
    P_OUT OUT ADDR_PREFIX,                                                                          
    NAM_OUT OUT ADDR_NAME,                                                                          
    T_OUT OUT ADDR_TYPE,                                                                            
    S_OUT OUT ADDR_SUFFIX,                                                                          
	parcel_out	out	addr_parcel,				-- july 2003                                                        
    STATUS_OUT OUT ADDR_STATUS                                                                      
*/                                                                                                  
                                                                                                    
);                                                                                                  
                                                                                                    
END;                                                                                                
                                                                                                    
                                                                                                    
PACKAGE BODY           NIRANJAN_test AS                                                             
                                                                                                    
PROCEDURE VRFY_ADDR(                                                                                
    N_IN IN NUMBER,                                                                                 
    P_IN IN VARCHAR2,                                                                               
    NAM_IN IN VARCHAR2,                                                                             
    T_IN IN VARCHAR2,                                                                               
    S_IN IN VARCHAR2,                                                                               
                                                                                                    
    N_OUT OUT ADDR_NUM,                                                                             
    P_OUT OUT ADDR_PREFIX,                                                                          
    NAM_OUT OUT ADDR_NAME,                                                                          
    T_OUT OUT ADDR_TYPE,                                                                            
    S_OUT OUT ADDR_SUFFIX,                                                                          
	parcel_out	out	addr_parcel,				-- july 2003                                                        
    STATUS_OUT OUT ADDR_STATUS                                                                      
)                                                                                                   
                                                                                                    
IS                                                                                                  
                                                                                                    
INT_N NUMBER;                                                                                       
INT_P VARCHAR2(2);                                                                                  
INT_NAM VARCHAR2(40);                                                                               
INT_T VARCHAR2(4);                                                                                  
INT_S VARCHAR2(2);                                                                                  
int_parcel	varchar2(11);									-- july 2003                                                       
this_status	number;                                                                                 
                                                                                                    
STRSQL VARCHAR2(200);                                                                               
SELECT_CURSOR INTEGER;                                                                              
IGNORE INTEGER;                                                                                     
I BINARY_INTEGER := 1;                                                                              
                                                                                                    
BEGIN                                                                                               
                                                                                                    
STRSQL := NIRANJAN_UTLS_test.GET_SQL_EQ(N_IN,P_IN,NAM_IN,T_IN ,S_IN);	                              
--DBMS_OUTPUT.PUT_LINE(STRSQL);                                                                     
If STRSQL Is Null Then                                                                              
    DBMS_OUTPUT.PUT_LINE('NULL VALUE');                                                             
    RETURN;                                                                                         
END IF;                                                                                             
                                                                                                    
SELECT_CURSOR := DBMS_SQL.OPEN_CURSOR;                                                              
DBMS_SQL.PARSE(SELECT_CURSOR,STRSQL,DBMS_SQL.V7);                                                   
DBMS_SQL.DEFINE_COLUMN(SELECT_CURSOR,1,N_IN);                                                       
DBMS_SQL.DEFINE_COLUMN(SELECT_CURSOR,2,P_IN,2);                                                     
DBMS_SQL.DEFINE_COLUMN(SELECT_CURSOR,3,NAM_IN,40);                                                  
DBMS_SQL.DEFINE_COLUMN(SELECT_CURSOR,4,T_IN,4);                                                     
DBMS_SQL.DEFINE_COLUMN(SELECT_CURSOR,5,S_IN,2);                                                     
                                                                                                    
                                                                                                    
IGNORE := DBMS_SQL.EXECUTE(SELECT_CURSOR);                                                          
Loop                                                                                                
If DBMS_SQL.FETCH_ROWS(SELECT_CURSOR) > 0 Then                                                      
    NULL;                                                                                           
Else                                                                                                
    EXIT;                                                                                           
END IF;                                                                                             
END LOOP;                                                                                           
-------------------------------------------------------------                                       
    If DBMS_SQL.LAST_ROW_COUNT = 1 Then                                                             
        DBMS_SQL.COLUMN_VALUE(SELECT_CURSOR,1,INT_N);                                               
        DBMS_SQL.COLUMN_VALUE(SELECT_CURSOR,2,INT_P);                                               
        DBMS_SQL.COLUMN_VALUE(SELECT_CURSOR,3,INT_NAM);                                             
        DBMS_SQL.COLUMN_VALUE(SELECT_CURSOR,4,INT_T);                                               
        DBMS_SQL.COLUMN_VALUE(SELECT_CURSOR,5,INT_S);                                               
--        DBMS_SQL.COLUMN_VALUE(SELECT_CURSOR,6,int_parcel);       -- july 2003                     
        N_OUT(I) := INT_N;                                                                          
        P_OUT(I) := INT_P;                                                                          
        NAM_OUT(I) := INT_NAM;                                                                      
        T_OUT(I) := INT_T;                                                                          
        S_OUT(I) := INT_S;                                                                          
                                                                                                    
--WHILE COMPARING PFX,TYPE AND SFX CONVERT NULL TO ' ' BECAUSE THERE IS NO NULL IN THE DATABASE     
                                                                                                    
        IF INT_N=N_IN AND INT_P=NVL(P_IN,' ') AND INT_NAM=NAM_IN AND INT_T=NVL(T_IN,' ') AND INT_S=N
	     DBMS_OUTPUT.PUT_LINE('ADDRESS VERIFIED');                                                     
            STATUS_OUT(I) := 1;                                                                     
		this_status	  := 1;                                                                               
	ELSE                                                                                               
	     STATUS_OUT(I) := 2;	                                                                          
		this_status	 := 2;                                                                                
        END IF;                                                                                     
                                                                                                    
    END IF;                                                                                         
-------------------------------------------------------------                                       
    If DBMS_SQL.LAST_ROW_COUNT > 1 And DBMS_SQL.LAST_ROW_COUNT <= 100 Then                          
        DBMS_OUTPUT.PUT_LINE('CHOOSE FROM CHOICE');                                                 
        IGNORE := DBMS_SQL.EXECUTE(SELECT_CURSOR);                                                  
        Loop                                                                                        
        If DBMS_SQL.FETCH_ROWS(SELECT_CURSOR) > 0 Then                                              
            DBMS_SQL.COLUMN_VALUE(SELECT_CURSOR,1,INT_N);                                           
            DBMS_SQL.COLUMN_VALUE(SELECT_CURSOR,2,INT_P);                                           
            DBMS_SQL.COLUMN_VALUE(SELECT_CURSOR,3,INT_NAM);                                         
            DBMS_SQL.COLUMN_VALUE(SELECT_CURSOR,4,INT_T);                                           
            DBMS_SQL.COLUMN_VALUE(SELECT_CURSOR,5,INT_S);                                           
--          DBMS_SQL.COLUMN_VALUE(SELECT_CURSOR,6,int_parcel);   -- july 2003                       
                                                                                                    
            N_OUT(I) := INT_N;                                                                      
            P_OUT(I) := INT_P;                                                                      
            NAM_OUT(I) := INT_NAM;                                                                  
            T_OUT(I) := INT_T;                                                                      
            S_OUT(I) := INT_S;                                                                      
--		parcel_out(I) := int_parcel;					-- july 2003                                                   
            STATUS_OUT(I) := 2;                                                                     
                                                                                                    
            I := I +1;                                                                              
        Else                                                                                        
            EXIT;                                                                                   
        END IF;                                                                                     
        END LOOP;                                                                                   
    ELSIF DBMS_SQL.LAST_ROW_COUNT > 100 Then                                                        
	N_OUT(1) := NULL;                                                                                  
	P_OUT(1) := NULL;                                                                                  
	NAM_OUT(1) := NULL;                                                                                
	T_OUT(1) := NULL;                                                                                  
	S_OUT(1) := NULL;                                                                                  
	parcel_out (1) := null;							-- july 2003                                                         
	STATUS_OUT(1) := 5;                                                                                
    END IF;                                                                                         
-------------------------------------------------------------                                       
    If DBMS_SQL.LAST_ROW_COUNT = 0 Then                                                             
	If NAM_IN Is Not Null Then                                                                         
		STRSQL := 'SELECT ADDR_NUM,ADDR_PFX,ADDR_NAME,ADDR_TYPE,ADDR_SFX, parcel_id FROM CDRELADR WHERE ';
		IF N_IN IS NOT NULL THEN                                                                          
			STRSQL := STRSQL || 'ADDR_NUM=' || N_IN || ' AND ';                                              
		END IF;                                                                                           
		STRSQL := STRSQL || 'ADDR_NAME=''' || NAM_IN || '''' ;                                            
                                                                                                    
          --STRSQL := NIRANJAN_UTLS_test.GET_SQL_LIKE(N_IN,P_IN,NAM_IN);                            
            --IF STRSQL IS NULL THEN                                                                
                --DBMS_OUTPUT.PUT_LINE('NULL VALUE');                                               
                --RETURN;                                                                           
            --END IF;                                                                               
                                                                                                    
            DBMS_SQL.PARSE(SELECT_CURSOR,STRSQL,DBMS_SQL.V7);                                       
            DBMS_SQL.DEFINE_COLUMN(SELECT_CURSOR,1,N_IN);                                           
            DBMS_SQL.DEFINE_COLUMN(SELECT_CURSOR,2,P_IN,2);                                         
            DBMS_SQL.DEFINE_COLUMN(SELECT_CURSOR,3,NAM_IN,40);                                      
            DBMS_SQL.DEFINE_COLUMN(SELECT_CURSOR,4,T_IN,4);                                         
            DBMS_SQL.DEFINE_COLUMN(SELECT_CURSOR,5,S_IN,2);                                         
                                                                                                    
            IGNORE := DBMS_SQL.EXECUTE(SELECT_CURSOR);                                              
            Loop                                                                                    
            If DBMS_SQL.FETCH_ROWS(SELECT_CURSOR) > 0 Then                                          
                NULL;                                                                               
            ELSE    ---------------------------------                                               
                If DBMS_SQL.LAST_ROW_COUNT = 0 Then                                                 
                    If NIRANJAN_UTLS_test.CHECK_NAME(NAM_IN) Then                                   
 If Not NIRANJAN_UTLS_test.CHECK_NUM(N_IN, NAM_IN) Then                                             
   N_OUT(1) := NULL;                                                                                
   P_OUT(1) := NULL;                                                                                
   NAM_OUT(1) := NULL;                                                                              
   T_OUT(1) := NULL;                                                                                
   S_OUT(1) := NULL;                                                                                
	parcel_out (1) := null;					-- july 2003                                                           
   STATUS_OUT(1) := 4;                                                                              
 END IF;                                                                                            
                    Else                                                                            
 N_OUT(1) := NULL;                                                                                  
 P_OUT(1) := NULL;                                                                                  
 NAM_OUT(1) := NULL;                                                                                
 T_OUT(1) := NULL;                                                                                  
 S_OUT(1) := NULL;                                                                                  
	parcel_out (1) := null;					-- july 2003                                                           
 STATUS_OUT(1) := 3;                                                                                
                    END IF;                                                                         
                END IF;                                                                             
                ---------------------------------                                                   
                If DBMS_SQL.LAST_ROW_COUNT > 0 And DBMS_SQL.LAST_ROW_COUNT < 100 Then               
                    DBMS_OUTPUT.PUT_LINE('CHOOSE FROM CHOICE');                                     
                    IGNORE := DBMS_SQL.EXECUTE(SELECT_CURSOR);                                      
                    Loop                                                                            
 If DBMS_SQL.FETCH_ROWS(SELECT_CURSOR) > 0 Then                                                     
   DBMS_SQL.COLUMN_VALUE(SELECT_CURSOR,1,INT_N);                                                    
   DBMS_SQL.COLUMN_VALUE(SELECT_CURSOR,2,INT_P);                                                    
   DBMS_SQL.COLUMN_VALUE(SELECT_CURSOR,3,INT_NAM);                                                  
   DBMS_SQL.COLUMN_VALUE(SELECT_CURSOR,4,INT_T);                                                    
   DBMS_SQL.COLUMN_VALUE(SELECT_CURSOR,5,INT_S);                                                    
--   DBMS_SQL.COLUMN_VALUE(SELECT_CURSOR,6,int_parcel);	-- july 2003                                
                                                                                                    
   N_OUT(I) := INT_N;                                                                               
   P_OUT(I) := INT_P;                                                                               
   NAM_OUT(I) := INT_NAM;                                                                           
   T_OUT(I) := INT_T;                                                                               
   S_OUT(I) := INT_S;                                                                               
--	parcel_out (I) := int_parcel;				-- july 2003                                                    
   STATUS_OUT(I) := 2;                                                                              
                                                                                                    
   I := I +1;                                                                                       
 Else                                                                                               
   EXIT;                                                                                            
 END IF;                                                                                            
                    END LOOP;                                                                       
                Else                                                                                
                                                                                                    
                    N_OUT(1) := NULL;                                                               
                    P_OUT(1) := NULL;                                                               
                    NAM_OUT(1) := NULL;                                                             
                    T_OUT(1) := NULL;                                                               
                    S_OUT(1) := NULL;                                                               
				parcel_out (1) := null;		-- july 2003                                                           
                    STATUS_OUT(1) := 5;                                                             
                                                                                                    
                END IF;                                                                             
                ---------------------------------                                                   
                EXIT;                                                                               
            END IF;                                                                                 
            END LOOP;                                                                               
	ELSE                                                                                               
		N_OUT(1) := NULL;                                                                                 
		P_OUT(1) := NULL;                                                                                 
		NAM_OUT(1) := NULL;                                                                               
		T_OUT(1) := NULL;                                                                                 
		S_OUT(1) := NULL;                                                                                 
		parcel_out (1) := null;				-- july 2003                                                           
		STATUS_OUT(1) := 6;                                                                               
        END IF;                                                                                     
    END IF;                                                                                         
-------------------------------------------------------                                             
                                                                                                    
DBMS_SQL.CLOSE_CURSOR(SELECT_CURSOR);                                                               
                                                                                                    
END VRFY_ADDR;                                                                                      
                                                                                                    
END NIRANJAN_test;                                                                                  
