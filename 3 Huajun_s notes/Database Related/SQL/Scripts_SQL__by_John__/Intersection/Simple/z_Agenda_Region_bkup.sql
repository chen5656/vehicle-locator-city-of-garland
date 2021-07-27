=================================================================================

	Note:	** indicates an indexed column

	Centerline ROAD feature

	**	Road ID
		Street

		Left  Address range
		Right Address ramge

		Left  Address Parity [0 = Even  1 = Odd]
		Right Address Parity [0 = Even  1 = Odd]


	ESRI NODE table		[ESRI extract from Road feature]

	**	Node ID		[at endpoint of Road segment]
		X Coord
		Y Coord


	ESRI ROAD table		[ESRI extract from Road feature]

	**	Road ID		[Centerline record]
		From Node ID	[temporary ESRI value]
		To   Node ID	

	Note:		ESRI Road record generates 4 Spoke records 
			for 2 Node Junctions = From & To
			and 2 Road Sides    =  Left & Right	


	SPOKE table

	**	Hub Node
	**	Road
	**	Side			[+1 = Left	-1 = Right		Road Side]

		Junction		[+1 = From  -1 = To		Road Node at intersection]

		X,Y Vectors		[End X,Y - Hub X,Y] 

		Parity		[of address range on Side of Road ]
		End Node
		REGION		[of Region Type being considered]


	CORNER table		[Intersection of 2 Spokes]

	**	Node
	**	This Road 

		Side			[Junction * Cross Product]

		That Road
		REGION

	Note:	Cross Product = [This X Vector * That Y Vector ] - [That X Vector * This Y Vector]
		Indicates whether This Road is the clockwise (positive) or counterclockwise (negative) leg
		of the intersecting Spokes (This road & That road)

	Note: Corner Side = Side of This Road containing intersecting region
		Corner Side = Sign(Cross Product) * Junction

		Side		= +1 or -1  =  Left or Right
		Sign(CP)	= +1 or -1  =  Clockwise or CounterClockwise
		Junction	= +1 or -1	=  From or To


	ROAD SIDE REGION table

	**	Road
	**	Parity
		Side
		Region Type				[Zip, Council, Beat, Code, etc]
		Region ID


	INTERSECTION table

		This Road Hundred Block 	[at From or To Junction Node]
		That Road Hundred Block 	[at From or To Junction Node]
		Node ID				[common Junction Node]

		Regions				[for different Region types]


	BLOCK SIDE table

	**	Road Street
	**	Road Hundred Block		[Left or Right side]
	**	Parity				(Even or Odd]

		Regions				[for different Region types]		

=================================================================================

	CLEAR REGION

		Spoke  region = null
		Corner region = null

	INITIALIZE SPOKE

		left/right	road		parity
				address	parity	parcel


=================================================================================

	driver	Clear Regions

	driver	update from Point regions (see below)

	driver	update from Parcel

	driver	call above Functions	update records	return update count

	driver	update Block regions		from Spoke 

	driver	update Intersection regions	from Corner

=================================================================================

	Spoke		from	ESRI Node & ESRI Road	
			join	Node

	Corner	from	Spoke & Spoke 		
			join	Node

---------------------------------------------------------------------------------

	Parcel region	to	Spoke Left	
	Parcel region	to	Spoke Right
			join	Street
			join	Range
			join	Parity

---------------------------------------------------------------------------------

	Update	Spoke (empty) by Spoke (region)
			join	That Node = This Node
			join	Road
			join	Side
			for	Junctions From & To

	Linear 	Spoke 
			per app rowid = order by Side, Address, Junction


	Update	Corner (empty) by Spoke (region)
			join	Node		This Node
			join	This Road	Road
			join	Side		Side

	Update	Corner (empty) by Corner (region)
			join	Node
			join	This Road	That Road

	Update	Spoke (empty) by Corner (region) 
			join	This Node	Road		
			join	Road		This Road	
			join	Side		Side

=================================================================================

	Make Point feature from ESRI Node
	ESRI assign Region to each Point
	If From & To Nodes in same Region, then entire Road is in region
	Except for boundary Roads

=================================================================================


