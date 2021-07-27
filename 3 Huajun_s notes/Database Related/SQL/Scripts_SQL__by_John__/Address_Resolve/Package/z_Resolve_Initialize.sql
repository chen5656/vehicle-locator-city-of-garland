
==================================
	adrResolve Initialization
==================================

======
RULES
=====

	do_alien		may indicate invalid name, but never a valid name

	do_alias		may indicate invalid name, but never a valid name
				it is always followed by do_name or do_street

	verify code	results

		do alien		vc <	10
		do parse		vc <	10
		do alias		vc <	10
		do name		vc <=	10
		do(qual)		vc >	10

		appl & addr		vc <	10
		form			vc <= 10

	alias	
		do alien		reset
		do parse		reset if vc >= 10
		do alias form	reset if vc >= 10		
		do name		reset if vc >= 10
		do(qual)		reset if vc >  10

	parse	
		do alien		reset
		do parse		reset

	name	
		do alien		reset
		do parse		reset
		do alias form	reset
		do name		reset

	qual	
		do alien		reset
		do parse		reset
		do alias form	reset
		do name		reset
		do(qual)		reset


	appl		reset 		verify / alias / parse / name / qual
	appl/addr	no reset		verify / alias

	form		reset			name / alias / qual
	addr		reset 		qual

	do parse reset			addr / alias / name / qual / verify

	do alias fuzzy			equivalent do alias form	

	do alias addr			reset qual	
						reset verify if vc > 10


======
LEGEND
======

	columns	refer to adrResult columns

	rows		refer to Rules (do) or adrResult

	=		means  leave alone
	-		means  reset value

	v		means  leave alone 
			except reset when verify >= valid name
	a		means  leave alone
			except reset when alias maps appl name

======================================================================================================
				form	addr		verify	alias		parse		name	qual		
======================================================================================================

do alien			-	-		-		-		-		-	-		

do parse appl		-	-		a		a		-		-	-			

do parse reset		=	-		-		-		=		-	-		

do alias form		=	-		v		v		=		-	-		
do alias fuzzy		=	-		v		=		=		-	-

do alias addr		=	=		=		=		=		=	=		

do name			=	-		v		=		=		-	-		

do street			=	=		v		=		=		=	-		

do block			=	=		=		=		=		=	=
do range			=	=		=		=		=		=	=
do address			=	=		=		=		=		=	=

form is null		=	-		v		v		-		-	-				

addr is null		=	=		v		v		=		-	-		


