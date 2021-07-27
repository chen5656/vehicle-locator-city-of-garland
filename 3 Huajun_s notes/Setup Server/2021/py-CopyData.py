import arcpy
fc = r"\\gis-fs1\PRJ\GIS_Analysts\HCHEN\0 Setup new server and SQL server\data.mdb\fileList" 
isMovingValue = 1 
isCopyValue = 0 
cursor = arcpy.SearchCursor(fc)
print(0)
for row in cursor:
    fileName = row.getValue("fileName")
    IsMoving= row.getValue("IsMoving")
    copied=row.getValue("copied")
    Data_type= row.getValue("fileType")
    if IsMoving==isMovingValue and copied==isCopyValue:
        print(fileName)
        copyFrom=row.getValue("value1")
        saveAs=row.getValue("value2")
        arcpy.Copy_management(copyFrom, saveAs, Data_type)


    #copyFrom="Database Connections\\z-gis@geoprod1.sde\\GIS." + fileName
    #saveAs="C:\\Users\\hchen\\AppData\\Roaming\\ESRI\\Desktop10.7\\conncections\\schemaUserConnection\\"+toDatabase+".sde\\"+toDatabase+"."+toDatabase+"."+fileName
