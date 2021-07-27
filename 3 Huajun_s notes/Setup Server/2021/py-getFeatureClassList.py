import arcpy
arcpy.env.workspace = r'Database Connections\z-gis@geoprod1.sde' 
fCs = arcpy.ListFeatureClasses()
for fc in fCs:
    print(fc)
