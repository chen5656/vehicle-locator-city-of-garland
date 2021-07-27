
	x.	match user quals to Item table

	x.	look for Street reduced name & Address number (+)

	x.	if street name not found, then do Fuzzy Match

	x.	if street name found but number not found, 
		then do Near Number for user hundred block
	
	x.	put all possible street names into Name List
		class1 = starting position of 1st group
		class2 = starting position of 2nd group
		class3 = starting position of 3rd group
	

1.	select S.* 
	from	Street, [2]
	where	[2].addr_name	= S.addr_name
	and	[2].addr_qual	in (' ', S.addr_qual)	

2.	select A.* 
	from Alias,  [3]
	where	A.alias_name = [3].addr_name
	and	A.alias_qual in ( ' ', user_qual)

3.	select addr_name, instr(list,addr_name)
	from Street 
	where instr(Name_List, S.addr_name) > 0

	union all
	select user_name, 0	from dual

	union all
	select ' ', 0		from dual
	(if called parse_address)

4.	Select from Block

5.	Select from Address