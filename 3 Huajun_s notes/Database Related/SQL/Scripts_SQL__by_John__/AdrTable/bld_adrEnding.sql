	set echo	off;
--	===================================================================================
--	adrEnding contains street name endings
--	===================================================================================

--	the following should be true of a street name ending, at least some of the time
--		it is attached directly without an intervening space
--		it is part of a two name conjuction

--	===================================================================================

--	INSURE	'WINE' before 'WIN'
--	put subset	'WIN'  after superset 'WINE'

--	===================================================================================

	truncate table garland.adrEnding  reuse storage;             
	insert into garland.adrEnding (name) values ( 'AIRE' );      
	insert into garland.adrEnding (name) values ( 'APPLE' );     
	insert into garland.adrEnding (name) values ( 'BACK' );      
	insert into garland.adrEnding (name) values ( 'BANKS' );     
	insert into garland.adrEnding (name) values ( 'BAR' );       
	insert into garland.adrEnding (name) values ( 'BAY' );       
	insert into garland.adrEnding (name) values ( 'BEACH' );     
	insert into garland.adrEnding (name) values ( 'BELL' );      
	insert into garland.adrEnding (name) values ( 'BEND' );      
	insert into garland.adrEnding (name) values ( 'BERRY' );     
	insert into garland.adrEnding (name) values ( 'BILT' );      
	insert into garland.adrEnding (name) values ( 'BIRD' );      
	insert into garland.adrEnding (name) values ( 'BORO' );      
	insert into garland.adrEnding (name) values ( 'BOW' );       
	insert into garland.adrEnding (name) values ( 'BRANCH' );    
	insert into garland.adrEnding (name) values ( 'BREEZE' );    
	insert into garland.adrEnding (name) values ( 'BRIAR' );     
	insert into garland.adrEnding (name) values ( 'BRIDGE' );    
	insert into garland.adrEnding (name) values ( 'BROOK' );     
	insert into garland.adrEnding (name) values ( 'BRUSH' );     
	insert into garland.adrEnding (name) values ( 'BUNION' );    
	insert into garland.adrEnding (name) values ( 'BURG' );      
	insert into garland.adrEnding (name) values ( 'BURGH' );     
	insert into garland.adrEnding (name) values ( 'BURN' );      
	insert into garland.adrEnding (name) values ( 'BURY' );      
	insert into garland.adrEnding (name) values ( 'BUSH' );      
	insert into garland.adrEnding (name) values ( 'CASTLE' );    
	insert into garland.adrEnding (name) values ( 'CHALMERS' );  
	insert into garland.adrEnding (name) values ( 'CHESTER' );   
	insert into garland.adrEnding (name) values ( 'CLAIR' );     
	insert into garland.adrEnding (name) values ( 'CLAY' );      
	insert into garland.adrEnding (name) values ( 'CLIFF' );     
	insert into garland.adrEnding (name) values ( 'COACH' );     
	insert into garland.adrEnding (name) values ( 'COMB' );      
	insert into garland.adrEnding (name) values ( 'COVE' );      
	insert into garland.adrEnding (name) values ( 'CREEK' );     
	insert into garland.adrEnding (name) values ( 'CREST' );     
	insert into garland.adrEnding (name) values ( 'CROFT' );     
	insert into garland.adrEnding (name) values ( 'CUP' );       
	insert into garland.adrEnding (name) values ( 'CYPRESS' );   
	insert into garland.adrEnding (name) values ( 'DALE' );      
	insert into garland.adrEnding (name) values ( 'DAY' );       
	insert into garland.adrEnding (name) values ( 'DELL' );      
	insert into garland.adrEnding (name) values ( 'DELLE' );     
	insert into garland.adrEnding (name) values ( 'DOWNE' );     
	insert into garland.adrEnding (name) values ( 'DRAGON' );    
	insert into garland.adrEnding (name) values ( 'EAST' );      
	insert into garland.adrEnding (name) values ( 'EDGE' );      
	insert into garland.adrEnding (name) values ( 'FAX' );       
	insert into garland.adrEnding (name) values ( 'FIELD' );     
	insert into garland.adrEnding (name) values ( 'FINCH' );     
	insert into garland.adrEnding (name) values ( 'FISHER' );    
	insert into garland.adrEnding (name) values ( 'FLOWER' );    
	insert into garland.adrEnding (name) values ( 'FOLK' );      
	insert into garland.adrEnding (name) values ( 'FONT' );      
	insert into garland.adrEnding (name) values ( 'FORD' );      
	insert into garland.adrEnding (name) values ( 'FRONT' );     
	insert into garland.adrEnding (name) values ( 'GAME' );      
	insert into garland.adrEnding (name) values ( 'GARRY' );     
	insert into garland.adrEnding (name) values ( 'GATE' );      
	insert into garland.adrEnding (name) values ( 'GLASS' );     
	insert into garland.adrEnding (name) values ( 'GLEN' );      
	insert into garland.adrEnding (name) values ( 'GLOVE' );     
	insert into garland.adrEnding (name) values ( 'GLOW' );      
	insert into garland.adrEnding (name) values ( 'GOLD' );      
	insert into garland.adrEnding (name) values ( 'GRANDE' );    
	insert into garland.adrEnding (name) values ( 'GRASS' );     
	insert into garland.adrEnding (name) values ( 'GREEN' );     
	insert into garland.adrEnding (name) values ( 'GROVE' );     
	insert into garland.adrEnding (name) values ( 'GUM' );       
	insert into garland.adrEnding (name) values ( 'HALL' );      
	insert into garland.adrEnding (name) values ( 'HAM' );       
	insert into garland.adrEnding (name) values ( 'HAMPTON' );   
	insert into garland.adrEnding (name) values ( 'HAVEN' );     
	insert into garland.adrEnding (name) values ( 'HEAD' );      
	insert into garland.adrEnding (name) values ( 'HENGE' );     
	insert into garland.adrEnding (name) values ( 'HILL' );      
	insert into garland.adrEnding (name) values ( 'HOLLOW' );    
	insert into garland.adrEnding (name) values ( 'HOOD' );      
	insert into garland.adrEnding (name) values ( 'HORN' );      
	insert into garland.adrEnding (name) values ( 'HOUSE' );     
	insert into garland.adrEnding (name) values ( 'HURST' );     
	insert into garland.adrEnding (name) values ( 'KNOLL' );     
	insert into garland.adrEnding (name) values ( 'LAKE' );      
	insert into garland.adrEnding (name) values ( 'LAND' );      
	insert into garland.adrEnding (name) values ( 'LANDS' );     
	insert into garland.adrEnding (name) values ( 'LEAF' );      
	insert into garland.adrEnding (name) values ( 'LEDGE' );     
	insert into garland.adrEnding (name) values ( 'LEIGH' );     
	insert into garland.adrEnding (name) values ( 'LIGHT' );     
	insert into garland.adrEnding (name) values ( 'LINE' );      
	insert into garland.adrEnding (name) values ( 'LOOK' );      
	insert into garland.adrEnding (name) values ( 'MAN' );       
	insert into garland.adrEnding (name) values ( 'MARIE' );     
	insert into garland.adrEnding (name) values ( 'MARK' );      
	insert into garland.adrEnding (name) values ( 'MASS' );      
	insert into garland.adrEnding (name) values ( 'MEADE' );     
	insert into garland.adrEnding (name) values ( 'MEADOW' );    
	insert into garland.adrEnding (name) values ( 'MERE' );      
	insert into garland.adrEnding (name) values ( 'MILK' );      
	insert into garland.adrEnding (name) values ( 'MILL' );      
	insert into garland.adrEnding (name) values ( 'MINSTER' );   
	insert into garland.adrEnding (name) values ( 'MOND' );      
	insert into garland.adrEnding (name) values ( 'MONT' );      
	insert into garland.adrEnding (name) values ( 'MOOR' );      
	insert into garland.adrEnding (name) values ( 'MOUTH' );     
	insert into garland.adrEnding (name) values ( 'NECKER' );    
	insert into garland.adrEnding (name) values ( 'NOTE' );      
	insert into garland.adrEnding (name) values ( 'NUT' );       
	insert into garland.adrEnding (name) values ( 'OAK' );       
	insert into garland.adrEnding (name) values ( 'OAKS' );      
	insert into garland.adrEnding (name) values ( 'PARK' );      
	insert into garland.adrEnding (name) values ( 'PART' );      
	insert into garland.adrEnding (name) values ( 'PIPER' );     
	insert into garland.adrEnding (name) values ( 'POINT' );     
	insert into garland.adrEnding (name) values ( 'PORT' );      
	insert into garland.adrEnding (name) values ( 'RIDGE' );     
	insert into garland.adrEnding (name) values ( 'RISE' );      
	insert into garland.adrEnding (name) values ( 'ROBIN' );     
	insert into garland.adrEnding (name) values ( 'ROCK' );      
	insert into garland.adrEnding (name) values ( 'ROD' );       
	insert into garland.adrEnding (name) values ( 'ROSE' );      
	insert into garland.adrEnding (name) values ( 'ROW' );       
	insert into garland.adrEnding (name) values ( 'SCAPE' );     
	insert into garland.adrEnding (name) values ( 'SET' );       
	insert into garland.adrEnding (name) values ( 'SHED' );      
	insert into garland.adrEnding (name) values ( 'SHIRE' );     
	insert into garland.adrEnding (name) values ( 'SHORE' );     
	insert into garland.adrEnding (name) values ( 'SIDE' );      
	insert into garland.adrEnding (name) values ( 'SMITH' );     
	insert into garland.adrEnding (name) values ( 'SON' );       
	insert into garland.adrEnding (name) values ( 'SPRING' );    
	insert into garland.adrEnding (name) values ( 'SPRINGS' );   
	insert into garland.adrEnding (name) values ( 'SPUR' );      
	insert into garland.adrEnding (name) values ( 'SQUARE' );    
	insert into garland.adrEnding (name) values ( 'STAR' );      
	insert into garland.adrEnding (name) values ( 'STEAD' );     
	insert into garland.adrEnding (name) values ( 'STEM' );      
	insert into garland.adrEnding (name) values ( 'STICK' );     
	insert into garland.adrEnding (name) values ( 'STONE' );     
	insert into garland.adrEnding (name) values ( 'STRONG' );    
	insert into garland.adrEnding (name) values ( 'SUCKLE' );    
	insert into garland.adrEnding (name) values ( 'TABLE' );     
	insert into garland.adrEnding (name) values ( 'THORNE' );    
	insert into garland.adrEnding (name) values ( 'TOP' );       
	insert into garland.adrEnding (name) values ( 'TOWER' );     
	insert into garland.adrEnding (name) values ( 'TOWN' );      
	insert into garland.adrEnding (name) values ( 'TRAIL' );     
	insert into garland.adrEnding (name) values ( 'TREE' );      
	insert into garland.adrEnding (name) values ( 'VALE' );      
	insert into garland.adrEnding (name) values ( 'VALLEY' );    
	insert into garland.adrEnding (name) values ( 'VIEW' );      
	insert into garland.adrEnding (name) values ( 'VILLE' );     
	insert into garland.adrEnding (name) values ( 'WALL' );      
	insert into garland.adrEnding (name) values ( 'WATER' );     
	insert into garland.adrEnding (name) values ( 'WAY' );       
	insert into garland.adrEnding (name) values ( 'WEALTH' );    
	insert into garland.adrEnding (name) values ( 'WELL' );      
	insert into garland.adrEnding (name) values ( 'WEST' );      
	insert into garland.adrEnding (name) values ( 'WHEEL' );     
	insert into garland.adrEnding (name) values ( 'WICH' );      
	insert into garland.adrEnding (name) values ( 'WICK' );      
	insert into garland.adrEnding (name) values ( 'WILL' );      
	insert into garland.adrEnding (name) values ( 'WIN' );       
	insert into garland.adrEnding (name) values ( 'WIND' );      
	insert into garland.adrEnding (name) values ( 'WINE' );      
	insert into garland.adrEnding (name) values ( 'WOOD' );      
	insert into garland.adrEnding (name) values ( 'WORTH' );     
	insert into garland.adrEnding (name) values ( 'WRIGHT' );    
	insert into garland.adrEnding (name) values ( 'WRIGHT' );    
	insert into garland.adrEnding (name) values ( 'YARD' );      
	insert into garland.adrEnding (name) values ( 'YARD' );      
	commit;                                                      

--	================================================================

	select count(*) "total " from adrEnding;

--	================================================================
	set echo	on;
