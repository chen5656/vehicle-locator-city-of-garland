
--	build decode list to  correct lomain city 

	select	distinct

			'	'''	|| city || ''',	'	||
			''''	|| 'GARLAND'  || ''','
			" "

	from		leads.lomain

	where	(
		nvl (length (translate (rtrim(city), '/GARLAND', '/')), 0) 
	+	nvl (length (translate ('GARLAND', '/' || rtrim(city) , '/')), 0) <=  2 
		)

	and	city not in ( 	'CRANDALL','DARLING',  'DURANGO', 'GARDEN',    'GARDNER', 'GLENDORA',
				  	'HARLAND', 'LAGRANGE', 'RANDALL', 'RIDGELAND', 'SUGARLAND',
					'CRANDAL', 'DRANGO',   'LA GRANDE'	
				);

--	=================================================================================================
/*

	update rms_lomain
	set	city = decode ( city,

	'  GARLAND           ',	'GARLAND',
	' ARLAND             ',	'GARLAND',
	' GARLAND            ',	'GARLAND',
	',GARLAND            ',	'GARLAND',
	'.GARLAND            ',	'GARLAND',
	'2ARLAND             ',	'GARLAND',
	'7ARLAND             ',	'GARLAND',
	'AGRLAND             ',	'GARLAND',
	'ANDLAND             ',	'GARLAND',
	'ARLAND              ',	'GARLAND',
	'BARLAND             ',	'GARLAND',
	'BGARLAND            ',	'GARLAND',
	'CARLAND             ',	'GARLAND',
	'GAARLAND            ',	'GARLAND',
	'GAGLAND             ',	'GARLAND',
	'GALAND              ',	'GARLAND',
	'GALNAND             ',	'GARLAND',
	'GALRAND             ',	'GARLAND',
	'GALRNAD             ',	'GARLAND',
	'GARALAND            ',	'GARLAND',
	'GARALND             ',	'GARLAND',
	'GARAND              ',	'GARLAND',
	'GARELAND            ',	'GARLAND',
	'GARKAND             ',	'GARLAND',
	'GARKLAND            ',	'GARLAND',
	'GARL,AND            ',	'GARLAND',
	'GARL;AND            ',	'GARLAND',
	'GARLAAND            ',	'GARLAND',
	'GARLAD              ',	'GARLAND',
	'GARLADN             ',	'GARLAND',
	'GARLALND            ',	'GARLAND',
	'GARLAMD             ',	'GARLAND',
	'GARLAMND            ',	'GARLAND',
	'GARLAN              ',	'GARLAND',
	'GARLAN;D            ',	'GARLAND',
	'GARLAN<D            ',	'GARLAND',
	'GARLANAD            ',	'GARLAND',
	'GARLANB             ',	'GARLAND',
	'GARLANBD            ',	'GARLAND',
	'GARLAND             ',	'GARLAND',
	'GARLAND 1           ',	'GARLAND',
	'GARLAND PD          ',	'GARLAND',
	'GARLAND X           ',	'GARLAND',
	'GARLAND `           ',	'GARLAND',
	'GARLAND,            ',	'GARLAND',
	'GARLAND,DR          ',	'GARLAND',
	'GARLAND,GX          ',	'GARLAND',
	'GARLAND,T           ',	'GARLAND',
	'GARLAND,X           ',	'GARLAND',
	'GARLAND/PD          ',	'GARLAND',
	'GARLANDD            ',	'GARLAND',
	'GARLANDPRI          ',	'GARLAND',
	'GARLANDQ            ',	'GARLAND',
	'GARLANDS            ',	'GARLAND',
	'GARLANDT            ',	'GARLAND',
	'GARLANDTX           ',	'GARLAND',
	'GARLANDX            ',	'GARLAND',
	'GARLANDY            ',	'GARLAND',
	'GARLAND`            ',	'GARLAND',
	'GARLANED            ',	'GARLAND',
	'GARLANJD            ',	'GARLAND',
	'GARLANMD            ',	'GARLAND',
	'GARLANND            ',	'GARLAND',
	'GARLANR             ',	'GARLAND',
	'GARLANS             ',	'GARLAND',
	'GARLAQND            ',	'GARLAND',
	'GARLARND            ',	'GARLAND',
	'GARLASND            ',	'GARLAND',
	'GARLKAND            ',	'GARLAND',
	'GARLLAND            ',	'GARLAND',
	'GARLNAD             ',	'GARLAND',
	'GARLND              ',	'GARLAND',
	'GARLOAND            ',	'GARLAND',
	'GARNAND,            ',	'GARLAND',
	'GARRLAND            ',	'GARLAND',
	'GGARLAND            ',	'GARLAND',
	'GRALAND             ',	'GARLAND',
	'GRALND              ',	'GARLAND',
	'GRLAND              ',	'GARLAND',
	'RARLAND             ',	'GARLAND',

	city;

*/
--	=================================================================================================



