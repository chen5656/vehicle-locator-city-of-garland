	set echo off;
--	==============================================================

	truncate table	garland.Find_Address_Rule		reuse storage;

--	==============================================================

	insert into		garland.Find_Address_Rule_Vw
(	rule_name,        command,       show_like,       show_range,
	allow_weight,     allow_entity,  allow_name,      allow_qual,
	alias_right,      alias_good,    alias_fair,      alias_poor, 
	fuzzy_good,       fuzzy_scope,   fuzzy_per_alias, fuzzy_alias,
	display_block,    display_class, display_also,    display_upper,   display_intersect 
)	values

(	'GIS VERIFY',	'VERIFY',	'BEGIN',		'NUM',				-- show

	'6',		'S',			'4',			'3',					-- allow
--	'6',		'B',			'1',			'0',					-- allow

	'7',		'6',			'4',			'2',					-- alias

	'200',	'0',			'6',			'1',					-- fuzzy

	'',		'4',			'RHYME',		'2',		'BB%'			-- display
--	'0',		'4',			'RHYME',		'2',		'BB%'			-- display
);


--	==============================================================

	insert into		garland.Find_Address_Rule_Vw
(	rule_name,        command,       show_like,       show_range,
	allow_weight,     allow_entity,  allow_name,      allow_qual,
	alias_right,      alias_good,    alias_fair,      alias_poor, 
	fuzzy_good,       fuzzy_scope,   fuzzy_per_alias, fuzzy_alias,
	display_block,    display_class, display_also,    display_upper,   display_intersect 
)	values

(	'CCS VERIFY',	'VERIFY',	'BEGIN',		'NUM',				-- show

	'6',		'S',			'4',			'3',					-- allow
--	'6',		'B',			'1',			'0',					-- allow

	'7',		'6',			'4',			'2',					-- alias

	'200',	'0',			'6',			'1',					-- fuzzy

	'',		'4',			'RHYME',		'2',		'BB%'			-- display
--	'0',		'4',			'RHYME',		'2',		'BB%'			-- display
);

--	==============================================================

	commit;

--	==============================================================
/* 	INSERT TEMPLATE

	insert into		garland.Find_Address_Rule_Vw
(	rule_name,        command,       show_like,       show_range,			
	allow_weight,     allow_entity,  allow_name,      allow_qual,
	alias_right,      alias_good,    alias_fair,      alias_poor, 
	fuzzy_good,       fuzzy_scope,   fuzzy_alias,     fuzzy_per_alias,
	display_block,    display_class, display_also,    display_upper,   display_intersect 
)	values
(	'',		'',			'',			'',					-- show
	'',		'',			'',			'',					-- allow
	'',		'',			'',			'',					-- alias
	'',		'',			'',			'',					-- fuzzy
	'',		'',			'',			'',		''			-- display
);

*/
--	==============================================================
	set echo on;

