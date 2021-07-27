
adrResult Table
===============

	rec_key
	rec_seq

	rec_type
			10	address  result

			21	street 1 result
			22	street 2 result		

	alternative to rec_type = 20

			20	original	==>	21 appl	22 appl

			20	alias		==>	21 parcel id
			20	verify code	==>	22 parcel id

			20	quals		==>	21,22	quals

			quals
				sat rat aat xat
				sct rct act xct


Processing Steps
================

1.	Copy App table	

		rec type = 0

	Formats

		a.	appl 			 entire location
		b.	form & addr		 intersection streets


2.	Parse
	
		read	00

		write	20

			if format = a, then b = a parts
			if format = b, then a = null

		write	21

			21.appl	= 20.form_
			21.form	= parse

		write	22

			22.appl	= 20.addr_
			22.form	= parse


3.	Name Correction

		copy		20

		read/write	21		form	=> addr

		read/write	22		form	=> addr


4.	Street Correction

		copy		20

		read/write	21		addr	=> addr

		read/write	22		addr	=> addr


5.	Intersection Street Verification

		hold		20

		hold		21 & 22

		read		intersection 

		update	21 & 22	addr	=> addr

		update	20

