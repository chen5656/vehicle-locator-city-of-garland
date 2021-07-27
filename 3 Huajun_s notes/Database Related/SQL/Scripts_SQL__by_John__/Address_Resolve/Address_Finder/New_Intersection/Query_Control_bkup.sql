
==========
MAIN QUERY
==========

	x.	Search = 1st, 1st, 2nd, 2nd, 3rd, 3rd

	x.	where	exact & exact

		where	exact & close

		where close & exact

		close = close name or original name
		close = after revision

		if	exact[2] = close[2]	then suppress others

	x.	query matches on names only
		all other filtering is done later

	x.	always retrieve 'AA' intersections

	x.	where	user_block	in (  0,  addr_block)		

		where	user_type	in ( ' ', addr_type)	
		where	user_pfx	in ( ' ', addr_pfx)	
		where	user_sfx	in ( ' ', addr_sfx)

	x.	exact name = 30
		close name = 20
		input name = 10

		soft qual  = 01

	x.	final score determines choice & acceptance

	x.	always show all name matches
		
		always show perm quals						('A')

		always show full quals						('C')

		also show soft matches on other intersection types	('X')

==================
INTERSECTION TYPES
==================

		intersection type [2]
			complete
			minimum

		primary   type	[2]
		secondary type	[2]

		basic street
			name + type + implied prefix / suffix
			implied = unique

		basic street
			1	no  = more than basic
			10	yes = basic		

		whole street
			1	no  = incomplete	
			10	yes = complete 

		note:		applying arbitrary factors to above (1, 10) permit further distinctions

======
BLOCKS
======

		no blocks		addr1 block * -1 >= 0

		only blocks		addr1 block * 1 >= 1
		
		all blocks		addr1 block * 1 >= 0
		match blocks	addr1 block * 1 >= 0

========
EXAMPLES
========

		Fifth & Austin
		show   AC
		choose A = N Fifth St / Austin St

		N Fifth & Austin
		show   X
		choose A = N Fifth St / Austin St

		N Shiloh & Forest
		show   X
		choose C = N Shiloh Rd / Forest Ln

		900 N Shiloh
		show   X
		choose B = 900 S Shiloh Rd

		E Shiloh & Forest
		show AC
		choose none




