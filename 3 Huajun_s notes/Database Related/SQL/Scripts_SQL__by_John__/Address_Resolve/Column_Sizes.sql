
	set echo off;

	select

		max(length(addr_num  ))			num,
		max(length(addr_pfx  ))			prefix,
		max(length(addr_name ))			name,
		max(length(addr_type ))			type,
		max(length(addr_sfx  ))			suffix,
		max(length(addr_code1))			code1,
		max(length(addr_unit1))			unit1,
		max(length(addr_code2))			code2,
		max(length(addr_unit2))			unit2,
		chr(10),

		max(length(appl_num  ))			q2,
		max(length(form_pfx))			p2,
		max(length(form_name))			n2,
		max(length(form_type))			t2,
		max(length(form_sfx))			s2,
		max(length(form_code1))			c2,
		max(length(form_unit1))			u2,
		max(length(form_code2))			k2,
		max(length(form_unit2))			v2,
		chr(10),

		max(length(appl_num  ))			q3,
		max(length(appl_pfx))			p3,
		max(length(appl_name))			n3,
		max(length(appl_type))			t3,
		max(length(appl_sfx))			s3,
		max(length(appl_code1))			c1,
		max(length(appl_unit1))			u1,
		max(length(appl_code2))			k1,
		max(length(appl_unit2))			v1,
		chr(10),

		'   pid '	|| max(length(parcel_id))	||
		'   sid '	|| max(length(segment_id))	||
		'   key '	|| max(length(rec_key ))	||
		'   parse '	|| max(length(do_parse))	||
		'   alias '	|| max(length(do_alias))	||
		'   name '	|| max(length(do_name ))	||
		'   qual '	|| max(length(do_qual ))	||
		chr(10)				" "


		from adrResult

		where	verify_code > 10

		;


	set echo on;






