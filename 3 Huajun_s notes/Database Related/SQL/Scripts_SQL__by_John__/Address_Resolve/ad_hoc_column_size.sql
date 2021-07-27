
	set echo off;

	select count(*) from adrResult_User;


	select
		max(length(rec_key))	"key",
		max(length(addr_num))	"num",
		max(length(addr_pfx))	"pfx",
		max(length(addr_name))	"name",
		max(length(addr_type))	"type",
		max(length(addr_sfx))	"sfx",
		max(length(addr_code1))	"code1",
		max(length(addr_unit1))	"unit1",
		max(length(addr_code2))	"code2",
		max(length(addr_unit2))	"unit2"

	from	adrResult_User;

	set echo on;