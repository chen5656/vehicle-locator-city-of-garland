
-- DDL for the tracking table

-- SHAPE, OBJECTID, X and Y are all populated by a trigger.

-- SELECT to_char(DBMS_METADATA.GET_DDL('TABLE', 'WATER_AVL_TRACKING')) FROM DUAL;

  CREATE TABLE "GARLAND"."WATER_AVL_TRACKING"
   (    "TRACKING_ID" NUMBER(*,0) NOT NULL ENABLE,
        "VEHICLE" CHAR(4),
        "SPEED" NUMBER(*,0),
        "LATITUDE" VARCHAR2(25),
        "LONGITUDE" VARCHAR2(25),
        "HEADING" VARCHAR2(3),
        "RECORDDATE" DATE,
        "MEMO" VARCHAR2(80),
        "SHAPE" "MDSYS"."SDO_GEOMETRY"  NOT NULL ENABLE,
        "OBJECTID" NUMBER(38,0) NOT NULL ENABLE,
        "X" NUMBER NOT NULL ENABLE,
        "Y" NUMBER NOT NULL ENABLE,
         CONSTRAINT "WATER_AVL_TRACKING_PKEY" PRIMARY KEY ("TRACKING_ID")
   );
   
-- DDL for the workorder table

-- SELECT to_char(DBMS_METADATA.GET_DDL('TABLE', 'WATER_AVL_WORKORDER')) FROM DUAL;

  CREATE TABLE "GARLAND"."WATER_AVL_WORKORDER"
   (    "WORKORDER" NUMBER(*,0) NOT NULL ENABLE,
        "LATITUDE" NUMBER,
        "LONGITUDE" NUMBER,
        "RECORDDATE" DATE,
        "MEMO" VARCHAR2(80),
        "SHAPE" "MDSYS"."SDO_GEOMETRY"  NOT NULL ENABLE,
        "OBJECTID" NUMBER(38,0) NOT NULL ENABLE,
        "X" NUMBER NOT NULL ENABLE,
        "Y" NUMBER NOT NULL ENABLE,
        "CREW" VARCHAR2(50),
         CONSTRAINT "WATER_AVL_WORKORDER_PKEY" PRIMARY KEY ("WORKORDER")
   );
   
-- Tracking "breadcrumb" table

CREATE TABLE "GARLAND"."WATER_AVL_TRACK_HIST"
  (  "OBJECTID" NUMBER(38,0) NOT NULL, 
     "VEHICLE" CHAR(4),
     "SPEED" NUMBER(*,0),
     "LATITUDE" VARCHAR2(25),
     "LONGITUDE" VARCHAR2(25),
     "HEADING" VARCHAR2(3),
     "RECORDDATE" DATE,
     "INSERTDATE" DATE NOT NULL,
     "MEMO" VARCHAR2(80),
     "SHAPE" "MDSYS"."SDO_GEOMETRY"  NOT NULL ENABLE,
     "X" NUMBER NOT NULL ENABLE,
     "Y" NUMBER NOT NULL ENABLE,
     CONSTRAINT "WATER_AVL_TRACK_HIST_PKEY" PRIMARY KEY ("OBJECTID")
  );

-- Sequence for breadcrumb primary key

CREATE SEQUENCE "GARLAND"."WATER_AVL_TRACK_HIST_SEQ" 
START WITH 1 
INCREMENT BY 1 
NOMAXVALUE; 

-- trigger to set primary key

CREATE OR REPLACE TRIGGER WATER_AVL_TRACK_HIST_ID
BEFORE INSERT ON WATER_AVL_TRACK_HIST
FOR EACH ROW
BEGIN
SELECT WATER_AVL_TRACK_HIST_SEQ.NEXTVAL INTO :NEW.OBJECTID FROM DUAL;
SELECT SYSDATE INTO :NEW.INSERTDATE FROM DUAL;
END;
/

-- add Work Order Spatial Update trigger to table
-- This trigger analyzes the lat and long input, and updates
-- the spatial column with a coordinate in state plane feet.

CREATE OR REPLACE TRIGGER "GARLAND"."INST_SPOBJ_WO" 
  BEFORE INSERT OR UPDATE OF "LATITUDE", "LONGITUDE" 
  ON "WATER_AVL_WORKORDER" 
  FOR EACH ROW
  
DECLARE
  OBJ MDSYS.SDO_GEOMETRY;
  NEWOBJ MDSYS.SDO_GEOMETRY;

BEGIN

OBJ := MDSYS.SDO_GEOMETRY(2001, 8307, MDSYS.SDO_POINT_TYPE(TO_NUMBER(:NEW.LONGITUDE), TO_NUMBER(:NEW.LATITUDE), NULL), NULL, NULL);
NEWOBJ := MDSYS.SDO_CS.TRANSFORM(OBJ, 41147); -- TRANSFORM TO STATE PLANE

:NEW.X := NEWOBJ.SDO_POINT.X;
:NEW.Y := NEWOBJ.SDO_POINT.Y;
:NEW.SHAPE := NEWOBJ;

END;
ALTER TRIGGER "GARLAND"."INST_SPOBJ_WO" ENABLE;

-- Vehicle Spatial trigger
CREATE OR REPLACE TRIGGER INST_SPOBJ_TRACK
  before INSERT or UPDATE 
  OF LATITUDE, LONGITUDE, TRACKING_ID
  ON WATER_AVL_TRACKING
  
FOR EACH ROW 
DECLARE 
  OBJ MDSYS.SDO_GEOMETRY;
  NEWOBJ MDSYS.SDO_GEOMETRY;

BEGIN 

OBJ := MDSYS.SDO_GEOMETRY(2001, 8307, MDSYS.SDO_POINT_TYPE(
  TO_NUMBER(:NEW.LONGITUDE), 
  TO_NUMBER(:NEW.LATITUDE), NULL), NULL, NULL);
NEWOBJ := MDSYS.SDO_CS.TRANSFORM(OBJ, 41147); -- TRANSFORM TO STATE PLANE
:NEW.OBJECTID := :NEW.TRACKING_ID;
:NEW.X := NEWOBJ.SDO_POINT.X;
:NEW.Y := NEWOBJ.SDO_POINT.Y;
:NEW.SHAPE := NEWOBJ;

END; 

ALTER TRIGGER INST_SPOBJ_TRACK ENABLE;

-- History trigger - inserts into "breadcrumb" table
CREATE OR REPLACE TRIGGER AVL_TRACKING_HISTORY
  after UPDATE OR DELETE
  ON WATER_AVL_TRACKING
  
FOR EACH ROW
DECLARE
BEGIN
  INSERT INTO WATER_AVL_TRACK_HIST (VEHICLE, SPEED, LATITUDE, LONGITUDE, HEADING, RECORDDATE, MEMO, SHAPE, X, Y)
  VALUES(:OLD.VEHICLE,
    :OLD.SPEED,
    :OLD.LATITUDE,
    :OLD.LONGITUDE,
    :OLD.HEADING,
    :OLD.RECORDDATE,
    :OLD.MEMO,
    :OLD.SHAPE,
    :OLD.X,
    :OLD.Y
  );
END;
/

-- Add Oracle Spatial metadata

INSERT INTO USER_SDO_GEOM_METADATA VALUES (
  'WATER_AVL_WORKORDER',
  'SHAPE',
  MDSYS.SDO_DIM_ARRAY(MDSYS.SDO_DIM_ELEMENT('X', 0, 2147483647, .005),
                      MDSYS.SDO_DIM_ELEMENT('Y', 0, 2147483647, .005)
  ),
  41147
);

INSERT INTO USER_SDO_GEOM_METADATA VALUES (
  'WATER_AVL_TRACKING',
  'SHAPE',
  MDSYS.SDO_DIM_ARRAY(MDSYS.SDO_DIM_ELEMENT('X', 0, 2147483647, .005),
                      MDSYS.SDO_DIM_ELEMENT('Y', 0, 2147483647, .005)
  ),
  41147
);

INSERT INTO USER_SDO_GEOM_METADATA VALUES (
  'WATER_AVL_TRACK_HIST',
  'SHAPE',
  MDSYS.SDO_DIM_ARRAY(MDSYS.SDO_DIM_ELEMENT('X', 0, 2147483647, .005),
                      MDSYS.SDO_DIM_ELEMENT('Y', 0, 2147483647, .005)
  ),
  41147
);


-- create spatial index

create index point_wo_idx on WATER_AVL_WORKORDER(SHAPE) INDEXTYPE IS MDSYS.SPATIAL_INDEX parameters ('SDO_LEVEL = 16')

create index point_track_idx ON WATER_AVL_TRACKING(SHAPE) INDEXTYPE IS MDSYS.SPATIAL_INDEX parameters ('SDO_LEVEL=16');

create index point_track_hist_idx ON WATER_AVL_TRACK_HIST(SHAPE) INDEXTYPE IS MDSYS.SPATIAL_INDEX parameters ('SDO_LEVEL=16');

-- NOTE: A warning may appear.  Disregard.  We will recreate the spatial indices once the projections are set.

-- add keyword to SDE

INSERT INTO SDE.DBTUNE (KEYWORD, PARAMETER_NAME, CONFIG_STRING)
  VALUES ('SDO_GEOMETRY', 'GEOMETRY_STORAGE', 'SDO_GEOMETRY');

-- THE FOLLOWING NINE COMMANDS ARE INVOKED FROM THE COMMAND LINE IN THE
-- SDE HOST - THEY ARE NOT SQL
-- register layers with ArcSDE 9.1:

sdelayer -o register -l WATER_AVL_TRACKING,SHAPE -e p -C OBJECTID,USER 
-k SDO_GEOMETRY -u garland -p ******

sdelayer -o register -l WATER_AVL_WORKORDER,SHAPE -e p -C OBJECTID,USER
-k SDO_GEOMETRY -u garland -p ******

sdelayer -o register -l WATER_AVL_TRACK_HIST,SHAPE -e p -C OBJECTID,USER
-k SDO_GEOMETRY -u garland -p ******

-- the SDE auto registry picks a projection that is close, but not quite correct.
-- we must alter the SDE layer to set it.

sdelayer -o alter -l WATER_AVL_TRACKING,SHAPE -G 102738 -u garland -p ******
sdelayer -o alter -l WATER_AVL_WORKORDER,SHAPE -G 102738 -u garland -p ******
sdelayer -o alter -l WATER_AVL_TRACK_HIST,SHAPE -G 102738 -u garland -p ******

-- update the spatial index in SDE

sdelayer -o alter -l WATER_AVL_TRACKING,SHAPE -g FIXED,16 -u garland -p ******
sdelayer -o alter -l WATER_AVL_WORKORDER,SHAPE -g FIXED,16 -u garland -p ******
sdelayer -o alter -l WATER_AVL_TRACK_HIST,SHAPE -g FIXED,16 -u garland -p ******

-- Ok, now back to Oracle...

-- A view that reports how many work orders are assigned to a vehicle
CREATE OR REPLACE VIEW WATER_AVL_WO_V AS
SELECT COUNT(CREW) AS WO_COUNT, CREW FROM WATER_AVL_WORKORDER GROUP BY CREW;
/

-- The parameters table

CREATE TABLE AVL_ALERT_SETTINGS
  (NAME VARCHAR2(100), 
   VALUE VARCHAR2(255));


-- THESE PARAMETERS WILL NEED TO BE UPDATED TO SITE-SPECIFIC SETTINGS

-- network address (host/port) of the ESRI servlet connector to ArcIMS
INSERT INTO AVL_ALERT_SETTINGS VALUES ('map-server','magellan:8081');

-- name of the map service 
INSERT INTO AVL_ALERT_SETTINGS VALUES ('map-service','garlandtx');

-- layer ID of the streets layer
INSERT INTO AVL_ALERT_SETTINGS VALUES ('streets-layer-id', '2');

-- layer ID of the city limits layer
INSERT INTO AVL_ALERT_SETTINGS VALUES ('city-limit-layer-id', '0');

-- field name to request when testing city limits layer
INSERT INTO AVL_ALERT_SETTINGS VALUES ('city-limit-fieldname', '#ALL#');

-- field name in streets layer that stores the speed limit
INSERT INTO AVL_ALERT_SETTINGS VALUES ('speed-limit-fieldname', 'SPEED_LIMI');

-- field name in streets layer that stores the street name
INSERT INTO AVL_ALERT_SETTINGS VALUES ('street-name-fieldname', 'ST_NAME');

-- threshold, in mph, before sending an alert 
INSERT INTO AVL_ALERT_SETTINGS VALUES ('speed-limit-threshold', '10');

-- who appears to send the broadcast emails
INSERT INTO AVL_ALERT_SETTINGS VALUES ('email-from', 'avl@latitudegeo.com');

-- who receives the emails
INSERT INTO AVL_ALERT_SETTINGS VALUES ('email-to', 'malcolm@latitudegeo.com');

-- amount of map units to buffer the point into an envelope - 50 means a 
-- envelope 100' by 100'
INSERT INTO AVL_ALERT_SETTINGS VALUES ('buffer', '50');

-- network address of the SMTP server for outgoing mail
INSERT INTO AVL_ALERT_SETTINGS VALUES ('smtp-server', 'mail.latitudegeo.com');

-- port for the SMTP server 
INSERT INTO AVL_ALERT_SETTINGS VALUES ('smtp-port', '25');

-- Custom function to get settings

CREATE OR REPLACE FUNCTION GET_AVL_ALERT_SETTING(NAME_IN IN VARCHAR2)
RETURN VARCHAR2
IS
  retval VARCHAR2(255);
BEGIN
  SELECT VALUE INTO retval FROM AVL_ALERT_SETTINGS WHERE NAME=NAME_IN;
  RETURN retval;
END;

-- A custom object that represents a street: streets have a name and a speed
-- limit.  
CREATE OR REPLACE TYPE STREET_OBJ AS OBJECT (
  speed NUMBER,
  name VARCHAR2(30)
);

-- A collection of streets go into a street_tbl
create or replace type street_tbl as table of street_obj;

-- When parsing the ArcXML response from ArcIMS, we may get multiple streets for a given
-- spatial extent.  So, this function will extract all the streets below a given point.
CREATE OR REPLACE FUNCTION GET_SPEED_FIELDS (XML_IN IN VARCHAR2, SPEED_FIELD_IN VARCHAR2, STREET_FIELD_IN VARCHAR2, VEHICLE_SPEED_IN NUMBER, THRESHOLD_IN NUMBER)
RETURN GARLAND.STREET_TBL
IS
  idx number;
  endidx number;
  q1 number;
  q2 number;
  speed number;
  streetname varchar2(30);
  retval GARLAND.STREET_TBL;
  fieldname varchar2(75);
  fieldvalue varchar2(25);
  counter number;
  
BEGIN
  retval := street_tbl();
  idx := instr(XML_IN, '<FIELDS', 1, 1);
  counter := 0;
  endidx := instr(XML_IN, '</FIELDS', 1, 1);
  WHILE idx <> 0 AND endidx <> 0 AND idx < endidx AND counter < 100 LOOP
    counter := counter + 1;
    idx := instr(XML_IN, '<FIELD ', idx, 1);
    while idx <> 0 AND idx < endidx AND counter < 100 LOOP
      counter := counter + 1;
      q1 := instr(XML_IN, '"', idx, 1);
      q2 := instr(XML_IN, '"', idx + 1, 2);
      fieldname := substr(XML_IN, q1 + 1, q2-(q1+1));
      idx := q2 + 1;
      q1 := instr(XML_IN, '"', idx, 1);
      q2 := instr(XML_IN, '"', idx + 1, 2);
      fieldvalue := substr(XML_IN, q1+1, q2-(q1+1));
    
      IF fieldname = SPEED_FIELD_IN THEN
        speed := TO_NUMBER(fieldvalue);
      ELSIF fieldname = STREET_FIELD_IN THEN
        streetname := fieldvalue;
      END IF;
      idx := instr(XML_IN, '<FIELD ', idx, 1);
    END LOOP;
    IF VEHICLE_SPEED_IN > (speed + THRESHOLD_IN) THEN
      retval.extend;
      retval(retval.last) := street_obj(speed, streetname);
    END IF;
    idx := instr(XML_IN, '<FIELDS', idx, 1);
    endidx := instr(XML_IN, '</FIELDS', idx, 1);
  END LOOP;
  
  return retval;
END;
/

-- This function returns the featurecount only from a feature request
-- in ArcXML.  It's used to determine if a vehicle is outside city limits.
CREATE OR REPLACE FUNCTION GET_VEHICLE_OUTSIDE (XML_IN IN VARCHAR2)
RETURN NUMBER
IS
  idx number;
  endidx number;
  retval number;
BEGIN
  retval := -1;
  idx := instr(XML_IN, '<FEATURECOUNT', 1, 1);
  IF idx > 0 THEN
    idx := instr(XML_IN, 'count', idx, 1);  
    idx := instr(XML_IN, '"', idx, 1);
    endidx := instr(XML_IN, '"', idx + 1, 1);
    retval := TO_NUMBER(substr(XML_IN, idx+1, endidx -(idx+1)));
  END IF;
  return retval;
END;
/

-- This trigger is fired after a vehicle point is updated in the layer (table).
-- It performs two spatial queries against ArcIMS: one to determine which
-- streets are under the vehicle, and one to determine if the vehicle is outside
-- city limits.
-- If the vehicle is speeding or out-of-bounds, the trigger composes and email and
-- sends it from within Oracle.
CREATE OR REPLACE TRIGGER AVL_SPEED_BOUNDS_CHECK
AFTER INSERT ON WATER_AVL_TRACKING
FOR EACH ROW
DECLARE
-- CREATE OR REPLACE PROCEDURE TEST_EMAIL AS
qry VARCHAR2(32767);
qry_resp VARCHAR2(32767);

http_req utl_http.req;
http_resp utl_http.resp;
mail_conn utl_smtp.connection;
mail_body VARCHAR2(32767);
minx NUMBER;
maxx NUMBER;
miny NUMBER;
maxy NUMBER;
buffer NUMBER;
speeding_streets street_tbl;
speed_report varchar2(20000);

alerts number;
newalerts number;

CURSOR AVLCUR IS SELECT VEHICLE, TRACKING_ID, SPEED, LIMIT, HEADING, ST_NAME FROM AVL_ALERT_ITEMS;
PARTALERT AVLCUR%ROWTYPE;

CURSOR AVLCOUNT IS SELECT COUNT(*) FROM AVL_ALERT_ITEMS;

BEGIN
  buffer := TO_NUMBER(GET_AVL_ALERT_SETTING('buffer'));
  minx := :NEW.X - buffer;
  miny := :NEW.Y - buffer;
  maxx := :NEW.X + buffer;
  maxy := :NEW.Y + buffer;
  qry := '<ARCXML version="1.1"><REQUEST><GET_FEATURES featurelimit="25" beginrecord="0" outputmode="newxml" geometry="false" envelope="false" >' ||
         '<LAYER id="'||GET_AVL_ALERT_SETTING('streets-layer-id')||'" />'||
         '<SPATIALQUERY subfields="'||GET_AVL_ALERT_SETTING('speed-limit-fieldname')||' '||GET_AVL_ALERT_SETTING('street-name-fieldname')||'">'||
         '<SPATIALFILTER relation="area_intersection"><ENVELOPE minx="'||
         TO_CHAR(minx)||'" miny="'||TO_CHAR(miny)||'" maxx="'||TO_CHAR(maxx)||'" maxy="'||TO_CHAR(maxy)||'" />'||
         '</SPATIALFILTER></SPATIALQUERY></GET_FEATURES></REQUEST></ARCXML>';
  
  utl_http.set_persistent_conn_support(FALSE);
  
  http_req := utl_http.begin_request('http://'||GET_AVL_ALERT_SETTING('map-server')||'/servlet/com.esri.esrimap.Esrimap?ServiceName='||GET_AVL_ALERT_SETTING('map-service')||Chr(38)||'ClientVersion=4.0'||Chr(38)||'CustomService=Query', 'POST','HTTP/1.1');
  
  utl_http.set_header(http_req, 'Content-Type', 'text/xml');
  utl_http.set_header(http_req, 'Content-Length', length(qry));
    
  utl_http.write_text(http_req, qry);
  
  http_resp := utl_http.get_response(http_req);
  utl_http.read_text(http_resp, qry_resp);
  utl_http.end_response(http_resp);
  
  -- parse the XML that comes back from the HTTP request...
  speeding_streets := GET_SPEED_FIELDS(qry_resp, 
    GET_AVL_ALERT_SETTING('speed-limit-fieldname'), 
    GET_AVL_ALERT_SETTING('street-name-fieldname'),
    TO_NUMBER(:NEW.SPEED),
    TO_NUMBER(GET_AVL_ALERT_SETTING('speed-limit-threshold'))
  );
  
  FOR I IN 1 .. speeding_streets.COUNT
  LOOP
      INSERT INTO AVL_ALERT_ITEMS (VEHICLE, TRACKING_ID, SPEED, LIMIT, HEADING, ST_NAME)
      VALUES (:NEW.VEHICLE, :NEW.TRACKING_ID, :NEW.SPEED, speeding_streets(I).speed, :NEW.HEADING, speeding_streets(I).name);
  END LOOP;  

  -- Now see if the vehicle is inside the city limits shapefile
  qry := '<ARCXML version="1.1"><REQUEST><GET_FEATURES featurelimit="25" beginrecord="0" outputmode="newxml" geometry="false" envelope="false" >' ||
         '<LAYER id="'||GET_AVL_ALERT_SETTING('city-limit-layer-id')||'" />'||
         '<SPATIALQUERY subfields="'||GET_AVL_ALERT_SETTING('city-limit-fieldname')||'">'||
         '<SPATIALFILTER relation="area_intersection"><ENVELOPE minx="'||
         TO_CHAR(minx)||'" miny="'||TO_CHAR(miny)||'" maxx="'||TO_CHAR(maxx)||'" maxy="'||TO_CHAR(maxy)||'" />'||
         '</SPATIALFILTER></SPATIALQUERY></GET_FEATURES></REQUEST></ARCXML>';
  
  http_req := utl_http.begin_request('http://'||GET_AVL_ALERT_SETTING('map-server')||'/servlet/com.esri.esrimap.Esrimap?ServiceName='||GET_AVL_ALERT_SETTING('map-service')||Chr(38)||'ClientVersion=4.0'||Chr(38)||'CustomService=Query', 'POST','HTTP/1.1');
  
  utl_http.set_header(http_req, 'Content-Type', 'text/xml');
  utl_http.set_header(http_req, 'Content-Length', length(qry));
    
  utl_http.write_text(http_req, qry);
  
  http_resp := utl_http.get_response(http_req);
  utl_http.read_text(http_resp, qry_resp);
  utl_http.end_response(http_resp);
  
  IF GET_VEHICLE_OUTSIDE(qry_resp) = 0 THEN
      INSERT INTO AVL_ALERT_ITEMS (VEHICLE, TRACKING_ID, SPEED, LIMIT, HEADING, ST_NAME)
      VALUES (:NEW.VEHICLE, :NEW.TRACKING_ID, :NEW.SPEED, 0, :NEW.HEADING, NULL);
  END IF;

  speed_report := '';

  OPEN AVLCUR;
  LOOP
    FETCH AVLCUR INTO PARTALERT;
    EXIT WHEN AVLCUR%NOTFOUND;   
    IF PARTALERT.ST_NAME IS NULL THEN 
        speed_report := speed_report ||CHR(13)||CHR(10)||
             'Vehicle '||PARTALERT.VEHICLE||
             ' (ID: '||PARTALERT.TRACKING_ID||', heading '||
             PARTALERT.HEADING||', speed '||TO_CHAR(PARTALERT.SPEED)||' mph) appears to be outside city limits.';
    ELSE
        speed_report := speed_report ||CHR(13)||CHR(10)||
             'Vehicle '||PARTALERT.VEHICLE||
             ' (ID: '||PARTALERT.TRACKING_ID||', heading '||
             PARTALERT.HEADING||') speed of '||TO_CHAR(PARTALERT.SPEED)||' exceeds '||
             PARTALERT.ST_NAME ||' limit of '||TO_CHAR(PARTALERT.LIMIT)||' mph ';
    END IF;
      
  END LOOP;
  CLOSE AVLCUR;
    
  if LENGTH(speed_report) > 0 THEN 
    mail_conn := utl_smtp.open_connection(GET_AVL_ALERT_SETTING('smtp-server'), GET_AVL_ALERT_SETTING('smtp-port'));
    utl_smtp.helo (mail_conn, GET_AVL_ALERT_SETTING('smtp-server'));
    utl_smtp.mail (mail_conn, GET_AVL_ALERT_SETTING('email-from'));
    utl_smtp.rcpt (mail_conn, GET_AVL_ALERT_SETTING('email-to'));
    utl_smtp.data (mail_conn,
        'Subject: Automated email from AVL trigger'||CHR(13)||CHR(10)||
        'To: '||GET_AVL_ALERT_SETTING('email-to')||CHR(13)||CHR(10)||speed_report);
    utl_smtp.quit (mail_conn);

  END IF;
  
  DELETE FROM AVL_ALERT_ITEMS;
    
END;
/


