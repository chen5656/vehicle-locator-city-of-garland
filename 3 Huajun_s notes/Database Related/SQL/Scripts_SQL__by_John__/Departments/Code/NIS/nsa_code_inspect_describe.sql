
NSA CODE INSPECTION	DESCRIPTION
===================	===========

CASE_NUMBER                    	case number		from inspection file     
INSPECTION_DATE                	inspection date      	from inspection file
CASE_CLOSED_DATE        	case closed date	from inspection file            

ADDR_NUM                    	address info		from code address file
ADDR_PFX                           
ADDR_NAME                           
ADDR_TYPE                           
ADDR_SFX                            
UNIT_NUM                            
ZIP_CODE                            

ISSUE_DATE                      issue date		from citation file    
COMPLY_DATE                     comply date		from citation file    
FOLLOW_UP_ACTION                follow up action	from inspection file    
ACTION                          action			from case violation file    
STATUS                          status			from case violation file    
CODE_ID                         code id			from case violation file	    
VIOLATION_ID                    violation id		from case violation file    
VIOLATION                       violation		from case violation file
    
SUBDIV_ID                       gis link to tax subdivision    
PARCEL_ID                       gis link to garland address    
SEGMENT_ID                      gis link to city block containing address    

VERIFY_ID                       indicates how valid the address is
				0 = invalid street name
				1 = valid name but bad number
				2 = valid name & number but invalid prefix, suffix, or type
				3 = incomplete address (missing prefix, suffix, or type)
				4 = valid address    
