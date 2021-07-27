
--	adrAlias pctfree = 30 / (46 + 30) =  0.39

--	By not figuring data block overhead, pctfree is larger, giving extra room for updates


	set echo	off;

	select avg (						--	46
				
		vsize (alias_name)	+
		vsize (alias_type)	+
		vsize (alias_pfx)		+
		vsize (alias_sfx)		+

		nvl(vsize (addr_name),0)	+
		nvl(vsize (addr_type),0)	+
		nvl(vsize (addr_pfx), 0)	+
		nvl(vsize (addr_sfx), 0)	+

		nvl(vsize (alias_lo), 0)	+
		nvl(vsize (alias_hi), 0)	+
		nvl(vsize (alias_how),0)	+

		11							--	11 columns
		)	"initial"

	from	adrAlias;
	



	select avg (						--	30

		nvl(vsize (alias_compress),0)	+
		nvl(vsize (alias_compact), 0)	+
		nvl(vsize (alias_reduced), 0)	+
		3							--	3 columns
		)	"extension"

	from	adrAlias;
