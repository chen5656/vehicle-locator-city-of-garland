
drop package				niranjan;
     
create or replace	PACKAGE           niranjan		as

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
--	parcel_out	out	addr_parcel,				-- july 2003
    STATUS_OUT OUT ADDR_STATUS
);   
     
END; 
     
