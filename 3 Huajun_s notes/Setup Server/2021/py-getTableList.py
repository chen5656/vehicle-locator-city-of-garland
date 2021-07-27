import arcpy
arcpy.env.workspace = r'Database Connections\z-gis@geoprod1.sde' 
TBs = arcpy.ListTables()
for tb in TBs:
    print(tb)
