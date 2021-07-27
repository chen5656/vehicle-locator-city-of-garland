	set echo	off;

	variable	 spec_table		varchar2(20);
	execute	:spec_table	:=	'COMPLAINT';

	select rpad(' ',70) " " from dual;

--	=========================================================================
--	table

	select rpad(:spec_table, 20) table_name	from dual;

	select
		column_name, 
		rpad(data_type, 16) 									TYPE, 
		rpad(data_length || rpad(',', sign(data_scale + 1)) || data_scale, 12)	"LENGTH,SCALE",
		decode (nullable, 'N', 'not null', null)						" "
			
	from	all_tab_columns@cdep.world
	where	table_name = :spec_table
	order by column_id;

--	=========================================================================
--	index

	select distinct
		rpad(c.index_name,  20)		index_name, 
		lpad(c.column_position,02)	" ",
		rpad(c.column_name, 20) 	column_name, 
		rpad(x.uniqueness,  10)		uniqueness
		
	from	all_ind_columns@cdep.world	c,
		all_indexes@cdep.world		x
	where	c.table_name = :spec_table
	and	c.index_name = x.index_name;

--	=========================================================================
--	foreign key child

	select distinct
		rpad(c.constraint_name,	 20)	constraint, 
		lpad(cc.position,        02)	" ",
		rpad(cc.column_name,	 20)	column_name,
		rpad(c.constraint_type,  04) 	type, 
		rpad(c.r_constraint_name,20)	references
		
	from	all_constraints@cdep.world	c,
		all_cons_columns@cdep.world	cc

	where c.table_name 	= :spec_table
	and	c.constraint_name	= cc.constraint_name
	and	c.constraint_type in ( 'P', 'U', 'R');	

--	=========================================================================
--	foreign key parent

	select distinct
		rpad(c.constraint_name,  20)	child_constraint, 
		lpad(cc.position,        02)	" ",
		rpad(cc.column_name,     20)	column_name,
		rpad(c.constraint_type,  04)	type, 
		rpad(p.r_constraint_name,20)	references
		
	from	all_constraints@cdep.world	p,
		all_constraints@cdep.world	c,
		all_cons_columns@cdep.world	cc

	where p.table_name		= :spec_table
	and	p.constraint_name		= c.r_constraint_name
	and	cc.constraint_name	= c.constraint_name;

--	=========================================================================

	select rpad(' ',70) " " from dual;

	set echo	on;
