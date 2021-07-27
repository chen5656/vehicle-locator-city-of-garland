import arcpy
arcpy.env.workspace = r'Database Connections\gis@newgeoprod.sde' 
datasets = arcpy.ListDatasets()
for dataset in datasets:
    print(dataset)
