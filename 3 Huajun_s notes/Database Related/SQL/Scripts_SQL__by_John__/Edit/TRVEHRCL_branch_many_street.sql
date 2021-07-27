
	set echo	off;

	select	mslink,
			branch_no, section_no,
			addr_lo, addr_hi, addr_pfx, addr_name, addr_type, addr_sfx

	from		trvehrcl

	where		branch_no	in
(
	select	branch_no
	from		trvehrcl
	where		branch_no < 9999
	group by	branch_no
	having	count(distinct addr_name) > 1
)

	order by	2, 3, addr_name, addr_type, addr_pfx, addr_sfx, addr_lo;


	set echo	on;