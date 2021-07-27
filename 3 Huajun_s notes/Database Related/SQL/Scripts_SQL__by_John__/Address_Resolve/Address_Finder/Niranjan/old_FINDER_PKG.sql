
--	july 1 2003

drop package				adrfinder;
     
create or replace	PACKAGE           adrfinder		as

     
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

TYPE addr_parcel IS TABLE OF VARCHAR(11)   
	INDEX BY BINARY_INTEGER;     

TYPE ADDR_STATUS IS TABLE OF INTEGER                        
	INDEX BY BINARY_INTEGER;     

TYPE addr_total IS TABLE OF INTEGER                        
	INDEX BY BINARY_INTEGER;     
     
PROCEDURE verify_address 
(         		
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

	total_out	OUT addr_total,
	parcel_out	out addr_parcel,
	STATUS_OUT	OUT ADDR_STATUS 
);   
     
END; 


