==========================================================================
Purpose 
==========================================================================

	Adr_Compare_Name simply compares 2 names and measures the difference in their spelling.
	It makes no assumptions about a "right" name and a "wrong" name.

	"Extra" and "Missing" are simply two ways of saying the same thing.
	"Extra" and single "Orphan" are the same thing arrived at by different pathways.
	"Mistake" and "Transpose" could be blamed on either name.

	We just happen to know that the first name is wrong and the second name is right.
	The program does not know and does not care.

==========================================================================
Strategy
==========================================================================

	The Rule:	
		Focus on finding the good stuff and the bad stuff will be what's left over.

	Exception to the Rule:
		Two wrongs sometimes make a not-so-wrong when they occur apart.
		"Misplace" and "Transplace" errors are not so wrong.

	Footnote to the Exception
		Two wrongs are terribly wrong when they occur together.
		"Stop" errors are terribly wrong, but not decisive.

==========================================================================
Examples
==========================================================================

	Buckingham vs Buckham
		
		Right = 'buck' & 'ham'
		Wrong = 'ing'
		Error = Orphan 

	First vs Fitst
	
		Right = 'fi' & 'st'
		Wrong = 'r' vs 't'
		Error = Mistake

	Forest vs Fortress

		Right = 'for'  
		Wrong = 'es' vs 'tr'
		Error = Stop Error

	First vs Fist
		Right = 'ri' & 'st'
		Wrong = 'r'
		Error = Missing Letter 'r'

	Cornell vs Coronell

		Right = 'cor' & 'nell'
		Wrong = 'o'
		Error = Extra Letter 'o'	

	Acorn Green vs Arcon Green	

		Right = 'acon' & 'green'
		Extra = 'r' in aRcon Green
		Extra = 'r'	in acoRn Green
		Error = Misplaced 'r'

	First vs Fisrt

		Right = 'fi' & 't'
		Wrong = 'rs' vs 'sr'
		Error = Adjacent Transpose	

	Jupiter vs Jutiper

		Right = 'ju' & 'i' & 'er'
		Wrong = 'p' vs 't'
		Wrong = 't' vs 'p'
		Error = Separate Transpose (Transplace)	


==========================================================================
Types of Errors 
==========================================================================

	Stop Error		(adjacent wrongs)	

		Forest		Forest
		Fortress		Foreign

	Mistake Error	(isolated wrong)		     

		First			Forest
		Fitst			Foresr
	
	Extra Letter		   	

		Cornell		Forest
		Coronell		Forests

	Missing Letter		   		

		Plano			Forest
		Pano			Fores

	Misplace Letter

		Acorn Green		Country Club
		Arcon Green		County Clurb		

	Adjacent Transpose  	

		Garland		Forest
		Garlnad		Forets

	Separated Transpose (Transplace)

		Jupiter		Jupiter
		Jutiper 		Juritep

	Remaining Letters	  (Orphan)

		Lake Hubbard		Old Mill Run	Mississippi		
		Lake Ray Hubbard		Old Mill		Missippi	

		First				First			
		Fist				Firtst		

	Vowel Error

		Jupiter		Laura		Carny		Colleen
		Jupeter		Lara		Carney	Collene
					
	Double Letter

		Fremont		Moccasin
		Freemont		Mocassin

	Punctuation

		Belt Line		O Henry
		Beltline		O'Henry


--	==================================================================
--	Error Values
--	==================================================================

	100		wrong letter followed by wrong letter	(stop error)
	105		wrong letter followed by equal letter	(mistake)

	110		extra letter
	115		extra letter is misplaced

	120		missing letter
	125		missing letter is misplaced

	130		transposed letters are adjacent
	135		transposed letters are separated  		(transplace)


--	==================================================================
--	Name Search Procedures	
--	==================================================================

	adr_name_search = specification package containing control constants


	adr_compare_names	( best_names, good_names, best_count, good_count );

	adr_compare_name	( name1, name2, score, errors );

	
	best & good names = varchar2 or array  (overloading)	


	Default	
			best names	having lowest score & lowest error count
			good names	having lowest score & higher error count

	Best Count = -n
			name list	should have fixed name length = n

	Good Count = -1
			best names	having lowest score & lowest error count
			good names	having lowest score & higher error count / or next lower score


--	==================================================================
--	Rating
--	==================================================================

	Rating = (1000 - score) * (Ratio ** (errors - 01))

	Ratio = 0.7


--	==================================================================
--	Module sizes
--	==================================================================

NAME                           CODE_SIZE 
------------------------------ ----------

compare_name_test                    5700		

compare_names_test                   1200		(ran twice as long as compare_name_test)
TST_COMPARE_NAMES                    3000
						-----
						 4200

TST_COMPARE_NAME                     8250
TST_COMPARE_NAME                    14720		(including trace)



--------------------------------------------------------------
COMPARE NAME PARAMETERS

INPUT

	best name	user name
	good name	options
	count1		score  limit		(neg)
	count2	  	error  limit		(neg)
	count3	  	length differ		(neg)

OUTPUT

	best name	best names
	good name	all names w/in score
	count1		best/good count		(pos)
	count2		lower  score		(pos)
	count3		higher score		(pos)


OPTIONS

	$$$		good	= specifications

	s / a		search	= SOME/all
	b / g		count1	= BEST/good
	f / w		orphan	= FIXED/wrong scores

NOTES

	default	option	fewest/smallest

	count2		highest score below limit score
	count3		lowest  score above limit score

	error limit	limits orphan length

--------------------------------------------------------------
