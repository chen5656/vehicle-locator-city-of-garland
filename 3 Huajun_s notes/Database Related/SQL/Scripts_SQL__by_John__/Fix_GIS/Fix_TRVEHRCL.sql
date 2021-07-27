
	select
		addr_pfx	" ",
		addr_name	" ",
		addr_type	" ",
		addr_left_from	"left",
		addr_left_to	" ",
		addr_rght_from	"right ",
		addr_rght_to	" "

	from	trvehrcl

	where	mslink = 2626	;



/*

	update trvehrcl

		set	addr_left_from	=	28,
			addr_left_to	=	28,
			addr_rght_from	=	28,
			addr_rght_to	=	28

		where	mslink =	2626
		;

	rollback;
	commit;


*/