
--	Find pairs of Alias records which could yield a 'many' result


--	select	count(*)
	select	' '||	a.alias_name, a.alias_type, a.alias_pfx, a.alias_sfx, a.alias_weight, a.alias_how, chr(10),
				b.alias_name, b.alias_type, b.alias_pfx, b.alias_sfx, b.alias_weight, b.alias_how, chr(10)

	from		adrAlias	a,
			adrAlias	b

	where		a.alias_name 	= b.alias_name
	and		a.alias_weight	= b.alias_weight
	and		a.rowid <> b.rowid

	and		nvl(rtrim(a.alias_type,'*'), b.alias_type) = nvl(rtrim(b.alias_type,'*'), a.alias_type)
	and		nvl(rtrim(a.alias_pfx, '*'), b.alias_pfx)  = nvl(rtrim(b.alias_pfx, '*'), a.alias_pfx)
	and		nvl(rtrim(a.alias_sfx, '*'), b.alias_sfx)  = nvl(rtrim(b.alias_sfx, '*'), a.alias_sfx)

	;