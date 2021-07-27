
	drop view			garland.Find_Address_Rule_Vw;

	create or replace view	garland.Find_Address_Rule_Vw
(
	 rule_name
	,command				-- Verify / Select / Display

-- allow user selection	
	,allow_weight			-- alias weight
	,allow_entity			-- Address / Block / Street
	,allow_name				-- name class = 1, 2, 3, 4
	,allow_qual				-- 0-3 qualifier conflicts

-- alias name class
	,alias_right			-- min alias weight
	,alias_good				-- min alias weight
	,alias_fair				-- min alias weight
	,alias_poor				-- min alias weight

	,fuzzy_good				-- good fuzzy score
	,fuzzy_scope			-- near or far
	,fuzzy_alias			-- fuzzy match on alias names
	,fuzzy_per_alias			-- alias class triggers fuzzy search

	,also_scope				-- transpose / rhyme

-- perm display options
	,display_block			-- block grouping 
	,display_class			-- max name class displayed
	,display_upper			-- max name class at top of list
	,display_intersect		-- yes/no

-- temp show options
	,show_look_like			-- begin / complex
	,show_range				-- nearest / all
)
	AS	select

	rule_01, rule_02, rule_03, rule_04, rule_05, rule_06, rule_07, rule_08, rule_09, rule_10,

	rule_11, rule_12, rule_13, rule_14, rule_15, rule_16, rule_17, rule_18, rule_19, rule_20,

	rule_21

--	rule_21, rule_22, rule_23, rule_24, rule_25, rule_26, rule_27, rule_28, rule_29, rule_30 

	from	garland.Find_Address_Rule;


