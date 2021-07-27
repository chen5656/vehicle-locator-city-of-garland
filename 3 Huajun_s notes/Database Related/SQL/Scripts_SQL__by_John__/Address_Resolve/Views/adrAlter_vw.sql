
--	insert view of adrAlter


create or replace	view	adrAlter_vw
(
LO_RANGE,                      
HI_RANGE,                      
NOTES,                         
FLAG1,                         
PFX1,                          
NAME1,                         
TYPE1,                         
SFX1,                          
FLAG2,                         
PFX2,                          
NAME2,                         
TYPE2,                         
SFX2,                          
FLAG3,                         
PFX3,                          
NAME3,                         
TYPE3,                         
SFX3                          
)
as	select
LO_RANGE,                      
HI_RANGE,                      
NOTES,                         
FLAG1,                         
PFX1,                          
NAME1,                         
TYPE1,                         
SFX1,                          
FLAG2,                         
PFX2,                          
NAME2,                         
TYPE2,                         
SFX2,                          
FLAG3,                         
PFX3,                          
NAME3,                         
TYPE3,                         
SFX3                          
from	garland.adrAlter;
