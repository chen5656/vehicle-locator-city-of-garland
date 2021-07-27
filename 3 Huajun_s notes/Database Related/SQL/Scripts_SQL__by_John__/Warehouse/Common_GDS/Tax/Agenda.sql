===========
LOT & BLOCK
===========

	keywords	string		'BLK LOT ...'


	key array
			key			'BLK'
			info			'24'


	block counter
		first seq
		last  seq

	lot   occurs
	part  occurs
	acs	occurs


	end-of-legal keywords
		'$$$'
		'JURIS'


	need look-ahead when '&' is encountered
	full extract into arrays is done first
	formatting extract into fields is done last
