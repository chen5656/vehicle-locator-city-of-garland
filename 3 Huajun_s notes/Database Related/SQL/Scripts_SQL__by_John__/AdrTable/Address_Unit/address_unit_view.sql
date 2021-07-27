	set echo	off;

	create or replace view	temp_view
(
	REC_KEY,                       

	ADDR_NUM,                      
	ADDR_PFX,                      
	ADDR_NAME,                     
	ADDR_TYPE,                     
	ADDR_SFX,                      
	ADDR_CODE1,                    
	ADDR_UNIT1,                    
	ADDR_CODE2,                    
	ADDR_UNIT2,                    

	PARCEL_ID,
	VERIFY_CODE,                   
	DO_PARSE,                      
	DO_ALIAS,                      
	DO_NAME,                       
	DO_QUAL,                       

	APPL_NUM,                      
	APPL_PFX,                      
	APPL_NAME,                     
	APPL_TYPE,                     
	APPL_SFX,                      
	APPL_CODE1,                    
	APPL_UNIT1,                    
	APPL_CODE2,                    
	APPL_UNIT2
)
	as select

	item01,

	item02,
	item03,
	item04,
	item05,
	item06,
	item07,
	item08,
	item09,
	item10,

	item11,
	item12,
	item13,
	item14,
	item15,
	item16,

	item17,
	item18,
	item19,
	item20,
	item21,
	item22,
	item23,
	item24,
	item25

	from	garland.gis_temp4;

--	====================================================================
/*

	truncate table	gis_temp4		reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

	insert into temp_view
	select

	REC_KEY,                       

	ADDR_NUM,                      
	ADDR_PFX,                      
	ADDR_NAME,                     
	ADDR_TYPE,                     
	ADDR_SFX,                      
	ADDR_CODE1,                    
	ADDR_UNIT1,                    
	ADDR_CODE2,                    
	ADDR_UNIT2,                    

	PARCEL_ID,
	VERIFY_CODE,                   
	DO_PARSE,                      
	DO_ALIAS,                      
	DO_NAME,                       
	DO_QUAL,                       

	APPL_NUM,                      
	APPL_PFX,                      
	APPL_NAME,                     
	APPL_TYPE,                     
	APPL_SFX,                      
	APPL_CODE1,                    
	APPL_UNIT1,                    
	APPL_CODE2,                    
	APPL_UNIT2

	from	garland.adrResult;

*/
--	====================================================================
	set echo	on;
