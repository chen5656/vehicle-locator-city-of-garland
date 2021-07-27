	set echo on;

	create or replace	function	UMS_Attrib_Value
(
	asset_area	in SFG.AM00100M.ASSET_AREA@umsp.world%TYPE,		--	'SW'
    
	asset_type	in SFG.AM00100M.ASSET_TYPE@umsp.world%TYPE,		--	'FL'
    
	asset_no	in SFG.AM00100M.ASSET_NO@umsp.world%TYPE,
    
	attribute	in SFG.AM00200M.ATTRIBUTE_CD@umsp.world%TYPE		--	'SIZE'
)
	return	VARCHAR2

as

   attr_value	VARCHAR2(2000);
    
   p_pointer	CHAR(10);
    
   data_type	CHAR(2);
    
   t_count		INTEGER(10);
    
   format_cd	CHAR(6);
    
begin
  declare

  cursor am00200m_cursor(p1 char, p2 char, p3 char) is

    Select
      ltrim(rtrim(to_char((NVL(LTRIM(RTRIM(SUBSTR(T1."VAL_POINTER_ID",7)) || ' '), ' ')) 		
	- (TRUNC((NVL(LTRIM(RTRIM(SUBSTR(T1."VAL_POINTER_ID", 7)) || ' '), ' '))  / 20,0)*20)))),
         TRUNC((NVL(LTRIM(RTRIM(SUBSTR(T1."VAL_POINTER_ID", 7)) || ' '), ' '))  / 20,0)*20,
      T1."FMT_CD",
      T1."ATTR_DATA_TYPE"
    
    From sfg.AM00200M@umsp.world  T1

    Where ltrim(rtrim(T1."ASSET_AREA" ))  = ltrim(rtrim(p1))
	And ltrim(rtrim(T1."ASSET_TYPE"))   = ltrim(rtrim(p2))
      And ltrim(rtrim(T1."ATTRIBUTE_CD")) = ltrim(rtrim(p3))
	And T1."FMT"  = 'T'
	 ;
    
   cursor am00510m_cursor
	(p1 char, p2 char,p3 char, p4 char, p5 integer, data_type char, p_pointer char) is

    Select

      decode(ltrim(rtrim(data_type)) ,  

	'C', 
	decode(ltrim(rtrim(p_pointer)) ,
     	'1', T0."CVALUE1", '2', T0."CVALUE2", '3',T0."CVALUE3", 
	'4', T0."CVALUE4", '5', T0."CVALUE5",
     	'6', T0."CVALUE6", '7', T0."CVALUE7", '8', T0."CVALUE8", 
	'9', T0."CVALUE9",  '10', T0."CVALUE10",
     '11', T0."CVALUE11", '12', T0."CVALUE12",
     '13', T0."CVALUE13", '14', T0."CVALUE14",
     '15', T0."CVALUE15", '16', T0."CVALUE16",
     '17', T0."CVALUE17", '18', T0."CVALUE18",
     '19', T0."CVALUE19", '20', T0."CVALUE20",
     NULL), 

	'V', 
	decode(ltrim(rtrim(p_pointer)) ,
     	'1', T0."VVALUE1", '2', T0."VVALUE2", '3',T0."VVALUE3", 
	'4', T0."VVALUE4", '5', T0."VVALUE5",
     	'6', T0."VVALUE6", '7', T0."VVALUE7", '8', T0."VVALUE8", 
	'9', T0."VVALUE9",  '10', T0."VVALUE10",
     '11', T0."VVALUE11", '12', T0."VVALUE12",
     '13', T0."VVALUE13", '14', T0."VVALUE14",
     '15', T0."VVALUE15", '16', T0."VVALUE16",
     '17', T0."VVALUE17", '18', T0."VVALUE18",
     '19', T0."VVALUE19", '20', T0."VVALUE20",
     NULL), 

	'D', 
	(to_char(decode(ltrim(rtrim(p_pointer)) ,
     	'1', T0."DVALUE1", '2', T0."DVALUE2", '3', T0."DVALUE3", 
	'4', T0."DVALUE4", '5', T0."DVALUE5",
     	'6', T0."DVALUE6", '7', T0."DVALUE7", '8', T0."DVALUE8", '9', T0."DVALUE9", '10', T0."DVALUE10",
     '11', T0."DVALUE11", '12', T0."DVALUE12",
     '13', T0."DVALUE13", '14', T0."DVALUE14",
     '15', T0."DVALUE15", '16', T0."DVALUE16",
     '17', T0."DVALUE17", '18', T0."DVALUE18",
     '19', T0."DVALUE19", '20', T0."DVALUE20",
     NULL),'MM/DD/YYYY')), 

	'I', 
	(to_char(decode(ltrim(rtrim(p_pointer)) ,
     	'1', T0."IVALUE1", '2', T0."IVALUE2", '3', T0."IVALUE3", 
	'4', T0."IVALUE4", '5', T0."IVALUE5",
     	'6', T0."IVALUE6", '7', T0."IVALUE7", '8', T0."IVALUE8", 
	'9', T0."IVALUE9",  '10', T0."IVALUE10",
     '11', T0."IVALUE11", '12', T0."IVALUE12",
     '13', T0."IVALUE13", '14', T0."IVALUE14",
     '15', T0."IVALUE15", '16', T0."IVALUE16",
     '17', T0."IVALUE17", '18', T0."IVALUE18",
     '19', T0."IVALUE19", '20', T0."IVALUE20",
     0))), 

	'N', 
	(to_char(decode(ltrim(rtrim(p_pointer)) ,
     	'1', T0."NVALUE1", '2', T0."NVALUE2", '3', T0."NVALUE3", 
	'4', T0."NVALUE4", '5', T0."NVALUE5",
     	'6', T0."NVALUE6", '7', T0."NVALUE7", '8', T0."NVALUE8", 
	'9', T0."NVALUE9", '10',T0."NVALUE10",
     '11', T0."NVALUE11", '12', T0."NVALUE12",
     '13', T0."NVALUE13", '14', T0."NVALUE14",
     '15', T0."NVALUE15", '16', T0."NVALUE16",
     '17', T0."NVALUE17", '18', T0."NVALUE18",
     '19', T0."NVALUE19", '20', T0."NVALUE20",
     0))), 

	NULL)

    From sfg.AM00510M@umsp.world     T0

    Where ltrim(rtrim(T0."ASSET_AREA")) = ltrim(rtrim(p1))
      and ltrim(rtrim(T0."ASSET_TYPE")) = ltrim(rtrim(p2))
	and ltrim(rtrim(T0."ASSET_NO"))   = ltrim(rtrim(p3))
	and ltrim(rtrim(T0."FMT"))	= 'T'
      and ltrim(rtrim(T0."FMT_CD"))     = ltrim(rtrim(p4))
	and T0."TRX_CNT" = p5
	;
    
  begin

	open	am00200m_cursor(asset_area, asset_type, attribute);
    
	fetch	am00200m_cursor into p_pointer, t_count, format_cd, data_type;

    
	open	am00510m_cursor(asset_area, asset_type, asset_no, format_cd, t_count, data_type, p_pointer);
    
	fetch	am00510m_cursor into attr_value;
    

	return(attr_value);
    
  end;
    
end;

