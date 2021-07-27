
==============
ALTER STRATEGY
==============
						adrStreet

						   |			
						   |			
						   V

	adrAlter  <-->	Alias_Roster	--->	adrAlias


============
INTERSECTION
============

	full address	  =  5 + 4 = 09 items
	full intersection =  5 + 5 = 10 items

	Alien reformats an invalid intersection entry
	Parse sees a valid intersection entry

	Different streets within intersection can be handled 
	by different Alias records

================================
ALTER COMMAND FILE (unnecessary)
================================

	insert into adrAlter_view1 values(	'',	'','','',	'notes',	
'',	'801A','','Walnut Cir E','','',
'',	'0','','Walnut','Cir','E',		
'',	'0','','Walnut Circle East','','',	);


	insert into adrAlter_view2 values(	'1',		'notes',
'',	'801A','','N Country Club Rd E','Bdg 21','',	'0','','','','',	
'',	'0','N','Country Club','Rd','E',			'0','Bdg', '21','', 'A',	
'',	'0','S','Country Club','Rd','E',			'0','Bldg','21','#','A',		);


	insert into adrAlter_view2 values(	'2',		'notes',
'',	'800','','S Country Club E / Walnut','','',	'1200','','','','',	
'',	'0','S','Country Club','','E',			'0','','Walnut','','',	
'',	'0','S','Country Club','Rd','E',			'0','E','Walnut','St','',		);


