

	create type	o$street	as object
(
		addr_pfx		varchar(02),
		addr_name		varchar(30),
		addr_type		varchar(04),
		addr_sfx		varchar(02)
);