
Regular Edits
=============
	
=====================================================================================

	print street listing
	display distinct addr_name & qualifiers from cdreladr
	display distinct addr_name & qualifiers from trvehrcl
	visual check & correct

	select	distinct addr_name || ';;' " "
	from		cdreladr;
	from		trvehrcl;
	
=====================================================================================

	display	adr names - seg names
	display	seg names - adr names

	display	adr streets - seg streets
	display	seg streets - adr streets
	
=====================================================================================

	display	overlapping segments

	display	segments without addresses
	
=====================================================================================

	display	address lying outside of segment block
	display	address lying outside of segment range

=====================================================================================

	display	address name - fuzzy match - segment name
			where not the same

=====================================================================================

	display	duplicate cdrelpar parcel ids
	display	duplicate cdreladr parcel ids

	display	invalid cdrelpar parcel id formats
	display	invalid cdreladr parcel id formats

=====================================================================================

	display	address gaps
	display	address range truncations

=====================================================================================

	display	parcel ids w/ multiple address

=====================================================================================

	execute	address range edit

=====================================================================================
